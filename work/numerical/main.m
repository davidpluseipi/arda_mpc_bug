clear
close all
clc

delta_T = 100;
T_o0 = 20;
phi_0 = 0;
T_h0 = 20;
T_s = 1;
N = 300;
off = 1e6;

[T_g, T_h, P_h, phi_out] = arda_numerical(delta_T, T_o0, phi_0, T_h0, T_s, N/T_s, off/T_s);

price = 0.1036;  % $/kWh
cost = 0;
for i = 1:numel(P_h)
   % Needs to be adjusted to account for when Ts is not 1 sec
   cost = cost + price * P_h(i)/(1000*60*60);
end
fprintf('Cost for this run: $%.8f\n', cost)
