clear; close all; clc
main_folder = fullfile('C:','ARDA','ARDA Raw Output','Results');
d = dir(main_folder);

controllers = cell(30,1);
for i = 3:length(d)
    if d(i).isdir
        folder = fullfile(main_folder, d(i).name);
        if exist(fullfile(folder,'bob.mat'),'file')
            load(fullfile(folder, 'bob.mat'),'bob');
            if bob.max_iterations >= 600 && length(bob.history) >= 600
                [C, info, sys] = tune_it(bob); % in info, stable 1 is closed loops stable, 0 otherwise
                if info.Stable
                    arda1 = bob.history{1};
                    idx = arda1.temperature_setpoint - 1;
                    if isempty(controllers(idx))
                        controllers{idx} = C;
                    else
                        error('Tuning.m tried to overwrite a non-empty cell.')
                    end
                end
            end
        end
    end
end


function [C, info, sys] = tune_it(bob)
n = 5; % order of state space model
nx = n + 1;
Y =  bob.outputs(:,1);%[zeros(n,1); bob.outputs(:,9)] ];

U = bob.voltage;
T_s = 1;
ze = iddata(Y, U', T_s);
ze.Name = 'ARDA';
ze.InputUnit = 'V';
ze.InputName = 'Voltage';
ze.OutputUnit = {'K'};
ze.OutputName = {'Temperature'};%,'Relative Humidity'};


% Split the data into estimation and validation datasets
ze1 = ze(1:floor(length(U)*2/3));
zv1 = ze(floor(length(U)*2/3 + 1):end);

opt = ssestOptions("EnforceStability", true);
sys = ssest(ze1, nx, opt);

% figure
% compare(ze1, sys)

G = idtf(sys, 'InputName', 'u', 'OutputName','y');
% C1 = pidtune(tf(1),'PID');
% C2 = pidtune(tf(2),'PID');

if ~isempty(find(pole(G) > 0, 1))
    disp('Unstable: Poles in the right hand plane.')
    disp(pole(G))
end
n_unstable_poles = sum(pole(G) > 0);

%% Estimate frequency response
% with fixed frequency resolution using spectral analysis
% figure
% ge = spa(ze);
% b = bodeplot(ge);
% showConfidence(b,3)

%% Estimate impulse response model
% with persistence-of-exitation analysis on the input data
% to select the model order. Use nonparametric impulse
% response estimation to analyze I/O data for feedback
% effects, delays and significant time constants.
model_impulse = impulseest(ze1,60);
% figure
% step(model_impulse)
delay = delayest(ze1);

%% Estimate ARX models
% Generate model order combinations for estimation
NN = struc(2:10,2:10, delay);

% Estimate ARX models and compute the loss function for each model order
% combination
V = arxstruc(ze1(:,:,1), zv1(:,:,1), NN);
order = selstruc(V,0);
options = arxOptions('EnforceStability',true);
model_discrete = arx(ze1, order, options);

%% Convert to other forms as needed
% Convert model to continuous time
try
    model_continuous = d2c(model_discrete);
    model_state_space = idss(model_continuous); %#ok<NASGU>
    model_transfer_function = idtf(model_continuous);
    
    %% System Analysis
    sys = model_transfer_function;
catch
    sys = model_discrete;
end

%% Plot system step and impluse responses
% figure
% subplot(2,1,1); step(sys)
% subplot(2,1,2); impulse(sys)

%% Tune
bandwidth = 0.03;
options = pidtuneOptions(...
    'PhaseMargin', 60,...
    'DesignFocus', 'reference-tracking',...
    'NumUnstablePoles', n_unstable_poles);
% 'balanced'
% 'reference-tracking'
% 'disturbance-rejection'
[C, info] = pidtune(sys, 'PID2', bandwidth, options);
% pidTuner(sys,'PID')


end