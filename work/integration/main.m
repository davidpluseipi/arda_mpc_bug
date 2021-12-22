function [bob] = main(bob, options)
%% [ARDA_OBJ] = MAIN(ARDA_OBJ) runs the aRDA with preselected options.
arguments
    bob
    options.app
end

import realsense.*  % for LIDAR L515 (import lines need to be first

%% Create datastore folder
directory_info = dir(bob.datastore_folder);
serials = zeros(length(directory_info)-2,1);

for idx = 3:length(directory_info)
    serials(idx-2) = str2double(directory_info(idx).name(end-4:end));
end

str1 = datestr( datetime('now'), 'YYYY.mm.DD-HH-MM-ss - ');
bob.serial = max(serials) + 1;
str2 = pad_zeros(bob.serial, 5);

folder2save2 = fullfile(bob.datastore_folder, [str1 str2]);
mkdir(folder2save2)


% Check for conflicts
if bob.using_relative_humidity_sensor && ~bob.using_ni_hardware

    bob.using_ni_hardware = true;
    warning(['Input arguments to main.m indicate ',...
        'using_relative_humidity_sensor is TRUE. The arda object property ',...
        '''using_ni_hardware'' has been set to TRUE.']);

end

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


if bob.parallel && ~bob.using_arduino_hardware && ~bob.using_ni_hardware

    error(['Invalid input arguments. Property ''parallel'' requires that',...
        '''using_arduino_hardware'' or ''using_ni_hardware'' be TRUE.']);

end


%% Setup
bob.m_steam = zeros(bob.max_iterations, 1);
bob.V_h = zeros(bob.max_iterations, 1);
bob.draw_times = 1:2:bob.max_iterations;
bob.resistance = zeros(bob.max_iterations,1);
bob.time = NaT(bob.max_iterations,1);
bob.loop_time = NaN(bob.max_iterations,1);
bob.history = cell(bob.max_iterations,1);
bob.outputs = zeros(bob.max_iterations,15);
bob.voltage = zeros(bob.max_iterations,1);

% Create the responder object with listeners
zoe = responder(bob); %#ok<NASGU>

% Create the app
if bob.live_plot

    if bob.using_app && ~isempty(options.app)

        app = options.app;

    else

        app = arda_app();
        app.RunButton.Enable = "off";
        app.CreateNewButton.Enable = "off";
        app.LoadExistingButton.Enable = "off";
        app.EditCurrentButton.Enable = "off";
        app.HeaterDropDown.Value = bob.heater;
        app.max_iterationsEditField_2.Value = bob.max_iterations;
        app.LivePlotCheckBox.Value = bob.live_plot;
        app.SimulationonlyCheckBox.Value = bob.simulation_only;
        app.UsingArduinoHardwareCheckBox.Value = bob.using_arduino_hardware;
        app.UsingNIHardwareCheckBox.Value = bob.using_ni_hardware;
        app.ProgressBarCheckBox.Value = bob.progress_bar;
        app.UsingLIDARCheckBox.Value = bob.using_lidar;
        app.UsingRHsensorCheckBox.Value = bob.using_relative_humidity_sensor;
        app.UsingloadcellCheckBox.Value = bob.using_load_cell;

    end

    plot(app.UIAxes_profile, bob.t(end-1), bob.s, '-r');
    app.UIAxes_profile.XLim = [0 bob.max_iterations];

    app.UIAxes_profile.YLim = [20 40];
    hold(app.UIAxes_profile,'on')
    for ii = 1:length(bob.t)
        plot(app.UIAxes_profile, bob.t(ii) * ones(length(app.UIAxes_profile.YLim),1),...
            app.UIAxes_profile.YLim);
    end

    app.UIAxes_12.XLim = [0 bob.max_iterations];
    app.UIAxes_11.XLim = [0 bob.max_iterations];
    app.UIAxes_10.XLim = [0 bob.max_iterations];
    app.UIAxes_9.XLim = [0 bob.max_iterations];
    app.UIAxes_8.XLim = [0 bob.max_iterations];
    app.UIAxes_7.XLim = [0 bob.max_iterations];
    app.UIAxes_6.XLim = [0 bob.max_iterations];
    app.UIAxes_4.XLim = [0 bob.max_iterations];
    app.UIAxes_15.XLim = [0 bob.max_iterations];
    app.UIAxes_14.XLim = [0 bob.max_iterations];
    app.UIAxes_13.XLim = [0 bob.max_iterations];
    % app.UIAxes_16.XLim = [0 bob.max_iterations];
    % app.UIAxes_17.XLim = [0 bob.max_iterations];
    % app.UIAxes_18.XLim = [0 bob.max_iterations];
    % app.UIAxes_19.XLim = [0 bob.max_iterations];


    app.max_iterationsEditField.Value = bob.max_iterations;
end

% Set the default figure window style
set(0,'DefaultFigureWindowStyle', bob.window_style)

% Run the arda 'startup' methods
bob.setup_sensors();
bob.setup_hardware();

if bob.progress_bar

    fig = uifigure('HandleVisibility', 'on');
    dialog_box = uiprogressdlg(fig,...
        "Title", "Thank you for your patience",...
        "Message", "Starting...", ...
        "Cancelable", "on");
    drawnow

end

bob.define_constants();
c2k = 273.15;

% Set the initial temperatures
if bob.simulation_only

    bob.T_g = bob.T_g + c2k;
    bob.T_h = bob.T_h + c2k;

else
    if bob.using_ni_hardware

        daq_data = read(bob.ni_daq_obj);
        bob.T_g = daq_data.cDAQ1Mod8_ai1 + c2k;
        bob.T_h = daq_data.cDAQ1Mod8_ai3 + c2k;

    elseif bob.using_arduino_hardware

        % Data is captured in set_initial_conditions

    end
end

% Establish a consistent set of ICs
bob.set_initial_conditions();

% Create nonlinear mpc
bob.controller = controller_mpc(bob.x_0, "type", "linear");
save bob.mat bob

test_model = "simple_arda_mpc";
load_system(test_model)
set_param(test_model, "SolverType","Variable-step")
set_param("plant", "SolverType", "Variable-step")
%simout = sim(test_model,"TimeOut", 600);

tuning_model = "simple_arda_mpc_tune_me";
load_system(tuning_model)
set_param(tuning_model, "SolverType","Variable-step")

%simout = sim(tuning_model,"TimeOut", 4.9);

open_system("arda_hybrid")



return
% % Create and define the temperature controller
% bob.pid = controller_pid();
% bob.define_temperature_controller();
%
% % Create and define the relative humidity controller
% bob.pid_phi = controller_pid();
% bob.define_relative_humidity_controller();

% Update the progress bar
if bob.progress_bar

    dialog_box.Message = "Processing...";
    drawnow

end




% Notify listeners of events. She then runs the code for those states.
notify(bob, "prestartup")
notify(bob, "startup")
notify(bob, "selftest")

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
    close(dialog_box)
    close(fig)
end

% Set the default figure window style back to normal
set(0,"DefaultFigureWindowStyle","normal")

% Delete / Stop stuff
bob.arduino_daq_obj = []; % Remove before saving. Not saved anyway.

if ~isempty(bob.pipe)
    try
        pipe = bob.pipe;
        pipe.stop();
    catch er
        warning(er.message)
    end
end

if exist('app','var')
    app.RunButton.Enable = "on";
    app.CreateNewButton.Enable = "on";
    app.LoadExistingButton.Enable = "on";
    app.EditCurrentButton.Enable = "on";
end

if bob.delete_app_on_completion
    delete(app) % Save this for later
end

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
        % bob.temperature_setpoint = bob.T_g;
        bob.s = bob.s + bob.temperature_setpoint + c2k;

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

        T_cold = 20; % C
        R_cold = 120; % Ohms (measured)
        T_hot = 400; % C
        R_hot = R_cold*1.5; % Ohms (guess)
        bob.slope = (R_cold - R_hot)/(T_cold - T_hot);
        t = 0.02; % sec
        k = ones(t*100, 1); % column vector

        x = bob.x_0; % initial state
        last_control = [0 0 0];
        ref = [300 0.5 0.1];
        y = zeros(3, bob.max_iterations); % mpc simulation outputs
        if strcmp(bob.controller.type, 'linear')

            controller_state_obj = mpcstate(bob.controller.mpc1);

        end

        %% Loop
        for i = 1:bob.max_iterations

            t_start = tic;

            %% Tune new controller
            if bob.parallel

                % When needed, tune a new controller on a separate worker
                if ~exist("F","var")

                    % Call function on separate worker
                    warning("off","MATLAB:hwsdk:general:nosave")
                    F2 = parfeval(@bob.tune_new_controller, 1);
                    warning("on","MATLAB:hwsdk:general:nosave")

                else

                    % If F2 has its returned output arguments, fetch them
                    if numel(F2.OutputArguments) > 0

                        B2 = fetchOutputs(F2); %#ok<NASGU>
                        clearvars F2

                    end

                end

            end

            %% Controller
            %             if round(bob.T_g) <= length(bob.controllers)
            %                 C = bob.controllers{round(bob.T_g)};
            %             else
            %                 C = bob.controllers{end};
            %             end
            %             bob.pid.K_p = C.Kp;
            %             bob.pid.K_i = C.Ki;
            %             bob.pid.K_d = C.Kd;

            % Calculate output for temperature controller
            %             bob.pid.calculate_controller_output(bob.setpoints(i), bob.T_g);
            %             if i < 10
            %                 bob.pid.out = 0;
            %             end
            %             bob.P_h(i) = bob.pid.out;

            %% MPC
            % Set references
            ref(1) = bob.setpoints(i);
            ref(2) = 0.5;
            ref(3) = 0.1;

            % Calculate controller output

            %% linear mpc
            if strcmp(bob.controller.type, 'linear')

                if i == 1

                    mv = mpcmove(bob.controller.mpc1, controller_state_obj,...
                        bob.controller.mpc1.Model.Nominal.Y, ref, []);

                else

                    mv = mpcmove(bob.controller.mpc1, controller_state_obj,...
                        y(:,i-1), ref, []);

                end

            elseif strcmp(bob.controller.type, 'nonlinear')

                %% nonlinear mpc
                mv = nlmpcmove(bob.controller.nlmpc1, x, last_control, ref); % Calculate next mv
                last_control = mv;

            end

            bob.V_h(i) = mv(1);

            % mv(2) = mv(2)/bob.controller.nlmpc1.Ts; % Adjust steam from kg/s to kg/Ts




            %% Actuator
            % When using the Arduino, the heater can only be on or off
            if ~bob.simulation_only

                % If the heater is connected to the arduino
                if strcmp(bob.heater, "arduino")

                    % Any commanded output turns the heater full on,
                    % otherwise, turn it off
                    if bob.pid.out > 0

                        writeDigitalPin(bob.arduino_daq_obj,"D2",1);  % ON

                    else

                        writeDigitalPin(bob.arduino_daq_obj,"D2",0);  % OFF

                    end
                    pause(1) % Don't burn out the Arduino relay

                elseif strcmp(bob.heater, "ni") % If heater is connected to

                    % Set size of watchdog timer
                    if i < 10
                        A(:,1) = 3*ones(size(k,1), 1);
                    else
                        A(:,1) = zeros(size(k,1), 1);
                    end

                    % Heater
                    bob.resistance(i) = bob.slope * (bob.T_h-c2k) + R_cold;
                    bob.voltage(i) = min(sqrt(bob.resistance(i)*bob.pid.out),...
                        10); % NI9263 outputs 0-10V
                    A(:,2) = k*bob.voltage(i); % A must be MxN where N is number of channels

                    % copy value to watchdog
                    %A(:,1) = bob.voltage*A(:,1);

                    % Read/write to/from the DAQ
                    bob.time(i) = datetime('now');
                    data = readwrite(bob.ni_daq_obj, A);

                end
            end

            %% Controller
            % Calculate output for humidity controller
            %             bob.pid_phi.calculate_controller_output(...
            %                 bob.relative_humidity_setpoint, bob.phi);
            %             bob.m_steam(i) = bob.pid_phi.out;

            %% Actuator: steam
            %             if ~bob.simulation_only && bob.using_arduino_hardware
            %
            %                 if bob.pid_phi.out > 0
            %
            %                     writeDigitalPin(bob.arduino_daq_obj, "D6",1); % light
            %                     pause(bob.pid_phi.out)
            %                     writeDigitalPin(bob.arduino_daq_obj, "D6",0); % light
            %
            %                 end
            %
            %             end
            %% Plant Model
            % On the first time through the loop, use the x_0 above,
            % otherwise, use the output of the ode.
            %             if i >= 2
            %
            %                 % bob.x_0 = y(end,:);
            %                 x = y(end,:);
            %
            %             end

            % Call ode solver
            % [~,y] = ode23(@(t,y)odefun(t,y,bob),[0 bob.step_size],bob.x_0);
            %             x = state_function(x, mv) + x;
            %             o(:,i) = output_function(x, mv);

            y(:,i) = bob.controller.mpc1.Model.Plant.C * x + ...
                bob.controller.mpc1.Model.Plant.D * mv;

            x = bob.controller.mpc1.Model.Plant.A * x + ...
                bob.controller.mpc1.Model.Plant.B * mv;


            %% Acquire data from hardware sensors
            % If using hardware sensors, overwrite the simulated values
            if ~bob.simulation_only

                if bob.using_ni_hardware

                    if bob.parallel

                        try
                            % It is possible to poll the queue on the
                            % worker before it's ready and get invalid
                            % values, so this is in a try
                            y(end,1) = poll(p) + c2k;  % T_g
                            y(end,2) = poll(p) + c2k;  % T_h

                        catch

                            %disp(er.message)

                        end

                    else
                        if strcmp(bob.heater,"ni")

                            % If not using parpool, acquire data locally.
                            y(end,1) = data.cDAQ1Mod8_ai1(1) + c2k; % T_g
                            y(end,2) = data.cDAQ1Mod8_ai3(1) + c2k; % T_h
                            bob.V2(i) = data.cDAQ1Mod5_ai0(1);

                        end


                        if bob.using_relative_humidity_sensor

                            % data2 = read(bob.ni_daq_obj);
                            y(end,9) = data.cDAQ1Mod5_ai1(1) *...
                                bob.vaisala1_output1_conversion_factor;

                        end
                    end
                end


                if bob.using_arduino_hardware
                    if ~bob.using_relative_humidity_sensor
                        % Read humidity values from the arduino hardware
                        y(end,9) = readHumidity(bob.sensor_dht22);
                    end
                end
            end

            if bob.using_lidar
                % Obtain frames from streaming device
                bob.frame_set = bob.pipe.wait_for_frames();

                % Select depth frame
                bob.depth = bob.frame_set.get_depth_frame();
                % bob.color = bob.frames.get_color_frame();

                % Produce point cloud
                if bob.depth.logical() % && bob.color.logical()

                    % bob.point_cloud.map_to(bob.color);
                    bob.points = bob.point_cloud.calculate(bob.depth);

                    % Adjust frame coord. system to MATLAB coord sys
                    bob.vertices = bob.points.get_vertices();
                    bob.X = bob.vertices(:,1,1);
                    bob.Y = bob.vertices(:,2,1);
                    bob.Z = bob.vertices(:,3,1);
                    %                     fprintf("mean(Z): %.3f\n", mean(bob.Z))
                    %                     fprintf("max(Z): %.3\n", max(bob.Z))
                end
            end

            if bob.using_load_cell

                raw_str = readline(bob.load_cell_obj);
                raw_char = char(raw_str);
                bob.weight_lb = -1 * str2double(raw_char(1:8));
                bob.mass_kg = bob.weight_lb / 2.2046226218488;

            end

            % Manage output data
            if ~strcmp(bob.heater,"ni")
                bob.time(i) = datetime('now');
            end
            %             bob.outputs(i,1:12) = y(end,:);
            bob.outputs(i,1:12) = x';
            bob.T_g = bob.outputs(i,1); %disp(bob.T_g)
            bob.T_h = bob.outputs(i,2); %disp(bob.T_h)
            bob.phi = bob.outputs(i,8); %disp(bob.phi)
            bob.T_o = bob.outputs(i,3);
            bob.p_v = bob.outputs(i,5);
            bob.p_a = bob.outputs(i,6);
            bob.p_s = bob.outputs(i,9);
            bob.m_v = bob.outputs(i,10);
            bob.flow = bob.outputs(i,12);
            bob.outputs(i,13) = bob.V_h(i);

            % If user has opted for a live plot of the date during the run
            if bob.live_plot

                if ~exist('app','var')

                    turn_off(bob)
                    break

                else

                    % Update the gauges
                    app.T_gEditField.Value = bob.T_g - c2k;
                    app.T_hEditField.Value = bob.T_h - c2k;
                    app.T_oEditField.Value = bob.T_o - c2k;
                    app.p_gEditField.Value = bob.p_g;
                    app.p_vEditField.Value = bob.p_v;
                    app.p_aEditField.Value = bob.p_a;
                    app.V_gEditField.Value = bob.V_g;
                    app.phiEditField.Value = bob.phi;
                    app.m_vEditField.Value = bob.m_v;
                    app.m_aEditField.Value = bob.m_a;
                    app.P_hEditField.Value = bob.V_h(i);
                    app.p_sEditField.Value = bob.p_s;
                    app.iEditField.Value = i;


                    if ~bob.simulation_only && strcmp(bob.heater, 'ni')
                        app.V_hEditField.Value = bob.voltage(i);
                    end
                    app.m_dotEditField.Value = 0;
                    app.vEditField.Value = 0;
                    app.MasstotalmeasuredkgEditField.Value = bob.mass_kg;

                    if bob.using_lidar
                        app.DistanceLIDARtomaterialmEditField.Value =...
                            mean(abs(bob.Z(bob.Z > mean(bob.Z))));
                    end


                    L = length(bob.outputs(:,1));
                    xx = 1:L;
                    xx_16 = 1:length(bob.V_h);

                    yy_profile = bob.outputs(:,1) - c2k;
                    yy_12 = yy_profile;
                    yy_11 = bob.outputs(:,2) - c2k;
                    yy_10 = bob.outputs(:,3) - c2k;
                    yy_9 = bob.outputs(:,4);
                    yy_8 = bob.outputs(:,5);
                    yy_7 = bob.outputs(:,6);
                    yy_6 = bob.outputs(:,7);
                    yy_4 = bob.outputs(:,9);
                    yy_15 = bob.outputs(:,10);
                    yy_14 = bob.outputs(:,11);
                    yy_13 = bob.outputs(:,12);
                    yy_16 = bob.V_h;
                    yy_17 = bob.voltage;
                    yy_18 = zeros(L,1);
                    yy_19 = zeros(L,1);

                    if i == 1

                        line_profile = plot(app.UIAxes_profile, xx(1:i), yy_profile(1:i), '.b');
                        line_profile.XDataSource = 'xx';
                        line_profile.YDataSource = 'yy_profile';

                        line_12 = plot(app.UIAxes_12, xx(1:i), yy_12(1:i), '.b');
                        line_12.XDataSource = 'xx';
                        line_12.YDataSource = 'yy_12';

                        line_11 = plot(app.UIAxes_11, xx(1:i), yy_11(1:i), '.b');
                        line_11.XDataSource = 'xx';
                        line_11.YDataSource = 'yy_11';

                        line_10 = plot(app.UIAxes_10, xx(1:i), yy_10(1:i), '.b');
                        line_10.XDataSource = 'xx';
                        line_10.YDataSource = 'yy_10';

                        line_9 = plot(app.UIAxes_9, xx(1:i), yy_9(1:i), '.b');
                        line_9.XDataSource = 'xx';
                        line_9.YDataSource = 'yy_9';

                        line_8 = plot(app.UIAxes_8, xx(1:i), yy_8(1:i), '.b');
                        line_8.XDataSource = 'xx';
                        line_8.YDataSource = 'yy_8';

                        line_7 = plot(app.UIAxes_7, xx(1:i), yy_7(1:i), '.b');
                        line_7.XDataSource = 'xx';
                        line_7.YDataSource = 'yy_7';

                        line_6 = plot(app.UIAxes_6, xx(1:i), yy_6(1:i), '.b');
                        line_6.XDataSource = 'xx';
                        line_6.YDataSource = 'yy_6';

                        line_4 = plot(app.UIAxes_4, xx(1:i), yy_4(1:i), '.b');
                        line_4.XDataSource = 'xx';
                        line_4.YDataSource = 'yy_4';

                        line_15 = plot(app.UIAxes_15, xx(1:i), yy_15(1:i), '.b');
                        line_15.XDataSource = 'xx';
                        line_15.YDataSource = 'yy_15';

                        line_14 = plot(app.UIAxes_14, xx(1:i), yy_14(1:i), '.b');
                        line_14.XDataSource = 'xx';
                        line_14.YDataSource = 'yy_14';

                        line_13 = plot(app.UIAxes_13, xx(1:i), yy_13(1:i), '.b');
                        line_13.XDataSource = 'xx';
                        line_13.YDataSource = 'yy_13';

                        line_16 = plot(app.UIAxes_16, xx_16(1:i), yy_16(1:i), '.b');
                        line_16.XDataSource = 'xx_16';
                        line_16.YDataSource = 'yy_16';

                        if ~bob.simulation_only && strcmp(bob.heater, 'ni')
                            line_17 = plot(app.UIAxes_17, xx(1:i), yy_17(1:i), '.b');
                            line_17.XDataSource = 'xx';
                            line_17.YDataSource = 'yy_17';
                        end

                        line_18 = plot(app.UIAxes_18, xx(1:i), yy_18(1:i), '.b');
                        line_18.XDataSource = 'xx';
                        line_18.YDataSource = 'yy_18';

                        line_19 = plot(app.UIAxes_19, xx(1:i), yy_19(1:i), '.b');
                        line_19.XDataSource = 'xx';
                        line_19.YDataSource = 'yy_19';

                    else

                        refreshdata(app.UIAxes_profile,'caller')
                        refreshdata(app.UIAxes_12,'caller')
                        refreshdata(app.UIAxes_11,'caller')
                        refreshdata(app.UIAxes_10,'caller')
                        refreshdata(app.UIAxes_9,'caller')
                        refreshdata(app.UIAxes_8,'caller')
                        refreshdata(app.UIAxes_7, 'caller')
                        refreshdata(app.UIAxes_6, 'caller')
                        refreshdata(app.UIAxes_4, 'caller')
                        refreshdata(app.UIAxes_15, 'caller')
                        refreshdata(app.UIAxes_14, 'caller')
                        refreshdata(app.UIAxes_13, 'caller')
                        refreshdata(app.UIAxes_16, 'caller')

                        if ~bob.simulation_only && strcmp(bob.heater, 'ni')
                            refreshdata(app.UIAxes_17, 'caller')
                        end

                        refreshdata(app.UIAxes_18, 'caller')
                        refreshdata(app.UIAxes_19, 'caller')

                    end

                    app.ElapsedTimeTextArea.Value = string(bob.time(i) -...
                        bob.time(1));

                    if bob.using_lidar

                        bob.Z(abs(bob.Z) > abs(max(bob.Z)) - 0.01) = NaN;

                        plot3(app.UIAxes_lidar, bob.X, bob.Y, -1*bob.Z, '.')
                        view(app.UIAxes_lidar, [0 0]) % [azimuth, elevation]
                        xlim(app.UIAxes_lidar, [-0.5 0.5])
                        ylim(app.UIAxes_lidar, [-0.5 0.5])
                        zlim(app.UIAxes_lidar, [-max(bob.Z)-0.05 -max(bob.Z)]...
                            + 0.05)
                        xlabel(app.UIAxes_lidar, 'X')
                        ylabel(app.UIAxes_lidar, 'Y')
                        zlabel(app.UIAxes_lidar, 'Z')

                    end
                end
            end


            %% Insert errors as necessary
            stuff_happens(bob);  % Defined below as sub-function


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

                dialog_box.Value = i/bob.max_iterations;
                drawnow

                if dialog_box.CancelRequested
                    break
                end

            end

            %% Continuously save everything
            bob.loop_time(i) = toc(t_start);
            bob.history{i} = bob;
            save(fullfile(folder2save2, ['arda_' str2 '.mat']), 'bob')

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

function turn_off(obj)

readwrite(obj.ni_daq_obj, [0;0])

end
