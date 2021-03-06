function dx = state_function(x, u)
%% State function — Predicts how the plant states evolve over time
% Form of state vector
% x = [T_g, T_h, T_o, p_g, p_v,...
%      p_a, V_g, q, phi, p_s,...
%      m_v, m_a];
persistent specific_heat_fit_obj

if isempty(specific_heat_fit_obj)
    specific_heat_fit_obj = load_object();
end
%%
dx = zeros(length(x), 1);

%% Constants
R_a = 287.058;      % J/(kg*K), Specific Gas Constant, dry air
R_v = 461.495;      % J/(kg*K), Specific Gas Constant, water vapor
R_go = 0.03;        % K/W, Thermal resistance of the gas mixture to outside interface (1 inch insulation)
R_hg = 0.005;       % K/W, Thermal resistance of the heater to gax mixture interface
C_g = specific_heat_fit_obj(x(1)); % J/(kg*K), Specific heat capacity
C_h = 4660;         % J/(kg*K), Specific heat capacity of the heater
c_p = 0.718;        % Specific heat of air at constant pressure
m_h = 2.8;          % kg, Mass of the heater (about 6 lbs)

%% dT_o/dt
dx(3) = 0; % Constant ambient temperature outside the system

%% dp_g/dt
dx(4) = 0; % Constant total pressure at ambient
p_g2 = x(4) + dx(4);

%% dV_g/dt
dx(7) = 0;  % Constant volume for the gas mixture (aRDA volume is fixed)
V_g2 = x(7) + dx(7);

%% Change in m_a
% kg/m^3, density of dry air at 20C and 1 atm
%rho_a = XDryAir('tK', x(1), 'rho', x(4)); % input T_g and p_g
R_air = 0.287002; % gas constant for air kJ/kmol*K
if (x(1) >= 265 && x(1) <= 1500) && (x(4) >= 10 && x(4) <= 370)
    rho_a = x(4) / (R_air * x(1)); % p_g in kPa, T_g in K
else
    error('Temperature or pressure out of range for density calculation.')
end
m_a2 = rho_a * V_g2; % kg, mass of dry air
dx(11) = m_a2 - x(11);

%% dT_g/dt
dx(1) = -(1/(C_g*R_hg) + 1/(C_g * R_go))*x(1) +...
    ((c_p/C_g) * ((x(6) * x(7) / R_a) + (x(5) * x(7) / R_v)))/x(1) +...
    x(2)/(C_g*R_hg) +...
    x(3)/(C_g*R_go);
T_g2 = x(1) + dx(1);

%% Change in m_v
% Call XSteam with pressure in bar (kPa/100), and T in C
% p_g_bar = p_g2/100; % convert pressure to bars
% T_g_C = T_g2 - 273.15; % convert temperature to C
% rho_v2 = XSteam('rho_pt', p_g_bar, T_g_C);
rho_v2 = mini_xsteam(p_g2, T_g2);
m_v2 = rho_v2 * V_g2;
dx(10) = (m_v2 - x(10)) + u(2); % kg per time step

%% dT_h/dt
dx(2) = x(1)/(C_h * m_h * R_hg)...
    - x(2)/(C_h * m_h * R_hg)...
    + u(1)/(C_h * m_h);

%% dp_s/dt (change in saturation pressure)
% p_s2 = XSteam('psat_T', T_g2);
if T_g2 > 273.15 && T_g2 < 627.096
    p_s2 = calc_saturation_pressure(T_g2); 
else
    error('Temperature at next iteration is outside valid limits.')
end
dx(9) = p_s2 - x(9);

%% dp_v/dt
p_v2 = rho_v2 * x(3) / 0.0022;
if p_v2 > p_g2
    p_v2 = x(5);
end
dx(5) = p_v2 - x(5);

%% dp_a/dt
dx(6) = -dx(5);

%% dphi/dt (change in relative humidity)
phi2 =  p_v2 / p_s2;
dx(8) = phi2 - x(8);

%% v(flow)/dt (change in Volumetric flow rate)
dx(12) = (u(3)/460)*(0.188 - 0);

end

%%
function specific_heat_fit_obj = load_object()

if exist('specific_heat_table.mat', 'file')

    S = load('specific_heat_table.mat','specific_heat_fit_obj');
    specific_heat_fit_obj = S.specific_heat_fit_obj;

end

end

function out = mini_xsteam(p,T)
%% Inputs:
% p: pressure (kPa)
% T: temperature (K)

p = p/1000;

if (T > 1073.15 && p < 10 && T < 2273.15 && p > 0.000611)

    region = 5;

elseif (T <= 1073.15 && T > 273.15 && p <= 100 && p > 0.000611)

    if (T > 623.15)

        B23p_T = 348.05185628969 - 1.1671859879975 * T + 1.0192970039326e-3 * T^2;

        if (p > B23p_T)

            region = 3;

            if T < 647.096

                ps = calc_saturation_pressure(T)*100; % convert to bar

                if abs(p - ps) < 0.00001

                    region = 4;

                end

            end

        else

            region = 2;

        end

    else

        ps = calc_saturation_pressure(T) * 100; % convert to bar

        if abs(p - ps) < 0.00001

            region = 4;

        elseif p > ps

            region = 1;

        else

            region = 2;

        end

    end

else

    region = 0;

end

switch region

    case 1
        out = v1_pT(p, T);

    case 2
        out = v2_pT(p, T);

    case 3
        out = v3_ph(p, h3_pT(p, T));

    case 5
        out = v5_pT(p, T);

    otherwise
        out = NaN;

end
out = 1/out;

end % xsteam

%%
function p = calc_saturation_pressure(T)
% Inputs:
%   T: temperature (K)
% Outputs:
%   p4_T: pressure (kPa)
teta = T - 0.23855557567849 / (T - 650.17534844798);
a = teta ^ 2 + 1167.0521452767 * teta - 724213.16703206;
B = -17.073846940092 * teta ^ 2 + 12020.82470247 * teta - 3232555.0322333;
C = 14.91510861353 * teta ^ 2 - 4823.2657361591 * teta + 405113.40542057;
p = (2 * C / (-B + (B ^ 2 - 4 * a * C) ^ 0.5)) ^ 4;
p = p/100;
end 

%%
function v1_pT = v1_pT(p, T)
I1 = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 8, 8, 21, 23, 29, 30, 31, 32];
J1 = [-2, -1, 0, 1, 2, 3, 4, 5, -9, -7, -1, 0, 1, 3, -3, 0, 1, 3, 17, -4, 0, 6, -5, -2, 10, -8, -11, -6, -29, -31, -38, -39, -40, -41];
n1 = [0.14632971213167, -0.84548187169114, -3.756360367204, 3.3855169168385, -0.95791963387872, 0.15772038513228, -0.016616417199501, 8.1214629983568E-04, 2.8319080123804E-04, -6.0706301565874E-04, -0.018990068218419, -0.032529748770505, -0.021841717175414, -5.283835796993E-05, -4.7184321073267E-04, -3.0001780793026E-04, 4.7661393906987E-05, -4.4141845330846E-06, -7.2694996297594E-16, -3.1679644845054E-05, -2.8270797985312E-06, -8.5205128120103E-10, -2.2425281908E-06, -6.5171222895601E-07, -1.4341729937924E-13, -4.0516996860117E-07, -1.2734301741641E-09, -1.7424871230634E-10, -6.8762131295531E-19, 1.4478307828521E-20, 2.6335781662795E-23, -1.1947622640071E-23, 1.8228094581404E-24, -9.3537087292458E-26];
R = 0.461526; %kJ/(kg K)
Pi = p / 16.53;
tau = 1386 / T;
gamma_der_pi = 0;
for i = 1 : 34
    gamma_der_pi = gamma_der_pi - n1(i) * I1(i) * (7.1 - Pi) ^ (I1(i) - 1) * (tau - 1.222) ^ J1(i);
end
v1_pT = R * T / p * Pi * gamma_der_pi / 1000;
end % v1pT

%%
function v2_pT = v2_pT(p, T)
Ir = [1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 5, 6, 6, 6, 7, 7, 7, 8, 8, 9, 10, 10, 10, 16, 16, 18, 20, 20, 20, 21, 22, 23, 24, 24, 24];
Jr = [0, 1, 2, 3, 6, 1, 2, 4, 7, 36, 0, 1, 3, 6, 35, 1, 2, 3, 7, 3, 16, 35, 0, 11, 25, 8, 36, 13, 4, 10, 14, 29, 50, 57, 20, 35, 48, 21, 53, 39, 26, 40, 58];
nr = [-1.7731742473213E-03, -0.017834862292358, -0.045996013696365, -0.057581259083432, -0.05032527872793, -3.3032641670203E-05, -1.8948987516315E-04, -3.9392777243355E-03, -0.043797295650573, -2.6674547914087E-05, 2.0481737692309E-08, 4.3870667284435E-07, -3.227767723857E-05, -1.5033924542148E-03, -0.040668253562649, -7.8847309559367E-10, 1.2790717852285E-08, 4.8225372718507E-07, 2.2922076337661E-06, -1.6714766451061E-11, -2.1171472321355E-03, -23.895741934104, -5.905956432427E-18, -1.2621808899101E-06, -0.038946842435739, 1.1256211360459E-11, -8.2311340897998, 1.9809712802088E-08, 1.0406965210174E-19, -1.0234747095929E-13, -1.0018179379511E-09, -8.0882908646985E-11, 0.10693031879409, -0.33662250574171, 8.9185845355421E-25, 3.0629316876232E-13, -4.2002467698208E-06, -5.9056029685639E-26, 3.7826947613457E-06, -1.2768608934681E-15, 7.3087610595061E-29, 5.5414715350778E-17, -9.436970724121E-07];
R = 0.461526; %kJ/(kg K)
Pi = p;
tau = 540 / T;
g0_pi = 1 / Pi;
gr_pi = 0;
for i = 1 : 43
    gr_pi = gr_pi + nr(i) * Ir(i) * Pi ^ (Ir(i) - 1) * (tau - 0.5) ^ Jr(i);
end
v2_pT = R * T / p * Pi * (g0_pi + gr_pi) / 1000;
end % v2pT

%%
function h3_pT = h3_pT(p, T)
if p < 22.06395    
    Ts = T4_p(p);    
    if T <= Ts    
        High_Bound = h4L_p(p); 
        Low_Bound = h1_pT(p, 623.15);
    else
        Low_Bound = h4V_p(p);  
        High_Bound = h2_pT(p, B23T_p(p));
    end
else                 
    Low_Bound = h1_pT(p, 623.15);
    High_Bound = h2_pT(p, B23T_p(p));
end
Ts = T+1;
while abs(T - Ts) > 0.00001
    hs = (Low_Bound + High_Bound) / 2;
    Ts = T3_ph(p, hs);
    if Ts > T
        High_Bound = hs;
    else
        Low_Bound = hs;
    end
end
h3_pT = hs;
end

%%
function v3_ph = v3_ph(p, h)
h3ab = 2014.64004206875 + 3.74696550136983 * p - 2.19921901054187E-02 * p ^ 2 + 8.7513168600995E-05 * p ^ 3;
if h < h3ab
    Ii = [-12, -12, -12, -12, -10, -10, -10, -8, -8, -6, -6, -6, -4, -4, -3, -2, -2, -1, -1, -1, -1, 0, 0, 1, 1, 1, 2, 2, 3, 4, 5, 8];
    Ji = [6, 8, 12, 18, 4, 7, 10, 5, 12, 3, 4, 22, 2, 3, 7, 3, 16, 0, 1, 2, 3, 0, 1, 0, 1, 2, 0, 2, 0, 2, 2, 2];
    ni = [5.29944062966028E-03, -0.170099690234461, 11.1323814312927, -2178.98123145125, -5.06061827980875E-04, 0.556495239685324, -9.43672726094016, -0.297856807561527, 93.9353943717186, 1.92944939465981E-02, 0.421740664704763, -3689141.2628233, -7.37566847600639E-03, -0.354753242424366, -1.99768169338727, 1.15456297059049, 5683.6687581596, 8.08169540124668E-03, 0.172416341519307, 1.04270175292927, -0.297691372792847, 0.560394465163593, 0.275234661176914, -0.148347894866012, -6.51142513478515E-02, -2.92468715386302, 6.64876096952665E-02, 3.52335014263844, -1.46340792313332E-02, -2.24503486668184, 1.10533464706142, -4.08757344495612E-02];
    ps = p / 100;
    hs = h / 2100;
    vs = 0;
    for i = 1 : 32
        vs = vs + ni(i) * (ps + 0.128) ^ Ii(i) * (hs - 0.727) ^ Ji(i);
    end
    v3_ph = vs * 0.0028;
else
    Ii = [-12, -12, -8, -8, -8, -8, -8, -8, -6, -6, -6, -6, -6, -6, -4, -4, -4, -3, -3, -2, -2, -1, -1, -1, -1, 0, 1, 1, 2, 2];
    Ji = [0, 1, 0, 1, 3, 6, 7, 8, 0, 1, 2, 5, 6, 10, 3, 6, 10, 0, 2, 1, 2, 0, 1, 4, 5, 0, 0, 1, 2, 6];
    ni = [-2.25196934336318E-09, 1.40674363313486E-08, 2.3378408528056E-06, -3.31833715229001E-05, 1.07956778514318E-03, -0.271382067378863, 1.07202262490333, -0.853821329075382, -2.15214194340526E-05, 7.6965608822273E-04, -4.31136580433864E-03, 0.453342167309331, -0.507749535873652, -100.475154528389, -0.219201924648793, -3.21087965668917, 607.567815637771, 5.57686450685932E-04, 0.18749904002955, 9.05368030448107E-03, 0.285417173048685, 3.29924030996098E-02, 0.239897419685483, 4.82754995951394, -11.8035753702231, 0.169490044091791, -1.79967222507787E-02, 3.71810116332674E-02, -5.36288335065096E-02, 1.6069710109252];
    ps = p / 100;
    hs = h / 2800;
    vs = 0;
    for i = 1 : 30
        vs = vs + ni(i) * (ps + 0.0661) ^ Ii(i) * (hs - 0.72) ^ Ji(i);
    end
    v3_ph = vs * 0.0088;
end
end

%%
function v5_pT = v5_pT(p, T)
Iir = [1, 1, 1, 2, 3];
Jir = [0, 1, 3, 9, 3];
nir = [-1.2563183589592E-04, 2.1774678714571E-03, -0.004594282089991, -3.9724828359569E-06, 1.2919228289784E-07];
R = 0.461526; %kJ/(kg K)
tau = 1000 / T;
Pi = p;
gamma0_pi = 1 / Pi;
gammar_pi = 0;
for i = 1 : 5
    gammar_pi = gammar_pi + nir(i) * Iir(i) * Pi ^ (Iir(i) - 1) * tau ^ Jir(i);
end
v5_pT = R * T / p * Pi * (gamma0_pi + gammar_pi) / 1000;
end

