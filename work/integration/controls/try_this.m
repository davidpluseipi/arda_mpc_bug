clear; close all; clc

load('matlab3.mat','tf','C1','C2')
T0 = 20;
T_d = 22;
phi0 = 0.5;
phi_d = 0.45;
i = 1;
T(i) = T0;
phi(i) = phi0;
while i <= 1000
    T_e = T_d - T(i);
    phi_e = phi_d - phi(i);
    
    i = i + 1;
    T(i) = tf(1) * C1 * T_e;
    phi(i) = tf(2) * C2 * phi_e;
end