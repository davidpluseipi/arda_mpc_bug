function [T_g_out, T_h_out, P_h_out, phi_out] = arda_numerical(T_g0, delta_T, T_o0, phi_0, T_h0, T_s, max_iterations, stop)
%% [T_g, T_h, P_h] = arda_numerical(T_g0, delta_T, T_o, phi_0, max_iterations)
% Inputs:
%   T_g0            : Initial gax mixture temperature (C)
%   delta_T         : Desired change in temperature (C)
%   T_o             : Outside (ambient) temperature (C)
%   phi_0           : Initial relative humidity in control volume (decimal)
%   max_iterations  : Controls the length of the simulation
%
% Outputs:
%   T_g             : Temperature of the gas mixture (C)
%   T_h             : Temperature of the heater (C)
%   P_h             : Commanded power setting of the heater at each step
%
% Example:
%   [T_g, T_h, P_h] = arda_numerical(20, 100, 20, 0.50, 300)

%% Progress dialog
fig = uifigure('HandleVisibility', 'on');
d = uiprogressdlg(fig, "Title", "MATLAB is thinking", "Message",...
    "Starting...", "Cancelable", "on");%, "Indeterminate", "on");
drawnow

%% Convert to Kelvin
c2k = 273.15;
T_g0 = T_g0 + c2k;
T_o0 = T_o0 + c2k;
T_h0 = T_h0 + c2k;

%% Define system constants
R_a = 287.058;      % J/(kg*K), Specific Gas Constant, dry air
R_v = 461.495;      % J/(kg*K), Specific Gas Constant, water vapor
R_go = 0.03;        % K/W, Thermal resistance of the gas mixture to outside interface (1 inch insulation)
R_hg = 0.005;       % K/W, Thermal resistance of the heater to gax mixture interface
constants = [R_a, R_v, R_go, R_hg];

% Create a vector for specific heat of air
% Ref: https://www.me.psu.edu/cimbala/me433/Links/Table_A_9_CC_Properties_of_Air.pdf
if exist('specific_heat_table.mat', 'file')
    load('specific_heat_table.mat','specific_heat_fit_obj');
    fit_obj = specific_heat_fit_obj;
else
    [fit_obj, ~] = calculate_specific_heat_data();
end

p_g0 = 101.325;     % kPa, Initial pressure of the control volume.
V_g0 = 0.25;        % m^3, Initial volume of aRDA "control volume" (constant)

% Calculate initial saturation pressure (needed for humidity ratio)
p_s0 = calculate_saturation_pressure(T_g0);

% kg/m^3, density of dry air at 20C and 1 atm
rho_a = 1.204; 

% kg, mass of dry air
m_a0 = rho_a * V_g0;

% kg, mass of vapor
m_v0 = m_a0 * phi_0 * 0.622 * (p_s0 / (p_g0 - p_s0)); 

% Initial humidity ratio
% m_v0 = phi_0 * p_s0 * V_g0 / (R_v * T_g0);
q_0 = phi_0 * p_s0 * V_g0 * R_a * T_g0 /(R_v * T_g0 * p_g0 * V_g0 ...
    - m_v0*R_v^2 * T_g0);

% kPa, Initial partial pressure of water vapor
p_v0 = q_0 * p_g0/(q_0 + 0.622);

% kPa, Initial partial pressure of air
p_a0 = p_g0 - p_v0;

% Initial state vector
x_0 = [T_g0;T_h0;T_o0;p_g0;p_v0;p_a0;V_g0;q_0;phi_0;p_s0;m_v0;m_a0];


%% Define the controller
% Initialize the controller
pid = controller_pid;

% Set the time step
pid.Ts = T_s;

tau = 2532;
tau_dead = 10; 
P = (197.1 - 97.1)/97.1; % Percent change of input
N = ((25.81 - 22.87)/22.87) / tau; % Percent change of output / tau
L = tau_dead;
R = tau_dead / tau;
K_0 = P/(N*L);

% Cohen-Coon 1(only for self-regulating processes, like flow, temp, pressure)
pid.Kp = K_0 * (1.33 + R/4);
pid.Ki = (L * (30 + 3*R) / (9 + 20 * R));
pid.Kd = (4 * L / (11 + 2 * R));
pid.tau = tau;
pid.min_output = 0;
pid.max_output = 11000; % Max watts from heater

measurement = x_0(1);
T_g_out = zeros(max_iterations, 1);
T_h_out = zeros(max_iterations, 1);
T_o_out = zeros(max_iterations, 1);
p_v_out = zeros(max_iterations, 1);
p_a_out = zeros(max_iterations, 1);
q_out = zeros(max_iterations, 1);
phi_out = zeros(max_iterations, 1);
p_s_out = zeros(max_iterations, 1);
P_h_out = zeros(max_iterations, 1);

d.Message = "Processing...";
drawnow
draw_times = 1:10:max_iterations;
%%
for i = 1:max_iterations
    
    %% Controller
    % Establish setpoint
    if i > stop
        setpoint = T_g0;
    else 
        setpoint = T_g0 + delta_T;
    end
    
    % Calculate controller output
    pid = calculate_controller_output(pid, setpoint, measurement);
    
    % Record the power setting of the heater at each time step
    P_h_out(i) = pid.out;
    
    %% Plant Model
    % On the first time through the loop, use the x_0 above. After that,
    % the initial values to give to the ode are the last ones it gave.
    if i >= 2
        x_0 = y(end,:);
    end
    
    % Call ode solver 
    [~, y] = ode15s(@(t,y) odefun(t, y, 0, 0, 0, pid, constants,...
        fit_obj), [0 pid.Ts], x_0);

    % Capture sensor measurements
    measurement = y(end,1);
    T_g_out(i) = y(end,1);
    T_h_out(i) = y(end,2);
    T_o_out(i) = y(end,3);
    p_v_out(i) = y(end,5);
    p_a_out(i) = y(end,6);
    q_out(i)   = y(end,8);
    phi_out(i) = y(end,9);
    p_s_out(i) = y(end,10);
       
    if ismember(i, draw_times)
        d.Value = i/max_iterations;
        drawnow
        if d.CancelRequested
            break
        end
    end
end

d.Message = 'Plotting...';
drawnow

%% Convert to Celsius
T_g_out = T_g_out - c2k;
T_h_out = T_h_out - c2k;
T_o_out = T_o_out - c2k;
setpoint = T_g0 + delta_T;
setpoint = setpoint - c2k;

%% Humidity plot
figure
yyaxis left
plot(q_out)
ylabel('Humidity Ratio')

yyaxis right
plot(phi_out)
ylabel('Relative Humidity')
xlabel('Time')
grid on

%% Pressure plot
figure
subplot(3,1,1)
plot(p_v_out)
title('Pressure (kPa)')
grid on
legend({'p_v'}, 'Location', 'best')
ylabel('p_v')

subplot(3,1,2)
plot(p_a_out)
grid on
legend({'p_a'}, 'Location', 'best')
ylabel('p_a')

subplot(3,1,3)
plot(p_s_out)
grid on
xlabel('Time')
legend({'p_s'}, 'Location', 'best')
ylabel('p_s')

%% Temperature plot
figure; subplot(2,1,1)

% Gas mixture temperature
plot(T_g_out); hold on; grid on

% Heater temperature
plot(T_h_out)

% Plot a horizontal line at the setpoint
plot(setpoint * ones(max_iterations,1), '--k')

% Plot a horizontal line at the outside temperature
plot(T_o_out, '--m')
ylabel('Temp. (C)')
legend({'T_g', 'T_h', 'SP', 'T_o'}, 'Location', 'best')

% Power setting of the heater
subplot(2,1,2)
plot(P_h_out); grid on
legend({'P_h'},'Location','best')
ylabel('Power (W)')

% Done with progress dialog
close(d)

end

%% ODE of thermal system
function [delta] = odefun(~, x, p_v_dot, p_a_dot, V_g_dot, pid, constants, fit_obj)
%% Setup and unpacking
delta = zeros(length(x), 1);

% System variables
T_g = x(1); % T_g0  1) K, initial T_g
T_h = x(2); % T_h0; 2) K, Initial heater temp, T_h
T_o = x(3); % T_o0; 3) K, Initial outside / ambient temp, T_o
p_g = x(4); % p_g0; 4) kPa, Initial total pressure of gas mixture
p_v = x(5); % p_v0; 5) kPa, Initial partial pressure of water vapor
p_a = x(6); % p_a0; 6) kPa, Initial partial pressure of air
V_g = x(7); % V_g0; 7) m^3, Initial volume of the control volume
q   = x(8); % q_0;  8) Initial humidity ratio
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

%% Change in m_a
delta(12) = 0;
m_a2 = m_a + delta(12);

%% Change in m_v
delta(11) = 0.001; % 1 gram per time step
m_v2 = m_v + delta(11);


%% dT_g/dt
c1 = 1/(C_g*R_hg) + 1/(C_g*R_go);

c2 = (c_p/C_g) * ((p_a * V_g/R_a) + (p_v * V_g/R_v));

c3 = (c_p/C_g) * ((p_a_dot * x(7) + x(6) * V_g_dot)/ R_a ...
    + ((p_v_dot * x(7) + x(5) * V_g_dot))/R_v);

% mass_flow_in = 0;
delta(1) = -(c3 + c1)*x(1) + c2/x(1) + x(2)/(C_g*R_hg) + x(3)/(C_g*R_go);
T_g2 = T_g + delta(1);
%%
p_s2 = calculate_saturation_pressure(T_g2);

%% dT_h/dt
delta(2) = x(1)/(C_h * m_h * R_hg)...
         - x(2)/(C_h * m_h * R_hg)...
         + pid.out/(C_h * m_h) ;
T_h2 = T_h + delta(2);

%% dp_s/dt (change in saturation pressure)
delta(10) = p_s2 - p_s;

%% dq/dt (change in humidity ratio)
% phi2 = phi + delta(9);
% p_s2 = p_s + delta(10);
% V_g2 = V_g + delta(7);
% T_g2 = T_g + delta(1);
% p_g2 = p_g + delta(4);
% %
% m_v2 = phi2 * p_s2 * V_g2 / (R_v * T_g2);
% q2 = phi2 * p_s2 * V_g2 * R_a * T_g2 /...
%     (R_v * T_g2 * p_g2 * V_g2 - m_v2*R_v^2 * T_g2);
q2 = m_v2 / (m_a2 + m_v2); 
delta(8) = q2 - q;

%% dp_v/dt
p_v2 = q2 * p_g2/(q2 + 0.622);
delta(5) = p_v2 - p_v;

%% dp_a/dt
delta(6) = -delta(5);

%% dphi/dt (change in relative humidity)

phi2 = q / (0.622 * (p_s2 / (p_g2 - (1 - 0.622)*p_s2)));
delta(9) = phi2 - phi;

end







































