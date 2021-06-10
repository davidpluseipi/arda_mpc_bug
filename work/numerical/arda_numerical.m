function [T_g, T_h, P_h] = arda_numerical(T_g0, delta_T)

C_g = 1800;         % J/(kg*K), Specific heat capacity of humid air (60% relative humidity)
C_h = 4660;         % J/(kg*K), Specific heat capacity of the heater
c_p = 0.718;        % Specific heat of air at constant volume
m_h = 2.8;          % kg, Mass of the heater
R_a = 287.058;      % J/(kg*K), Specific Gas Constant, dry air
R_v = 461.495;      % J/(kg*K), Specific Gas Constant, water vapor
R_go = 0.03;        % K/W, Thermal resistance of the gas mixture to outside interface
R_hg = 0.005;       % K/W, Thermal resistance of the heater to gax mixture interface

C_to_K = 273.15;

% kPa, Initial pressure of the control volume.
p_g0 = 101.325;     % kPa
V_g0 = 0.25;         % m^3

phi_0 = 0; % Relative humidity

T = T_g0 + C_to_K;
if T < 647.096 && T > 273.15
    teta = T - 0.23855557567849 / (T - 650.17534844798);
    A = teta ^ 2 + 1167.0521452767 * teta - 724213.16703206;
    B = -17.073846940092 * teta ^ 2 + 12020.82470247 * teta - 3232555.0322333;
    C = 14.91510861353 * teta ^ 2 - 4823.2657361591 * teta + 405113.40542057;
    p4_ = (2 * C / (-B + (B ^ 2 - 4 * A * C) ^ 0.5)) ^ 4;
    p_s = p4_ * 10;  % bar to MPa
else
    error('Temperature out of valid range.')
end

V_g = V_g0;
p_g = p_g0;

a1 = (phi_0 * p_s * R_a)/(p_g * R_v);
q_0 = 0; %(a1 + 0.622) / (0.622 - a1);

% kg/kg, humidity ratio (mass of vapor to mass of air)
% humidity_ratio = q_0;

% kPa, Initial partial pressure of water vapor
p_v0 = q_0 * p_g0/(q_0 + 0.622);

% kPa, Initial partial pressure of air
p_a0 = p_g0 - p_v0;



x_0 = [T_g0 + C_to_K;  % 1) K, initial T_g
    25 + C_to_K;    % 2) K, Initial heater temp, T_h
    25 + C_to_K;    % 3) K, Initial outside / ambient temp, T_o
    p_g0;           % 4) kPa, total pressure of gas mixture
    p_v0;           % 5) kPa, partial pressure of water vapor
    p_a0;           % 6) kPa, partial pressure of air
    V_g;            % 7) m^3, Initial volume of the control volume (approx.)
    q_0;            % 8) humidity ratio
    phi_0];           % 9) relative humidity

% Initialize the controller
pid = struct(controller_pid);

% Set the time step
pid.Ts = 1;

% Delay
L = 50 * pid.Ts;

% Time constant
T = 60;
tau = L/(L+T);
process_gain = delta_T;
a = process_gain*L/T;

% % Set the gains
% % Nichols
% pid.Kp = 1.2/a;
% pid.Ki = pid.Kp/(2*L);
% pid.Kd = pid.Kp * (L/2);

% Cohen-Coon
pid.Kp = (1.35/a) * (1 + (0.18*tau)/(1-tau));
pid.Ki = pid.Kp / ((2.5 - 2*tau)*L/(1-0.39*tau));
pid.Kd = pid.Kp * ((0.37 - 0.37*tau)*L/(1-0.81*tau));

pid.tau = 1;

pid.limMin = 0;
pid.limMax = 11000;

setpoint = x_0(1) + process_gain;
measurement = x_0(1);
goal_achieved = false;
max_iterations = 300;
count = 1;
count2 = 1;
while ~goal_achieved
    
    pid = calculate_controller_output(pid, setpoint, measurement);
    if count >= 2
        x_0 = y(end,:);
    end
    [~, y] = ode15s(@(t,y) odefun(t, y, 0, 0, 0, pid.out), [0 pid.Ts], x_0);
    measurement = y(end,1);
    T_g(count) = y(end,1);
    T_h(count) = y(end,2);
    p_v(count) = y(end,5);
    p_a(count) = y(end,6);
    q(count) = y(end,8);
    phi(count) = y(end,9);
    
    
    P_h(count) = pid.out;
    
    if measurement >= setpoint * 0.98 && measurement <= setpoint * 1.02
        count2 = count2 + 1;
        if count2 >= max_iterations
            break
        end
    end
    
    if count < max_iterations
        count = count + 1;
    else
        break
    end
    
end

figure
subplot(2,1,1)
plot(T_g - C_to_K)
hold on
plot(T_h - C_to_K)
plot(setpoint * ones(1, numel(T_h)) - C_to_K, '--k')
ylabel('Temp. (C)')
legend({'T_g', 'T_h'},'Location','best')%, 'T_o'}
grid on

subplot(2,1,2)
plot(P_h)
legend({'P_h'},'Location','best')
ylabel('Power (W)')
grid on

T_g = T_g - C_to_K;
T_h = y(:,2) - C_to_K;

shg

figure
plot(p_v)
hold on
plot(p_a)
ylabel('Pressure (kPa)')
xlabel('Time')
legend({'p_v', 'p_a'}, 'Location', 'best')
shg

figure
yyaxis left
plot(q)
ylabel('Humidity Ratio')

yyaxis right
plot(phi)
ylabel('Relative Humidity')
xlabel('Time')
shg




    function delta = odefun(~, x, p_v_dot, p_a_dot, V_g_dot, P_h)
        
        delta = zeros(length(x), 1);
        
        c1 = 1/(C_g*R_hg) + 1/(C_g*R_go);
        
        c2 = (c_p/C_g) * (x(6) * x(7)/R_a + (x(5) * x(7)/R_v));
        
        c3 = (c_p/C_g) * ((p_a_dot * x(7) + x(6) * V_g_dot)/ R_a ...
            + ((p_v_dot * x(7) + x(5) * V_g_dot))/R_v);
        
        mass_flow_in = 0;
        
        delta(1) = c3 - c1*x(1) + c2/x(1) + x(2)/(C_g*R_hg) + (x(3)/(C_g*R_go) + mass_flow_in); % dT_g/dt
        
        delta(2) = x(1)/(C_h * m_h *R_hg) - x(2)/(C_h * m_h * R_hg) + P_h; % dT_h/dt
        
        delta(3) = 0; % dT_o/dt, Constant ambient temperature outside the system
        delta(4) = 0; % dp_g/dt, Constant total pressure at ambient
        
        % dp_v/dt, Constant partial pressure of water (for now)
        if x(1) < 647.096 && x(1) > 273.15
            teta = x(1) - 0.23855557567849 / (x(1) - 650.17534844798);
            A1 = teta ^ 2 + 1167.0521452767 * teta - 724213.16703206;
            B1 = -17.073846940092 * teta ^ 2 + 12020.82470247 * teta - 3232555.0322333;
            C1 = 14.91510861353 * teta ^ 2 - 4823.2657361591 * teta + 405113.40542057;
            p4 = (2 * C1 / (-B1 + (B1 ^ 2 - 4 * A1 * C1) ^ 0.5)) ^ 4;
            p_s = p4 * 10;  % bar to MPa
        else
            warning('Temperature out of valid range for steam tables.')
        end
        
            
        if exist('q_prev','var')
            q_dot = (x(8) - q_prev)/pid.Ts; % dq/dt    
        else
            q_dot = 0;
        end
        
        delta(5) = x(4)*(q_dot*(x(8) + 0.622) - x(8)*q_dot) / (x(8)^2 +2*0.622*x(8) + 0.622^2);
        delta(6) = -delta(5); % dp_a/dt, Constant partial pressure of air (for now)
        delta(7) = 0; % dV_g/dt, Constant volume for the gas mixture (aRDA volume is fixed)
        delta(8) = 0;
        
        delta(9) = 0; % dphi/dt
        
        q_prev = x(8);
        p_s_prev = p_s;
    end
end






































