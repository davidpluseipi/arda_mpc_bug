function create_plots(arda)
%% Create plots from the output data

%% Data management
c2k = 273.15;
T_g = arda.outputs(:,1) - c2k;
% T_h = arda.outputs(:,2) - c2k; % save for later
T_o = arda.outputs(:,3) - c2k;
p_v = arda.outputs(:,5);
p_a = arda.outputs(:,6);
p_s = arda.outputs(:,10);
P_h = arda.P_h;

%% Humidity plot
figure
plot(arda.phi)
ylabel('Relative Humidity')
xlabel('Time')
grid on

%% Pressure plot
figure
subplot(3,1,1)

% Partial pressure of vapor
plot(p_v)
title('Pressure (kPa)')
grid on
legend({'p_v'}, 'Location', 'best')
ylabel('p_v')

% Partial pressure of air
subplot(3,1,2)
plot(p_a)
grid on
legend({'p_a'}, 'Location', 'best')
ylabel('p_a')

% Saturation pressure
subplot(3,1,3)
plot(p_s)
grid on
xlabel('Time')
legend({'p_s'}, 'Location', 'best')
ylabel('p_s')

%% Temperature plot
figure
subplot(2,1,1)

% Gas mixture temperature
plot(T_g)
hold on
grid on

% Heater temperature
% plot(T_h) % save for later

% Plot a horizontal line at the setpoint
plot((arda.temperature_setpoint - c2k) * ones(arda.max_iterations,1), '--k')

% Plot a horizontal line at the outside temperature
plot(T_o, '--m')
ylabel('Temp. (C)')
legend({'T_g', 'Setpoint', 'T_o'}, 'Location', 'best')
xlim([1 arda.max_iterations])

% Power setting of the heater
subplot(2,1,2)
plot(P_h)
grid on
legend({'P_h'},'Location','best')
ylabel('Power (W)')
xlim([1 arda.max_iterations])

end