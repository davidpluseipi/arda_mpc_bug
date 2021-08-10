%% test_main


%% Test 1: normal simulation only
disp('Starting Test 1')
bob = arda();
bob.simulation_only = true;
bob.temperature_setpoint = 25;
bob.max_iterations = 1800;
bob.live_plot = true;
bob.t = linspace(0, bob.max_iterations, 5);
bob.s = bob.temperature_setpoint + 273.15 + [0 1 0 0 0]*10;
bob = main(bob);
assert(~bob.yellow_alert,'No failures introduced, but yellow alert was reported.')
assert(~bob.red_alert,'No failures introduced, but red alert was reported.')

%% Test 2: normal operation with hardware
disp('Starting Test 2')
bob = arda();
bob.using_arduino_hardware = false;
bob.using_ni_hardware = true;
bob.heater = 'ni';
bob.temperature_setpoint = 40;
bob.max_iterations = 1800;
bob.live_plot = true;
bob.t = linspace(0, bob.max_iterations, 5);
bob.s = bob.temperature_setpoint + 273.15 + [1 1 0 0 0]*10;
bob = main(bob);
figure
plot(bob.outputs(:,1)-273.15); grid on
assert(~bob.yellow_alert,'No failures introduced, but yellow alert was reported. (parallel)')
assert(~bob.red_alert,'No failures introduced, but red alert was reported. (parallel)')

%% Test 3: normal operation with hardware in parallel
disp('Starting Test 3')
bob = arda();
bob.using_arduino_hardware = false;
bob.using_ni_hardware = true;
bob.heater = 'ni';
bob.temperature_setpoint = 33;
bob.max_iterations = 1800;
bob.live_plot = true;
bob.t = linspace(0, bob.max_iterations, 5);
bob.s = bob.temperature_setpoint + 273.15 + [1 1 0 0 0]*5;
bob = main(bob);
figure
plot(bob.outputs(:,1)-273.15); grid on
assert(~bob.yellow_alert, 'No failures introduced, but yellow alert was reported. (parallel)')
assert(~bob.red_alert, 'No failures introduced, but red alert was reported. (parallel)')

% %% Test 4: fail selftest with hardware
% disp('Starting Test 4')
% bob = arda();
% bob = main(bob, ...
%     'using_arduino_hardware', true,...
%     'using_ni_hardware', true, ...
%     'fail_selftest', true,...
%     'temperature_setpoint', 45);
% figure
% try plot(bob.outputs(:,1)-273.15); grid on; catch; end
% assert(bob.yellow_alert, 'aRDA should have failed the selftest with a yellow alert, but none was thrown.')
% assert(~bob.red_alert, 'No red level failures were introduced, but red alert was reported.')
% 
% %% Test 5: fail selftest with hardware in parallel
% disp('Starting Test 5')
% bob = arda();
% bob = main(bob, ...
%     'using_arduino_hardware', true,...
%     'using_ni_hardware', true, ...
%     'parallel', true,...
%     'fail_selftest', true);
% figure
% try plot(bob.outputs(:,1)-273.15); grid on; catch; end
% assert(bob.yellow_alert,'aRDA should have failed the selftest with a yellow alert, but none was thrown. (parallel)')
% assert(~bob.red_alert,'No red level failures were introduced, but red alert was reported. (parallel)')
% 
% %% Test 6: fail overtemp with hardware
% disp('Starting Test 6')
% bob = arda();
% bob = main(bob, ...
%     'using_arduino_hardware', true,...
%     'using_ni_hardware', true, ...
%     'fail_overtemp', true);
% figure
% try plot(bob.outputs(:,1)-273.15); grid on; catch; end
% assert(bob.red_alert,'Overtemp failure introduced, but red alert was not reported.')
% 
% %% Test 7: fail overtemp with hardware parallel
% disp('Starting Test 7')
% bob = arda();
% bob = main(bob, ...
%     'using_arduino_hardware', true,...
%     'using_ni_hardware', true, ...
%     'parallel', true,...
%     'fail_overtemp', true);
% figure
% try plot(bob.outputs(:,1)-273.15); grid on; catch; end
% assert(bob.red_alert,'Overtemp failure introduced, but red alert was not reported. (parallel)')