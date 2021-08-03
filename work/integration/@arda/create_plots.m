function create_plots(arda)

c2k = 273.15;
arda.T_g_out = arda.T_g_out - c2k;
arda.T_h_out = arda.T_h_out - c2k;
arda.T_o_out = arda.T_o_out - c2k;

%% Humidity plot
figure
% yyaxis left
% plot(q_out)
% ylabel('Humidity Ratio')
%
% yyaxis right
plot(arda.phi_out)
ylabel('Relative Humidity')
xlabel('Time')
grid on


%% Pressure plot
figure
subplot(3,1,1)
plot(arda.p_v_out)
title('Pressure (kPa)')
grid on
legend({'p_v'}, 'Location', 'best')
ylabel('p_v')

subplot(3,1,2)
plot(arda.p_a_out)
grid on
legend({'p_a'}, 'Location', 'best')
ylabel('p_a')

subplot(3,1,3)
plot(arda.p_s_out)
grid on
xlabel('Time')
legend({'p_s'}, 'Location', 'best')
ylabel('p_s')

%% Temperature plot
figure; subplot(2,1,1)

% Gas mixture temperature
plot(arda.T_g_out); hold on; grid on

% Heater temperature
plot(arda.T_h_out)

% Plot a horizontal line at the setpoint
plot(arda.settings.setpoints.T * ones(arda.max_iterations,1), '--k')

% Plot a horizontal line at the outside temperature
plot(arda.T_o_out, '--m')
ylabel('Temp. (C)')
legend({'T_g', 'T_h', 'SP', 'T_o'}, 'Location', 'best')
xlim([1 arda.max_iterations])

% Power setting of the heater
subplot(2,1,2)
plot(arda.P_h_out); grid on
legend({'P_h'},'Location','best')
ylabel('Power (W)')
xlim([1 arda.max_iterations])

end