clear; close all; clc
load('controllers.mat','controllers')


bob = arda();
bob.controllers = controllers;

bob.simulation_only = false;
bob.using_arduino_hardware = false;
bob.using_ni_hardware = true;
bob.using_lidar = false;
bob.using_relative_humidity_sensor = true;
bob.heater = 'ni';
bob.max_iterations = 1200;
bob.live_plot = true;

bob.temperature_setpoint = 24;
step_up = 1; % deg C
str = ['bob_' num2str(bob.temperature_setpoint) '_step_' num2str(step_up)];

k = 3; % number of times setpoint changes
bob.t = floor(linspace(1, bob.max_iterations, k+2));
bob.s = [];
for i = 1:k+1
    if i <= 1
        j = 0;
    elseif i == 2
        j = 1;
    else
        j = 2;
    end
    bob.s = [bob.s j];
end
bob.s = step_up*bob.s;

disp(['***** Starting ' str ' *****'])
tic
bob = main(bob);
toc

T = timetable(bob.time', bob.outputs(:,1), bob.outputs(:,2), ...
    bob.P_h, 'VariableNames',{'T_g','T_h','P'});
figure
plot(bob.setpoints,'-r');
hold on
plot(bob.outputs(:,1),'.b')
hold off

title(str, "Interpreter","none")
legend("setpoints","T_g")

figure
stackedplot(T);
title(str, "Interpreter","none")

save([str '.mat'], "bob", "T")
disp(['***** Complete with ' str ' *****'])



