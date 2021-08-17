clear; close all; clc
disp('Starting Test 2A')

load('C.mat','C')
bob = arda();
bob.C = C;
bob.using_arduino_hardware = false;
bob.using_ni_hardware = true;
bob.heater = 'ni';
bob.max_iterations = 600;
bob.live_plot = true;
k = 3; % number of times setpoint changes
step_up = 1; % deg C
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

bob = main(bob);
figure; plot(bob.P_h)
figure; plot(bob.setpoints,'-r');hold on; plot(bob.outputs(:,1),'.b')
save bob.mat bob
save bob1.mat bob

% clear; close all; clc
% C = test_online_tuning();
% 
% disp('Starting Test 2B')
% bob = arda();
% bob.C = C;
% bob.using_arduino_hardware = false;
% bob.using_ni_hardware = true;
% bob.heater = 'ni';
% bob.max_iterations = 600;
% bob.live_plot = true;
% k = 3; % number of times setpoint changes
% step_up = 1; % deg C
% bob.t = floor(linspace(1, bob.max_iterations, k+2));
% bob.s = [];
% for i = 1:k+1
%     if i <= 1
%         j = 0;
%     else
%         j = 1;
%     end
%     bob.s = [bob.s j];
% end
% bob.s = step_up*bob.s;
% bob = main(bob);
% figure; plot(bob.P_h)
% figure; plot(bob.setpoints,'-r');hold on; plot(bob.outputs(:,1),'.b')
% save bob.mat bob
% save bob2.mat bob