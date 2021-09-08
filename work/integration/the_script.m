clear; close all; clc
memory

load('controllers.mat','controllers')
load('C.mat','C')
for i = 1:length(controllers)
    controllers{i} = C;
end

bob = arda();
bob.controllers = controllers;

bob.simulation_only = false;
bob.using_arduino_hardware = false;
bob.using_ni_hardware = true;
bob.using_lidar = false;
bob.using_relative_humidity_sensor = false;
bob.heater = 'ni';
bob.max_iterations = 100;
bob.live_plot = false;

bob.temperature_setpoint = 25;
step_up = 1; % deg C
%str = ['bob_' num2str(bob.temperature_setpoint) '_step_' num2str(step_up)];

k = 3; % number of times setpoint changes
bob.t = floor(linspace(1, bob.max_iterations, k+2));

bob.s = [];
for i = 1:k+1
    if i <= 1
        j = 0;
    else
        j = 1;
    end
    bob.s = [bob.s j];
end
bob.s = step_up*bob.s;

% disp(['***** Starting ' str ' *****'])
tic
bob = main(bob);
toc

min(bob.loop_time)
max(bob.loop_time)

% T = timetable(bob.time', bob.outputs(:,1), bob.outputs(:,2), ...
%     bob.P_h, 'VariableNames',{'T_g','T_h','P'});
% figure
% plot(bob.setpoints,'-r');
% hold on
% plot(bob.outputs(:,1),'.b')
% hold off

% title(str, "Interpreter","none")
% legend("setpoints","T_g")

% figure
% stackedplot(T);
% title(str, "Interpreter","none")

% save([str '.mat'], "bob", "T")
% disp(['***** Complete with ' str ' *****'])

memory

L1 = length(bob.time);

if rem(L1,2) == 0
    L2 = L1-1;
else
    L2 = L1;
end

idx = 1;
d = seconds(zeros(L1/2,1));
for i = 1:2:L2
    d(idx) = duration(bob.time(i+1) - bob.time(i));
    idx = idx + 1;
end
D = seconds(duration(d)); % duration of time steps in main loop (sec)