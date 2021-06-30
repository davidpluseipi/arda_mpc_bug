clear
close all
clc

delta_T = 20;
T_o0 = 35;
T_h0 = 50;
T_s = 1;
N = 10;
off = 1e6;

data = arda_numerical(delta_T, T_o0, T_h0, T_s, N/T_s, off/T_s);

price = 0.1036;  % $/kWh
cost = 0;
for i = 1:numel(data.P_h)
   % Needs to be adjusted to account for when Ts is not 1 sec
   cost = cost + price * data.P_h(i)/(1000*60*60);
end
fprintf('Cost for this run: $%.8f\n', cost)
