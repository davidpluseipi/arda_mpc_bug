function x_0 = set_initial_conditions(obj)
%% Set Initial Conditions
c2k = 273.15;

obj.T_o = obj.settings.T_o + c2k;
obj.p_g = 101.325;     % kPa, Initial/constant pressure of the control volume.
obj.V_g = 0.25;        % m^3, Initial/constant volume of aRDA "control volume"

% Calculate initial saturation pressure
obj.p_s = XSteam('psat_T', obj.T_g);

% kg/m^3
obj.rho_a = XDryAir('tK', obj.T_g, 'rho', obj.p_g);

% kg, mass of dry air
obj.m_a = obj.rho_a * obj.V_g;

%% Unused currently
% rho_v = XSteam('rho_pt', p_g/100, T_g0-273.15); %#ok<NASGU>

%%
% kg, mass of vapor
obj.m_v = 0;

% kPa, Initial partial pressure of water vapor
obj.p_v = 25.7;

% kPa, Initial partial pressure of air
obj.p_a = obj.p_g - obj.p_v;

% Initial relative humidity (fraction)
if ~obj.settings.simulation && obj.settings.arduino
    obj.phi = readHumidity(obj.sensor_dht22);
    if isnan(obj.phi)
        obj.phi =  obj.p_v / obj.p_s;
    end
else
    obj.phi =  obj.p_v / obj.p_s;
end

%% Currently unused
% percent of moisture by volume
pmv = obj.p_v / obj.p_g; %#ok<NASGU>

%%
q_0 = 0;

% Initial state vector
x_0 = [obj.T_g; obj.T_h; obj.T_o; obj.p_g; obj.p_v;...
    obj.p_a; obj.V_g; q_0; obj.phi; obj.p_s; obj.m_v; obj.m_a];

end