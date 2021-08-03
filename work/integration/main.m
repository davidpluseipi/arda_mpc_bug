function [bob, data] = main(bob, options)

arguments
    bob handle
    options.simulation_only (1,1) {mustBeNumericOrLogical} = false
    options.using_ni_hardware (1,1) {mustBeNumericOrLogical} = false
    options.using_arduino_hardware (1,1) {mustBeNumericOrLogical} = false
    options.heater {ischar} = 'arduino'
    options.parallel (1,1) {mustBeNumericOrLogical} = false
    options.fail_selftest (1,1) {mustBeNumericOrLogical} = false
    options.fail_overtemp (1,1) {mustBeNumericOrLogical} = false
end

bob.simulation_only = options.simulation_only;
bob.using_ni_hardware = options.using_ni_hardware;
bob.using_arduino_hardware = options.using_arduino_hardware;
bob.heater = options.heater;
bob.parallel = options.parallel;
bob.fail_selftest = options.fail_selftest;
bob.fail_overtemp = options.fail_overtemp;
zoe = responder(bob); %#ok<NASGU>


%%
bob.setup_hardware();
bob.progress_dialog();
bob.define_constants(); c2k = 273.15;

if bob.simulation_only
    
    bob.T_g = bob.settings.T_g_sim + c2k;
    bob.T_h = bob.settings.T_h + c2k;
    
elseif ~bob.simulation_only && bob.using_ni_hardware
    
    daq_data = read(bob.ni_daq_obj);
    bob.T_g = daq_data.cDAQ1Mod8_ai1 + c2k;
    bob.T_h = daq_data.cDAQ1Mod8_ai3 + c2k;

end

% Establish a consistent set of ICs
bob.set_initial_conditions(); 

% Create and define the temperature controller
bob.pid = controller_pid();
bob.define_temperature_controller();

% Create and define the relative humidity controller
bob.pid_phi = controller_pid();
bob.define_relative_humidity_controller();

% Update the progress bar
if bob.progress_bar 
    
    bob.dialog_box.Message = "Processing...";
    drawnow 
    
end

% Convert the temperature setpoint to Kelvin
bob.temperature_setpoint = bob.temperature_setpoint + 273.15;

% Notify listeners of events. She then runs the code for those states.
notify(bob, 'prestartup')
notify(bob, 'startup')
notify(bob, 'selftest')

% If there have been any red alerts or yellow alerts, take action
check4errors(bob)
if bob.red_alert || bob.yellow_alert
    
    data = {};
    return
    
end

% Call the main loop (nested function below)
B = main_loop(); %#ok<NASGU>

% If there were any red alerts or yellow alerts in the main loop, return
if bob.red_alert || bob.yellow_alert
    
    data = {};
    return
    
end

% Create the plots for the output data
bob.create_plots();

% Close the progress bar
if bob.progress_bar
    
    close(bob.dialog_box)
    close(bob.fig)
    
end

% Put some specific data into a table
data = table(bob.outputs(:,1), bob.outputs(:,2), bob.outputs(:,3),...
    bob.outputs(:,5), bob.outputs(:,6), bob.outputs(:,8),...
    bob.outputs(:,9), bob.outputs(:,10), bob.P_h,...
    'VariableNames', {'T_g', 'T_h', 'T_o', 'p_v', 'p_a', 'q', 'phi',...
    'p_s', 'P_h'});

% Save the contents of the workspace
save data.mat


%% Main loop
    function B1 = main_loop()
        
        if bob.parallel
            
            % Create a pollable data queue to run on a worker
            p = parallel.pool.PollableDataQueue;
            
            % Run capture data on a worker for (max_iterations) seconds 
            F1 = parfeval(@capture_data, 1, p, bob.max_iterations);
            
        end
        
        if bob.live_plot
            % Create a figure and store its axes handle
            figure; ax = gca;
        end
        
        %%
        for i = 1:bob.max_iterations
            
            %% Insert errors as necessary
            stuff_happens(bob);
           
            %% Tune new controller
            if bob.parallel
                
                % When needed, tune a new controller on a separate worker
                if ~exist('F','var')
                    
                    F2 = parfeval(@bob.tune_new_controller, 1);
                    
                else
                    
                    if numel(F2.OutputArguments) > 0
                        
                        B2 = fetchOutputs(F2); %#ok<NASGU>
                        clearvars F2
                        
                    end
                    
                end
                
            end
            
            %% Controller
            % Calculate output for temperature controller
            bob.pid.calculate_controller_output( ...
                bob.temperature_setpoint, bob.T_g);
            
            % When using the Arduino, the heater can be on or off
            if ~bob.simulation_only
                
                if strcmp(bob.heater, 'arduino')
                    
                    if bob.pid.out > 0
                        
                        writeDigitalPin(bob.arduino_daq_obj,'D2',1)  % ON
                        
                    else
                        
                        writeDigitalPin(bob.arduino_daq_obj,'D2',0)  % OFF
                        
                    end
                    pause(1) % Don't burn out the Arduino relay
                    
                elseif strcmp(bob.heater, 'ni')
                    
                end
            end
            
            % Calculate output for humidity controller
            bob.pid_phi.calculate_controller_output(...
                bob.relative_humidity_setpoint, bob.phi);
            
            % Record the power setting of the heater at each time step
            bob.P_h(i) = bob.pid.out;
            bob.m_steam(i) = bob.pid_phi.out;
            
            %% Plant Model
            % On the first time through the loop, use the x_0 above. After
            % that, the initial values to give to the ode are the last ones
            % it gave.
            if i >= 2
                bob.x_0 = y(end,:);
            end
            
            % Call ode solver
            [~,y] = ode23(@(t,y) odefun(t, y, bob), [0 bob.step_size],...
                bob.x_0);
            
            % Capture sensor measurements
            if ~bob.simulation_only
                
                if bob.using_ni_hardware
                    
                    if bob.parallel
                        
                        try
                            
                            y(end,1) = poll(p) + 273.15;  % T_g
                            y(end,2) = poll(p) + 273.15;  % T_h
                            
                        catch er
                            
                            disp(er.message)
                            
                        end
                        
                    else
                        
                        daq_data = read(bob.ni_daq_obj);
                        y(end,1) = daq_data.cDAQ1Mod8_ai1 + 273.15; % T_g
                        y(end,2) = daq_data.cDAQ1Mod8_ai3 + 273.15; % T_h
                        
                    end
                end
                
                if bob.using_arduino_hardware
                    
                    y(end,9) = readHumidity(bob.sensor_dht22);
                    
                end
            end
            
            bob.outputs(i,:) = y(end,:);
            bob.T_g = bob.outputs(i,1);
            bob.T_h = bob.outputs(i,2);
            bob.phi = bob.outputs(i,9);
            bob.T_o = bob.outputs(i,3);
            bob.p_v = bob.outputs(i,5);
            bob.p_a = bob.outputs(i,6);
            bob.p_s = bob.outputs(i,10);
            
            
            if bob.live_plot
                
                yy = bob.outputs(:,1) - 273.15;
                xx = 1:length(bob.outputs(:,1));
                plot(ax, xx, yy, '.b')
                grid on
                hold on
                axis([1 bob.max_iterations 20 50])
                
            end
            
            check4errors(bob)
            
            
            if bob.red_alert || bob.yellow_alert
                
                if bob.parallel
 
                    B1 = fetchOutputs(F1);
                    
                end
                return
                
            end
            
            
            if bob.progress_bar && ismember(i, bob.draw_times)
                
                bob.dialog_box.Value = i/bob.max_iterations;
                drawnow
                
                if bob.dialog_box.CancelRequested
                    break
                end
                
            end
        end
        
        if bob.parallel
            B1 = fetchOutputs(F1);
        else
            B1 = [];
        end
        
    end
end

function obj = stuff_happens(obj)

%% TEST
delta = 0;
if obj.fail_overtemp
    delta = 300;
end
obj.T_g = obj.T_g + delta;

end


