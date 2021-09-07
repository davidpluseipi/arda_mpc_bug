function calculate_controller_output(controller_pid, setpoint, measurement)

% Error signal
error = setpoint - measurement;
controller_pid.integral_of_error = controller_pid.integral_of_error ...
    + error * controller_pid.step_size;
controller_pid.derivative_of_measurement = (measurement ...
    - controller_pid.previous_measurement)...
    / controller_pid.step_size;

% Proportional
controller_pid.proportional = controller_pid.K_p * error;

% Integral
controller_pid.integrator = controller_pid.K_i / controller_pid.tau ...
    * controller_pid.integral_of_error;

% Derivative (band limited differentiator)
% Doing derivative on measurement instead of error to avoid "kick" on
% setpoint changes.
controller_pid.differentiator = controller_pid.K_d * controller_pid.tau ...
    * controller_pid.derivative_of_measurement;

% Compute limits and apply limits
controller_pid.out = controller_pid.proportional + controller_pid.integrator ...
    + controller_pid.differentiator;

% Anti-windup
% Check upper limit
if controller_pid.out > controller_pid.max_output
    
    controller_pid.out = controller_pid.max_output;
    controller_pid.integral_of_error = controller_pid.integral_of_error ...
        - error * controller_pid.step_size;
    
end   

% Check lower limit
if controller_pid.out < controller_pid.min_output
    
    controller_pid.out = controller_pid.min_output;
    controller_pid.integral_of_error = controller_pid.integral_of_error ...
        - error * controller_pid.step_size;
    
end 


% Store variables for subsequent iterations
controller_pid.previous_error = error;
controller_pid.previous_measurement = measurement;

end
