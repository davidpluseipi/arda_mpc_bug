function [delta] = odefun(~, x, arda)
%% Setup and unpacking
delta = zeros(length(x), 1);
p_v_dot = 0;
p_a_dot = 0;
V_g_dot = 0;

% Constants
C_g = arda.specific_heat_fit_obj(arda.T_g); % J/(kg*K), Specific heat capacity of
C_h = 4660;         % J/(kg*K), Specific heat capacity of the heater
c_p = 0.718;        % Specific heat of air at constant pressure
m_h = 2.8;          % kg, Mass of the heater (about 6 lbs)

%% dT_o/dt
delta(3) = 0; % Constant ambient temperature outside the system

%% dp_g/dt
delta(4) = 0; % Constant total pressure at ambient
p_g2 = arda.p_g + delta(4);

%% dV_g/dt
delta(7) = 0;  % Constant volume for the gas mixture (aRDA volume is fixed)
V_g2 = arda.V_g + delta(7);

%% Change in m_a
% kg/m^3, density of dry air at 20C and 1 atm
arda.rho_a = XDryAir('tK', arda.T_g, 'rho', arda.p_g);

% kg, mass of dry air
m_a2 = arda.rho_a * V_g2;

delta(12) = m_a2 - arda.m_a;

%% dT_g/dt

c1 = 1/(C_g*arda.R_hg) + 1/(C_g * arda.R_go);

c2 = (c_p/C_g) * ((arda.p_a * arda.V_g / arda.R_a) + (arda.p_v * arda.V_g / arda.R_v));

c3 = (c_p/C_g) * ((p_a_dot * x(7) + x(6) * V_g_dot)/ arda.R_a ...
    + ((p_v_dot * x(7) + x(5) * V_g_dot)) / arda.R_v);

% mass_flow_in = 0;
delta(1) = -(c3 + c1)*x(1) + c2/x(1) + x(2)/(C_g*arda.R_hg) + x(3)/(C_g*arda.R_go);
T_g2 = arda.T_g + delta(1);
delta(1) = T_g2 - arda.T_g;

%% Change in m_v
% Call XSteam with pressure in bar (kPa/100), and T in C
p_g_bar = p_g2/100; % convert pressure to bars
T_g_C = T_g2 - 273.15; % convert temperature to C
rho_v2 = XSteam('rho_pt', p_g_bar, T_g_C);
m_v2 = rho_v2 * V_g2;
delta(11) = (m_v2 - arda.m_v) + arda.pid_phi.out; % kg per time step
% m_v2 = m_v + delta(11);

%% dT_h/dt
delta(2) = x(1)/(C_h * m_h * arda.R_hg)...
    - x(2)/(C_h * m_h * arda.R_hg)...
    + arda.pid.out/(C_h * m_h);
%     delta(2) = T_h2 - T_h;
%% dp_s/dt (change in saturation pressure)
% p_s2 = calculate_saturation_pressure(T_g2);
p_s2 = XSteam('psat_T', T_g2);
delta(10) = p_s2 - arda.p_s;

%% dp_v/dt
% p_v2 = q2 * p_g2/(q2 + 0.622);

p_v2 = rho_v2 * arda.T_o / 0.0022;
% h = XSteam('hv_p', p_g2/100);
% s = XSteam('s_pt', p_g2/100, T_g2-273.15);
% p_v2 = XSteam('p_hs', h, s);
% if any(isnan([h s p_v2]))
%     keyboard
% end
if p_v2 > p_g2
    p_v2 = arda.p_v;
end
delta(5) = p_v2 - arda.p_v;

%% dq/dt
% q2 = m_v2 / (m_a2 + m_v2);
% percent of moisture by volume
% pmv2 = p_v2 / p_g2;
% q2 = 0.622 * pmv2 / ((1 - pmv2) + 0.622 * pmv2);
delta(8) = 0;

%% dp_a/dt
% p_a2 = p_g2 - p_v2;
delta(6) = -delta(5);

%% dphi/dt (change in relative humidity)
% m_v2 / calculate_saturation_density(T_g2);
phi2 =  p_v2 / p_s2;
% phi2 =  q2 / (0.622 * (p_s2 / (p_g2 - (1 - 0.622)*p_s2)));
% phi2 = (m_v2/m_a2) / (0.622 * p_s2 / (p_g2 - p_s2))

delta(9) = phi2 - arda.phi;

end