function define_temperature_controller(arda)

arda.pid.K_p = 63.7;
arda.pid.K_i = 3.51;
arda.pid.K_d = 0;
arda.pid.tau = 1;
arda.pid.min_output = 0;
arda.pid.max_output = 10;



%% Controller for large metal rolled up
% % Set the time step
% arda.pid.step_size = arda.step_size;
% 
% tau = 16-20; % horizontal distance of rise
% tau_dead = 20; % delay at onset before any rise occurs
% P = 1; % Percent change of input
% N = ((30 - 23.8)/23.8) / tau; % Percent change of output / tau
% L = tau_dead;
% R = tau_dead / tau;
% K_0 = P/(N*L);
% 
% % Cohen-Coon 1(only for self-regulating processes, like flow, temp, pressure)
% arda.pid.K_p = K_0 * (1.33 + R/4);
% arda.pid.K_i = (L * (30 + 3*R) / (9 + 20 * R));
% arda.pid.K_d = (4 * L / (11 + 2 * R));
% arda.pid.tau = tau;
% arda.pid.min_output = 0;
% if arda.simulation_only
%     arda.pid.max_output = 11000; % Max watts from heater
% elseif arda.using_arduino_hardware
%     arda.pid.max_output = 1;
% end
% if arda.using_ni_hardware
%     arda.pid.max_output = 10;
% end

end