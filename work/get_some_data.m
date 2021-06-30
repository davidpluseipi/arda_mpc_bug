function [data] = get_some_data(d, acquisition_time, thermocouple_fit_obj,...
    f_s, idx, n_loops)
%% Read the data
% Create a daq object
if isempty(d)
    d = daq("mcc");
    try
    % Add a channel for the J type thermocouple connected to A4
    d.addinput("Board1", "Ai4", "Voltage") % jammed in heating element
    
    % Set the sampling frequency
    d.Rate = f_s;
    
    start(d, "Continuous");
    catch E
        disp(E)
    end
end
pause(acquisition_time)
data = read(d, acquisition_time*f_s);


end