Q = eye(2);
R = eye(2);
N = [];
[K, Qp] = lqry(bob.controller.mpc1.Model.Plant, Q, R, N);
L = chol(Qp);
Ts = 0.1;

G = ss(bob.controller.mpc1.Model.Plant.A, ...
    bob.controller.mpc1.Model.Plant.B, ...
    bob.controller.mpc1.Model.Plant.C,...
    bob.controller.mpc1.Model.Plant.D,...
    Ts);

C2 = [G.C; L];
D2 =[G.D; zeros(12,2)];

G.InputName = {'u1';'u2'};
c = {'y1';'y2';'y3';'y4';'y5';'y6';'y7';'y8';'y9';'y10';'y11';'y12';'y13';'y14'};
set(G, 'C', C2, 'D', D2)
G.y = c;

G = setmpcsignals(G, 'MO', [1 2]);

ph = 5;
ch = 3;
mpc_obj = mpc(G,Ts,ph,ch);

yw = sqrt(diag(Q))';
uw = sqrt(diag(R))';
mpc_obj.Weights.OV = [yw 1 0 0 0 0 0 0 0 0 0 0 0];
mpc_obj.Weights.MV = sqrt(R);
mpc_obj.Weights.MVRate = [1e-5 1e-5];

Y = struct('Weight', [0 0 0 0 0 0 0 0 0 0 0 0 1 1]);
U = struct('Weight', uw);
setterminal(mpc_obj,Y,U);
setoutdist(mpc_obj,'model',ss(zeros(14,1)))
setEstimator(mpc_obj,[],eye(2))

simopt = mpcsimopt(mpc_obj);
simopt.PlantInitialState = [293.15; 0.3;0;0;0;0;0;0;0;0;0;0;0;0];
N = 101;
r = ones(N,2);
r(1:10, 1) = 293.15;
r(11:end, 1) = 294.15;
r(1:10, 2) = 0.3;
r(11:end, 2) = 0.4;
Tstop = 6;
[y,t,u] = sim(mpc_obj, ceil(Tstop/Ts), r, simopt)
