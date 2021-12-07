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

    idx = zeros(6,1);
    names = logsout.getElementNames;
    correct_names = {'u1' 'u2' 'u3' 'y1' 'y2' 'y3'};

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

input = data(:,1:3);
output = data(:,4:6);
z = iddata(output, input, Ts);
z.Name = 'arda';
z.InputName = {'u1' 'u2' 'u3'};
z.InputUnit = {'V' 'kg/s' 'V'};
z.OutputName = {'y1' 'y2' 'y3'};
z.OutputUnit = {'degC' ' ' 'm^3/s'};

% Split the data into estimation and validation datasets
ze = z(1 : 0.9*size(data,1));
zv = z(length(ze)+1 : end);

% sys1 = ssest(ze, 1:15, "InputDelay", [1;2;3]);
[sys, x0] = ssest(ze, 15, "InputDelay", [1;2;3],...
    ssestOptions("InitialState", "estimate"));
fprintf("plant sample time: %f",sys.Ts)
sys.Ts = Ts;

% Convert model to continuous time
% model_continuous = d2c(model_discrete,'tustin');
% model_state_space = idss(model_continuous);
% model_transfer_function = idtf(model_continuous);

end

