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



%% EOF