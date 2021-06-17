function acquire_data()
%% Acquire data from Measurement Computing DAQ

% Create a daq object
d = daq("mcc");

% Set the sampling frequency
d.Rate = 10;

% Add a channel for the J type thermocouple connected to A4
d.addinput("Board1", "Ai4", "Voltage") % above heating element in plastic
d.addinput("Board1", "Ai6", "Voltage") % jammed in heating element


%%
% Set the amount of time to acquire data
acquisition_window = 10; % seconds

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
[data, ~] = read(d, seconds(acquisition_window));

% Smooth and convert from V to mV
%y_s = smooth(data.Board1_Ai4, 100);
y_A4 = data.Board1_Ai4 * 1000; % convert to mV
y_A6 = data.Board1_Ai6 * 1000; % convert to mV

%% Create the fit object needed to convert mV to C
if ~exist('thermocouple_fit_obj','var')
    [thermocouple_fit_obj, ~] = create_fit_obj_volts2celsius();
end

%% Convert to C and filter
reference = 27;

% Convert to C and shift up by the reference
y_C4 = thermocouple_fit_obj(y_A4) + reference;
y_C6 = thermocouple_fit_obj(y_A6) + reference;

% Apply noise filter
y_C4_filtered = filter_stuff(y_C4, d.Rate);
y_C6_filtered = filter_stuff(y_C6, d.Rate);

% Get the mean
C4 = mean(y_C4_filtered);
C6 = mean(y_C6_filtered);

%% Convert to Fahrenheit

% Convert C to F
y_F4 = y_C4*9./5 + 32;
y_F6 = y_C6*9./5 + 32;

% Apply noise filter
y_F4_filtered = filter_stuff(y_F4, d.Rate);
y_F6_filtered = filter_stuff(y_F6, d.Rate);

% Get the mean
F4 = mean(y_F4_filtered);
F6 = mean(y_F6_filtered);

%% Plot

% Raw data
figure
title('Raw Data')
subplot(2,1,1); plot(data.Board1_Ai4); grid on; ylabel('A4')
subplot(2,1,2); plot(data.Board1_Ai6); grid on; ylabel('A6')
xlabel('Time')

%%
% Celsius
figure;
subplot(2,1,1);
plot(y_C4, 'Color', '#0072BD'); grid on; hold on  % blue
plot(y_C4_filtered, 'Color', '#D95319')  % orange
ylabel('Temp. (C)')
axis([0 numel(data.Variables)/2 C4-6 C4+6])
title('Temp of A4 (Other one)')

% Fahrenheit
subplot(2,1,2)
plot(y_F4, 'Color', '#0072BD'); grid on; hold on  % blue
plot(y_F4_filtered, 'Color', '#D95319')  % orange
ylabel('Temp. (F)')
axis([0 numel(data.Variables)/2 F4-10 F4+10])

%%
% Celsius
figure;
subplot(2,1,1);
plot(y_C6, 'Color', '#0072BD'); grid on; hold on  % blue
plot(y_C6_filtered, 'Color', '#D95319')  % orange
ylabel('Temp. (C)')
axis([0 numel(data.Variables)/2 C6-6 C6+6])
title('Temp of A6 (Little one)')

% Fahrenheit
subplot(2,1,2)
plot(y_F6, 'Color', '#0072BD'); grid on; hold on  % blue
plot(y_F6_filtered, 'Color', '#D95319')  % orange
ylabel('Temp. (F)')
axis([0 numel(data.Variables)/2 F6-10 F6+10])

fprintf('Average Temperature A4: %.1f C (%.1f F)\n', C4, F4)
fprintf('Average Temperature A6: %.1f C (%.1f F)\n', C6, F6)
try
    close(dialog_box)
    close(dialog_figure)
catch
end

% Save all variables
save_everything(true, 'daq_results')


    function save_everything(varargin)
        
        if nargin ~= 2
            error('The function save_everything.m requires 2 inputs.')
        else
            if islogical(varargin{1}) && size(varargin{1},1) == 1 ...
                    && size(varargin{1},2) == 1
                
                save_stuff = varargin{1};
            else
                error('First argument must be a logical datatype of size 1x1.')
            end
            
            if ischar(varargin{2})
                folder_name = varargin{2};
            else
                error('Second argument must be a char datatype.')
            end
        end
        
        if save_stuff
            try
                working_folder = pwd;
                dir_info = dir;
                make_folder = true;
                
                for i = 1:length(dir_info)
                    if strcmpi(dir_info(i).name, folder_name)
                        make_folder = false;
                        break
                    end
                end
                
                if make_folder
                    mkdir(folder_name)
                end
                
                datetime_str = datestr(now,'yyyy-mm-dd_HHMMSS');
                
                variables_filename = sprintf([folder_name '_%s'], ...
                    datetime_str);
                save(fullfile(working_folder, folder_name, ...
                    variables_filename));
                
            catch
                warning('Unable to save simulation results.')
            end
        end
        
    end

end
%%
function y_out = filter_stuff(y_in, sample_frequency)
% Setup for filter()
windowSize = 20*sample_frequency;
b = (1/windowSize)*ones(1,windowSize);
a = 1;

% Filter with base matlab filter
y2 = filter(b, a, y_in);

% Flip to prep for the 2nd filtering
y_out = zeros(size(y_in));
for i = 1:samples
    y_out(i) = y2(end-i+1);
end

% Filter the flipped data to remove lateral offset
ynew = filter(b,a,y_out);

% Flip the data again so it's initial orientation
for i = 1:samples
    y_out(i) = ynew(end-i+1);
end

end