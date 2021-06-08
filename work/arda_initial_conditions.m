%% aRDA Equations

%% Start Clean
clear; close all; clc

%% Initial Conditions
T0 = 20; % C, Standard Temperature (68 F, 293.15 K)
p0 = 101.325; % kPa, Standard Pressure (1 atm, 14.696 psi)
% phi0 = 0.50; % percent, Relative Humidity
R = 8.31446261815324; % Ideal Gas Constant (Pa*m^2/(K*mol)), or J/(K*mol)
V = 1; % m^3, Volume (assumed. Get from Chris M. later)

%% Calculate moles of dry air, n
n = p0*V/(R*T0);
fprintf('Moles of dry air: %.2f\n\n',n)

%% Calculate Mean Molecular Fraction of Dry Air, M_a
% Define properties for dry air
C = [0.78 0.21 0.093]; % Mixing Ratio [N2, O2, Ar]
M = [28e-3 32e-3 40e-3]; % Molecular weights (kg/mol) of the same

% Calculate mean molecular weight of dry are based on top constiuents
M_a_dry = 0;
for i = 1:length(C)
	M_a_dry = M_a_dry + C(i)*M(i);
end
fprintf('Mean molecular weight of dry air (kg/mol): %.6f (M_a_dry)\n\n', M_a_dry)

%% Calculare Molecular Weight of Moist Air
% Define properties for water (append to molecular weight vector M)
M = [M 18e-3]; % Molecular weight of water (kg/mol)

% Mixing Ratio of Water to Dry Air
w = 0.03; % mol/mol (typical over tropical oceans)
% ratio of mass or density of water vapor to the same quantity for dry air 

% Calculate the molecular weight of this, now, moist air
M_a = (1 - w) * M_a_dry + w * M(end);

fprintf(['Molecular weight of (%1.2f mol/mol) moist air (kg/mol): %.6f (M_a)\n',...
'  Note: Moist should be lighter than dry.\n\n'], w, M_a);

if M_a < M_a_dry
	fprintf('In this case, the moist air is lighter...Good.\n\n')
else
	error('Molecular weight of moist air should be less than dry air.')
end
% %%
% P_v = x_ % Pa, Partial Pressure of water vapor
% rho_a = 0.0022*P_v / T0

%% Specific Humidity, q
% Mass or density of water vapor to the same for all constituents
% $$q = \frac{m_v}{m_{all}} = \frac{\rho_v}{\rho_{all}} = \frac{\rho_v}{\rho}$$
%
% $$q = \frac{w}{1+w}$$
%
% $$w=\frac{q}{1-q}$$
q = w/(1+w);
fprintf('Specific Humidity: %1.2f\n\n', q)

%% Relative Humidity
% $$RH=\frac{w}{w_s}$$
%
% $$ w_s = \frac{m_{vapor}}{m_{dry}}$$
%
% where $$ w_s $$ is the saturation mixing ratio (the mixing ratio at which RH = 100%)
%
% where $$ m_{vapor} $$ is mass of water vapor (kg)
m_dry = M_a_dry * n;

% TODO: Is the number of moles the same here?
m_vapor = M_a * n;

w_s = m_vapor / m_dry;
phi = w/w_s







%EOF
fprintf('Stop time: %s \n', datestr(datetime('now')))

























