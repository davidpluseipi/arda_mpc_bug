function [T_g_out, T_h_out, P_h_out, phi_out] = arda_numerical(T_g0, delta_T, T_o0, phi_0, T_h0, max_iterations)
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
    
else
    temp_data = 273.15 + [0:5:50, 60:10:100, 120:20:200]';
    c_data = [1006*ones(1,3) 1007*ones(1,10) 1008*ones(1,2) 1009 1011 1013 ...
        1016 1019 1023]';
    
    [xData, yData] = prepareCurveData(temp_data, c_data);
    ft = fittype( 'poly8' );
    [specific_heat_fit_obj, gof] = fit(xData, yData, ft, 'Normalize', 'on' );
    
    save specific_heat_table.mat specific_heat_fit_obj
    
    figure
    plot(specific_heat_fit_obj, temp_data, c_data)
    title('Specific Heat J/(kg K) vs Temp (K)')
end
fit_obj = specific_heat_fit_obj;


p_g0 = 101.325;     % kPa, Initial pressure of the control volume.
V_g0 = 0.25;        % m^3, Initial volume of aRDA "control volume" (constant)

% Calculate initial saturation pressure (needed for humidity ratio)
if T_g0 >= 647.096 || T_g0 < 273.15
        fprintf(['\nInitial temperature is %.3f K. Valid range in Kelvin is '...
        '273.15 < T < 647.096\n'], T_g0)
    error(['Temperature out of valid range for valid saturation pressure '...
        'calculation.'])

else
    teta = T_g0 - 0.23855557567849 / (T_g0 - 650.17534844798);
    A = teta ^ 2 + 1167.0521452767 * teta - 724213.16703206;
    B = -17.073846940092 * teta ^ 2 + 12020.82470247 * teta - 3232555.0322333;
    C = 14.91510861353 * teta ^ 2 - 4823.2657361591 * teta + 405113.40542057;
    p_4 = (2 * C / (-B + (B ^ 2 - 4 * A * C) ^ 0.5)) ^ 4;
    p_s0 = p_4 * 1000;  % conver to kPa
    clearvars teta A B C p_4 teta
end

% MEASUREMENT
% phi_0 = 0.99;  % percent, Initial Relative humidity

% Initial humidity ratio
q_0 = (phi_0 * p_s0 * R_a / R_v) * (1 / (p_g0 - phi_0 * p_s0));

% kPa, Initial partial pressure of water vapor
p_v0 = q_0 * p_g0/(q_0 + 0.622);

% kPa, Initial partial pressure of air
p_a0 = p_g0 - p_v0;

% Initial state vector
x_0 = [T_g0;   % 1) K, initial T_g
    T_h0;       % 2) K, Initial heater temp, T_h
    T_o0;       % 3) K, Initial outside / ambient temp, T_o
    p_g0;      % 4) kPa, Initial total pressure of gas mixture
    p_v0;      % 5) kPa, Initial partial pressure of water vapor
    p_a0;      % 6) kPa, Initial partial pressure of air
    V_g0;      % 7) m^3, Initial volume of the control volume
    q_0;       % 8) Initial humidity ratio
    phi_0;    % 9) Initial relative humidity
    p_s0];      % 10) Initial saturation vapor pressure

%% Define the controller
% Initialize the controller
pid = controller_pid;

% Set the time step
pid.Ts = 0.01;

% Time delay L, aka T_dead
% Transportation lag or dead time. The time taken from the moment the 
% disturbance was introduced to the first sign of change in the output 
% signal
my_delay = 0;
first_sign_of_change = 2.5; % Measured from plot (calibration run "without" controller)
tau_dead = first_sign_of_change - my_delay;

% Time for the response to occur 
tau = 2000-2.5; % The calibration run was for 2000 iterations

% Size of the step change
X_0 = delta_T;

% The value the response goes to as the system reaches steady state
M_u = 98.87; % Pulled of the plot from the calibration run

R = tau_dead/tau; 
K_0 = X_0 * tau / (M_u * tau_dead);

% tau = tau_dead/(tau_dead+T);
% process_gain = delta_T;

% Steady state gain
% a = process_gain*tau_dead/T;
L = tau_dead;

% Cohen-Coon
pid.Kp = K_0 * (1.33 + R/4); % (1.35/a) * (1 + (0.18*tau)/(1-tau));
pid.Ki = L * (30 + 3*R) / (9 + 20 * R); % pid.Kp / ((2.5 - 2*tau)*T_dead/(1-0.39*tau));
pid.Kd = 4 * L / (11 + 2 * R); % pid.Kp * ((0.37 - 0.37*tau)*T_dead/(1-0.81*tau));

pid.tau = tau;

pid.min_output = 0;
pid.max_output = 11000; % Max watts from heater

setpoint = x_0(1) + delta_T;
measurement = x_0(1);
% goal_achieved = false;
% max_iterations = 300;
count = 1;
% count2 = 1;
prev = zeros(length(x_0), 1);
for i = 1:max_iterations
    
    %% Controller
    % Calculate the controller output given the setpoint for the
    % temperature of the air and the initial T_g measurement
    if i < 1 
        setpoint = T_g0;
    else
        setpoint = T_g0 + delta_T;
    end
    pid = calculate_controller_output(pid, setpoint, measurement);
    
    % Record the power setting of the heater at each time step
    P_h_out(count) = pid.out;
    
    %% Plant Model
    % On the first time through the loop, use the x_0 above. After that,
    % the initial values to give to the ode are the last ones it gave.
    if count >= 2
        x_0 = y(end,:);
        
    end
    
    % Call ode solver on custom ode function using the controller output
    % (i.e. the setting in Watts to send to the heater)
    % ode_options = odeset('RelTol',5e-6, 'AbsTol',5e-6);
    
    [~, y] = ode15s(@(t,y) odefun(t, y, 0, 0, 0, pid, constants, prev',...
        fit_obj, count, max_iterations), [0 pid.Ts], x_0);%, ode_options);
    try
        prev = y(end-1,:);
    catch
    end
    % Capture sensor measurements
    measurement = y(end,1);
    T_g_out(count) = y(end,1);
    T_h_out(count) = y(end,2);
    T_o_out(count) = y(end,3);
    p_v_out(count) = y(end,5);
    p_a_out(count) = y(end,6);
    q_out(count) = y(end,8);
    phi_out(count) = y(end,9);
    p_s_out(count) = y(end,10);
    
    fprintf('%f%f%f%f%f%f%f%f', T_g_out, T_h_out, T_o_out, p_v_out, ...
        p_a_out, q_out, phi_out, p_s_out)
%     if count == 1
%         t_0 = t(1);
%     end
    
%     %% Determine when to stop the simulation
%     if measurement >= setpoint * 0.98 && measurement <= setpoint * 1.02
%         count2 = count2 + 1;
%         if count2 >= max_iterations
%             t_final = t(end);
%             break
%         end
%     end
%     
%     if count < max_iterations
%         count = count + 1;
%     else
%         t_final = t(end);
%         break
%     end
    count = count + 1;
end

%% Convert to Celsius
T_g_out = T_g_out - c2k;
T_h_out = T_h_out - c2k;
T_o_out = T_o_out - c2k;
setpoint = setpoint - c2k;

%% Humidity plot
figure(3)
yyaxis left
plot(q_out)
ylabel('Humidity Ratio')

yyaxis right
plot(phi_out)
ylabel('Relative Humidity')
xlabel('Time')

%% Pressure plot
figure
subplot(3,1,1)
plot(p_v_out)
grid on
legend({'p_v'}, 'Location', 'best')

subplot(3,1,2)
plot(p_a_out)
grid on
legend({'p_a'}, 'Location', 'best')

subplot(3,1,3)
plot(p_s_out)
grid on
title('Pressure (kPa)')
xlabel('Time')
legend({'p_s'}, 'Location', 'best')

%% Temperature plot
fig3 = figure(3)
subplot(2,1,1)

% Gas mixture temperature
plot(T_g_out)
hold on

% Heater temperature
plot(T_h_out)

% Plot a horizontal line at the setpoint
% plot(setpoint * ones(1, numel(T_h_out)), '--k')

% Plot a horizontal line at the outside temperature
plot(T_o_out, '--m')

ylabel('Temp. (C)')
legend({'T_g', 'T_h', 'T_o'}, 'Location', 'best')
grid on

% Power setting of the heater
subplot(2,1,2)
plot(P_h_out)
legend({'P_h'},'Location','best')
ylabel('Power (W)')
grid on


end

%% ODE of thermal system
function [delta] = odefun(~, x, p_v_dot, p_a_dot, V_g_dot, pid, constants, prev, fit_obj)
%% Setup and unpacking
delta = zeros(length(x), 1);
% System variables
T_g = x(1);
if T_g > 140 + 273.15
    error('Your weapons have melted and you are defenseness. You die.')
end
if x(1) < 273.15
    error('The ice wizard has frozen your Tantan.')
end
T_h = x(2);
T_o = x(3);
p_g = x(4);
p_v = x(5);
p_a = x(6);
V_g = x(7);
q = x(8);
phi = x(9);
p_s = x(10);

% Values from the previous step
q_prev = prev(8);
p_s_prev = prev(10);

% Constants
% constants = [C_g, C_h, c_p, m_h, R_a, R_v, R_go, R_hg];
%C_g = 1000;         % J/(kg*K), Specific heat capacity of
C_g = fit_obj(T_g);

C_h = 4660;         % J/(kg*K), Specific heat capacity of the heater
c_p = 0.718;        % Specific heat of air at constant pressure
m_h = 2.8;          % kg, Mass of the heater (about 6 lbs)
R_a = constants(1);
R_v = constants(2);
R_go = constants(3);
R_hg = constants(4);



%% dT_g/dt
c1 = 1/(C_g*R_hg) + 1/(C_g*R_go);

c2 = (c_p/C_g) * ((p_a * V_g/R_a) + (p_v * V_g/R_v));

c3 = (c_p/C_g) * ((p_a_dot * x(7) + x(6) * V_g_dot)/ R_a ...
    + ((p_v_dot * x(7) + x(5) * V_g_dot))/R_v);

mass_flow_in = 0;

delta(1) = -(c3 + c1)*x(1) + c2/x(1) + x(2)/(C_g*R_hg) + x(3)/(C_g*R_go);


%% dT_h/dt
delta(2) = x(1)/(C_h * m_h * R_hg) - x(2)/(C_h * m_h * R_hg) + pid.out/(C_h * m_h) ;


%% dT_o/dt
delta(3) = 0; % Constant ambient temperature outside the system


%% dp_g/dt
delta(4) = 0; % Constant total pressure at ambient


%% dp_v/dt
if T_g >= 647.096 || T_g <= 273.15
    
    fprintf(['\nTemperature is %.3f K. Valid range in Kelvin is '...
        '273.15 < T < 647.096\n'], T_g)
    error(['Temperature out of valid range for valid saturation pressure '...
        'calculation.'])
else
    teta2 = x(1) - 0.23855557567849 / (x(1) - 650.17534844798);
    A1 = teta2 ^ 2 + 1167.0521452767 * teta2 - 724213.16703206;
    B1 = -17.073846940092 * teta2 ^ 2 + 12020.82470247 * teta2 - 3232555.0322333;
    C1 = 14.91510861353 * teta2 ^ 2 - 4823.2657361591 * teta2 + 405113.40542057;
    p4 = (2 * C1 / (-B1 + (B1 ^ 2 - 4 * A1 * C1) ^ 0.5)) ^ 4;
    p_s = p4 * 1000;  % convert to kPa
    clearvars A1 B1 C1 p4 teta2

end

if exist('q_prev','var')
    q_dot = (q - q_prev)/pid.Ts; % dq/dt
else
    q_dot = 0;
end

delta(5) = p_g*(q_dot*(q + 0.622) - q*q_dot)...
    / (q^2 +2*0.622*q + 0.622^2);


%% dp_a/dt
delta(6) = -delta(5);


%% dV_g/dt
delta(7) = 0;  % Constant volume for the gas mixture (aRDA volume is fixed)


%% dphi/dt (change in relative humidity)
if phi < 0.99
    delta(9) = 0.001; % Manually increase slightly as if the steam
    % injection valve is open
else
    delta(9) = 0;
end
phi_dot = delta(9)/pid.Ts;

%% dp_s/dt (change in saturation pressure)
delta(10) = p_s - prev(10);
p_s_dot = delta(10)/pid.Ts;

%% dq/dt (change in humidity ratio)
delta(8) = (R_a/R_v) * ((phi_dot*p_s + phi*p_s_dot)*(p_g - phi*p_s) ...
    + (phi_dot*p_s + phi*p_s_dot)^2) ...
    / (p_g^2 - 2*p_g*phi*p_s + (phi^2)*(p_s^2));

end







































