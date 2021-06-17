clearvars -except thermocouple_fit_obj
close all; home
%% Acquire data from Measurement Computing DAQ

% Create a daq object
daq_obj = daq("mcc");

% Set the sampling frequency
daq_obj.Rate = 10;

% Add a channel for the J type thermocouple connected to A4
daq_obj.addinput("Board1", "Ai4", "Voltage")

%%
% Set the amount of time to acquire data
acquisition_window = 30; % seconds

% Create a dialog box for the user
dialog_figure = uifigure('HandleVisibility', 'on');
dialog_box = uiprogressdlg(dialog_figure, "Title", "Acquiring Data", "Message",...
    strcat(...
        strcat(...
            strcat('Started: ', string(datetime('now')))...
            , '  End: ')...
        , string(datetime('now') + duration(0,0, acquisition_window))));
drawnow

%% Read the data
[data, start_time] = read(daq_obj, seconds(acquisition_window));

% Smooth and convert from V to mV
%y_s = smooth(data.Board1_Ai4, 100); 
y_s = data.Board1_Ai4 * 1000; % convert to mV

%% Create the fit object needed to convert mV to C
if ~exist('thermocouple_fit_obj','var')
    [thermocouple_fit_obj, gof] = create_fit_obj_volts2celsius();
end

%% Convert to C and filter
reference = 27;

% Convert to C and shift up by the reference
y_C = thermocouple_fit_obj(y_s) + reference;

% Apply noise filter
y_C2 = filter_stuff(y_C, daq_obj.Rate);

% Get the mean
C = mean(y_C);

%% Convert to Fahrenheit

% Convert C to F
y_F = y_C*9./5 + 32;

% Apply noise filter
y_F2 = filter_stuff(y_F, daq_obj.Rate);

% Get the mean
F = mean(y_F2);

%% Plot

% Raw data
figure; plot(data.Board1_Ai4); grid on; 

% Celsius
figure; subplot(2,1,1); 
plot(y_C, 'Color', '#0072BD'); grid on; hold on  % blue
plot(y_C2, 'Color', '#D95319')  % orange
ylabel('Temp. (C)')
axis([0 numel(data.Variables) C-6 C+6])

% Fahrenheit

subplot(2,1,2)
plot(y_F, 'Color', '#0072BD'); grid on; hold on  % blue
plot(y_F2, 'Color', '#D95319')  % orange
ylabel('Temp. (F)')
axis([0 numel(data.Variables) F-10 F+10])

fprintf('Average Temperature: %.1f C (%.1f F)\n', C, F)
try
    close(dialog_box)
    close(dialog_figure)
catch
end

% Save all variables
save_everything(true, 'daq_results')