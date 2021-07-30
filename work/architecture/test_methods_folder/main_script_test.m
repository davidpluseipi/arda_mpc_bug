%% Start clean
clear; clc; close all

%% Setup


%% Test setup
opt = logical([0 1]);
test_results = false(2);
idx = 1;

for i = 1:2
    for j = 1:2
        bob = arda();
        zoe = responder(bob);
        bob.idx = idx;
        
        bob.fail_selftest = opt(i);
        parallel = opt(j);
                
        if parallel
            deadpool = gcp;
            bob = main_fcn_test(bob, zoe, deadpool);
        else
            bob = main_fcn_test(bob, zoe);
        end
        
        % Check test results
        if ~bob.fail_selftest
            if ~bob.yellow_alert
                test_results(i,j) = true;
            end
        else
            if bob.yellow_alert
                test_results(i,j) = true;
            end
        end
        
        idx = idx + 1;
        
    end
end
disp(test_results)
