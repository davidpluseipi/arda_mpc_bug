%% test_main
% Shared variables


% Preconditions


%% Test 1: normal operation
bob = main(arda());
assert(~bob.yellow_alert,'No failures introduced, but yellow alert was reported.')
assert(~bob.red_alert,'No failures introduced, but red alert was reported.')

%% Test 2: normal operation parallel
bob = main(arda(),'parallel', true);
assert(~bob.yellow_alert,'No failures introduced, but yellow alert was reported. (parallel)')
assert(~bob.red_alert,'No failures introduced, but red alert was reported. (parallel)')

%% Test 3: fail selftest
bob = main(arda(), 'fail_selftest', true);
assert(bob.yellow_alert,'aRDA should have failed the selftest with a yellow alert, but none was thrown.')
assert(~bob.red_alert,'No red level failures were introduced, but red alert was reported.')

%% Test 4: fail selftest parallel
bob = main(arda(), 'fail_selftest', true, 'parallel', true);
assert(bob.yellow_alert,'aRDA should have failed the selftest with a yellow alert, but none was thrown. (parallel)')
assert(~bob.red_alert,'No red level failures were introduced, but red alert was reported. (parallel)')

%% Test 5: fail overtemp
bob = main(arda(), 'fail_overtemp', true);
assert(bob.red_alert,'Overtemp failure introduced, but red alert was not reported.')

%% Test 6: fail overtemp parallel
bob = main(arda(), 'fail_overtemp', true, 'parallel', true);
assert(bob.red_alert,'Overtemp failure introduced, but red alert was not reported. (parallel)')