last_mv = [0 0];
x = bob.x_0;
ref = [300 0.5];
stop_time = 15;
T = zeros(stop_time,1);
phi = T;
for i = 1:stop_time
    [mv,opt,info] = nlmpcmove(bob.mpc.nlmpc1, x, last_mv, ref);
    x = state_function(x,mv) + x;
    last_mv = mv;
    T(i) = x(1);
    phi(i) = x(9);
    disp(i)
end
figure
subplot(2,1,1)
plot(T)
subplot(2,1,2)
plot(phi)