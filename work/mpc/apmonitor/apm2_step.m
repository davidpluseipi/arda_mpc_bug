% Add path to APM libraries
% addpath('./apm');

% Clear MATLAB
clear
close all

% retrieve n,m,p sizes
% n = # of states
% m = # of inputs
% p = # of outputs
load dimensions.mat

% Select server
server = 'http://xps.apmonitor.com';

% Application
app = 'step_mv1';

% Clear previous application
apm(server,app,'clear all');

% load model variables and equations
apm_load(server,app,'lti.apm');

% load data
csv_load(server,app,'step_mv1.csv');

% Set up variable classifications for data flow

% Feedforwards - measured process disturbances
% No parameters
% apm_info(server,app,'FV','gamma[1]');

% Manipulated variables
for i = 1:m
  v = ['u[' int2str(i) ']'];
  apm_info(server,app,'MV',v);
end

% State variables (for display only)
for i = 1:n
  v = ['x[' int2str(i) ']'];
  apm_info(server,app,'SV',v);
end

% Controlled variables
for i = 1:p
  v = ['y[' int2str(i) ']'];
  apm_info(server,app,'CV',v);
end

% imode = 4, simulation
apm_option(server,app,'nlc.imode',4);

% time units (1=sec, 2=min, 3=hr, etc.)
apm_option(server,app,'nlc.ctrl_units',1);
apm_option(server,app,'nlc.hist_units',2);

% read csv file
apm_option(server,app,'nlc.csv_read',1);

% Run APMonitor
apm(server,app,'solve')

% Open web-viewer
apm_web(server,app);

% Retrieve solution (creates solution.csv locally)
solution = apm_sol(server,app);
cc = cell2mat(solution(2:end,:));

time = cc(:,1);

names = solution(1,:);

u11 = cc(:, contains(names, 'u[1]'));

u21 = cc(:, contains(names, 'u[2]'));

y11 = cc(:, contains(names, 'y[1]'));

y21 = cc(:, contains(names, 'y[2]'));




% Application
app = 'step_mv2';

% Clear previous application
apm(server,app,'clear all');

% load model variables and equations
apm_load(server,app,'lti.apm');

% load data
csv_load(server,app,'step_mv2.csv');

% Set up variable classifications for data flow

% Feedforwards - measured process disturbances
% No parameters
% apm_info(server,app,'FV','gamma[1]');
% Manipulated variables
for i = 1:m
  v = ['u[' int2str(i) ']'];
  apm_info(server,app,'MV',v);
end

% State variables (for display only)
for i = 1:n
  v = ['x[' int2str(i) ']'];
  apm_info(server,app,'SV',v);
end

% Controlled variables
for i = 1:p
  v = ['y[' int2str(i) ']'];
  apm_info(server,app,'CV',v);
end

% imode = 4, simulation
apm_option(server,app,'nlc.imode',4);

% time units (1=sec, 2=min, 3=hr, etc.)
apm_option(server,app,'nlc.ctrl_units',1);
apm_option(server,app,'nlc.hist_units',2);

% read csv file
apm_option(server,app,'nlc.csv_read',1);

% Run APMonitor
apm(server,app,'solve')

% Open web-viewer
apm_web(server,app);

% Retrieve solution (creates solution.csv locally)
solution = apm_sol(server,app);
cc = cell2mat(solution(2:end,:));

time = cc(:,1);

names = solution(1,:);

u12 = cc(:, contains(names, 'u[1]'));

u22 = cc(:, contains(names, 'u[2]'));

y12 = cc(:, contains(names, 'y[1]'));

y22 = cc(:, contains(names, 'y[2]'));

figure(1)
subplot(4,2,1)
plot(time, u11, '-b');
title('step 1')
ylabel('MV_1')
legend('u_1');
grid on

subplot(4,2,2)
title('step 2')
plot(time, u12, '-b');
legend('u_1');
grid on

subplot(4,2,3)
plot(time,u21,'b-');
ylabel('MV_2')
legend('u_2');
grid on

subplot(4,2,4)
plot(time, u22, '-b');
legend('u_2');
xlabel('Time (sec)')
grid on

subplot(4,2,5)
plot(time, y11, '-b');
ylabel('CV_1')
legend('y_1');
grid on

subplot(4,2,6)
plot(time,y12,'b-');
legend('y_1');
grid on

subplot(4,2,7)
plot(time, y21, '-b');
ylabel('CV_2')
legend('y_2');
grid on

subplot(4,2,8)
plot(time, y22, 'b-');
legend('y_2');
grid on
xlabel('Time (sec)')