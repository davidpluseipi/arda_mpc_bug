function [sys, x0] = system_id(input, options)
%% Identifies discrete system plant model from Simulink logsout data (default) or N X 6 matrix of input and output data, where N is the number of samples in the dataset.

arguments

    input
    options.logsout {mustBeNumericOrLogical} = true

end


if options.logsout

    logsout = input;
    Ts = logsout{1}.Values.Time(3) - logsout{1}.Values.Time(2); % Sample time.

    % Encapsulate the input/output data into an iddata object

    idx = zeros(4,1);
    names = logsout.getElementNames;
    correct_names = {'u1' 'u2' 'y1' 'y2'};

    for i = 1:length(correct_names)

        for j = 1:length(names)

            if strcmp(correct_names{i}, names{j})

                idx(i) = j;

            end

        end

    end
    
    % Assume the first length is the shortest
    L = length(logsout{1}.Values.Data);

    for i = 2:length(idx)

        L2 = length(logsout{idx(i)}.Values.Data);

        if L > L2

            L = L2;

        end

    end

    data = zeros(L, length(idx));

    for i = 1:length(idx)

        data(:,i) = logsout{idx(i)}.Values.Data(1:L);

    end

end

input = data(:,1:2);
output = data(:,3:4);
z = iddata(output, input, Ts);

z.Name = 'arda';
z.InputName = {'u1' 'u2'};
z.InputUnit = {'V' 'kg/s'};
z.OutputName = {'y1' 'y2'};
z.OutputUnit = {'degC' ' '};

% Split the data into estimation and validation datasets
ze = z(1 : 0.9*size(data,1));
zv = z(length(ze) + 1 : end);

% Define model structure
A = ones(12);
B = ones(12,2);
C = [1 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 1 0 0 0 0];
D = zeros(2);
K = zeros(12,2);
sys = idss(A, B, C, D, K, "Ts", Ts);

% Specify which matrices or elements are free to change
sys.Structure.D.Free(:,:) = false;
sys.Structure.K.Free(:,:) = false;

% Randomize model initial parameters (so you don't hit a local min)
sys = init(sys);

% Specify parameterization, feedthrough, and disturbance dynamics
sys = ssform(sys,...
    "Form","Canonical",...
    "Feedthrough", [false false],...
    "DisturbanceModel", "none");

% Define ssest options
options = ssestOptions();
options.EnforceStability = true;
options.InputOffset = [1;1];
options.SearchMethod = "lsqnonlin";
options.SearchOptions.Advanced.UseParallel = true;

%sys1 = ssest(ze, 12:30, "InputDelay", [1;1;1]);
[sys, x0] = ssest(ze, sys, options);
fprintf("plant sample time: %f",sys.Ts)
sys.Ts = Ts;

end

