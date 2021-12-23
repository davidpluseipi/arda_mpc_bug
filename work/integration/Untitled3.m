    simopt = mpcsimopt(bob.controller.mpc1);
    simopt.PlantInitialState = [293.15; 0.3; 0;0;0;0;0;0;0;0;0;0];
    N = 301;
    r = ones(N,2);
    r(1:10, 1) = 293.15;
    r(11:end, 1) = 294.15;
    r(1:10, 2) = 0.3;
    r(11:end, 2) = 0.4;
    Tstop = 300;
    [y,t,u] = sim(bob.controller.mpc1, ceil(Tstop/bob.controller.mpc1.Model.Plant.Ts), r, simopt);
    figure
    plot(t,y(:,1),"-b")
    figure
    plot(t,y(:,2),"-r")