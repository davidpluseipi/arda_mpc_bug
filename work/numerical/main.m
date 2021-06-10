clear
close all
clc
% function [T_g, T_h, P_h] = arda_numerical(T_g0, delta_T)
[T_g, T_h, P_h] = arda_numerical(20, 100);
fprintf('Max heater output (W): %f\n', max(P_h))
fprintf('Min heater output (W): %f\n', min(P_h))


