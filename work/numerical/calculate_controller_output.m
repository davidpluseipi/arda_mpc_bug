function [pid] = calculate_controller_output(pid, setpoint, measurement)

% Error signal
error = setpoint - measurement;
pid.integral_of_error = pid.integral_of_error + error * pid.Ts;
pid.derivative_of_measurement = (measurement - pid.previous_measurement)...
    / pid.Ts;

% Proportional
pid.proportional = pid.Kp * error;

% Integral
pid.integrator = pid.Ki / pid.tau * pid.integral_of_error;

% Derivative (band limited differentiator)
% Doing derivative on measurement instead of error to avoid "kick" on
% setpoint changes.
pid.differentiator = pid.Kd * pid.tau * pid.derivative_of_measurement;

% Compute limits and apply limits
pid.out = pid.proportional + pid.integrator + pid.differentiator;

% Anti-windup
% Check upper limit
if pid.out > pid.max_output
    
    pid.out = pid.max_output;
    pid.integral_of_error = pid.integral_of_error - error * pid.Ts;
    
end   

% Check lower limit
if pid.out < pid.min_output
    
    pid.out = pid.min_output;
    pid.integral_of_error = pid.integral_of_error - error * pid.Ts;
    
end 


% Store variables for subsequent iterations
pid.previous_error = error;
pid.previous_measurement = measurement;

end
