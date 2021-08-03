function calculate_controller_output(controller_pid, setpoint, measurement)

% Error signal
error = setpoint - measurement;
controller_pid.integral_of_error = controller_pid.integral_of_error ...
    + error * controller_pid.Ts;
controller_pid.derivative_of_measurement = (measurement ...
    - controller_pid.previous_measurement)...
    / controller_pid.Ts;

% Proportional
controller_pid.proportional = controller_pid.Kp * error;

% Integral
controller_pid.integrator = controller_pid.Ki / controller_pid.tau ...
    * controller_pid.integral_of_error;

% Derivative (band limited differentiator)
% Doing derivative on measurement instead of error to avoid "kick" on
% setpoint changes.
controller_pid.differentiator = controller_pid.Kd * controller_pid.tau ...
    * controller_pid.derivative_of_measurement;

% Compute limits and apply limits
controller_pid.out = controller_pid.proportional + controller_pid.integrator ...
    + controller_pid.differentiator;

% Anti-windup
% Check upper limit
if controller_pid.out > controller_pid.max_output
    
    controller_pid.out = controller_pid.max_output;
    controller_pid.integral_of_error = controller_pid.integral_of_error ...
        - error * controller_pid.Ts;
    
end   

% Check lower limit
if controller_pid.out < controller_pid.min_output
    
    controller_pid.out = controller_pid.min_output;
    controller_pid.integral_of_error = controller_pid.integral_of_error ...
        - error * controller_pid.Ts;
    
end 


% Store variables for subsequent iterations
controller_pid.previous_error = error;
controller_pid.previous_measurement = measurement;

end
