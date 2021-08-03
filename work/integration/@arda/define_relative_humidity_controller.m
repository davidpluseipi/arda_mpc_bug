function define_relative_humidity_controller(arda)

arda.pid_phi.Ts = arda.settings.T_s;
arda.pid_phi.tau = 59;
tau_dead = 0.1;
P2 = (0.1001 - 0.001)/0.001;
N2 = ((0.3 - 0.2)/0.2) / arda.pid_phi.tau;
L2 = 0.1; % tau_dead
R2 = tau_dead / arda.pid_phi.tau;
K_02 = P2 / (N2 * L2);

arda.pid_phi.Kp = K_02 * (1.33 + R2/4);
arda.pid_phi.Ki = (L2 * (30 + 3*R2) / (9 + 20 * R2));
arda.pid_phi.Kd = (4 * L2 / (11 + 2 * R2));
arda.pid_phi.min_output = 0;
arda.pid_phi.max_output = 1;
end