function set_initial_conditions(arda)
%% Set Initial Conditions
c2k = 273.15;

arda.T_o = arda.settings.T_o + c2k;
arda.p_g = 101.325;     % kPa, Initial/constant pressure of the control volume.
arda.V_g = 0.25;        % m^3, Initial/constant volume of aRDA "control volume"

% Calculate initial saturation pressure
arda.p_s = XSteam('psat_T', arda.T_g);

% kg/m^3
arda.rho_a = XDryAir('tK', arda.T_g, 'rho', arda.p_g);

% kg, mass of dry air
arda.m_a = arda.rho_a * arda.V_g;

%% Unused currently
% rho_v = XSteam('rho_pt', p_g/100, T_g0-273.15); %#ok<NASGU>

%%
% kg, mass of vapor
arda.m_v = 0;

% kPa, Initial partial pressure of water vapor
arda.p_v = 25.7;

% kPa, Initial partial pressure of air
arda.p_a = arda.p_g - arda.p_v;

% Initial relative humidity (fraction)
if ~arda.settings.simulation_only && arda.settings.arduino
    arda.phi = readHumidity(arda.sensor_dht22);
    if isnan(arda.phi)
        arda.phi =  arda.p_v / arda.p_s;
    end
else
    arda.phi =  arda.p_v / arda.p_s;
end

%% Currently unused
% percent of moisture by volume
pmv = arda.p_v / arda.p_g; %#ok<NASGU>

%%
q_0 = 0;

% Initial state vector
arda.x_0 = [arda.T_g; arda.T_h; arda.T_o; arda.p_g; arda.p_v;...
    arda.p_a; arda.V_g; q_0; arda.phi; arda.p_s; arda.m_v; arda.m_a];

end