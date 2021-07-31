function [bob, data] = main(bob, options)

    arguments
        bob handle
        options.parallel (1,1) {mustBeNumericOrLogical} = false
        options.fail_selftest (1,1) {mustBeNumericOrLogical} = false
        options.fail_overtemp (1,1) {mustBeNumericOrLogical} = false
    end

bob.parallel = options.parallel;
bob.fail_selftest = options.fail_selftest;
bob.fail_overtemp = options.fail_overtemp;
zoe = responder(bob); %#ok<NASGU>

%% Setup Hardware
try
if ~bob.settings.simulation
    %% Setup Arduino
    if bob.settings.arduino
        bob.arduino_daq_obj = arduino('COM4' ,'Uno', 'Libraries', {'Adafruit/DHT22'});
        
        % Heater
        configurePin(bob.arduino_daq_obj,'D2','DigitalOutput');
        
        % Temperature / Humidity
        bob.sensor_dht22 = addon(bob.arduino_daq_obj, 'Adafruit/DHT22', 'A0');
    end
    
    %% Setup NI
    if bob.settings.ni
        bob.ni_daq_obj = daq("ni");
        bob.ni_daq_obj.Rate = 100;
        bob.ni_daq_obj.addinput("cDAQ1Mod8","ai1","Thermocouple");
        bob.ni_daq_obj.addinput("cDAQ1Mod8","ai3","Thermocouple");
        % bob.ni_daq_obj.addinput("cDAQ1Mod8","ai4","Thermocouple");
        for j = 1:length(bob.ni_daq_obj.Channels)
            bob.ni_daq_obj.Channels(j).ThermocoupleType = "J";
        end
    end
end
catch er
    bob.log_error(er.message)
end

%% Memory Preallocation

T_g_out = zeros(bob.max_iterations, 1);
T_h_out = zeros(bob.max_iterations, 1);
T_o_out = zeros(bob.max_iterations, 1);
p_v_out = zeros(bob.max_iterations, 1);
p_a_out = zeros(bob.max_iterations, 1);
q_out = zeros(bob.max_iterations, 1);
phi_out = zeros(bob.max_iterations, 1);
p_s_out = zeros(bob.max_iterations, 1);
P_h_out = zeros(bob.max_iterations, 1);
m_steam = zeros(bob.max_iterations, 1);
x_0 = zeros(12,1);
draw_times = 1:2:bob.max_iterations;

%% Create a sensor object to store data
% sensor1 = sensor();
% sensor1.wire = '1234';

%%
bob.progress_dialog();

bob.define_constants();

c2k = 273.15;

if bob.settings.simulation
    
    bob.T_g = bob.settings.T_g_sim + c2k;
    bob.T_h = bob.settings.T_h + c2k;

elseif ~bob.settings.simulation && bob.settings.ni
    
    daq_data = read(bob.ni_daq_obj);
    bob.T_g = daq_data.cDAQ1Mod8_ai1 + c2k;
    bob.T_h = daq_data.cDAQ1Mod8_ai3 + c2k;

end

x_0 = bob.set_initial_conditions();

pid = controller_pid();

pid_phi = controller_pid;

define_temperature_controller();

define_relative_humidity_controller();

if bob.progress_bar; setup_progress_dialog(); end

setpoint_T = bob.settings.setpoints.T + 273.15;

notify(bob, 'prestartup');
notify(bob, 'startup')
notify(bob, 'selftest')

check4errors(bob)
if bob.red_alert || bob.yellow_alert
    data = {};
    return
end

if bob.parallel 
    bob.pool = gcp;
end

main_loop();
convert_to_C(bob);

create_plots(T_g_out, T_h_out, T_o_out, p_v_out, p_a_out, q_out,...
    phi_out, p_s_out, P_h_out, setpoint_T, bob.max_iterations, m_steam)

if bob.progress_bar
    close(bob.dialog_box)
    close(bob.fig)
end

data = table(T_g_out, T_h_out, T_o_out, p_v_out, p_a_out, q_out,...
    phi_out, p_s_out, P_h_out, 'VariableNames', {'T_g', 'T_h', 'T_o', ...
    'p_v', 'p_a', 'q', 'phi', 'p_s', 'P_h'});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define Nested Functions

%% Progress dialog


%% Define constants
    

%% Define the temperature controller
    function define_temperature_controller()
        
        
        % Set the time step
        pid.Ts = bob.settings.T_s;
        
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
        if bob.settings.simulation
            pid.max_output = 11000; % Max watts from heater
        elseif ~bob.settings.simulation && bob.settings.arduino
            pid.max_output = 1;
        end
    end

%% Initialize the relative humidity controller
    function define_relative_humidity_controller()
        
        pid_phi.Ts = bob.settings.T_s;
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
        bob.dialog_box.Message = "Processing...";
        drawnow
    end

%% Main loop
    function main_loop()
        setpoint_T = bob.settings.setpoints.T;
        setpoint_phi = bob.settings.setpoints.phi;
        measurement = x_0(1); % T_g
        measurement_phi = x_0(9); % phi
        
        figure
        ax = gca;
        title('Temperature (K)')
        %%
        for i = 1:bob.max_iterations
            stuff_happens(bob);
            if bob.parallel
                if ~exist('F','var')
                    fcn_handle = @bob.do_stuff;
                    F = parfeval(fcn_handle, 1);
                else
                    if numel(F.OutputArguments) > 0
                        bob2 = fetchOutputs(F);
                        clearvars F
                    end
                end
            end            
            %% Controller
            % Calculate output for temperature controller
            pid = calculate_controller_output(...
                pid, setpoint_T, measurement);
            home
            fprintf('Measurement: %.1f\n', measurement)
            fprintf('Setpoint: %.1f\n', setpoint_T)

            % When using the Arduino, the heater can be on or off
            if ~bob.settings.simulation && bob.settings.arduino
                if pid.out > 0
                    % Turn on the heater
                    writeDigitalPin(bob.arduino_daq_obj,'D2',1)
                else
                    % Turn off the heater
                    writeDigitalPin(bob.arduino_daq_obj,'D2',0)
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
            [~, y] = ode23(@(t,y) odefun(t, y, pid, pid_phi, bob.constants,...
                bob.specific_heat_fit_obj),...
                [0 pid.Ts], x_0);
            
            % Capture sensor measurements
            if ~bob.settings.simulation
                if bob.settings.ni
                    daq_data = read(bob.ni_daq_obj);
                    y(end,1) = daq_data.cDAQ1Mod8_ai1 + 273.15; % T_g2
                    y(end,2) = daq_data.cDAQ1Mod8_ai3 + 273.15; % T_h2
                end
                if bob.settings.arduino
                    y(end,9) = readHumidity(bob.sensor_dht22);
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
            axis([1 bob.max_iterations 20 50])
            
            check4errors(bob)
            if bob.red_alert || bob.yellow_alert
                return
            end
            
            if bob.progress_bar && ismember(i, draw_times)
                bob.dialog_box.Value = i/bob.max_iterations;
                drawnow
                if bob.dialog_box.CancelRequested
                    break
                end
            end
        end
    end

%% Convert to Celsius
    function convert_to_C(bob)
        c2k = 273.15;
        T_g_out = T_g_out - c2k;
        T_h_out = T_h_out - c2k;
        T_o_out = T_o_out - c2k;
        setpoint_T = bob.settings.setpoints.T;
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

function obj = stuff_happens(obj)

%% TEST
delta = 0;
if obj.fail_overtemp
    delta = 300;
end
obj.T_g = obj.T_g + delta;

end


