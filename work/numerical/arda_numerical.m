function [output] = arda_numerical(delta_T, T_o0, T_h0, T_s, max_iterations, stop)
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
%%
%

arduino_obj = arduino('COM4' ,'Uno', 'Libraries', {'Adafruit/DHT22'});

% Heater
configurePin(arduino_obj,'D2','DigitalOutput');

% Temperature / Humidity
sensor = addon(arduino_obj, 'Adafruit/DHT22', 'A1');

%% Memory Preallocation
try
T_g_out = zeros(max_iterations, 1);
T_h_out = zeros(max_iterations, 1);
T_o_out = zeros(max_iterations, 1);
p_v_out = zeros(max_iterations, 1);
p_a_out = zeros(max_iterations, 1);
q_out = zeros(max_iterations, 1);
phi_out = zeros(max_iterations, 1);
p_s_out = zeros(max_iterations, 1);
P_h_out = zeros(max_iterations, 1);
m_steam = zeros(max_iterations, 1);
x_0 = zeros(12,1);
constants = zeros(1,4);
specific_heat_fit_obj = [];
draw_times = 1:10:max_iterations;
catch
end

[handle_dialog_box, dialog_box] = progress_dialog();
T_g0 = 20;
define_constants()
x_0 = set_initial_conditions();
pid = controller_pid;
pid_phi = controller_pid;
define_temperature_controller()
define_relative_humidity_controller()
setup_progress_dialog()

setpoint_T = T_g0 + delta_T;

main_loop()

convert_to_C()

create_plots(T_g_out, T_h_out, T_o_out, p_v_out, p_a_out, q_out,...
    phi_out, p_s_out, P_h_out, setpoint_T, max_iterations, m_steam)

close(dialog_box); close(handle_dialog_box)
output = table(T_g_out, T_h_out, T_o_out, p_v_out, p_a_out, q_out,...
    phi_out, p_s_out, P_h_out, 'VariableNames', {'T_g', 'T_h', 'T_o', ...
    'p_v', 'p_a', 'q', 'phi', 'p_s', 'P_h'});

%% Define Nested Functions

%% Progress dialog
    function [fig, dialog_box] = progress_dialog()
        fig = uifigure('HandleVisibility', 'on');
        dialog_box = uiprogressdlg(fig, "Title", "MATLAB is thinking", "Message",...
            "Starting...", "Cancelable", "on");%, "Indeterminate", "on");
        drawnow
    end

%% Define constants
    function define_constants()
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
            [specific_heat_fit_obj, ~] = calculate_specific_heat_data();
        end
        
    end

%% Set initial conditions
    function x_0 = set_initial_conditions()
        c2k = 273.15;
        
        T_g0 = T_g0 + c2k;
        T_o0 = T_o0 + c2k;
        T_h0 = T_h0 + c2k;
        p_g0 = 101.325;     % kPa, Initial pressure of the control volume.
        V_g0 = 0.25;        % m^3, Initial volume of aRDA "control volume" (constant)
        
        % Calculate initial saturation pressure 
        %p_s0 = calculate_saturation_pressure(T_g0);
        p_s0 = XSteam('psat_T', T_g0);
        
        % kg/m^3
        rho_a0 = XDryAir('tK', T_g0, 'rho', p_g0);
        
        % kg, mass of dry air
        m_a0 = rho_a0 * V_g0;
        
        % kg, mass of vapor
        % m_v0 = m_a0 * phi_0 * 0.622 * (p_s0 / (p_g0 - p_s0));
        rho_v0 = XSteam('rho_pt', p_g0/100, T_g0-273.15);
        % rho_v0 = 0.59;
        % m_v0 = rho_v0 * V_g0;
        m_v0 = 0;
        
        % Initial humidity ratio
        % m_v0 = phi_0 * p_s0 * V_g0 / (R_v * T_g0);
        
        % q_0 = m_v0 / (m_a0 + m_v0);
        
        % kPa, Initial partial pressure of water vapor
        % p_v0 = q_0 * p_g0/(q_0 + 0.622);
        % p_v0 = rho_v0 * T_g0 / 0.0022;
        p_v0 = 25.7;
        
        % kPa, Initial partial pressure of air
        p_a0 = p_g0 - p_v0;
        
        % percent, Initial relative humidity
        phi_0 =  p_v0 / p_s0;
        
        % percent of moisture by volume
        pmv = p_v0 / p_g0;
        
        %
        q_0 = 0; % 0.622 * pmv / ((1 - pmv) + 0.622 * pmv);
        
        % Initial state vector
        x_0 = [T_g0; T_h0; T_o0; p_g0; p_v0; p_a0; V_g0; q_0; phi_0; p_s0; m_v0; m_a0];
    end

%% Define the temperature controller
    function define_temperature_controller()
        
        
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
    end

%% Initialize the relative humidity controller
    function define_relative_humidity_controller()
        
        pid_phi.Ts = pid.Ts;
        pid_phi.tau = 59;
        tau_dead = 0.1;
        P2 = (0.1001 - 0.001)/0.001;
        N2 = ((0.3 - 0.2)/0.2) / pid_phi.tau;
        L2 = 0.1; % tau_dead
        R2 = tau_dead / pid_phi.tau;
        K_02 = P2 / (N2 * L2);
        
        pid_phi.Kp = K_02 * (1.33 + R2/4);
        pid_phi.Ki = (L2 * (30 + 3*R2) / (9 + 20 * R2));
        pid_phi.Kd = (4 * L2 / (11 + 2 * R2));
        pid_phi.min_output = 0;
        pid_phi.max_output = 1;
    end

%% Setup progress dialog
    function setup_progress_dialog()
        dialog_box.Message = "Processing...";
        drawnow
    end

%% Main loop
    function main_loop()
        measurement = x_0(1);
        measurement_phi = x_0(9);
        original = setpoint_T;
        setpoint_phi = 0.33;
        
%         d = daq("mcc");
%         d.Rate = 10;  % Hz
%         addinput(d,"Board1","Ai4","Voltage");
        %%
        for i = 1:max_iterations
            
            if i < 20
                setpoint_T = T_g0;
            else
                setpoint_T = original;
            end
            %% Controller
            % Calculate controller output
            pid = calculate_controller_output(pid, setpoint_T, measurement);
            if pid.out > 0 
                % Turn on the heater
                writeDigitalPin(arduino_obj,'D2',1)
            else
                % Turn off the heater
                writeDigitalPin(arduino_obj,'D2',0)
            end
            pause(1)
            pid_phi = calculate_controller_output(pid_phi, setpoint_phi, ...
                measurement_phi);
            
            % Record the power setting of the heater at each time step
            P_h_out(i) = pid.out;
            m_steam(i) = pid_phi.out;
            
            %% Plant Model
            % On the first time through the loop, use the x_0 above. After that,
            % the initial values to give to the ode are the last ones it gave.
            if i >= 2
                x_0 = y(end,:);
            end
            
            % Call ode solver
            [~, y] = ode23(@(t,y) odefun(t, y, pid, pid_phi, constants,...
                specific_heat_fit_obj, i), [0 pid.Ts], x_0);

            % Capture sensor measurements
            measurement = y(end,1);
            measurement_phi = y(end,9);
            T_g_out(i) = y(end,1);
            T_h_out(i) = y(end,2);
            T_o_out(i) = y(end,3);
            p_v_out(i) = y(end,5);
            p_a_out(i) = y(end,6);
            q_out(i)   = y(end,8);
            phi_out(i) = y(end,9);
            p_s_out(i) = y(end,10);
            
            if ismember(i, draw_times)
                dialog_box.Value = i/max_iterations;
                drawnow
                if dialog_box.CancelRequested
                    break
                end
            end
        end
    end

%% Convert to Celsius
    function convert_to_C()
        c2k = 273.15;
        T_g_out = T_g_out - c2k;
        T_h_out = T_h_out - c2k;
        T_o_out = T_o_out - c2k;
        setpoint_T = T_g0 + delta_T;
        setpoint_T = setpoint_T - c2k;
    end

end

%% ODE of thermal system
function [delta] = odefun(~, x, pid, pid_phi, constants, fit_obj, i)
%% Setup and unpacking
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
V_g2 = V_g + delta(7);

%% Change in m_a
% kg/m^3, density of dry air at 20C and 1 atm
rho_a = XDryAir('tK', T_g, 'rho', p_g);

% kg, mass of dry air
m_a2 = rho_a * V_g2;

delta(12) = m_a2 - m_a;

%% dT_g/dt
% c1 = 1/(C_g*R_hg) + 1/(C_g*R_go);
% 
% c2 = (c_p/C_g) * ((p_a * V_g/R_a) + (p_v * V_g/R_v));
% 
% c3 = (c_p/C_g) * ((p_a_dot * x(7) + x(6) * V_g_dot)/ R_a ...
%     + ((p_v_dot * x(7) + x(5) * V_g_dot))/R_v);
% 
% % mass_flow_in = 0;
% delta(1) = -(c3 + c1)*x(1) + c2/x(1) + x(2)/(C_g*R_hg) + x(3)/(C_g*R_go);
% T_g2 = T_g + delta(1);

[sensor1] = read_daq(i, fit_obj, 2, 20);
T_g2 = sensor1.mu + 273.15;
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
    + pid.out/(C_h * m_h) ;
% T_h2 = T_h + delta(2);

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

%%
%%                
       

end

function create_plots(T_g_out, T_h_out, T_o_out, p_v_out, p_a_out, q_out,...
    phi_out, p_s_out, P_h_out, setpoint_T, max_iterations, m_steam)
%% Humidity plot
figure(1)
% yyaxis left
% plot(q_out)
% ylabel('Humidity Ratio')
% 
% yyaxis right
plot(phi_out)
ylabel('Relative Humidity')
xlabel('Time')
grid on


%% Pressure plot
figure(2)
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
figure(3); subplot(2,1,1)

% Gas mixture temperature
plot(T_g_out); hold on; grid on

% Heater temperature
plot(T_h_out)

% Plot a horizontal line at the setpoint
plot(setpoint_T * ones(max_iterations,1), '--k')

% Plot a horizontal line at the outside temperature
plot(T_o_out, '--m')
ylabel('Temp. (C)')
legend({'T_g', 'T_h', 'SP', 'T_o'}, 'Location', 'best')

% Power setting of the heater
subplot(2,1,2)
plot(P_h_out); grid on
legend({'P_h'},'Location','best')
ylabel('Power (W)')

%%
% figure(4)
% plot(m_steam)
end



































