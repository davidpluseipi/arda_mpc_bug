clear; close all; clc; disp('Starting Test')

load('C.mat','C')
bob = arda();

bob.C = C;
bob.using_arduino_hardware = true;
bob.using_ni_hardware = true;
bob.heater = 'ni';
bob.max_iterations = 1200;
bob.live_plot = true;

k = 3; % number of times setpoint changes
step_up = 5; % deg C
bob.t = floor(linspace(1, bob.max_iterations, k+2));
bob.t(2) = 10;
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

tic
bob = main(bob);
toc
% T = timetable(bob.time', bob.outputs(:,1), bob.outputs(:,2), ...
%     bob.resistance', bob.voltage', bob.P_h,...
%     'VariableNames',{'T_g','T_h','R','V','P'});
% figure; plot(bob.setpoints,'-r');hold on; plot(bob.outputs(:,1),'.b')
% figure; stackedplot(T);
% save bob.mat bob
% save run_9.mat bob
% disp(bob.C)

