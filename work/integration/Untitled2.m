%% Controller Tuning
nx = 8; % order of state space model
n = nx + 1;
Y = [ [zeros(n,1); bob.outputs(:,1)] [zeros(n,1); bob.outputs(:,9)] ];
U = [zeros(n,1); bob.P_h];
ze = iddata(Y, U, bob.step_size);
ze.Name = 'ARDA';
ze.InputUnit = 'Voltage';
ze.InputName = 'Power';
ze.OutputUnit = {'K','percent'};
ze.OutputName = {'Temperature','Relative Humidity'};

% Split the data into estimation and validation datasets
ze1 = ze(1 : (2*size(ze,1)/3) );
zv1 = ze( (2*size(ze,1)/3 + 1) : end);

sys = ssest(ze1, nx);
% compare(ze1, sys)

bob.G = idtf(sys, 'InputName', 'q', 'OutputName','y');
bob.C1 = pidtune(tf(1),'PID');
bob.C2 = pidtune(tf(2),'PID');

if ~isempty(find(pole(bob.G) > 0, 1))
    disp('Unstable: Poles in the right hand plane.')
    disp(pole(bob.G))
end