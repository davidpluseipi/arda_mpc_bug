classdef controller_mpc < handle
    properties
        nlmpc1

        % Output limits
        min_output {mustBeNumeric} = 0
        max_output {mustBeNumeric} = 0

        % State
        x {mustBeNumeric} = zeros(12,1)

        % Last value of manipulated variable
        last_mv {mustBeNumeric} = 0

        % Controller output
        out {mustBeNumeric} = 0
    end

    methods
        % Constructor
        function obj = controller_mpc(x_0)
            if nargin > 1
                error('Too many arguments. controller_mpc class takes 1 argument, x_0')
            end  
            
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
            states(2,1).Max = 273.15 + 400;
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

            states(8,1).Name = "q";
            states(8,1).Units = " ";
            states(8,1).Min = 0;
            states(8,1).Max = 1;
            states(8,1).ScaleFactor = 1;

            states(9,1).Name = "phi";
            states(9,1).Units = "1";
            states(9,1).Min = 0;
            states(9,1).Max = 1;
            states(9,1).ScaleFactor = 1;

            states(10,1).Name = "p_s";
            states(10,1).Units = "kPa";
            states(10,1).Min = 0;
            states(10,1).Max = 106;
            states(10,1).ScaleFactor = 106;

            states(11,1).Name = "m_v";
            states(11,1).Units = "kg";
            states(11,1).Min = 0;
            states(11,1).Max = 5;
            states(11,1).ScaleFactor = states(11,1).Max - states(11,1).Min;

            states(12,1).Name = "m_a";
            states(12,1).Units = "kg";
            states(12,1).Min = 1;
            states(12,1).Max = 2;
            states(12,1).ScaleFactor = 1;

            nlmpc1.States = states;

            %% Output variables
            output_variables(1,1).Name = "T_g";
            output_variables(1,1).Units = "K";
            output_variables(1,1).Min = 273.15 + 20;
            output_variables(1,1).Max = 273.15 + 180;
            output_variables(1,1).MinECR = 1;
            output_variables(1,1).MaxECR = 1;
            output_variables(1,1).ScaleFactor = output_variables(1,1).Max -...
                output_variables(1,1).Min;

            output_variables(2,1).Name = "phi";
            output_variables(2,1).Units = "1";
            output_variables(2,1).Min = 0;
            output_variables(2,1).Max = 1;
            output_variables(2,1).MinECR = 0;
            output_variables(2,1).MaxECR = 0;
            output_variables(2,1).ScaleFactor = 1;

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

            nlmpc1.ManipulatedVariables = manipulated_variables;

            %% Measured disturbances
            nlmpc1.MeasuredDisturbances = [];
                
            %% Weights
            weights = struct(...
                "ManipulatedVariables",[0 0],...     % default 0
                "ManipulatedVariablesRate",[0.1 0.1],...% default 0.1
                "OutputVariables", [1e12 1e6],...         % default 1
                "ECR", 1e5);                            % default 1e5

            nlmpc1.Weights = weights;

            %% Validate
            % State
            x = x_0;

            % Manipulated variables
            mv = [0 0]; 

            % Measured disturbances
            md = [];

            % Parameters
            params = [];

            % References / Setpoints
            ref = [300 0.5]; % [position, velocity]

            % Validate state and output functions
            validateFcns(nlmpc1, x, mv, md, params, ref)

            % Store the controller in object
            obj.nlmpc1 = nlmpc1;
        end

        calculate_mpc_output(controller_mpc, ref, x, last_mv)
    end
end