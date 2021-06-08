clear; close all; clc

% get cfm fan data
load('fan_data.mat','fan_data')
lower_limit = fan_data.power.watts(1);
upper_limit = fan_data.power.watts(end);

% Create a vector of power settings
x1 = lower_limit:1:upper_limit;
x2 = x1(x1 >= lower_limit & x1 <= upper_limit);
P = num2cell(x2);
[f,v,~,~] = cellfun(@calculate_flow_rate, P, 'UniformOutput', false);
%%
plot(x2, cell2mat(v))
xlabel 'Power (Watts)'
ylabel 'Velocity (m/s)'
title 'Power Setting vs Velocity'
grid on
