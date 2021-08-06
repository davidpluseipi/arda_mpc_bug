function [bob] = main(bob)
%% MAIN  Run aRDA
%
%   [ARDA_OBJ, DATA] = MAIN(ARDA_OBJ) runs the aRDA with default options.
%
%   [ARDA_OBJ, DATA] = MAIN(ARDA_OBJ, OPTIONS) runs with specified options.
%
%   OPTIONS:
% 
%      (name)                     (values)         (default)
%      'fail_overtemp'            true/false       default = false
%      'fail_selftest'            true/false       default = false
%      'heater'                   'arduino'/'ni'   default = 'arduino'
%      'parallel'                 true/false       default = false
%      'using_arduino_hardware'   true/false       default = false
%      'using_ni_hardware'        true/false       default = false
%      'simulation_only'          true/false       default = true
%
%    
%% Manage input arguments
% arguments
%     
%     bob handle
%     options.fail_overtemp (1,1) {mustBeNumericOrLogical} = false 
%     options.fail_selftest (1,1) {mustBeNumericOrLogical} = false 
%     options.heater {ischar} = 'arduino' % 'arduino' or 'ni'
%     options.max_iterations (1,1) {mustBeNumeric} = 30
%     options.parallel (1,1) {mustBeNumericOrLogical} = false
%     options.using_arduino_hardware (1,1) {mustBeNumericOrLogical} = false
%     options.using_ni_hardware (1,1) {mustBeNumericOrLogical} = false
%     options.simulation_only (1,1) {mustBeNumericOrLogical} = false
%     options.temperature_setpoint (1,1) {mustBeNumeric} = 45
%     
% end
% 
% bob.fail_overtemp = options.fail_overtemp;
% bob.fail_selftest = options.fail_selftest;
% bob.heater = options.heater;
% bob.max_iterations = options.max_iterations;
% bob.parallel = options.parallel;
% bob.simulation_only = options.simulation_only;
% bob.using_arduino_hardware = options.using_arduino_hardware;
% bob.using_ni_hardware = options.using_ni_hardware;
% bob.temperature_setpoint = options.temperature_setpoint;

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
% Create the responder object with listeners
zoe = responder(bob); %#ok<NASGU>

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

% Convert the temperature setpoint to Kelvin
bob.temperature_setpoint = bob.temperature_setpoint + 273.15;

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

% Delete the arduino object
bob.arduino_daq_obj = [];


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
        if bob.live_plot
            figure
            ax = gca;
        end
        
        t = linspace(0, bob.max_iterations, 4);
        s = 22 + [1 2 2 1];
        
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
            
            if i > t(1) && i < t(2)
                bob.temperature_setpoint = s(1) + c2k;
            elseif i >= t(2) && i < t(3)
                bob.temperature_setpoint = s(2) + c2k;
            elseif i >= t(3) && i < t(4)
                bob.temperature_setpoint = s(3) + c2k;
            else
                bob.temperature_setpoint = s(4) + c2k;
            end
            
            bob.pid.calculate_controller_output( ...
                bob.temperature_setpoint, bob.T_g);
            
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
                    
                    write(bob.ni_daq_obj, bob.pid.out*ones(...
                        bob.ni_daq_obj.Rate, 1))
                end
            end
            
            %% Controller
            % Calculate output for humidity controller
            bob.pid_phi.calculate_controller_output(...
                bob.relative_humidity_setpoint, bob.phi);
            
            
            %% Actuator: steam
            %
            %
            %
            
            
            %% Data collection
            % Record the outputs of each controller
            bob.P_h(i) = bob.pid.out;
            bob.m_steam(i) = bob.pid_phi.out;
            
            
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
            bob.outputs(i,:) = y(end,:);
            bob.T_g = bob.outputs(i,1); 
            bob.T_h = bob.outputs(i,2);
            bob.phi = bob.outputs(i,9);
            bob.T_o = bob.outputs(i,3);
            bob.p_v = bob.outputs(i,5);
            bob.p_a = bob.outputs(i,6);
            bob.p_s = bob.outputs(i,10);
            
            
            % If user has opted for a live plot of the date during the run
            if bob.live_plot
                
                yy = bob.outputs(:,1) - 273.15;
                xx = 1:length(bob.outputs(:,1));
                plot(ax, xx, yy, '.b')
                grid on
                hold on
                axis([1 bob.max_iterations...
                    floor(min(bob.outputs(:,1))-2-273.15)...
                    ceil(max(bob.outputs(:,1))+2-273.15)])
                
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


