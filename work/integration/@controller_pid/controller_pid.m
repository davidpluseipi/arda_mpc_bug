classdef controller_pid < handle
    properties
        % Time step
        Ts {mustBeNumeric} = 1
        
        % Controller gains
        Kp {mustBeNumeric} = 1
        Ki {mustBeNumeric} = 0
        Kd {mustBeNumeric} = 0
        
        % Derivative low-pass filter time constant
        tau {mustBeNumeric} = 0
        
        % Output limits
        min_output {mustBeNumeric} = 0
        max_output {mustBeNumeric} = 0
        
        % Controller "memory"
        integrator {mustBeNumeric} = 0
        previous_error {mustBeNumeric} = 0           % Required for integrator
        differentiator {mustBeNumeric} = 0
        previous_measurement {mustBeNumeric} = 0     % Required for differentiator
        integral_of_error {mustBeNumeric} = 0
        proportional {mustBeNumeric} = 0
        derivative_of_measurement {mustBeNumeric} = 0
        
        % Controller output
        out {mustBeNumeric} = 0
    end
    
    methods
        % Constructor
        function obj = controller_pid()
            if nargin > 0
                error('Too many arguments. controller_pid class takes 0 arguments.')
            end
        end
        
         calculate_controller_output(controller_pid, setpoint, measurement)
    end
end