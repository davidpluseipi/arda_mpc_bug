clear; clc
bob = arda();
bob.max_iterations = 18;
bob.temperature_setpoint = 35;
bob.t = floor(linspace(1, bob.max_iterations, 5));
bob.s = bob.temperature_setpoint + [0 1 0 0 0]*5;

for i = 1:bob.max_iterations
    for j = 1:length(bob.t)-1
        
        if i >= bob.t(j) && i < bob.t(j+1)
            data(i,1) = i;
            data(i,2) = bob.s(j);
            bob.temperature_setpoint = bob.s(j);
            break
        end
    end
end
for i = 1:length(bob.t)-1
    if ~all(data(bob.t(i):bob.t(i+1)-1, 2) == bob.s(i))
        disp(i)
        %error('Incorrect temperature setpoints were commanded.')
    end
end
