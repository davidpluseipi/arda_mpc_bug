function [bob] = main(bob, options)

    arguments
        bob handle
        options.parallel (1,1) {mustBeNumericOrLogical} = false
        options.fail_selftest (1,1) {mustBeNumericOrLogical} = false
        options.fail_overtemp (1,1) {mustBeNumericOrLogical} = false
    end

bob.parallel = options.parallel;
bob.fail_selftest = options.fail_selftest;
bob.fail_overtemp = options.fail_overtemp;
zoe = responder(bob); %#ok<NASGU>

notify(bob, 'prestartup');
notify(bob, 'startup')
notify(bob, 'selftest')

check4errors(bob)
if bob.red_alert || bob.yellow_alert
    return
end

if bob.parallel 
    bob.pool = gcp;
end

count = 1;
while true
    bob = stuff_happens(bob);
    if bob.parallel 
        if ~exist('F','var')
            fcn_handle = @bob.check4errors;
            F = parfeval(fcn_handle, 1);
        else
            if numel(F.OutputArguments) > 0
                bob = fetchOutputs(F);
                clearvars F
            end
        end
    end
    check4errors(bob)
    if bob.red_alert || bob.yellow_alert
        return
    end
    
    if count > 5
        break
    end
    
    count = count + 1;
end

end

function obj = stuff_happens(obj)

%% TEST
delta = 0;
if obj.fail_overtemp
    delta = 100;
end
obj.air_temp = obj.air_temp + delta;

end

