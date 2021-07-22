%% Test Listeners
%%
% This script runs 2 loops. In the first loop, we do not run in parallel,
% but use listeners to execute code in the handle_event method of the
% object of class thing_that_responds. Loop 2 is run using a
% parallel pool and both set the state of the object of
% class thing_with_boolean_state from false(default) to true.
%
%% Start clean
clear; clc

%% Setup
modes = ["Starting","Standing By","Running","Stopping","Shutting Down","Emergency"];
d = thing_with_boolean_state();
d_responder = thing_that_responds(d);


fig = uifigure('Name','Control Panel');
text_area = uitextarea(fig, 'Position', [50 50 150 50], 'Value', {'blank'});

mode = "Starting";
text_area.Value = mode;
pause(2)

% pool = gcp('nocreate');
start_time = datetime("now");
done = true;
x = 100;

mode = "Standing By";
text_area.Value = mode;

selection = 'Stand by';
while strcmp(selection, 'Stand by')
    selection = uiconfirm(fig, "Next action?", "Confirm", "Options", {'Start','Shut down',...
        'Stand by'}, "DefaultOption", 1, "CancelOption", 3);
    if strcmp(selection, 'Start')
        done = false;
        text_area.Value = "Starting";
    elseif strcmp(selection, 'Shut down')
        done = true;
        text_area.Value = "You have selected Shut down";
        mode = "Shutting down";
    end
end
pause(2)

%% Main loop
i = 1;
while done == false

    mode = "Running";
    text_area.Value = mode;
    
    % Get state
    % Calculate controller output
    
    % After x steps, or after new setpoint is requested
    %   Get updated controller parameters from worker (autotune type thing)
    
    % Run the process
    y = randi(x);
    
    % Check for errors
    
        % Check for critical errors
        if y == 10
            mode = "Emergency";
            text_area.Value = mode;
            %         B = estop.set2(true);
            F = parfeval(@estop_obj.set2, 1, true);
            
            done = true;
        end
        
    % Shutdown if system stays on too long
    if i > 300
        mode = "Shutting Down";
        text_area.Value = mode;
        done = true;
    end
    
    % Save this code in case we need to trigger the event in parallel
    % 

    i = i + 1;
end
%% Post - Main loop
pause(2)
if strcmp(mode, "Shutting Down")
    text_area.Value = "Shutdown complete";
    % If run was in parallel, fetch the output
    if exist("F",'var')
        B = fetchOutputs(F);
    end
elseif strcmp(mode, "Emergency")
    text_area.Value = "Emergency shutdown complete";
end


