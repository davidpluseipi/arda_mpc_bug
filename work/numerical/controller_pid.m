classdef controller_pid
    properties
        % Time step
        Ts {mustBeNumeric} = 0.1
        
        % Controller gains
        Kp {mustBeNumeric} = 1
        Ki {mustBeNumeric} = 0
        Kd {mustBeNumeric} = 0
        
        % Derivative low-pass filter time constant
        tau {mustBeNumeric}
        
        % Output limits
        min_output {mustBeNumeric} = 0
        max_output {mustBeNumeric} = 100
        
        % Controller "memory"
        integrator {mustBeNumeric} = 0
        previous_error {mustBeNumeric} = 0           % Required for integrator
        differentiator {mustBeNumeric} = 0
        previous_measurement {mustBeNumeric} = 0     % Required for differentiator
        integral_of_error {mustBeNumeric} = 0
        proportional {mustBeNumeric} = 0
        
        % Controller output
        out {mustBeNumeric} = 0
    end
end