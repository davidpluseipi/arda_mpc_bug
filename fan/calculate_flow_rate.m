function [flow_rate, velocity, fit_obj, goodness_of_fit] = calculate_flow_rate(power_setting, options)
%% [flow_rate_vec, power_vec, goodness] = calculate_flow_rate(power_setting, recalculate=true/false, diameter=3)
% Input:    power in watts
%           recalculate = false (default) or true   (optional)
%           diameter = 3 (default)                  (optional) 
% Output:   flow rate (ACFM (actual cubic feet per minute))
%           velocity (m/s)
%           fit_object 
%           goodness of git (if recalculating estimated fan data)

arguments
    power_setting (1,1) {mustBeNumeric} 
    options.recalculate (1,1) {mustBeNumericOrLogical} = false
    options.diameter (1,1) {mustBeNumeric} = 3
end

% If user does not supply a value of true for the recalculate flag,
% just load previously calculated data.


% Try to load data, but if unable, recalculate and save it.
if ~options.recalculate
    try
        load('fan_data.mat', 'fan_data')
        flow_rate_acfm = fan_data.flow_rate.acfm;
        velocity_m_s = fan_data.flow_rate.meters_per_sec;
        power_watts = fan_data.power.watts;
        
    catch
        try
        addpath(which('fan_data.mat'))
        load(which('fan_data.mat'), 'fan_data');
        flow_rate_acfm = fan_data.flow_rate.acfm;
        velocity_m_s = fan_data.flow_rate.meters_per_sec;
        power_watts = fan_data.power.watts;
        catch
            options.recalculate = true;
        end
    end
end

if options.recalculate 
    % Input data from manufacturer
    flow_rate_data = 0:500:4000;
    % Given data is in hp. Convert it to watts.
    power_data_hp = [1.25 1.7 2.4 2.7 3.125 3.6 3.75 3.6 3.4];
    power_data_w = power_data_hp * 745.7;
    
    % Fit the data to a curve
    [fit_obj, goodness_of_fit] = create_fit_fan(flow_rate_data, power_data_w);
    
    % Evaluate the fit object to estimate the given data at a finer
    % resolution
    flow_rate_acfm = 0:flow_rate_data(end);
    
    % Calculate number of cfm in 1 m/s based on diameter to duct
    conversion = pi * (options.diameter/2)^2 * (10000/254) * 60 / 12^3;
    velocity_m_s = flow_rate_acfm ./ conversion; 
    
    power_watts = feval(fit_obj, flow_rate_acfm);
    power_hp = power_watts/745.7;
    
    % Put the data into a structure with info on the fan
    fan_data = struct(...
        'brand', 'Hartzel',...
        'model','A03-9-152BC-75STFCM2',...
        'power', struct('watts',power_watts,...
                        'hp', power_hp),...
        'flow_rate', struct('acfm', flow_rate_acfm',...
                            'meters_per_sec', velocity_m_s'),...
        'goodness_of_fit', goodness_of_fit);
    
    % save the data in the current directory
    save fan_data.mat fan_data
end

% Error checking
if power_setting < power_watts(1) || power_setting > power_watts(end)
    error('Power requested is outside the range of estimated data.')
end

% Use the user's provided power setting to estimate the flow rate
flow_rate = interp1(power_watts, flow_rate_acfm, power_setting);
velocity = interp1(power_watts, velocity_m_s, power_setting);

if ~exist('fit_obj','var')
    fit_obj = [];
end

if ~exist('goodness_of_fit','var')
    goodness_of_fit = [];
end

end