classdef controller_mpc < handle

    properties

        mpc1
        mpc1_initial_state
        nlmpc1
        type {mustBeMember(type,{'linear','nonlinear'})} = 'linear'
        use_data {mustBeNumericOrLogical} = false

    end

    methods

        % Constructor
        function obj = controller_mpc(x_0, options)

            arguments

                x_0 (12,1) {mustBeNumeric}
                options.type {mustBeMember(options.type,{'linear','nonlinear'})} = 'linear'
                options.use_data {mustBeNumericOrLogical} = true

            end

            % Open data dictionary and create data dictionary object
            data_dictionary_obj = Simulink.data.dictionary.open("data_dictionary1.sldd");

            % Open section and create data dictionary section object
            section_obj = getSection(data_dictionary_obj, "Design Data"); % default name
            % Use getEntry and addEntry on section object


            % Sample time
            ts_obj = getEntry(section_obj, "Ts");
            Ts =  ts_obj.getValue;

            if strcmp(options.type, 'linear')

                obj.type = 'linear';

                if options.use_data == true

                    obj.use_data = true;
                    

                    plant_model = "plant"; % Simulink plant model
                    load_system(plant_model) % Loads and opens
                    set_param(plant_model, "SolverType", "Fixed-step");
                    set_param(plant_model, "FixedStep", num2str(Ts))
                    save_system(plant_model)

                    top_model = "simple_arda"; % top level Simulink model
                    load_system(top_model)
                    set_param(top_model, "SolverType","Fixed-step")
                    set_param(top_model, "FixedStep", num2str(Ts))
                    save_system(top_model)


                    % Set the Simscape local solver sample time within the
                    % plant model successfully simulate
                    set_param(strcat(plant_model, "/Solver Configuration"),...
                        'LocalSolverSampleTime', num2str(Ts))
                    save_system(plant_model)

                    % Run the top level model which contains the plant
                    % model as a model reference
                    simout = sim("simple_arda", "TimeOut", 600);

                    % Set it now to the sample time that will be used in
                    % the mpc
                    set_param(strcat(plant_model, "/Solver Configuration"),...
                        'LocalSolverSampleTime','1')
                    % set_param(plant_model, 'SolverType', 'Variable-step');
                    save_system(plant_model)

                    [plant, initial_state] = system_id(simout.logsout);

                else

                    %% Linearize directly from the Simulink model

                    % Obtain linear plant model at initial operating point
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
                    % Note: These 3 variables need to be corrected
                    x0 = [report.States(1).x; report.States(2).x];
                    y0 = [report.Outputs(1).y; report.Outputs(2).y];
                    u0 = [report.Inputs(1).u; report.Inputs(2).u; report.Inputs(3).u];

                    plant = linearize(model, point);

                end

                % Look at the plant's D matrix (should be all zeros if
                % no feedthrough)
                fprintf("Plant D matrix: \n")
                disp(plant.D)

                % Use the MPC toolbox function to check for feedthrough
                fprintf("\nResults from mpc_checkdirectfeedthrough: \n")
                feedthrough = ~mpc_checkdirectfeedthrough(plant, 2);
                fprintf("feedthrough = %d\n", feedthrough)

                fprintf("\nPoles:\n")
                disp(pole(plant))

                n = numel(find(real(eig(plant.A))>1)); % closed loop stable should = 0
                fprintf('\nClosed-loop stability (stable=0): %d\n', n)

                if ~feedthrough && size(plant,1)~=0

                    fprintf("\nSample time for discretization: %.2f\n", Ts)
                    c2d_options = c2dOptions("Method","tustin");
                    fprintf("Previous sample time: %1.1f\n", plant.Ts)

                    if isct(plant)

                        plant = c2d(plant, Ts, c2d_options);
                        fprintf("Plant was continuous, but is now discrete.\n")

                    elseif isdt(plant)

                        plant = d2d(plant, Ts, 'tustin');
                        fprintf("Plant was resampled with d2d().\n")

                    end

                    fprintf("Sample time now: %f\n", plant.Ts)
                    n = numel(find( real(eig(plant.A)) > 1));
                    fprintf('Closed-loop stability (stable=0): %d\n', n)

                else

                    error('Either feedthrough or plant was empty.')

                end

                plant.InputGroup.ManipulatedVariables = 2;
                plant.OutputGroup.Measured = 2;



                % Define signal types
                plant = setmpcsignals(plant);

                sample_time = ts_obj.getValue; % round(desired_rise_time/10);
                % Typical starting guess allows 10-20 samples to cover the desired rise time

                %% create MPC controller object with sample time
                mpc_obj = mpc(plant, sample_time);
                
                % Prediction horizon
                ph_obj = getEntry(section_obj, "prediction_horizon");
                mpc_obj.PredictionHorizon = ph_obj.getValue; % sec
                % Typically long enough to capture transient reponse and significant dynamic
                
                % Control horizon
                ch_obj = getEntry(section_obj, "control_horizon");
                mpc_obj.ControlHorizon = ch_obj.getValue; % sec
                % Typically 10-20% of % prediction horizon
                
                % specify nominal values for inputs and outputs
                mpc_obj.Model.Nominal.U = [0;0];
                mpc_obj.Model.Nominal.Y = [293.15;0.5];
                
                c = cell(2,1);
                c{1} = 'u1';
                c{2} = 'u2';
                mpc_obj.Model.Plant.InputName = c;
                c{1} = 'y1';
                c{2} = 'y2';
                mpc_obj.Model.Plant.y = c;
                
                %% specify constraints for MV and MV Rate
                mpc_obj.MV(1).Min = 0;
                mpc_obj.MV(1).Max = 460;
                mpc_obj.MV(1).RateMin = -0.001;
                mpc_obj.MV(1).RateMax = 0.001;

                mpc_obj.MV(2).Min = 0;
                mpc_obj.MV(2).Max = 0.02;
                mpc_obj.MV(2).RateMin = -1e-12;
                mpc_obj.MV(2).RateMax = 1e-12;

                % specify constraints for OV
                mpc_obj.OV(1).Min = 293.15;
                mpc_obj.OV(1).Max = 453.15;

                mpc_obj.OV(2).Min = 0;
                mpc_obj.OV(2).Max = 1;
                
                % specify scale factors for inputs and outputs
                mpc_obj.MV(1).ScaleFactor = (mpc_obj.MV(1).Max - mpc_obj.MV(1).Min) * 1e-3;
                mpc_obj.MV(2).ScaleFactor = (mpc_obj.MV(2).Max - mpc_obj.MV(2).Min) * 1e1;

                mpc_obj.OV(1).ScaleFactor = (mpc_obj.OV(1).Max - mpc_obj.OV(1).Min) * 1e-2;
                mpc_obj.OV(2).ScaleFactor = mpc_obj.OV(2).Max - mpc_obj.OV(2).Min;

                % specify constraint softening for MV and MV Rate
                mpc_obj.MV(1).MinECR = 0.001;
                mpc_obj.MV(1).MaxECR = 0.001;
                mpc_obj.MV(1).RateMinECR = 0.1;
                mpc_obj.MV(1).RateMaxECR = 0.1;

                mpc_obj.MV(2).MinECR = 0;
                mpc_obj.MV(2).MaxECR = 0.01;
                mpc_obj.MV(2).RateMinECR = 0.1;
                mpc_obj.MV(2).RateMaxECR = 0.1;
                
                % specify constraint softening for OV
                mpc_obj.OV(1).MinECR = 0.001;
                mpc_obj.OV(1).MaxECR = 0.001;

                mpc_obj.OV(2).MinECR = 0.001;
                mpc_obj.OV(2).MaxECR = 0.001;

                % specify weights
                % Manipulated variable weights
                u1_weight_obj = getEntry(section_obj, "u1_wt");
                u2_weight_obj = getEntry(section_obj, "u2_wt");
                u1_weight = u1_weight_obj.getValue;
                u2_weight = u2_weight_obj.getValue;
                
                mpc_obj.Weights.MV = [u1_weight u2_weight];

                % Manipulated variable rate weights
                u1p_weight_obj = getEntry(section_obj, "u1p_wt"); % p for prime, derivative, aka rate
                u2p_weight_obj = getEntry(section_obj, "u2p_wt");
                u1p_weight = u1p_weight_obj.getValue;
                u2p_weight = u2p_weight_obj.getValue;  

                mpc_obj.Weights.MVRate = [u1p_weight u2p_weight];
                
                % Output variable weights
                y1_weight_obj = getEntry(section_obj, "y1_wt");
                y2_weight_obj = getEntry(section_obj, "y2_wt");
                y1_weight = y1_weight_obj.getValue;
                y2_weight = y2_weight_obj.getValue;
               
                mpc_obj.Weights.OV = [y1_weight y2_weight];


                % Slack variable tuning weight (ECR = equal concern for
                % relaxation... used to make all soft constraints harder (increase) or
                % softer (decrease))
                ecr_weight_obj = getEntry(section_obj, "ecr_wt");

                mpc_obj.Weights.ECR = ecr_weight_obj.getValue;
                

                % use custom output disturbance model
                output_disturbance_model = tf({1 0;0 1},{[1 0 0 0],1; 1, [1 0 0 0]});
                setoutdist(mpc_obj, 'model', output_disturbance_model);
                

                % specify simulation options
                options = mpcsimopt();
                options.RefLookAhead = 'on';
                options.MDLookAhead = 'off';
                options.Constraints = 'on';
                options.OpenLoop = 'off';

                % Specify references for simulation
                N = 101;
                reference_signal = ones(N,2);
                reference_signal(1:10, 1) = 293.15;
                reference_signal(11:end, 1) = 294.15;
                reference_signal(1:10, 2) = 0.3;
                reference_signal(11:end, 2) = 0.4;

                measured_disturbance_signal = [];

                % run simulation
                sim(mpc_obj, N, reference_signal, measured_disturbance_signal, options);
                                
                % Try generating an mpc state object (to look for errors)
                mpc_obj.Model.Plant = minreal(mpc_obj.Model.Plant);
                review(mpc_obj)

                try
                    obj.mpc1_initial_state = mpcstate(mpc_obj);
                catch er
                    disp(er.message)
                    obj.mpc1_initial_state = [];
                end

                obj.mpc1 = mpc_obj;

            elseif strcmp(options.type, 'nonlinear')

                obj.type = 'nonlinear';

                %% Nonlinear MPC
                nlmpc1 = nlmpc(12, 2, 2); % states, outputs, inputs

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