function [bob, data] = main(bob, options)

arguments
    bob handle
    options.parallel (1,1) {mustBeNumericOrLogical} = false
    options.fail_selftest (1,1) {mustBeNumericOrLogical} = false
    options.fail_overtemp (1,1) {mustBeNumericOrLogical} = false
end

bob.parallel = options.parallel;
bob.fail_selftest = options.fail_selftest;
bob.fail_overtemp = options.fail_overtemp;
zoe = responder(bob); %#ok<NASGU>


%%
bob.setup_hardware();
bob.progress_dialog();
bob.define_constants(); c2k = 273.15;

if bob.settings.simulation_only
    
    bob.T_g = bob.settings.T_g_sim + c2k;
    bob.T_h = bob.settings.T_h + c2k;
    
elseif ~bob.settings.simulation_only && bob.settings.ni
    
    daq_data = read(bob.ni_daq_obj);
    bob.T_g = daq_data.cDAQ1Mod8_ai1 + c2k;
    bob.T_h = daq_data.cDAQ1Mod8_ai3 + c2k;
    
end

bob.set_initial_conditions(); % Establish a consistent set of ICs

bob.pid = controller_pid();
bob.define_temperature_controller();

bob.pid_phi = controller_pid();
bob.define_relative_humidity_controller();

if bob.progress_bar; bob.dialog_box.Message = "Processing..."; drawnow; end

bob.settings.setpoints.T = bob.settings.setpoints.T + 273.15;

% Notify listeners of events
notify(bob, 'prestartup')  
notify(bob, 'startup')
notify(bob, 'selftest')

% If there have been any red alerts or yellow alerts, take action
check4errors(bob)
if bob.red_alert || bob.yellow_alert
    data = {};
    return
end

B = main_loop();
save data.mat B

bob.create_plots();

if bob.progress_bar; close(bob.dialog_box); close(bob.fig); end

data = table(bob.outputs(:,1), bob.outputs(:,2), bob.outputs(:,3),...
    bob.outputs(:,5), bob.outputs(:,6), bob.outputs(:,8),...
    bob.outputs(:,9), bob.outputs(:,10),... 
    'VariableNames', {'T_g', 'T_h', 'T_o', 'p_v', 'p_a', 'q', 'phi',...
    'p_s', 'P_h'});


%% Main loop
    function B = main_loop()
        if bob.parallel
            p = parallel.pool.PollableDataQueue;
            F = parfeval(@capture_data, 1, p, bob.settings.total_time);
            pause(2)  % Allows worker to get spooled up
        end
        measurement = bob.x_0(1); % T_g
        measurement_phi = bob.x_0(9); % phi
        
        figure; ax = gca; title('Temperature (K)')
        %%
        for i = 1:bob.max_iterations
            stuff_happens(bob);
            if bob.parallel
                if ~exist('F','var')
                    F = parfeval(@bob.do_stuff, 1);
                else
                    if numel(F.OutputArguments) > 0
                        temp = fetchOutputs(F);
                        clearvars F
                    end
                end
            end
            %% Controller
            % Calculate output for temperature controller
            bob.pid.calculate_controller_output( ...
                bob.settings.setpoints.T, measurement);
            
            % When using the Arduino, the heater can be on or off
            if ~bob.settings.simulation_only && bob.settings.arduino
                if bob.pid.out > 0
                    writeDigitalPin(bob.arduino_daq_obj,'D2',1)  % ON
                else
                    writeDigitalPin(bob.arduino_daq_obj,'D2',0)  % OFF
                end
                pause(1) % Don't burn out the Arduino relay
            end
            
            % Calculate output for humidity controller
            bob.pid_phi.calculate_controller_output(...
                bob.settings.setpoints.phi, measurement_phi);
            
            % Record the power setting of the heater at each time step
            bob.P_h_out(i) = bob.pid.out;
            bob.m_steam(i) = bob.pid_phi.out;
            
            %% Plant Model
            % On the first time through the loop, use the x_0 above. After 
            % that, the initial values to give to the ode are the last ones
            % it gave.
            if i >= 2
                bob.x_0 = y(end,:);
            end
            
            % Call ode solver
            [~,y] = ode23(@(t,y) odefun(t, y, bob),[0 bob.pid.Ts],bob.x_0);
            
            % Capture sensor measurements
            if ~bob.settings.simulation_only
                
                if bob.settings.ni
                    if bob.parallel
                        try
                            y(end,1) = poll(p) + 273.15;  % T_g2
                            y(end,2) = poll(p) + 273.15;  % T_h2
                        catch er
                            disp(er.message)
                        end
                    else
                        daq_data = read(bob.ni_daq_obj);
                        y(end,1) = daq_data.cDAQ1Mod8_ai1 + 273.15; % T_g2
                        y(end,2) = daq_data.cDAQ1Mod8_ai3 + 273.15; % T_h2
                    end
                end
                
                if bob.settings.arduino
                    y(end,9) = readHumidity(bob.sensor_dht22);
                end
            end
            bob.outputs(i,:) = y(end,:);
            
            measurement = y(end,1);
            measurement_phi = y(end,9);
            bob.T_g_out(i) = y(end,1);
            bob.T_h_out(i) = y(end,2);
            bob.T_o_out(i) = y(end,3);
            bob.p_v_out(i) = y(end,5);
            bob.p_a_out(i) = y(end,6);
            bob.q_out(i)   = y(end,8);
            bob.phi_out(i) = y(end,9);
            bob.p_s_out(i) = y(end,10);
            
            xx = 1:length(bob.T_g_out);
            yy = bob.T_g_out - 273.15;
            plot(ax, xx, yy, '.b'); grid on; hold on
            axis([1 bob.max_iterations 20 50])
            
            check4errors(bob)
            if bob.red_alert || bob.yellow_alert
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
        if exist('F','var')
            B = fetchOutputs(F);
        else
            B = [];
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


