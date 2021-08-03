function [delta] = odefun(~, x, arda_obj)
%% Setup and unpacking
pid = arda_obj.pid;
pid_phi = arda_obj.pid_phi;
constants = arda_obj.constants;
fit_obj = arda_obj.specific_heat_fit_obj;
delta = zeros(length(x), 1);
p_v_dot = 0;
p_a_dot = 0;
V_g_dot = 0;


% System variables
T_g = x(1); % T_g0  1) K, initial T_g
T_h = x(2); % T_h0; 2) K, Initial heater temp, T_h
T_o = x(3); % T_o0; 3) K, Initial outside / ambient temp, T_o
p_g = x(4); % p_g0; 4) kPa, Initial total pressure of gas mixture
p_v = x(5); % p_v0; 5) kPa, Initial partial pressure of water vapor
p_a = x(6); % p_a0; 6) kPa, Initial partial pressure of air
V_g = x(7); % V_g0; 7) m^3, Initial volume of the control volume
q   = x(8); %#ok<NASGU> % q_0;  8) Initial humidity ratio
phi = x(9); % phi_0;9) Initial relative humidity
p_s = x(10); % p_s0];10) Initial saturation vapor pressure
m_v = x(11);
m_a = x(12);

% Constants
C_g = fit_obj(T_g); % J/(kg*K), Specific heat capacity of
C_h = 4660;         % J/(kg*K), Specific heat capacity of the heater
c_p = 0.718;        % Specific heat of air at constant pressure
m_h = 2.8;          % kg, Mass of the heater (about 6 lbs)
R_a = constants(1);
R_v = constants(2);
R_go = constants(3);
R_hg = constants(4);

%% dT_o/dt
delta(3) = 0; % Constant ambient temperature outside the system

%% dp_g/dt
delta(4) = 0; % Constant total pressure at ambient
p_g2 = p_g + delta(4);

%% dV_g/dt
delta(7) = 0;  % Constant volume for the gas mixture (aRDA volume is fixed)
V_g2 = V_g + delta(7);

%% Change in m_a
% kg/m^3, density of dry air at 20C and 1 atm
rho_a = XDryAir('tK', T_g, 'rho', p_g);

% kg, mass of dry air
m_a2 = rho_a * V_g2;

delta(12) = m_a2 - m_a;

%% dT_g/dt

c1 = 1/(C_g*R_hg) + 1/(C_g*R_go);

c2 = (c_p/C_g) * ((p_a * V_g/R_a) + (p_v * V_g/R_v));

c3 = (c_p/C_g) * ((p_a_dot * x(7) + x(6) * V_g_dot)/ R_a ...
    + ((p_v_dot * x(7) + x(5) * V_g_dot))/R_v);

% mass_flow_in = 0;
delta(1) = -(c3 + c1)*x(1) + c2/x(1) + x(2)/(C_g*R_hg) + x(3)/(C_g*R_go);
T_g2 = T_g + delta(1);

delta(1) = T_g2 - T_g;

%% Change in m_v
% Call XSteam with pressure in bar (kPa/100), and T in C
p_g_bar = p_g2/100; % convert pressure to bars
T_g_C = T_g2 - 273.15; % convert temperature to C
rho_v2 = XSteam('rho_pt', p_g_bar, T_g_C);
m_v2 = rho_v2 * V_g2;
delta(11) = (m_v2 - m_v) + pid_phi.out; % kg per time step
% m_v2 = m_v + delta(11);

%% dT_h/dt
delta(2) = x(1)/(C_h * m_h * R_hg)...
    - x(2)/(C_h * m_h * R_hg)...
    + pid.out/(C_h * m_h);
%     delta(2) = T_h2 - T_h;
%% dp_s/dt (change in saturation pressure)
% p_s2 = calculate_saturation_pressure(T_g2);
p_s2 = XSteam('psat_T', T_g2);
delta(10) = p_s2 - p_s;

%% dp_v/dt
% p_v2 = q2 * p_g2/(q2 + 0.622);

p_v2 = rho_v2 * T_o / 0.0022;
% h = XSteam('hv_p', p_g2/100);
% s = XSteam('s_pt', p_g2/100, T_g2-273.15);
% p_v2 = XSteam('p_hs', h, s);
% if any(isnan([h s p_v2]))
%     keyboard
% end
if p_v2 > p_g2
    p_v2 = p_v;
end
delta(5) = p_v2 - p_v;

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

delta(9) = phi2 - phi;

end