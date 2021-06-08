function [T_g, T_h, T_o] = arda_numerical(t_final)

C_g = 1800;         % J/(kg*K), Specific heat capacity of humid air (60% relative humidity)
C_h = 4660;         % J/(kg*K), Specific heat capacity of the heater
c_p = 0.718;        % Specific heat of air at constant volume
m_h = 2.8;          % kg, Mass of the heater
R_a = 287.058;      % J/(kg*K), Specific Gas Constant, dry air
R_v = 461.495;      % J/(kg*K), Specific Gas Constant, water vapor
R_go = 0.03;       % K/W, Thermal resistance of the gas mixture to outside interface
R_hg = 0.005;       % K/W, Thermal resistance of the heater to gax mixture interface

% kPa, Initial pressure of the control volume.
p_g0 = 101.325;

% kg/kg, humidity ratio (mass of vapor to mass of air)
humidity_ratio = 0.03;

% kPa, Initial partial pressure of water vapor
p_v0 = humidity_ratio * p_g0/(humidity_ratio + 0.622);

% kPa, Initial partial pressure of air
p_a0 = p_g0 - p_v0;

C_to_K = 273.15;

x_0 = [20 + C_to_K;  % K, initial T_g
    30 + C_to_K;     % K, Initial heater temp, T_h
    25 + C_to_K;     % K, Initial outside / ambient temp, T_o
    p_g0;            % kPa, total pressure of gas mixture
    p_v0;            % kPa, partial pressure of water vapor
    p_a0;            % kPa, partial pressure of air
    0.25];           % m^3, Initial volume of the control volume (approx.)

[t, y] = ode15s(@(t,y) odefun(t, y, 0, 0, 0), [0 t_final], x_0);
figure
plot(t, y(:,1:3) - C_to_K)
legend({'T_g', 'T_h', 'T_o'},'Location','best')
grid on

T_g = y(:,1) - C_to_K;
T_h = y(:,2) - C_to_K;
T_o = y(:,3) - C_to_K;

    function delta = odefun(~, x, p_v_dot, p_a_dot, V_g_dot)
        delta = zeros(length(x), 1);
        
        c1 = 1/(C_g*R_hg) + 1/(C_g*R_go);
        
        c2 = (c_p/C_g) * (x(6) * x(7)/R_a + (x(5) * x(7)/R_v));
        
        c3 = (c_p/C_g) * ((p_a_dot * x(7) + x(6) * V_g_dot)/ R_a ...
            + ((p_v_dot * x(7) + x(5) * V_g_dot))/R_v);
        
        delta(1) = c3 - c1*x(1) + c2/x(1) + x(2)/(C_g*R_hg) + x(3)/(C_g*R_go); % dT_g/dt
        
        delta(2) = x(1)/(C_h * m_h *R_hg) - x(2)/(C_h * m_h * R_hg); % dT_h/dt
        
        delta(3) = 0; % dT_o/dt, Constant ambient temperature outside the system
        delta(4) = 0; % dp_g/dt, Constant total pressure at ambient
        delta(5) = 0; % dp_v/dt, Constant partial pressure of water (for now)
        delta(6) = 0; % dp_a/dt, Constant partial pressure of air (for now)
        delta(7) = 0; % dV_g/dt, Constant volume for the gas mixture (aRDA volume is fixed)
    end
end