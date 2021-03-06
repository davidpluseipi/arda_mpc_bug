function define_temperature_controller(arda)

if arda.simulation_only
    tau = 2532;
    tau_dead = 10;
    P = (197.1 - 97.1)/97.1; % Percent change of input
    N = ((25.81 - 22.87)/22.87) / tau; % Percent change of output / tau
    L = tau_dead;
    R = tau_dead / tau;
    K_0 = P/(N*L);
    % Cohen-Coon 1(only for self-regulating processes, like flow, temp, pressure)
    arda.pid.K_p = K_0 * (1.33 + R/4);
    arda.pid.K_i = (L * (30 + 3*R) / (9 + 20 * R));
    arda.pid.K_d = (4 * L / (11 + 2 * R));
    arda.pid.tau = tau;
    arda.pid.min_output = 0;
    arda.pid.max_output = 11000;
else
    if round(arda.T_g) <= length(arda.controllers)
        C = arda.controllers{round(arda.T_g)};
    else
        C = arda.controllers{end};
    end
    arda.pid.K_p = C.Kp;
    arda.pid.K_i = C.Ki;
    arda.pid.K_d = C.Kd;
    arda.pid.b = C.b;
    arda.pid.c = C.c;
    arda.pid.tau = 1;
    arda.pid.min_output = 0;
    arda.pid.max_output = 5/6;
    
    %     arda.pid.K_p = 0.0179;
    %     arda.pid.K_i = 1.37e-6;
    %     arda.pid.K_d = 0;
    %     arda.pid.tau = 1;
    %     arda.pid.min_output = 0;
    %     arda.pid.max_output = 5/6;
    
    %     arda.pid.K_p = 63.7;
    %     arda.pid.K_i = 3.51;
    %     arda.pid.K_d = 0;
    %     arda.pid.tau = 1;
    %     arda.pid.min_output = 0;
    %     arda.pid.max_output = 5/6;
end

end