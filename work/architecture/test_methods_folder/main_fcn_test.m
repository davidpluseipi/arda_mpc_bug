function [bob] = main_fcn_test(varargin)
if nargin < 2 || nargin > 3
    error('Incorrect number of inputs.')
else
    bob = varargin{1};
    zoe = varargin{2};
end

if nargin == 3
    parallel = true;
    deadpool = varargin{:};
else
    parallel = false;
end

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
    
    if parallel % Use parpool
        
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
    if bob.air_temp > 100
        bob.log_error("Overtemp");
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

