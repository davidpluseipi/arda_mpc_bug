clear; close all; clc


load('controllers.mat','controllers')
load('C.mat','C')
% C.Kp = 1;
% C.Ki = 0;
% C.Kd = 0;
% C.b = 1;
% C.c = 1;
for i = 1:length(controllers)
    controllers{i} = C;
end

for idx = 20
    % Create arda object
    bob = arda();
    bob.controllers = controllers;
    
    % Set settings
    bob.simulation_only = false;
    bob.using_arduino_hardware = false;
    bob.using_ni_hardware = true;
    bob.using_lidar = false;
    bob.using_relative_humidity_sensor = false;
    if bob.using_ni_hardware
        bob.heater = 'ni';
    else
        bob.heater = 'none';
    end
    bob.using_load_cell = false;
    bob.max_iterations = 600;
    bob.live_plot = true;
    bob.progress_bar = false;
    bob.delete_app_on_completion = false;
    
    
    % Set setpoints
    bob.temperature_setpoint = idx;
    step_up = 1; % deg C
    k = 3; % number of times setpoint changes
    bob.t = floor(linspace(1, bob.max_iterations, k+2));
    bob.s = [];
    for i = 1:k+1
        if i <= 2
            j = 0;
        else
            j = 1;
        end
        bob.s = [bob.s j];
    end
    bob.s = step_up*bob.s;
    
    % Run
    disp(['***** Starting ' num2str(idx) ' *****'])
    tic
    bob = main(bob);
    toc
    disp(['***** Complete with ' num2str(idx) ' *****'])
    
    if bob.simulation_only
        
        T = timetable(bob.time, ...
            bob.outputs(:,1),...
            bob.outputs(:,2), ...
            bob.outputs(:,3),...
            bob.outputs(:,4),...
            bob.outputs(:,5),...
            bob.outputs(:,6),...
            bob.outputs(:,7),...
            bob.outputs(:,8),...
            bob.outputs(:,9),...
            bob.outputs(:,10),...
            bob.outputs(:,11),...
            bob.outputs(:,12),...
            bob.P_h,...
            'VariableNames',...
            {'T_g', 'T_h', 'T_o',...
            'p_g', 'p_v', 'p_a',...
            'V_g', 'q', 'phi',...
            'p_s', 'm_v', 'm_a',...
            'P_h'});
        
    else
        
        size(bob.voltage)
        T = timetable(bob.time, ...
            bob.outputs(:,1),...
            bob.outputs(:,2), ...
            bob.outputs(:,3),...
            bob.outputs(:,4),...
            bob.outputs(:,5),...
            bob.outputs(:,6),...
            bob.outputs(:,7),...
            bob.outputs(:,8),...
            bob.outputs(:,9),...
            bob.outputs(:,10),...
            bob.outputs(:,11),...
            bob.outputs(:,12),...
            bob.P_h,...
            bob.voltage,...
            'VariableNames', {'T_g', 'T_h', 'T_o',...
            'p_g', 'p_v', 'p_a',...
            'V_g', 'q', 'phi',...
            'p_s', 'm_v', 'm_a',...
            'P_h', 'voltage_h'});
        
    end
    
    figure
    stackedplot(T);
    grid on
    
    
    
    
    %
    % L1 = length(bob.time);
    %
    % if rem(L1,2) == 0
    %     L2 = L1-1;
    % else
    %     L2 = L1;
    % end
    %
    % idx = 1;
    % d = seconds(zeros(L1/2,1));
    % for i = 1:2:L2
    %     d(idx) = duration(bob.time(i+1) - bob.time(i));
    %     idx = idx + 1;
    % end
    % D = seconds(duration(d)); % duration of time steps in main loop (sec)
end