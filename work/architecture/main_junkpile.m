clear; clc

%% Setup
% Create an arda object named bob
bob = arda();
% Create a responder object named amy who listens for bob's events
amy = responder(bob);

%% Startup

% Run the startup sequence, which includes loading of the alert table which
% matches each possible error with their pre-designated alert level/color
alert_table = bob.startup();

% Make sure bob is done with his startup, which will only be true if bob
% has run the startup sequence, notified amy and amy has set bob's
% startup_done property to true
while ~bob.startup_done
    disp('Waiting'); pause(1); home
end
disp('Startup Complete')

%% Self test

% Run the self test, which loads some saved data, acquires new data and
% compares them. Pass or fail, bob should notify amy that he's done, she'll
% set his self_test_done property to true.
bob.self_test();
while ~bob.self_test_done
    disp('Waiting'); pause(1); home
end
disp('Self Test Complete')

%% Check for errors
alerts = cell(length(bob.errors), 1);
if bob.self_test_done
    % Check to see if any of the errors show up in the alert table
    if any(cellfun(@(x) ismember(string(x), alert_table{:,1}), bob.errors))
        for i = 1:length(bob.errors)
            % Get the alert levels for each error
            alerts{i} = alert_table{alert_table{:,1} == bob.errors{i}, 2};
        end
    end
end

% Handle red alerts
if any(cellfun(@(x) ismember("red", x), alerts))
    bob.emergency();
    if bob.emergency_procedures_done
        imshow('simulating_computer_shutdown.png')
        return
    end
end

% Handle yellow alerts
if any(cellfun(@(x) ismember("yellow", x), alerts))
    bob.shutdown();
    return
end

%% EOF