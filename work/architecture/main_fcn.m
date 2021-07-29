function [bob] = main_fcn(bob, deadpool)

notify(bob, 'off');
notify(bob, 'startup')
notify(bob, 'self_test')

count = 1;
while true
    if ~exist('F','var')
        F = parfeval(deadpool, @bob.check_stuff, 1)
    else
        if numel(F.OutputArguments) > 0
            B = fetchOutputs(F)
            bob = copy_from(B,bob)
            clearvars F
        end
    end
    
    if count > 20
        break
    end
    count = count + 1;
    
end

end
