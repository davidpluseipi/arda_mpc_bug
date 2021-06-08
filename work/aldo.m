%% aRDA Simulation
% The purpose of this simulation is to gain a better understanding of the
% code and coding techniques required to: 
%%
% 
% * Acquire, Pre-process, and Perform System ID on Actual Data
% * Design, and Implement the aRDA Control System
% * Deploy Code using MATLAB Compiler
% 

%% Start Clean
clear
close all; clc


% %% Use Open Hardware Monitor via Windows Command Line to acquire data
% % This is a placeholder in the algorithm until DAQ is available
% 
% % Put together the command
% path = 'C:\Users\dmeissner\Downloads\OpenHardwareMonitorReport';
% cmd = [path ' .\OpenHardwareMonitorReport.exe'];
% 
% % Execute the command at the command line
% [status, output] = system(cmd);
% 
% % Convert the output to a string datatype
% output_str = string(output);
% 
% %% Find the location of keywords in the Hardware Monitor report
% 
% % Establish keywords
% pattern = {'temperature','(/intelcpu/0/power/0)'};
% 	% 'temperature is the pc's main battery temp in degrees Celsius
% 	% (/intelcpu/0/power/0) defines the line where total CPU power is shown
% 
% % Preallocate memory for the following loop
% locations = cell(length(pattern),1);
% 
% % Search for keywords
% for i = 1:length(pattern)
% 	locations{i} = strfind(lower(output_str), pattern{i});
% end
% 
% %% Temperature (C)
% 
% % For temperature, select the last location found
% location1 = locations{1}(1,end);
% % disp(output(location1 : location1 + length(pattern{1})))
% 
% % Specify the characters between 'temperature' and the actual value
% spacing = '                        270000000000 44    61    0     ';
% 
% % Define the index within the char where the temperature value is
% location_temp = location1 + length(pattern{1}) + length(spacing);
% 
% %% Power (W)
% location2 = locations{2};
% spacing2 = ' x.xxxxx   x.xxxxx ';
% location_cpu_power = location2 - length(spacing2);
% 
% %% Setup 
% end_after = 10*60; % seconds
% sampling_freq = 10; % Hz
% j = 1;
% temp = cell(end_after,1);
% power = cell(end_after,1);
% 
% % Read clock
% start_time = datetime('now');
% previous = start_time; % set the initial previous time
% 
% % Baseline data
% temp{j} = str2double(output(location_temp : location_temp + 1));
% power{j} = str2double(output(location_cpu_power : location_cpu_power+7));
% row_times(j) = datetime('now');
% % fprintf('Time                      Temp(C)  Power(W)\n')
% % fprintf('%s  %2.f       %3.1f\n', datetime(previous, 'Format',...
% % 			'uuuu-MMM-dd HH:mm:ss.SSS'), temp{j}, power{j})
% 
% while true
% 	
% 	if (datetime('now') - previous) > duration(0,0,0,1/sampling_freq)
% 		j = j + 1;
% 		previous = datetime('now');
% 		[status, output] = system(cmd);
% 		row_times(j) = previous;
% 		
% 		% Capture temperature data
% 		temp{j} = str2double(output(location_temp : location_temp + 1));
% 		
% 		% If we get bad temp data, re-verify output char formating
% 		if (abs(temp{j} - temp{j-1}) > 2) || isnan(temp{j})
% 			% Convert the output to a string datatype
% 			output_str = string(output);
% 			
% 			% Search for 'temperature'
% 			
% 			locations = cell(length(pattern),1);
% 			for i = 1:length(locations)
% 				locations{i} = strfind(lower(output_str), pattern{i});
% 			end
% 			
% 			% Temperature (C)
% 			location1 = locations{1}(1,end);
% 			%disp(output(location1 : location1 + length(pattern{1})))
% 			spacing = '                        270000000000 44    61    0     ';
% 			location_temp = location1 + length(pattern{1}) + length(spacing);
% 			
% 			temp{j} = str2double(output(location_temp : location_temp + 1));
% 					
% 		end
% 		
% 		% Capture power data
% 		power{j} = str2double(output(location_cpu_power : location_cpu_power+7));
% % 		fprintf('%s  %2.f       %3.1f\n', datetime(previous, 'Format',...
% % 			'uuuu-MMM-dd HH:mm:ss.SSS'), temp{j}, power{j})
% 	end
% 	
% 	if (datetime('now') - start_time > duration(0,0,end_after,0))
% 		break
% 	end
% end
% 
% % Convert the recorded data into a timetable
% data = timetable(cell2mat(temp), cell2mat(power), 'VariableNames',...
% 	{'temp','power'}, 'RowTimes', row_times');
% summary(data)
% 
% figure
% subplot(2,1,1)
% plot(data.Time,data.power)
% ylabel('Power (W)')
% title('Measured Data from PC')
% grid on
% 
% subplot(2,1,2)
% plot(data.Time, data.temp)
% ylabel('Temp (C)')
% grid on

%% 
load('D:\Git_onPH\Rehydration\allGraphDataBaseline.mat')
time_original = allGraphData.run20210216022A.rep1.atSeco;
base = datetime(2021, 05, 10, 12, 0, 0, 0, 'Format','yyyy-MM-dd HH:mm:ss.SSS');
time_datetimes = base + duration(0, 0, time_original);
time = time_datetimes;
data = timetable(allGraphData.run20210216022A.rep1.aTS1Pto,...
                 allGraphData.run20210216022A.rep1.cdPay,...
                 'VariableNames', {'temp','power'},...
                 'RowTimes',time);


% times = zeros(length(time),1);
% for i = 2:length(time)
%     times(i-1) = time(i) - time(i-1);
%     if time(i-1) ~= 1
%         time(i-1) = NaN;
%     end
% end

Ts = 1; 
% Ts = 1/sampling_freq;
%%
% Encapsulate the input/output data into an iddata object
ze = iddata(data.temp, data.power,Ts);
%%
close all
% or create an ARX model for generating data
% A = [1 -1.5 0.7];
% B = [0 1 0.5];
% m0 = idpoly(A,B);

% Generate random input and additive noise
% u = iddata([],idinput(400,'rbs'));
% e = iddata([],0.1*randn(400,1));
% y = sim(m0,[u e]);
% z = [y,u];

% Back to the measured data
ze.Name = 'pc';
ze.InputUnit = 'W';
ze.OutputUnit = 'C';
ze.InputName = 'Power';
ze.OutputName = 'Temperature';

figure
plot(ze)

% Split the data into estimation and validation datasets
ze1 = ze(1:300);
zv1 = ze(301:end);

figure
ge = spa(ze);
bode(ge)

model_impulse = impulseest(ze1,60);
figure
step(model_impulse)
delay = delayest(ze1);

% Generate model order combinations for estimation
NN = struc(2:10,2:10, delay);

% Estimate ARX models and compute the loss function for each model order
% combination (
V = arxstruc(ze1(:,:,1), zv1(:,:,1), NN);
order = selstruc(V,0);
model_discrete = arx(ze1, order);

% Convert model to continuous time
model_continuous = d2c(model_discrete);
model_state_space = idss(model_continuous);
model_transfer_function = idtf(model_continuous);

%% System Analysis
sys = model_transfer_function;

%% Plot system step and impluse responses
figure
subplot(2,1,1)
step(sys)
subplot(2,1,2)
impulse(sys)

%% Plot response to sine wave
figure
t = 0:400;
u = sin(10*t);
lsim(sys, u, t)

%% For state-space, plot the unforced response from a given state
x0 = [-1;0;2];
figure
initial(model_state_space, x0)
grid

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
% with this controller, it is not stable

%% Plot the locus of points as a function of k
figure
rlocus(model_discrete)
axis([-1.5 6 -2.5 2.5])
% loop gain should be restricted to only allow values to stay on LHP

%% Auto-tune a PID controller
C_pid = pidtune(sys, 'PID');
[T_pid, info] = feedback(C_pid*sys,1)
step(T_pid)



