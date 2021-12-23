function mpc_obj = impose_terminal_penalty(bob, options)

arguments
    bob
    options.plot {mustBeNumericOrLogical} = false
end

if ~exist("options.plot", "var")
    create_plot = options.plot;
end

Q = eye(2);
R = eye(2);
N = [];
[~, Qp] = lqry(bob.controller.mpc1.Model.Plant, Q, R, N);
L = chol(Qp);

G = ss(bob.controller.mpc1.Model.Plant.A, ...
    bob.controller.mpc1.Model.Plant.B, ...
    bob.controller.mpc1.Model.Plant.C,...
    bob.controller.mpc1.Model.Plant.D,...
    bob.controller.mpc1.Model.Plant.Ts);

D2 =[G.D; zeros(12,2)];

G.InputName = {'u1';'u2'};
set(G, 'C', [G.C; L], 'D', D2)
G.y = {'y1';'y2';'y3';'y4';'y5';'y6';'y7';'y8';'y9';'y10';'y11';'y12';'y13';'y14'};

G = setmpcsignals(G, 'MO', [1 2]);

ph = bob.controller.mpc1.PredictionHorizon;
ch = bob.controller.mpc1.ControlHorizon;

mpc_obj = mpc(G, ...
    G.Ts, ...
    ph, ...
    ch);

yw = sqrt(diag(Q))';
uw = sqrt(diag(R))';
mpc_obj.Weights.OV = [yw 0 0 0 0 0 0 0 0 0 0 0 0];
mpc_obj.Weights.MV = sqrt(R);
mpc_obj.Weights.MVRate = [1e-5 1e-5] * 2;

Y = struct('Weight', [0 0 0 0 0 0 0 0 0 0 0 0 yw]);
U = struct('Weight', uw);
setterminal(mpc_obj, Y, U);

setoutdist(mpc_obj, 'model', ss( zeros(14, 1) ))

M2 = eye(12);
L2 = G.A * M2;
setEstimator(mpc_obj, L2, M2)


if create_plot
    simopt = mpcsimopt(mpc_obj);
    simopt.PlantInitialState = [293.15; 0.3; 0;0;0;0;0;0;0;0;0;0];
    N = 101;
    r = ones(N,12);
    r(1:10, 1) = 293.15;
    r(11:end, 1) = 294.15;
    r(1:10, 2) = 0.3;
    r(11:end, 2) = 0.4;
    Tstop = 6;
    [y,t,u] = sim(mpc_obj, ceil(Tstop/Ts), r, simopt);
    figure
    plot(t,y(:,1),"-b")
    figure
    plot(t,y(:,2),"-r")
end


end