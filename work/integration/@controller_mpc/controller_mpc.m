classdef controller_mpc < handle

    properties

        mpc1
        nlmpc1
        type {mustBeMember(type,{'linear','nonlinear'})} = 'linear'
        use_data {mustBeNumericOrLogical} = false

    end

    methods

        % Constructor
        function obj = controller_mpc(x_0,options)

            arguments

                x_0 (12,1) {mustBeNumeric}
                options.type {mustBeMember(options.type,{'linear','nonlinear'})} = 'linear'
                options.use_data {mustBeNumericOrLogical} = true

            end

            if strcmp(options.type, 'linear')

                obj.type = 'linear';

                if options.use_data == true

                    obj.use_data = true;

                    simout = sim("simple_arda", "TimeOut", 600);

                    try

                        [plant, initial_state] = system_id(simout.logsout);

                    catch er

                        disp(er.message)
                        load("linearized_model.mat","sys")
                        plant = sys;

                    end

                else

                    %% Obtain linear plant model at initial operating point
                    model = "plant";
                    op = operspec(model);

                    % Known initial conditions

                    % Voltage to the heater
                    op.Inputs(1).u = 0; % V
                    op.Inputs(1).Known = true;

                    % Steam injection rate
                    op.Inputs(2).u = 0; % kg/s
                    op.Inputs(2).Known = true;

                    % Voltage to the blower fan
                    op.Inputs(3).u = 0; % m^3/s
                    op.Inputs(3).Known = 0;

                    % Calculate initial condition
                    [point, report] = findop(model, op);

                    % Get nominal values of x,y,and u
                    x0 = [report.States(1).x; report.States(2).x];
                    y0 = [report.Outputs(1).y; report.Outputs(2).y];
                    u0 = [report.Inputs(1).u; report.Inputs(2).u; report.Inputs(3).u];

                    %% Linearize and make new mpc
                    %                 try
                    %                     [A,B,C,D] = dlinmod(model, Ts);
                    %                     plant = ss(A,B,C,D,Ts);
                    %                     method = 1;
                    %                     disp('Linearizing with dlinmod() worked.')
                    %                 catch er
                    %                     disp('dlinmod failed')
                    %                     disp(er.message)
                    plant = linearize(model, point);
                    %                     method = 2;
                    %                     disp('Linearizing with linearize() worked.')
                    %                 end
                end

                disp(plant.D)

                %                 if any(plant.D~=0,'all') && method == 1
                %
                %                     linsys = linearize(model);
                %                     plant = linsys;
                %                     method = 2;
                %                     disp('linearize')
                %
                %                 end

                feedthrough = ~mpc_checkdirectfeedthrough(plant, 3);
                fprintf("feedthrough = %f\n", feedthrough)

                disp("Poles of 'plant':")
                disp(pole(plant))
                n = numel(find(real(eig(plant.A))>1)); % closed loop stable should = 0
                fprintf('Closed-loop stability (should be 0): %d\n', n)

                if ~feedthrough && size(plant,1)~=0


                    sample_time = ceil(plant.Ts);
                    if sample_time < 1
                        sample_time = 1;
                    end
                    c2d_options = c2dOptions("Method","tustin");


                    %%
                    %                     failure = true;
                    %                     while failure
                    %
                    %                         try
                    %
                    %                             sample_time = sample_time/10;
                    if isct(plant)

                        plant = c2d(plant, sample_time, c2d_options);
                        disp('c2d')


                    elseif isdt(plant)

                        plant = d2d(plant, sample_time, 'Tustin');
                        disp('d2d')


                    end
                    %
                    %                             failure = false;
                    %
                    %                         catch er
                    %
                    %                             disp(er.message)
                    %                             failure = true;
                    %
                    %                         end
                    %
                    %
                    %                         if sample_time < 1e-15
                    %
                    %                             break
                    %
                    %                         end
                    %
                    %
                    %                     end

                    % closed loop stable, n should = 0
                    n = numel(find(real(eig(plant.A))>1));
                    fprintf('Closed-loop stability (should be 0): %d\n', n)

                else

                    error('Either feedthrough or plant was empty.')

                end



                %plant.InputGroup.MeasuredDisturbances = 0;
                plant.InputGroup.ManipulatedVariables = 3;
                plant.OutputGroup.Measured = 3;
                %plant.OutputGroup.Unmeasured = 0;
                plant.InputName = {'u1' 'u2' 'u3'};
                plant.OutputName = {'y1' 'y2' 'y3'};





                % Define signal types
                plant = setmpcsignals(plant);

                % Prepare to create MPC object

                % Sample time
                % desired_rise_time = 600;
                sample_time = 60; % round(desired_rise_time/10);
                % Typical starting guess allows 10-20 samples to cover the desired rise time

                % Prediction horizon
                prediction_horizon = 12; %round(desired_rise_time - k); % sec
                % Typically long enough to capture transient reponse and significant dynamic

                % Control horizon
                control_horizon = 2; %round(0.2 * prediction_horizon); % sec
                % Typically 10-20% of % prediction horizon

                % Define variables
                % Plant inputs (manipulated variables)
                mv1 = struct("Name", "u1", "Units", "V");
                mv2 = struct("Name", "u2", "Units", "kg/s");
                mv3 = struct("Name", "u3", "Units", "V");
                % Plant outputs (output variables)
                ov1 = struct("Name", "T_g", "Units", "K");
                ov2 = struct("Name", "phi_g", "Units", " ");
                ov3 = struct("Name", "flow", "Units", "m^3/s");


                % Constraints and constraint softness (phyical limits of the system)
                % Softness. 0 = hard, 1 = average, 20 = large violation allowed

                % Constraint and softness for heater voltage
                mv1.Min = 0;
                mv1.Max = 460;
                mv1.MinECR = 0;
                mv1.MaxECR = 0;
                mv1.ScaleFactor = mv1.Max - mv1.Min;
                mv1.RateMin = -0.001;
                mv1.RateMax = 0.001;
                mv1.RateMinECR = 0.1;
                mv1.RateMaxECR = 0.1;

                % Constraint and softness for steam injection
                mv2.Min = 0;
                mv2.Max = 0.06;
                mv2.MinECR = 0;
                mv2.MaxECR = 0;
                mv2.ScaleFactor = (mv2.Max - mv2.Min) * 0.8e2;
                mv2.RateMin = -1e-12;
                mv2.RateMax = 1e-12;
                mv2.RateMinECR = 0.1;
                mv2.RateMaxECR = 0.1;

                % Constraint and softness for volumetric airflow (blower)
                mv3.Min = 0;
                mv3.Max = 460;
                mv3.MinECR = 0;
                mv3.MaxECR = 0;
                mv3.ScaleFactor = mv3.Max - mv3.Min;
                mv3.RateMin = -1;
                mv3.RateMax = 1;
                mv3.RateMinECR = 0.001;
                mv3.RateMaxECR = 0.001;

                % Constraint and softness for gas mixture temperature
                ov1.Min = 20 + 273.15;
                ov1.Max = 180 + 273.15;
                ov1.MinECR = 0;
                ov1.MaxECR = 0;
                ov1.ScaleFactor = (ov1.Max - ov1.Min)*1e-3;

                % Constraint and softness for gas mixture relative humidity
                ov2.Min = 0;
                ov2.Max = 1;
                ov2.MinECR = 0;
                ov2.MaxECR = 0;
                ov2.ScaleFactor = 1000;

                % Constraint and softness for volumetric airflow (blower)
                ov3.Min = 0;
                ov3.Max = 0.188;
                ov3.MinECR = 0;
                ov3.MaxECR = 0;
                ov3.ScaleFactor = ov3.Max - ov3.Min;

                % Weights
                % 0 = no penalty for violating constraints. (weight > 1) = penalty
                weights = struct('MV', [0 0 0],...
                    'MVRate', 20 * [1 1 1],...
                    'OV', [20 10 1],...
                    'ECR', 100000);

                % Disturbance / Noise Variable
                %dv1 = struct("Name", "disturbance", "Units", " ");


                plant = minreal(plant);

                % Create the object
                mpc_obj = mpc(plant, sample_time, prediction_horizon, control_horizon, weights,...
                    [mv1; mv2; mv3], [ov1; ov2; ov3]);

                %mpc1 = mpc(plant);
                mpc_obj.Model.Nominal = struct('X', initial_state,...
                    'U', [0 0 0], 'Y', [293.15 0.1 0]);

                % Try generating an mpc state object (to look for errors)
                review(mpc_obj)
                xc = mpcstate(mpc_obj);


                obj.mpc1 = mpc_obj;



            elseif strcmp(options.type, 'nonlinear')

                obj.type = 'nonlinear';

                %% Nonlinear MPC
                nlmpc1 = nlmpc(12, 3, 3); % states, outputs, inputs

                % State fcn: Predicts how the plant states evolve over time
                nlmpc1.Model.StateFcn = @(x,u) state_function(x,u);

                % Output fcn: Calculates plant outputs in terms of state & input variables
                nlmpc1.Model.OutputFcn = @(x,u) output_function(x,u);

                % Number of parameters
                nlmpc1.Model.NumberOfParameters = 0;

                % Time step
                nlmpc1.Ts = 1;

                %% State variables
                states(1,1).Name = "T_g";
                states(1,1).Units = "K";
                states(1,1).Min = 273.15 + 20;
                states(1,1).Max = 273.15 + 180;
                states(1,1).ScaleFactor = states(1,1).Max - states(1,1).Min;

                states(2,1).Name = "T_h";
                states(2,1).Units = "K";
                states(2,1).Min = 273.15 + 20;
                states(2,1).Max = 273.15 + 300;
                states(2,1).ScaleFactor = states(2,1).Max - states(2,1).Min;

                states(3,1).Name = "T_o";
                states(3,1).Units = "K";
                states(3,1).Min = 273.15 + 5;
                states(3,1).Max = 273.15 + 35;
                states(3,1).ScaleFactor = states(3,1).Max - states(3,1).Min;

                states(4,1).Name = "p_g";
                states(4,1).Units = "kPa";
                states(4,1).Min = 100;
                states(4,1).Max = 106;
                states(4,1).ScaleFactor = states(4,1).Max - states(4,1).Min;

                states(5,1).Name = "p_v";
                states(5,1).Units = "kPa";
                states(5,1).Min = 0;
                states(5,1).Max = 104;
                states(5,1).ScaleFactor = states(5,1).Max - states(5,1).Min;

                states(6,1).Name = "p_a";
                states(6,1).Units = "kPa";
                states(6,1).Min = 0;
                states(6,1).Max = 104;
                states(6,1).ScaleFactor = states(6,1).Max - states(6,1).Min;

                states(7,1).Name = "V_g";
                states(7,1).Units = "m^3";
                states(7,1).Min = 0.20;
                states(7,1).Max = 0.30;
                states(7,1).ScaleFactor = states(7,1).Max - states(7,1).Min;

                states(8,1).Name = "phi";
                states(8,1).Units = "1";
                states(8,1).Min = 0;
                states(8,1).Max = 1;
                states(8,1).ScaleFactor = 1;

                states(9,1).Name = "p_s";
                states(9,1).Units = "kPa";
                states(9,1).Min = 0;
                states(9,1).Max = 106;
                states(9,1).ScaleFactor = 106;

                states(10,1).Name = "m_v";
                states(10,1).Units = "kg";
                states(10,1).Min = 0;
                states(10,1).Max = 5;
                states(10,1).ScaleFactor = states(10,1).Max - states(10,1).Min;

                states(11,1).Name = "m_a";
                states(11,1).Units = "kg";
                states(11,1).Min = 1;
                states(11,1).Max = 2;
                states(11,1).ScaleFactor = 1;

                states(12,1).Name = "flow";
                states(12,1).Units = "m^3/s";
                states(12,1).Min = 0;
                states(12,1).Max = 0.188;
                states(12,1).ScaleFactor = states(12,1).Max - states(12,1).Min;

                nlmpc1.States = states;

                %% Output variables
                output_variables(1,1).Name = "T_g";
                output_variables(1,1).Units = "K";
                output_variables(1,1).Min = 273.15 + 20;
                output_variables(1,1).Max = 273.15 + 180;
                output_variables(1,1).MinECR = 0;
                output_variables(1,1).MaxECR = 0;
                output_variables(1,1).ScaleFactor = output_variables(1,1).Max -...
                    output_variables(1,1).Min;

                output_variables(2,1).Name = "phi";
                output_variables(2,1).Units = "1";
                output_variables(2,1).Min = 0;
                output_variables(2,1).Max = 1;
                output_variables(2,1).MinECR = 0;
                output_variables(2,1).MaxECR = 0;
                output_variables(2,1).ScaleFactor = 1;

                output_variables(3,1).Name = "flow";
                output_variables(3,1).Units = "m^3/s";
                output_variables(3,1).Min = 0;
                output_variables(3,1).Max = 0.188;
                output_variables(3,1).MinECR = 0;
                output_variables(3,1).MaxECR = 0;
                output_variables(3,1).ScaleFactor = output_variables(3,1).Max -...
                    output_variables(3,1).Min;

                nlmpc1.OutputVariables = output_variables;

                %% Manipulated variables
                manipulated_variables(1,1).Name = "heater";
                manipulated_variables(1,1).Units = "V";
                manipulated_variables(1,1).Min = 0;
                manipulated_variables(1,1).Max = 460;
                manipulated_variables(1,1).MinECR = 0;
                manipulated_variables(1,1).MaxECR = 0;
                manipulated_variables(1,1).RateMin = -Inf;
                manipulated_variables(1,1).RateMax = Inf;
                manipulated_variables(1,1).RateMinECR = 1;
                manipulated_variables(1,1).RateMaxECR = 1;
                manipulated_variables(1,1).ScaleFactor = manipulated_variables(1,1).Max -...
                    manipulated_variables(1,1).Min;

                manipulated_variables(2,1).Name = "steam";
                manipulated_variables(2,1).Units = "kg/s";
                manipulated_variables(2,1).Min = 0;
                manipulated_variables(2,1).Max = 0.06;
                manipulated_variables(2,1).MinECR = 0;
                manipulated_variables(2,1).MaxECR = 0;
                manipulated_variables(2,1).RateMin = 0;
                manipulated_variables(2,1).RateMax = 0.06/10;
                manipulated_variables(2,1).RateMinECR = 0;
                manipulated_variables(2,1).RateMaxECR = 1;
                manipulated_variables(2,1).ScaleFactor = manipulated_variables(2,1).Max -...
                    manipulated_variables(2,1).Min;

                manipulated_variables(3,1).Name = "blower";
                manipulated_variables(3,1).Units = "V";
                manipulated_variables(3,1).Min = 0;
                manipulated_variables(3,1).Max = 460;
                manipulated_variables(3,1).MinECR = 0;
                manipulated_variables(3,1).MaxECR = 0;
                manipulated_variables(3,1).RateMin = -Inf;
                manipulated_variables(3,1).RateMax = Inf;
                manipulated_variables(3,1).RateMinECR = 1;
                manipulated_variables(3,1).RateMaxECR = 1;
                manipulated_variables(3,1).ScaleFactor = manipulated_variables(3,1).Max -...
                    manipulated_variables(3,1).Min;

                nlmpc1.ManipulatedVariables = manipulated_variables;

                %% Measured disturbances
                nlmpc1.MeasuredDisturbances = [];

                %% Weights
                weights = struct(...
                    "ManipulatedVariables",[0 0 0],...     % default 0
                    "ManipulatedVariablesRate",[0.1 0.1 0.1],...% default 0.1
                    "OutputVariables", [1e12 1e6 100],...         % default 1
                    "ECR", 1e5);                            % default 1e5

                nlmpc1.Weights = weights;

                %% Validate
                % State
                x = x_0;

                % Manipulated variables
                mv = [0 0 0];

                % Measured disturbances
                md = [];

                % Parameters
                params = [];

                % References / Setpoints
                ref = [300 0.5 0.1]; % [position, velocity]

                % Validate state and output functions
                validateFcns(nlmpc1, x, mv, md, params, ref)

                % Store the controller in object
                obj.nlmpc1 = nlmpc1;

            else

                error('Invalid mpc type.')

            end % linear or nonlinear

        end % constructor

        calculate_mpc_output(controller_mpc, ref, x, last_mv)

    end % methods

end % classdef