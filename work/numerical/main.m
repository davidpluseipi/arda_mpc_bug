clear
close all
clc
T_g0 = 20;
delta_T = 100;
T_o0 = 20;
phi_0 = 0.80;
T_h0 = T_g0;
T_s = 1;
N = 2000;
off = 400;
% [T_g_out, T_h_out, P_h_out, phi_out] = arda_numerical(T_g0, delta_T, T_o0, phi_0, T_h0, max_iterations)
[T_g, T_h, P_h, phi_out] = arda_numerical(T_g0, delta_T, T_o0, phi_0, T_h0, T_s, N/T_s, off/T_s);
fprintf('Max heater output (W): %.1f\n', max(P_h))
fprintf('Min heater output (W): %.1f\n', min(P_h))
price = 0.1036;  % $/kWh
cost = 0;
for i = 1:numel(P_h)
   % Needs to be adjusted to account for when Ts is not 1 sec
   cost = cost + price * P_h(i)/(1000*60*60);
end
fprintf('Cost for this run: $%.8f\n', cost)
% M = [T_g' T_h' P_h'];


% [T_g, T_h, P_h] = arda_numerical(T_g(end), T_g0 + delta_T - T_g(end), T_o0, phi_out(end), T_h(end), 100);
% % fprintf('Max heater output (W): %f\n', max(P_h))
% % fprintf('Min heater output (W): %f\n', min(P_h))
% % price = 0.1036;  % $/kWh
% % cost = 0;
% % for i = 1:numel(P_h)
% %    % Needs to be adjusted to account for when Ts is not 1 sec
% %    cost = cost + price * P_h(i)/(1000*60*60);
% % end
% % fprintf('Cost for this run: $%.8f\n', cost)
% M = [M; T_g' T_h' P_h'];
% figure
% plot(M(:,1))