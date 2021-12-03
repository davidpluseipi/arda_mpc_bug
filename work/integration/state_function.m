function dx = state_function(x, u)
%% State function — Predicts how the plant states evolve over time
% Form of state vector
% x = [T_g, T_h, T_o, p_g, p_v,...
%      p_a, V_g, q, phi, p_s,...
%      m_v, m_a];
persistent specific_heat_fit_obj

if isempty(specific_heat_fit_obj)
    specific_heat_fit_obj = load_object();
end
%%
dx = zeros(length(x), 1);

%% Constants
R_a = 287.058;      % J/(kg*K), Specific Gas Constant, dry air
R_v = 461.495;      % J/(kg*K), Specific Gas Constant, water vapor
R_go = 0.03;        % K/W, Thermal resistance of the gas mixture to outside interface (1 inch insulation)
R_hg = 0.005;       % K/W, Thermal resistance of the heater to gax mixture interface
C_g = specific_heat_fit_obj(x(1)); % J/(kg*K), Specific heat capacity
C_h = 4660;         % J/(kg*K), Specific heat capacity of the heater
c_p = 0.718;        % Specific heat of air at constant pressure
m_h = 2.8;          % kg, Mass of the heater (about 6 lbs)

%% dT_o/dt
dx(3) = 0; % Constant ambient temperature outside the system

%% dp_g/dt
dx(4) = 0; % Constant total pressure at ambient
p_g2 = x(4) + dx(4);

%% dV_g/dt
dx(7) = 0;  % Constant volume for the gas mixture (aRDA volume is fixed)
V_g2 = x(7) + dx(7);

%% Change in m_a
% kg/m^3, density of dry air at 20C and 1 atm
rho_a = XDryAir('tK', x(1), 'rho', x(4));
m_a2 = rho_a * V_g2; % kg, mass of dry air
dx(12) = m_a2 - x(12);

%% dT_g/dt
dx(1) = -(1/(C_g*R_hg) + 1/(C_g * R_go))*x(1) +...
    ((c_p/C_g) * ((x(6) * x(7) / R_a) + (x(5) * x(7) / R_v)))/x(1) +...
    x(2)/(C_g*R_hg) + x(3)/(C_g*R_go);
T_g2 = x(1) + dx(1);

%% Change in m_v
% Call XSteam with pressure in bar (kPa/100), and T in C
p_g_bar = p_g2/100; % convert pressure to bars
T_g_C = T_g2 - 273.15; % convert temperature to C
rho_v2 = XSteam('rho_pt', p_g_bar, T_g_C);
m_v2 = rho_v2 * V_g2;
dx(11) = (m_v2 - x(11)) + u(2); % kg per time step
% m_v2 = m_v + delta(11);

%% dT_h/dt
dx(2) = x(1)/(C_h * m_h * R_hg)...
    - x(2)/(C_h * m_h * R_hg)...
    + 15*u(1)/(C_h * m_h);

%% dp_s/dt (change in saturation pressure)
p_s2 = XSteam('psat_T', T_g2);
dx(10) = p_s2 - x(10);

%% dp_v/dt
p_v2 = rho_v2 * x(3) / 0.0022;
if p_v2 > p_g2
    p_v2 = x(5);
end
dx(5) = p_v2 - x(5);

%% dq/dt
dx(8) = 0;

%% dp_a/dt
dx(6) = -dx(5);

%% dphi/dt (change in relative humidity)
phi2 =  p_v2 / p_s2;
dx(9) = phi2 - x(9);

end

function specific_heat_fit_obj = load_object()
if exist('specific_heat_table.mat', 'file')
    S = load('specific_heat_table.mat','specific_heat_fit_obj');
    specific_heat_fit_obj = S.specific_heat_fit_obj;
end
end