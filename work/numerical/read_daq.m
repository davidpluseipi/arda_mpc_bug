function [sensor1] = read_daq(i, thermocouple_fit_obj, n_actual_datapoints, n_sec_each)
%% read_daq(thermocouple_fit_obj)
% inputs:
%   thermocouple_fit_obj (that converts mV to C)
% outputs:
%   none
%
% Author: David Meissner, Forest Concepts, LLC
%
arguments
    i                       (1,1) {mustBeInteger}
    thermocouple_fit_obj          {isobject}
    n_actual_datapoints     (1,1) {mustBeInteger} = 2
    n_sec_each              (1,1) {mustBeInteger} = 20
    
end

if n_actual_datapoints < 2
    error('The number of actual datapoints must be >= 2.')
end
if n_sec_each < 1
    error('The number of seconds per read must be >= 1.')
end

try
    %% Create a dialog box for the user
    % dialog_figure = uifigure('HandleVisibility', 'on');
    % dialog_box = uiprogressdlg(dialog_figure,...
    %     "Title", "Data Acquisition",...
    %     "Message", "Reading data from MCC Hardware",...
    %     "Cancelable", "on");
    % drawnow
    
    %%
    if ~exist('thermocouple_fit_obj','var')
        try
            load('thermocouple_fit_obj.mat','thermocouple_fit_obj')
        catch
            [thermocouple_fit_obj, ~] = create_thermocouple_fit_obj('J');
        end
    end
    %% Initialize the DAQ
    d = daq("mcc");
    d.Rate = 10;  % Hz
    if i == 1
        try
            addinput(d,"Board1","ai4","Voltage");
        catch er
            disp(er)
            disp('Skipping addinput. Ai4 might be reserved.')
        end
    end
    
    %% Setup
    % Read the data in timetable format.
    t_final = n_sec_each * (n_actual_datapoints - 1); % Seconds of total 'live' data acquisition
    n_scans = n_sec_each * d.Rate;     % Number of scans for each 'read'
    n_raw_datapoints = n_scans * (n_actual_datapoints);
    i = 1;                      % Index
    
    start(d,"continuous")       % Start acquiring data
    
    % Prepare for the loop
    raw_data = timetable('Size',[n_raw_datapoints, 1], ...
        'VariableTypes', "double",...
        'VariableNames', {'volts'},...
        'RowTimes', NaT(n_raw_datapoints,1));
    raw_data.Time.Format = 'yyyy-MM-dd HH:mm:ss.SSS';
    
    T = timetable('Size',[t_final-1 1], 'VariableNames',{'T_g'},...
        'VariableTypes',["double"],'RowTimes',NaT(t_final-1,1));
    T.Time.Format = 'yyyy-MM-dd HH:mm:ss.SSS';
    
    sensor1 = sensor();
    sensor1.wire = '1234';
    % dialog_box.Value = 0.1;
    % drawnow
    
    %% Read data until t_final
    t_start = tic;              % Start a timer
    while toc(t_start) < t_final
        % Get the data
        raw = read(d, n_scans, "OutputFormat","Matrix");
        T.Time(i) = datetime('now');
        raw_row_times = NaT(n_scans,1);
        for j = 1:length(raw_row_times)
            raw_row_times(j) = T.Time(i) + (j-1)*duration(0,0,1/d.Rate);
        end
        raw_table = timetable(raw, ...
            'VariableNames', {'volts'},...
            'RowTimes', raw_row_times);
        raw_data.Time((i-1)*n_scans + 1 : i*n_scans, :) = raw_table.Time;
        raw_data.volts((i-1)*n_scans + 1 : i*n_scans, :) = raw_table.volts;
        % Record the time each reading ended
        
        % Process the data
        y = raw * 1000;         % convert to mV
        y_C = thermocouple_fit_obj(y) + 26.3;   % correct for an offset
        y_C2 = rmoutliers(y_C,'gesd');          % remove outliers
        y_filtered = filter_stuff(y_C2);        % custom filter
        T.T_g(i) = mean(y_filtered);
        
        %     % Set the value of the progress bar
        %     p = toc(t_start)/t_final;
        %     if p > 0 && p < 0.95
        %         dialog_box.Value = toc(t_start)/t_final;
        %     elseif p >= 0.95
        %         dialog_box.Value = 0.95;
        %     else
        %         dialog_box.Value = 0.1;
        %     end
        %     drawnow    % Update the visible window
        %     % If the user presses cancel, exit the while loop
        %     if dialog_box.CancelRequested
        %         break
        %     end
        
        clear raw
        i = i + 1;
    end
    
    %% Post Read Data Management
    try
        stop(d)  % Stop the data acquisition
        raw_data.Properties.SampleRate = d.Rate;
        raw_data.Properties.TimeStep = seconds(1/d.Rate);
        raw_data.Properties.VariableUnits = {'volts'};
        raw_data.Properties.StartTime = raw_data.Time(1);
        
        T.Properties.VariableUnits = {'C'};
        T.Properties.StartTime = T.Time(1);
        
        sensor1.raw = raw_data;
        sensor1.data = T(~isnat(T.Time) & T.Variables ~= 0, :);
        sensor1.start = sensor1.data.Time(1);
        sensor1.stop = sensor1.data.Time(end);
        
        %% Stats
        sensor1 = sensor1.get_stats('Figure',false);%~dialog_box.CancelRequested);
        disp(sensor1.mu)
        disp(sensor1.sigma)
        
        %% Clean Up
        delete(d)
        clear d
        % delete(dialog_box)
        % close(dialog_figure)
        % save sensor_data.mat sensor1
        % save_everything(true, 'daq_results', sensor1.data.Time(1))
        % % Clear all DataAcquisition and channel objects.
        % clearvars -except thermocouple_fit_obj sensor1
    catch er
        disp(er)
        disp(er.stack)
        error('There was an issue with the data management after the read.')
    end
    
catch er
    delete(d)
    clear d
    disp(er)
    error('Issue in read_daq.')
end
%% Save Everything
    function save_everything(varargin)
        %% save_everything(logical, folder_name, time_stamp)
        if nargin ~= 2 || nargin ~= 3
            error('The function save_everything.m requires 2-3 inputs.')
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
                error('Second argument is the folder name and must be a char datatype.')
            end
            
            if nargin == 3
                try
                    datetime_str = datestr(varargin{3}, 'yyyy_mm_dd_HHMMSSS');
                catch
                    error('Invalid datetime as 3rd argument.')
                end
            end
        end
        
        if save_stuff
            try
                working_folder = pwd;
                dir_info = dir;
                make_folder = true;
                
                for k = 1:length(dir_info)
                    if strcmpi(dir_info(k).name, folder_name)
                        make_folder = false;
                        break
                    end
                end
                
                if make_folder
                    mkdir(folder_name)
                end
                
                
                
                variables_filename = sprintf([folder_name '_%s'], ...
                    datetime_str);
                save(fullfile(working_folder, folder_name, ...
                    variables_filename));
                
            catch
                warning('Unable to save data.')
            end
        end
        
    end

end
%% Noise Filter
function y_out = filter_stuff(x)
% Setup for filter()
windowSize = 5;
b = (1/windowSize)*ones(1,windowSize);
a = 1;

% Filter with base matlab filter
y2 = filter(b, a, x);

% Flip to prep for the 2nd filtering
y_out = zeros(size(x));
for i = 1:size(y2)
    y_out(i) = y2(end-i+1);
end

% Filter the flipped data to remove lateral offset
y_new = filter(b,a,y_out);

% Flip the data again so it's initial orientation
for i = 1:size(y_new)
    y_out(i) = y_new(end-i+1);
end

end
