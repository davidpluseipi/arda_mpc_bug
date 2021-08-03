function define_temperature_controller(arda)


% Set the time step
arda.pid.Ts = arda.settings.T_s;

tau = 2532;
tau_dead = 10;
P = (197.1 - 97.1)/97.1; % Percent change of input
N = ((25.81 - 22.87)/22.87) / tau; % Percent change of output / tau
L = tau_dead;
R = tau_dead / tau;
K_0 = P/(N*L);

% Cohen-Coon 1(only for self-regulating processes, like flow, temp, pressure)
arda.pid.Kp = K_0 * (1.33 + R/4);
arda.pid.Ki = (L * (30 + 3*R) / (9 + 20 * R));
arda.pid.Kd = (4 * L / (11 + 2 * R));
arda.pid.tau = tau;
arda.pid.min_output = 0;
if arda.settings.simulation_only
    arda.pid.max_output = 11000; % Max watts from heater
elseif ~arda.settings.simulation_only && arda.settings.arduino
    arda.pid.max_output = 1;
end
end