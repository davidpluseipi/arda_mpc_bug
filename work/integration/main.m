function [bob] = main(bob)
%% MAIN  Run aRDA
%
%   [ARDA_OBJ] = MAIN(ARDA_OBJ) runs the aRDA with preselected options.
%

% Check for conflicts
if ~bob.using_arduino_hardware && ~bob.using_ni_hardware
    
    if ~bob.simulation_only
        
        bob.simulation_only = true;
        bob.parallel = false;
        warning(['Input arguments to main.m indicate no hardware and ',...
            'did not indicate simulation only. The arda object property ',...
            '''simulation_only'' has been set to TRUE and ''parallel'' ',...
            'has been set to FALSE.'])
    end
    
else
    if bob.simulation_only
        bob.simulation_only = false;
        warning(['Input arguments to main.m indicate at least one type ',...
            'of hardware is being used.  The arda object property ',...
            '''simulation_only'' has been set to FALSE.'])
    end
end


if ~ismember(bob.heater, {'arduino', 'ni'})
    error(['Invalid input argument. arda object property heater has ',...
        'the following options: ''arduino'', ''ni''']);
end

if bob.parallel && ~bob.using_arduino_hardware && ~bob.using_ni_hardware
    
    error(['Invalid input arguments. Property ''parallel'' requires that',...
        '''using_arduino_hardware'' or ''using_ni_hardware'' be TRUE.']);
    
end


%% Setup
bob.resistance = zeros(length(bob.max_iterations),1);
bob.time = NaT(length(bob.max_iterations),1);

% Create the responder object with listeners
zoe = responder(bob); %#ok<NASGU>

% Create the gauges app
app = gauges();
app.max_iterationsEditField.Value = bob.max_iterations;

% Set the default figure window style
set(0,'DefaultFigureWindowStyle', bob.window_style)

% Run the arda 'startup' methods
bob.setup_hardware();
bob.progress_dialog();
bob.define_constants();
c2k = 273.15;

% Set the initial temperatures
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




% Notify listeners of events. She then runs the code for those states.
notify(bob, 'prestartup')
notify(bob, 'startup')
notify(bob, 'selftest')

% If there have been any red alerts or yellow alerts, take action
check4errors(bob);
if bob.red_alert || bob.yellow_alert
    return
end

%% Call the main loop (nested function below)
B = main_loop(); %#ok<NASGU>

% If there were any red alerts or yellow alerts in the main loop, return
if bob.red_alert || bob.yellow_alert
    return
end

% Create the plots for the output data
if bob.final_plots
    bob.create_plots();
end

% Close the progress bar
if bob.progress_bar
    
    close(bob.dialog_box)
    close(bob.fig)
    
end

% Set the default figure window style back to normal
set(0,'DefaultFigureWindowStyle','normal')

% Delete stuff
bob.arduino_daq_obj = [];
%delete(app)





%% Main loop
    function B1 = main_loop()
        
        %% If using the parpool, get the worker started aquiring data
        if bob.parallel
            
            % Create a pollable data queue to run on a worker
            p = parallel.pool.PollableDataQueue;
            
            % Run capture data on a worker for (max_iterations) seconds
            F1 = parfeval(@capture_data, 1, p, bob.max_iterations);
            
        end
        
        %% Create a figure and store its axes handle
%         if bob.live_plot
%             figure
%             ax = gca;
%         end
        
        %% Establish setpoints
        bob.temperature_setpoint = bob.T_g;
        bob.s = bob.s + bob.temperature_setpoint;
        
        bob.setpoints = zeros(length(bob.max_iterations),1);
        for i = 1:bob.max_iterations
            
            for j = 1:length(bob.t)-1
                
                if i >= bob.t(j) && i < bob.t(j+1)
                    
                    bob.setpoints(i) = bob.s(j);
                    break
                    
                end
                
            end
            
        end
        bob.setpoints = [bob.setpoints bob.setpoints(end)];
        
        
        %% Loop
        for i = 1:bob.max_iterations
            
            %% Tune new controller
            if bob.parallel
                
                % When needed, tune a new controller on a separate worker
                if ~exist('F','var')
                    
                    % Call function on separate worker
                    warning('off','MATLAB:hwsdk:general:nosave')
                    F2 = parfeval(@bob.tune_new_controller, 1);
                    warning('on','MATLAB:hwsdk:general:nosave')
                else
                    
                    % If F2 has its returned output arguments, fetch them
                    if numel(F2.OutputArguments) > 0
                        
                        B2 = fetchOutputs(F2); %#ok<NASGU>
                        clearvars F2
                        
                    end
                    
                end
                
            end
            
            %% Controller
            % Calculate output for temperature controller
            bob.temperature_setpoint = bob.setpoints(i);
            bob.pid.calculate_controller_output( ...
                bob.temperature_setpoint, bob.T_g);
            bob.P_h(i) = bob.pid.out;
            
            %% Actuator
            % When using the Arduino, the heater can be on or off
            if ~bob.simulation_only
                
                % If the heater is connected to the arduino
                if strcmp(bob.heater, 'arduino')
                    
                    % Any commanded output turns the heater full on,
                    % otherwise, turn it off
                    if bob.pid.out > 0
                        
                        writeDigitalPin(bob.arduino_daq_obj,'D2',1);  % ON
                        
                    else
                        
                        writeDigitalPin(bob.arduino_daq_obj,'D2',0);  % OFF
                        
                    end
                    pause(1) % Don't burn out the Arduino relay
                    
                elseif strcmp(bob.heater, 'ni') % If heater is connected to
                    T_cold = 20; % C
                    R_cold = 120; % Ohms (measured)
                    T_hot = 400; % C
                    R_hot = 10; % Ohms (guess)
                    bob.resistance(i) = (R_cold - R_hot)/(T_cold - T_hot) * (bob.T_g-273.15) + R_cold;
                    bob.voltage(i) = sqrt(bob.resistance(i)*bob.pid.out); % NI9263 outputs 0-10V
                    t = 0.02; % sec
                    k = ones(t*bob.ni_daq_obj.Rate, 1); % column vector
                    A = k*min(bob.voltage(i), 10); % A must be MxN where N is number of channels
                    readwrite(bob.ni_daq_obj, A);
                end
            end
            
            %% Controller
            % Calculate output for humidity controller
            bob.pid_phi.calculate_controller_output(...
                bob.relative_humidity_setpoint, bob.phi);
            bob.m_steam(i) = bob.pid_phi.out;
            
            %% Actuator: steam
            %
            %
            
            
            %% Plant Model
            % On the first time through the loop, use the x_0 above,
            % otherwise, use the output of the ode.
            if i >= 2
                bob.x_0 = y(end,:);
            end
            
            % Call ode solver
            [~,y] = ode23(@(t,y)odefun(t,y,bob),[0 bob.step_size],bob.x_0);
            
            %% Acquire data from hardware sensors
            % If using hardware sensors, overwrite the simulated values
            if ~bob.simulation_only
                
                if bob.using_ni_hardware
                    
                    if bob.parallel
                        
                        try
                            % It is possible to poll the queue on the
                            % worker before it's ready and get invalid
                            % values, so this is in a try
                            y(end,1) = poll(p) + 273.15;  % T_g
                            y(end,2) = poll(p) + 273.15;  % T_h
                            
                        catch
                            
                            %disp(er.message)
                            
                        end
                        
                    else
                        % If not operating on a parpool, acquire the data
                        % locally.
                        daq_data = read(bob.ni_daq_obj);
                        y(end,1) = daq_data.cDAQ1Mod8_ai1 + 273.15; % T_g
                        y(end,2) = daq_data.cDAQ1Mod8_ai3 + 273.15; % T_h
                        
                    end
                end
                
                
                if bob.using_arduino_hardware
                    % Read humidity values from the arduino hardware
                    y(end,9) = readHumidity(bob.sensor_dht22);
                    
                end
            end
            
            % Manage output data
            bob.time(i) = datetime('now');
            bob.outputs(i,:) = y(end,:);
            bob.T_g = bob.outputs(i,1); %disp(bob.T_g)
            bob.T_h = bob.outputs(i,2); %disp(bob.T_h)
            bob.phi = bob.outputs(i,9);
            bob.T_o = bob.outputs(i,3);
            bob.p_v = bob.outputs(i,5);
            bob.p_a = bob.outputs(i,6);
            bob.p_s = bob.outputs(i,10);
            
            % Update the gauges
            app.AirCGauge.Value = bob.T_g - 273.15;
            app.HeaterCGauge.Value = bob.T_h - 273.15;
            app.PowerWGauge.Value = bob.P_h(i);
            app.T_gEditField.Value = bob.T_g - 273.15;
            app.T_hEditField.Value = bob.T_h - 273.15;
            app.T_oEditField.Value = bob.T_o - 273.15;
            app.p_gEditField.Value = bob.p_g;
            app.p_vEditField.Value = bob.p_v;
            app.p_aEditField.Value = bob.p_a;
            app.V_gEditField.Value = bob.V_g;
            app.phiEditField.Value = bob.phi;
            app.m_vEditField.Value = bob.m_v;
            app.m_aEditField.Value = bob.m_a;
            app.P_hEditField.Value = bob.P_h(i);
            app.iEditField.Value = i;
            
            if strcmp(bob.heater, 'ni')
                app.V_hEditField.Value = bob.voltage(i);
            end
            app.m_dotEditField.Value = 0;
            app.vEditField.Value = 0;
            
            % If user has opted for a live plot of the date during the run
            if bob.live_plot
                
                % Simple plot
                %                 yy = bob.outputs(:,1) - 273.15;
                %                 xx = 1:length(bob.outputs(:,1));
                %                 plot(ax, xx, yy, '.b')
                %                 grid on
                %                 hold on
                %                 axis([1 bob.max_iterations...
                %                     floor(min(bob.outputs(:,1)) - 0.5 - 273.15)...
                %                     ceil(max(bob.outputs(:,1)) + 0.5 - 273.15)])
                
                % Use app
                L = length(bob.outputs(:,1));
                plot(app.UIAxes_12, 1:L, bob.outputs(:,1) - 273.15); 
                plot(app.UIAxes_11, 1:L, bob.outputs(:,2) - 273.15); 
                plot(app.UIAxes_10, 1:L, bob.outputs(:,3) - 273.15); 
                plot(app.UIAxes_9, 1:L, bob.outputs(:,4)); 
                plot(app.UIAxes_8, 1:L, bob.outputs(:,5)); 
                plot(app.UIAxes_7, 1:L, bob.outputs(:,6)); 
                plot(app.UIAxes_6, 1:L, bob.outputs(:,7)); 
                plot(app.UIAxes_4, 1:L, bob.outputs(:,9)); 
                plot(app.UIAxes_15, 1:L, bob.outputs(:,10)); 
                plot(app.UIAxes_14, 1:L, bob.outputs(:,11)); 
                plot(app.UIAxes_13, 1:L, bob.outputs(:,12)); 
                plot(app.UIAxes_16, 1:length(bob.P_h), bob.P_h); 
                if strcmp(bob.heater, 'ni')
                    plot(app.UIAxes_17, 1:L, bob.voltage);
                end
                plot(app.UIAxes_18, 1:L, zeros(L,1));
                plot(app.UIAxes_19, 1:L, zeros(L,1));
                
            end
            
            %% Insert errors as necessary
            stuff_happens(bob);
            
            %% Check for errors after each loop
            check4errors(bob);
            
            if bob.red_alert || bob.yellow_alert
                
                if bob.parallel
                    
                    B1 = fetchOutputs(F1);
                else
                    B1 = {};
                end
                
                return
                
            end
            
            
            %% Update the progress bar
            if bob.progress_bar && ismember(i, bob.draw_times)
                
                bob.dialog_box.Value = i/bob.max_iterations;
                drawnow
                
                if bob.dialog_box.CancelRequested
                    break
                end
                
            end
            
        end
        
        
        %% After the main loop, be sure to fetch any data from the worker
        if bob.parallel
            B1 = fetchOutputs(F1);
        else
            B1 = [];
        end
        
    end
end

function obj = stuff_happens(obj)

%% Overtemp
delta = 0;
if obj.fail_overtemp
    delta = 500;
end
obj.T_g = obj.T_g + delta;

end


