clear; close all; clc
load('matlab.mat','data')
h = figure;
h1 = figure;
for i = 1:10
    t = data.Time(i+1);
    T = data.T(i);
    live_plot(h,t,T);
    
    pause(1)
end
