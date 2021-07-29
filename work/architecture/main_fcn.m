function [bob] = main_fcn(deadpool)
if nargin == 0
    p = false;
else
    p = true;
end

bob = arda();
kari = responder(bob); %#ok<NASGU>

notify(bob, 'prestartup');
notify(bob, 'startup')
notify(bob, 'selftest')

check4errors(bob)
if bob.red_alert || bob.yellow_alert
    return
end

count = 1;
while true
    
    bob = stuff_happens(bob);
    
    if p % Use parpool
        
        if ~exist('F','var')
            F = parfeval(deadpool, @bob.check4errors, 1);
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

obj.air_temp = obj.air_temp + 20;
disp(obj.air_temp)

end