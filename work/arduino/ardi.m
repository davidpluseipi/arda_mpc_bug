%% Start clean
clear; close all; clc

%% Setup sensors
arduino_obj = arduino('COM4','Uno',...
    'Libraries',{'Adafruit/DHT22', 'I2C'});

% Heater
configurePin(arduino_obj,'D2','DigitalOutput');

% Temperature / Humidity
sensor = addon(arduino_obj, 'Adafruit/DHT22', 'A1');

%% Setup NI
ni=daq("ni");
ni.Rate = 100;
ni.addinput("cDAQ1Mod8","ai1","Thermocouple");
%     d.addinput("cDAQ1Mod8","ai3","Thermocouple");
%     d.addinput("cDAQ1Mod8","ai4","Thermocouple");
for i = 1:length(ni.Channels)
    ni.Channels(i).ThermocoupleType = "J";
end
sensor1 = sensor();
sensor1.wire = '1234';



% Turn on the heater
writeDigitalPin(arduino_obj,'D2',1)

data = struct('Time', [], 'T', [], 'phi', [], 'out', []);
T = 0;

pid = controller_pid;
pid.Ts = 1;

tau = 2532;
tau_dead = 10;
P = (197.1 - 97.1)/97.1; % Percent change of input
N = ((25.81 - 22.87)/22.87) / tau; % Percent change of output / tau
L = tau_dead;
R = tau_dead / tau;
K_0 = P/(N*L);

% Cohen-Coon 1(only for self-regulating processes, like flow, temp, pressure)
pid.Kp = 0.0195; % K_0 * (1.33 + R/4);
pid.Ki = (L * (30 + 3*R) / (9 + 20 * R));
pid.Kd = (4 * L / (11 + 2 * R));
pid.tau = tau;
pid.min_output = 0;
pid.max_output = 10; % Max watts from heater

setpoint = 40;
i = 1;
h1 = figure; ax1 = axes('Parent',h1); grid on; move_figure(h1,1);
h2 = figure; ax2 = axes('Parent',h2); grid on; move_figure(h2,3);
xlim(ax2,[0, 1500]);
ylim(ax2,[0, (pid.max_output+(pid.max_output-pid.min_output)/2)]);

t_start = datetime('now');
%% Increase temperature
while T < 70
    for j = 1:10
        T = readTemperature(sensor);
        phi = readHumidity(sensor);
    end
    data.T = [data.T; T];
    data.phi = [data.phi; phi];
    fprintf('%s: T_g: %.1f C   phi: %.1f percent\n',...
        datestr(datetime('now')), T, phi)
    data.Time = [data.Time; datetime('now')];
    pid = calculate_controller_output(pid, setpoint, T);
    data.out = [data.out; pid.out];
    if pid.out == 0
        % Turn off the heater
        writeDigitalPin(arduino_obj,'D2',0)
    else
        % Turn on the heater
        writeDigitalPin(arduino_obj,'D2',1)
    end
    if i >= 2
        live_plot(ax1, data.Time(i-1:i), data.T(i-1:i)); grid on;
        xlim(ax1,[t_start, t_start+seconds(3600)])
        ylim(ax1,[0, setpoint+10])
        live_plot(ax2, [i-1,i], data.out(i-1:i));
    end
    if i > 1500
        break
    end
    n = pid.out;
    pause(n)
    i = i + 1;
end

%% Safety
% Turn off the heater
writeDigitalPin(arduino_obj,'D2',0)
playTone(arduino_obj,'D5',1000,0.25)