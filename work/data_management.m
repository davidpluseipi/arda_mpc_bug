clear; close all; clc
cd('C:\Users\dmeissner\OneDrive - Forest Concepts\code\dryer\work\arduino');
load('matlab.mat','data')
A = timetable(data.T,data.phi,data.out/10,...
    'RowTimes',data.Time,...
    'VariableNames',{'T','phi','out'});
% Retime with 1 sec time step
B = retime(A,'secondly','spline');
head(B,10)

% Set the timestep to match the timestep above
Ts = 1;
% Put the input/output data into an iddata object
ze = iddata(B.T, B.out, Ts);

ze.Name = 'pc';
ze.InputUnit = 'percent';
ze.OutputUnit = 'C';
ze.InputName = 'Power Setting';
ze.OutputName = 'Temperature';

figure
plot(ze)

% Split the data into estimation and validation datasets
ze1 = ze(1:1600);
zv1 = ze(1601:end);

%% Estimate frequency response 
% with fixed frequency resolution using spectral analysis
figure
ge = spa(ze);
b = bodeplot(ge);
showConfidence(b,3)
%% Estimate impulse response model
% with persistence-of-exitation analysis on the input data
% to select the model order. Use nonparametric impulse 
% response estimation to analyze I/O data for feedback
% effects, delays and significant time constants.
model_impulse = impulseest(ze1,60);
figure
step(model_impulse)
delay = delayest(ze1);

%% Estimate ARX models
% Generate model order combinations for estimation
NN = struc(2:10,2:10, delay);

% Estimate ARX models and compute the loss function for each model order
% combination (
V = arxstruc(ze1(:,:,1), zv1(:,:,1), NN);
order = selstruc(V,0);
model_discrete = arx(ze1, order);

%% Convert to other forms as needed
% Convert model to continuous time
model_continuous = d2c(model_discrete);
model_state_space = idss(model_continuous);
model_transfer_function = idtf(model_continuous);

%% System Analysis
%
sys = model_transfer_function;
% Look for positive real parts (unstable)
Z = zero(sys);
if any(real(Z) > 0)
    disp('Unstable system.')
end
%% Plot system step and impluse responses
figure
subplot(2,1,1); step(sys)
subplot(2,1,2); impulse(sys)

%% Plot response to sine wave
figure
t = 0:400;
u = sin(10*t);
lsim(sys, u, t)

%% For state-space, plot the unforced response 
% from a given state
x0 = [0.8];
figure
initial(model_state_space, x0)
grid on

%% Frequency response
figure
bode(sys)
grid

%% Nyquist
figure
nyquist(sys)
grid

%% Nichols 
figure
nichols(sys)
grid
axis([-270 270 -40 20])

%% Pole/Zero Maps and Root Locus
% SISO
k = 0.7;
figure
pzmap(feedback(k*sys, 1))
grid

%% Plot step response to confirm closed-loop stability
figure
step(sys)