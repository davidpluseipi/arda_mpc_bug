%%
clear; clc; close all


load('bob.mat','bob')
nx = 8; % order of state space model
n = nx + 1;
Y = [ [zeros(n,1); bob.outputs(:,1)] [zeros(n,1); bob.outputs(:,9)] ];

U = [zeros(n,1); bob.P_h];
T_s = 1;
ze = iddata(Y, U, T_s);
ze.Name = 'ARDA';
ze.InputUnit = 'Voltage';
ze.InputName = 'Power';
ze.OutputUnit = {'K','percent'};
ze.OutputName = {'Temperature','Relative Humidity'};


% Split the data into estimation and validation datasets
ze1 = ze(1:1000);
zv1 = ze(1001:end);




sys = ssest(ze1, nx);
% compare(ze1, sys)

G = idtf(sys, 'InputName', 'q', 'OutputName','y');
% C1 = pidtune(tf(1),'PID');
% C2 = pidtune(tf(2),'PID');

if ~isempty(find(pole(G) > 0, 1))
    disp('Unstable: Poles in the right hand plane.')
    disp(pole(G))
end









% %%
% clear; clc; close all
% load('bob.mat','bob')
% Y = [bob.outputs(:,1) bob.outputs(:,9)];
% U = [bob.P_h];
% T_s = 1;
% ze = iddata(Y, U, T_s);
% ze.Name = 'ARDA';
% ze.InputUnit = 'Voltage';
% ze.InputName = 'Power';
% ze.OutputUnit = {'K','percent'};
% ze.OutputName = {'Temperature','Relative Humidity'};
%
% figure
% plot(ze)
%
% % Split the data into estimation and validation datasets
% ze1 = ze(1:1000);
% zv1 = ze(1001:end);
%
% %% Estimate frequency response
% % with fixed frequency resolution using spectral analysis
% figure
% ge = spa(ze);
% b = bodeplot(ge);
% showConfidence(b,3)
%
% %% Estimate impulse response model
% % with persistence-of-exitation analysis on the input data
% % to select the model order. Use nonparametric impulse
% % response estimation to analyze I/O data for feedback
% % effects, delays and significant time constants.
% model_impulse = impulseest(ze1,60);
% figure
% step(model_impulse)
% delay = delayest(ze1);
%
% %% Estimate ARX models
% % Generate model order combinations for estimation
% NN = struc(2:10,2:10, delay);
%
% % Estimate ARX models and compute the loss function for each model order
% % combination
% V = arxstruc(ze1(:,:,1), zv1(:,:,1), NN);
% order = selstruc(V,0);
% model_discrete = arx(ze1, order);
%
% %% Convert to other forms as needed
% % Convert model to continuous time
% model_continuous = d2c(model_discrete);
% model_state_space = idss(model_continuous);
% model_transfer_function = idtf(model_continuous);
%
% %% System Analysis
% %
% sys = model_transfer_function;
% % Look for positive real parts (unstable)
% Z = zero(sys);
% if any(real(Z) > 0)
%     disp('Unstable system.')
% end
% %% Plot system step and impluse responses
% figure
% subplot(2,1,1); step(sys)
% subplot(2,1,2); impulse(sys)
%
% %% Tune
% C = pidtune(sys,'PID');
