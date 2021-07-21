function [output] = arda_numerical(settings)
%% [output] = arda_numerical(settings)
% Inputs:
%   A structure with the following fields:
%   setpoints       : Structure with the following fields:
%       T           : Temperature setpoint (C)
%       phi         : Relative humidity setpoint (%)
%   T_g0_sim        : Initial gas mixture temperature for simulations (C)
%   T_o             : Outside (ambient) temperature (C)
%   T_h0            : Initial temperature of the heater (C)
%   T_s             : Length of time step (s)
%   N               : Number of steps
%   off             : Iteration at which to stop the simulation
%   simulation      : Indicator to run simulation or include hardware (T/F)
%   ni              : Indicator to include NI hardware (T/F)
%   arduino         : Indicator to include Arduino hardware (T/F)
%
% Outputs:
%   output          : A table with the following variables
%       T_g         : Temperature of the gas mixture (C)
%       T_h         : Temperature of the heater (C)
%       T_o         : Outside (ambient) temperature (C)
%       p_v         : Partial pressure of vapor (kPa)
%       p_a         : Partial pressure of dry air (kPa)
%       q           : Unused
%       phi         : Relative Humidity (%)
%       p_s         : Saturation Vapor Pressure of gas mixture (kPa)
%       P_h         : Power setting of the heater (commanded) 
%
% Example:
% settings = struct(...
%     'delta_T', 20,...
%     'T_o', 30,...
%     'T_h0', 50,...
%     'T_s', 1,...
%     'N', 180,...
%     'off', 1e6,...
%     'simulation', false,...
%     'ni', true,...
%     'arduino', false);
%
% data = arda_numerical(settings);
%
%% Setup Arduino

%% Setup Hardware
try
if ~settings.simulation
    %% Setup Arduino
    if settings.arduino
        arduino_obj = arduino('COM4' ,'Uno', 'Libraries', {'Adafruit/DHT22'});
        
        % Heater
        configurePin(arduino_obj,'D2','DigitalOutput');
        
        % Temperature / Humidity
        sensor_dht22 = addon(arduino_obj, 'Adafruit/DHT22', 'A0');
    end
    
    %% Setup NI
    if settings.ni
        ni=daq("ni");
        ni.Rate = 100;
        ni.addinput("cDAQ1Mod8","ai1","Thermocouple");
        ni.addinput("cDAQ1Mod8","ai3","Thermocouple");
        %     ni.addinput("cDAQ1Mod8","ai4","Thermocouple");
        for j = 1:length(ni.Channels)
            ni.Channels(j).ThermocoupleType = "J";
        end
    end
end
catch er
    disp('Issue setting up hardware.')
    error(er.message)
end

%% Create a sensor object to store data
sensor1 = sensor();
sensor1.wire = '1234';

%% Memory Preallocation
try
    T_g_out = zeros(settings.max_iterations, 1);
    T_h_out = zeros(settings.max_iterations, 1);
    T_o_out = zeros(settings.max_iterations, 1);
    p_v_out = zeros(settings.max_iterations, 1);
    p_a_out = zeros(settings.max_iterations, 1);
    q_out = zeros(settings.max_iterations, 1);
    phi_out = zeros(settings.max_iterations, 1);
    p_s_out = zeros(settings.max_iterations, 1);
    P_h_out = zeros(settings.max_iterations, 1);
    m_steam = zeros(settings.max_iterations, 1);
    x_0 = zeros(12,1);
    constants = zeros(1,4);
    specific_heat_fit_obj = [];
    draw_times = 1:10:settings.max_iterations;
catch er
    disp(er)
    error(er.message)
end

%% Do Everything
set(0,'DefaultFigureWindowStyle','docked')
[fig, dialog_box] = progress_dialog;
define_constants
x_0 = set_initial_conditions;
pid = controller_pid;
pid_phi = controller_pid;
define_temperature_controller
define_relative_humidity_controller
setup_progress_dialog

setpoint_T = settings.setpoints.T + 273.15;

main_loop

convert_to_C(settings)

create_plots(T_g_out, T_h_out, T_o_out, p_v_out, p_a_out, q_out,...
    phi_out, p_s_out, P_h_out, setpoint_T, settings.max_iterations, m_steam)

close(dialog_box)
close(fig)
output = table(T_g_out, T_h_out, T_o_out, p_v_out, p_a_out, q_out,...
    phi_out, p_s_out, P_h_out, 'VariableNames', {'T_g', 'T_h', 'T_o', ...
    'p_v', 'p_a', 'q', 'phi', 'p_s', 'P_h'});
set(0,'DefaultFigureWindowStyle','normal')

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
        if settings.simulation
            T_g0 = settings.T_g0_sim + c2k;
            T_h0 = settings.T_h0 + c2k;
        elseif ~settings.simulation && settings.ni
            daq_data = read(ni);
            T_g0 = daq_data.cDAQ1Mod8_ai1 + c2k;
            T_h0 = daq_data.cDAQ1Mod8_ai3 + c2k;
        end
        
        T_o0 = settings.T_o + c2k;
        p_g0 = 101.325;     % kPa, Initial/constant pressure of the control volume.
        V_g0 = 0.25;        % m^3, Initial/constant volume of aRDA "control volume"
        
        % Calculate initial saturation pressure
        %p_s0 = calculate_saturation_pressure(T_g0);
        p_s0 = XSteam('psat_T', T_g0);
        
        % kg/m^3
        rho_a0 = XDryAir('tK', T_g0, 'rho', p_g0);
        
        % kg, mass of dry air
        m_a0 = rho_a0 * V_g0;
        
        % kg, mass of vapor
        % m_v0 = m_a0 * phi_0 * 0.622 * (p_s0 / (p_g0 - p_s0));
        rho_v0 = XSteam('rho_pt', p_g0/100, T_g0-273.15); %#ok<NASGU>
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
        if ~settings.simulation && settings.arduino
            phi_0 = readHumidity(sensor_dht22);
            if isnan(phi_0)
                %error('Try disconnecting and reconnecting Arduino DHT22 Temp/Humidity Sensor')
            end
        else
            phi_0 =  p_v0 / p_s0;
        end
        % percent of moisture by volume
        pmv = p_v0 / p_g0; %#ok<NASGU>
        
        %
        q_0 = 0; % 0.622 * pmv / ((1 - pmv) + 0.622 * pmv);
        
        % Initial state vector
        x_0 = [T_g0; T_h0; T_o0; p_g0; p_v0; p_a0; V_g0; q_0; phi_0; p_s0; m_v0; m_a0];
    end

%% Define the temperature controller
    function define_temperature_controller()
        
        
        % Set the time step
        pid.Ts = settings.T_s;
        
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
        if settings.simulation
            pid.max_output = 11000; % Max watts from heater
        elseif ~settings.simulation && settings.arduino
            pid.max_output = 1;
        end
    end

%% Initialize the relative humidity controller
    function define_relative_humidity_controller()
        
        pid_phi.Ts = settings.T_s;
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
        setpoint_phi = 0.33;
        figure
        ax = gca;
        title('Temperature (K)')
        %%
        for i = 1:settings.max_iterations
            
            %% Controller
            
            % Calculate output for temperature controller
            pid = calculate_controller_output(...
                pid, setpoint_T, measurement);
            home
            fprintf('Measurement: %.1f\n', measurement)
            fprintf('Setpoint: %.1f\n', setpoint_T)
            if measurement - setpoint_T > 10
                keyboard
            end
            % When using the Arduino, the heater can be on or off
            if ~settings.simulation && settings.arduino
                if pid.out > 0
                    % Turn on the heater
                    writeDigitalPin(arduino_obj,'D2',1)
                else
                    % Turn off the heater
                    writeDigitalPin(arduino_obj,'D2',0)
                end
                pause(1) % Don't burn out the Arduino relay
            end
            
            % Calculate output for humidity controller
            pid_phi = calculate_controller_output(...
                pid_phi, setpoint_phi, measurement_phi);
            
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
                specific_heat_fit_obj),...
                [0 pid.Ts], x_0);
            
            % Capture sensor measurements
            if ~settings.simulation
                if settings.ni
                    daq_data = read(ni);
                    y(end,1) = daq_data.cDAQ1Mod8_ai1 + 273.15; % T_g2
                    y(end,2) = daq_data.cDAQ1Mod8_ai3 + 273.15; % T_h2
                end
                if settings.arduino
                    y(end,9) = readHumidity(sensor_dht22);
                end
            end
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
            
            xx = 1:length(T_g_out);
            yy = T_g_out - 273.15;
            plot(ax, xx, yy, '.b')
            grid on
            hold on
            axis([1 settings.max_iterations 20 50])
            
            
            if ismember(i, draw_times)
                dialog_box.Value = i/settings.max_iterations;
                drawnow
                if dialog_box.CancelRequested
                    break
                end
            end
        end
    end

%% Convert to Celsius
    function convert_to_C(settings)
        c2k = 273.15;
        T_g_out = T_g_out - c2k;
        T_h_out = T_h_out - c2k;
        T_o_out = T_o_out - c2k;
        setpoint_T = settings.setpoints.T;
    end

end

%% ODE of thermal system
function [delta] = odefun(~, x, pid, pid_phi, constants, fit_obj)
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

function create_plots(T_g_out, T_h_out, T_o_out, p_v_out, p_a_out, ~,...
    phi_out, p_s_out, P_h_out, setpoint_T, max_iterations, ~)
%% Humidity plot
figure
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
plot(setpoint_T * ones(max_iterations,1), '--k')

% Plot a horizontal line at the outside temperature
plot(T_o_out, '--m')
ylabel('Temp. (C)')
legend({'T_g', 'T_h', 'SP', 'T_o'}, 'Location', 'best')
xlim([1 max_iterations])

% Power setting of the heater
subplot(2,1,2)
plot(P_h_out); grid on
legend({'P_h'},'Location','best')
ylabel('Power (W)')
xlim([1 max_iterations])

end



































