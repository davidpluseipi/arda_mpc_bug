function calculate_controller_output(controller_pid, setpoint, measurement)



y = measurement;
r = setpoint;
b = controller_pid.b;
c = controller_pid.c;


% Error signal
e = r - y;
if controller_pid.previous_measurement ~= 0
    controller_pid.integral_of_error = controller_pid.integral_of_error ...
        + e * controller_pid.step_size;
    
    controller_pid.derivative_of_measurement = ...
        (y - controller_pid.previous_measurement) / controller_pid.step_size;
    drdt = 0;
    % Proportional component
    controller_pid.proportional = controller_pid.K_p * (b*r-y);
    
    % Integral
    controller_pid.integrator = controller_pid.K_i / controller_pid.tau ...
        * controller_pid.integral_of_error;
    
    % Derivative (band limited differentiator)
    % Doing derivative on measurement instead of error to avoid "kick" on
    % r changes.
    controller_pid.differentiator = ...
        controller_pid.K_d ...
        * controller_pid.tau ...
        * (c*drdt - controller_pid.derivative_of_measurement);
    
    % Compute limits and apply limits
    controller_pid.out = controller_pid.proportional + controller_pid.integrator ...
        + controller_pid.differentiator;
    
    % Anti-windup
    % Check upper limit
    if controller_pid.out > controller_pid.max_output
        
        controller_pid.out = controller_pid.max_output;
        controller_pid.integral_of_error = controller_pid.integral_of_error ...
            - e * controller_pid.step_size;
        
    end
    
    % Check lower limit
    if controller_pid.out < controller_pid.min_output
        
        controller_pid.out = controller_pid.min_output;
        controller_pid.integral_of_error = controller_pid.integral_of_error ...
            - e * controller_pid.step_size;
        
    end
end

% Store variables for subsequent iterations
controller_pid.previous_error = e;
controller_pid.previous_measurement = y;

end
