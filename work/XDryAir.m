function out = XDryAir(inputType, inputValue, outputType, secondInputValue) 
% XDryAir Dry Air functions, moved to Git Starting with X4DryAir
%   [Input type, Target, Output type]
%   Example: Find Enthapy at 300 Kelvin
%       ['tK', 300, 'h']
%   Example: Find Constant pressure specific heat at 75 celsius
%       ['tC', 75, 'Cp'] 
%
%   Input/Output type options:
%   'tK' = Temperature (Kelvin)
%   'tC' = Temperature (Celsius)
%   'h' = Enthalpy (kJ/kg)
%   'pr' = Relative Pressure
%   'u' = Internal Energy (kJ/kg)
%   'vr' = Relative Volume
%   's0' = Entropy (kJ/kg*K)
%   'dV' = Dynamic Viscosity (kg/m*s, same as N*s/m^2)
%   'kV' = Kinematic Viscosity (m^2/s)
%   'kT' = Thermal conductivity (W/m*K)
%   
%   Output only: 
%   't-' means choose temperature Input type 'tC' or 'tK'
%   'Cp' Const Pres Spec Heat {kJ/(kg*K)} ['t-', temperature, 'Cp']
%   'Cv' Const Vol Spec Heat {kJ/(kg*K)} ['t-', temperature, 'Cv']
%   'CR' Specific heat ratio {unitless}  ['t-', temperature, 'CR']
%   'Pt' = Prandlt Number (unitless)
%   'rho' density (kg/m^3)   ['t-', temperature, 'rho', pressure in kPa]


%   invalid parameters: output = -1
%   assumes 101.325kPa (atmos pres) if secondInputValue is n/a

% References
% [1] Cengel, Y. A., and M. A. Boles. 2002. Thermodynamics: An Engineering 
% Approach. McGraw-Hill, New York.
% [2] Incropera, F.P., and DeWitt, D.P. 2002. Fundamentals of Heat and Mass
% Transfer. 5th Ed. Wiley & Sons, New Jersey
%
% Ideal gas properties of air in SI units. [1] Table A-17
%
% AirTable: Temperature | Enthalpy | Relative Pressure | Internal energy | Relative Volume | Entropy referenced to absolute 0
% Airtable: Kelvin | kJ/kg | non-dimensional | kJ/kg | non-dimensional | kJ/kg * K
% See [1] Chapter 6 for related equations
%
% Reynods, Prandle, Viscosities, heat tranfer coefficient (k)

% check input for correct format

if exist('inputType', 'var')
   typeIn = inputType;
else
    disp('please specify input type such as tC')
    out = -1;
    return
end
    
if exist('outputType', 'var')
   typeOut = outputType;
else
    disp('please specify outputType such as kT')
    out = -1;
    return
end 

if isnan(inputValue)
    disp('nan is not a valid inputValue for XDryAir')
    out = -1;
    return
end
    
% check which source (heat tranfer or thermo book) to build tables from
inputIsTemperature = false;
switch typeIn
    % 0 indicates either source, 
    % 1 indicates source 1,
    % 2 indicates source 2,
    case {'tK', 'tC'}
        srcIn = 0;
        inputIsTemperature = true;
    case {'h', 'pr', 'u', 'vr','s0'}
        srcIn = 1;
    case {'dV', 'kV', 'kT'}
        srcIn = 2;
    case {'Pt', 'Cp', 'Cv', 'CR', 'rho'}
        out = -1;
        disp([inputType, ' is not a valid inputType for function XDryAir.']);
        disp('It may only be used as an outputType');
        return;
    otherwise  % case not found
        out = -1;
        disp('invalid inputType for function XDryAir');
        return;
end


switch typeOut
    % 0 indicates either source, 
    % 1 indicates source 1,
    % 2 indicates source 2,
    case {'tK', 'tC'}
        srcOut = 0;
    case {'Cp', 'Cv', 'CR'}
        srcOut = 0;
        if ~inputIsTemperature
            inputValue = XDryAir(inputType, inputValue, 'tK');
            inputType = 'tK';
        end
    case {'h', 'pr', 'u', 'vr','s0'}
        srcOut = 1;
    case {'dV', 'kV', 'Pt', 'kT'}
        srcOut = 2;
    case 'rho'
        % density is a special case in that it requres a second input
        if ~exist('secondInputValue', 'var')
            secondInputValue = 101.325;
        end
        if isnan(secondInputValue)
            disp('nan is not a valid secondInputValue for XDryAir')
            out = -1;
            return
        end
        srcOut = 0;
        if ~inputIsTemperature
            inputValue = XDryAir(inputType, inputValue, 'tK');
            inputType = 'tK';
        end
    otherwise  % case not found
        out = -1;
        disp('invalid outputType for function XDryAir');
        return;
end

% check sources match
srcConvert = false;
if srcIn>0 && srcOut>0 && srcIn ~= srcOut
    % sources are specific and don't match, will need to conver sources to
    % complete lookup.
    srcConvert = true;
    % In all cases where conversion is neecessary, convert to tK of input
    % Source, then use tK to lookup on output source
elseif srcIn == 1 || srcOut == 1
    useSrc1 = true;
else
    useSrc1 = false;
end

if srcConvert
    % utilize recursive call to perform conversion
    tK = XDryAir(inputType, inputValue, 'tK');
    out = XDryAir('tK', tK, outputType);
    % final value determined directly from recusive call
    return
end

switch inputType
    % vectors
    case 'tK' % temperature
        if useSrc1
            inVect = InitAirTableK;
        else
            inVect = InitAirTableK2;
        end
    case 'tC' % temperature in C
        if useSrc1
            inVect = InitAirTableK;
        else
            inVect = InitAirTableK2;
        end
        % convert celsius input to Kelvin for all calculations
        inputValue = toSIunit_T(inputValue); 
    case 'h'    % enthalpy [1]
        inVect = InitAirTableh;
    case 'pr'   % relative pressure [1]
        inVect = InitAirTablePr;
    case 'u'    % internal energy [1]
        inVect = InitAirTableU;
    case 'vr'   % relative volume [1]
        inVect = InitAirTableVr;
    case 's0'   % entropy [1]
        inVect = InitAirTableS0;
    case 'dV'   % Dynamic Visocisity [2]
        inVect = InitAirTabledV;
    case 'kV'   % Kinematic Viscosity [2]
        inVect = InitAirTablekV;
    case 'pt'   % Prandlt Number [2]
        inVect = InitializeAirTablePt;
    case 'kT'   % Thermal conductivity [2]
        inVect = InitAirTablekT;
    otherwise   % case not found
        out = -1;
        disp('invalid inputType for function XDryAir');
        disp('second inputType check');
        return;
end
    
KtoC = false;
switch typeOut
    case 'tK' % temperature
        if useSrc1
            outVect = InitAirTableK;
        else
            outVect = InitAirTableK2;
        end
    case 'tC' % temperature
        outVect = InitAirTableK;
        KtoC = true;
    case 'h'  % enthalpy
        outVect = InitAirTableh;
    case 'pr' % relative pressure
        outVect = InitAirTablePr;
    case 'u'  % internal energy
        outVect = InitAirTableU;
    case 'vr' % relative volume
        outVect = InitAirTableVr;
    case 's0' % entropy
        outVect = InitAirTableS0;
    case 'dV'   % Dynamic Visocisity
        outVect = InitAirTabledV;
    case 'kV'   % Kinematic Viscosity
        outVect = InitAirTablekV;
    case 'Pt'   % Prandlt Number
        outVect = InitializeAirTablePt;
    case 'kT'   % Thermal conductivity
        outVect = InitAirTablekT;

     % equations.
     % Note: tC inputs converted to tK above
    case 'Cp'   % constant pressure specific heat
        out = DryAirCpEq(inputValue);
        return
    case 'Cv'   % constant volume specific heat
        out = DryAirCvEq(inputValue);
        return
    case 'CR'    % specific heat ratio
        out = DryAirCpCvEq(inputValue);
        return
    case 'rho'  % density
        out = DryAirDensity(inputValue, secondInputValue);
        return  
    otherwise   % case not found
        out = -1;
        disp('invalid outputType for function XDryAir');
        disp('second output type check');
        return
end

[X, Lindx, Uindx] = OrderedVSearch(inVect,inputValue);
if Lindx == -1
    out = -1;
    disp('inputValue outside range of specified vector');
elseif KtoC 
    out = fromSIunit_T(LinInterpF(outVect,X,Lindx,Uindx));
else
    out = LinInterpF(outVect,X,Lindx,Uindx);
end



end

%% Ordered Var Search

    function [Interpolation, Lindex, Uindex] = OrderedVSearch(Vector, Target)

    % LB: dynamic lower bound of search region
    % UB: dynamic upper bound of search region
    % Iguess: next position guess
    % OldGuess:  track guesses to deal with poorly spaced data
 
        LB = 1;
        UB = length(Vector);

        if Target < Vector(LB) || Target > Vector(UB)
            % target outside range of vector
            Lindex = -1;
            Uindex = -1;
            Interpolation = -1;
        else
        Interpolation = (Target - Vector(LB)) / (Vector(UB) - Vector(LB));
        Iguess = round(Interpolation * (UB - LB) + LB);     
        OldGuess = 0;
        Cnt = 0;
        while UB - LB > 1
            if Target == Vector(Iguess)
                % value found, no interpolation
                Interpolation = 0;
                LB = Iguess;
                UB = Iguess;
            elseif Target > Vector(Iguess)
                % Iguess undershoot, narrow region
                if Iguess == OldGuess 
                    Iguess = Iguess + 1;
                end
                LB = Iguess;
                if Target <= Vector(LB + 1)
                    UB = LB + 1;
                end
                Interpolation = (Target - Vector(LB)) / (Vector(UB) - Vector(LB));
                OldGuess = Iguess;
                Iguess = round(Interpolation * (UB - LB) + LB);
            else % target < vector(iguess)
                if Iguess == OldGuess
                    Iguess = Iguess - 1;
                end
                UB = Iguess;
                if Target >= Vector(UB - 1)
                    LB = UB - 1;
                end
                Interpolation = (Target - Vector(LB)) / (Vector(UB) - Vector(LB));
                OldGuess = Iguess;
                Iguess = round(Interpolation * (UB - LB) + LB);
            end
            Cnt = Cnt + 1;
        end
        % Debug.Print Cnt
        Lindex = LB;
        Uindex = UB;
        end
    end

%% Linear Interpretation

    function LinInterpF = LinInterpF(Vector, X, I1, I2)
        % no error handling to increase speed of function
        LinInterpF = X * (Vector(I2) - Vector(I1)) + Vector(I1);
    end
    
%% Equations

    % cp
    function DryAirCp = DryAirCpEq(Kelvin)
    % Function returns the constant pressure specific heat of dry air at the specified temperature in Kelvin
    %   Output units of kJ/kg
    %   References
    %   [1] Cengel, Y. A., and M. A. Boles. 2002. Thermodynamics: An Engineering Approach. McGraw-Hill, New York.
 
        % maximum error within range: 0.10%
        % Average error within range: 0.00%
        if Kelvin < 250 || Kelvin > 1000
            % outside of valid range
            DryAirCp = -1;
            disp('Temp outside valid range for temp parameter.');
        else
            A = 1.04167083515766;
            B = -0.00032879595805;
            C = 0.00000078971178;
            D = -0.00000000036116;
            DryAirCp = (A + B * Kelvin + C * Kelvin ^ 2 + D * Kelvin ^ 3); 
            % [1] best fit line of values shown in Table A-2, NOT function based coefficients
        end
    end
    
    % cv
    function DryAirCv = DryAirCvEq(Kelvin)
    % Function returns the constant volume specific heat of dry air at the specified temperature in Kelvin
    %   Output units of kJ/kg
    %   References
    %   [1] Cengel, Y. A., and M. A. Boles. 2002. Thermodynamics: An Engineering Approach. McGraw-Hill, New York.
 
        if Kelvin < 250 || Kelvin > 1000
            % outside of valid range
            DryAirCv = -1;
            disp('Temp outside valid range for temp parameter.');
        else
            % constants
            a = 1.606850927 * 10^-13;
            b = -7.602409232 * 10^-10;
            c = 1.139318487 * 10^-6;
            d = -4.555393852 * 10^-4;
            e = 0.7705455443;

            DryAirCv = a * Kelvin^4 + b * Kelvin^3 + c * Kelvin^2 + d * Kelvin + e;
        end
    end
    
    % k
    function DryAirCpCv = DryAirCpCvEq(Kelvin)
    % Function returns the ratio of Cp/Cv
    %   Output units are dimensionless
    %   References
    %   [1] Cengel, Y. A., and M. A. Boles. 2002. Thermodynamics: An Engineering Approach. McGraw-Hill, New York.
 
        if Kelvin < 250 || Kelvin > 1000
            % outside of valid range
            DryAirCpCv = -1;
            disp('Temp outside valid range for temp parameter.');
        else
            % constants
            a = -1.114284331 * 10^-13;
            b = 4.643989264 * 10^-10;
            c = -6.261612302 * 10^-7;
            d = 2.347700298 * 10^-4;
            e = 1.374457144;

            DryAirCpCv = a * Kelvin^4 + b * Kelvin^3 + c * Kelvin^2 + d * Kelvin + e;
        end
    end
        
    % dens
    function DryAirDensity = DryAirDensity(Kelvin, kPa)
        % requires the temperature in kelvin and pressure in kPa
    	% Outputs the density of air in kg/m^3 based on Ideal Gas Law [1] Example 2-10

        Rair = 0.287002;  % Gas contant for Air in kJ/kmol*K )[1] eq. 2-10)
        
        % limits
        if (Kelvin < 265 || Kelvin > 1500)
            DryAirDensity = -1;
            disp('Temp parameter for Density out of range.');
        elseif (kPa > 370 || kPa < 10)
            DryAirDensity = -1;
            disp('Pres parameter for Density out of range.');
        else
            DryAirDensity = kPa / (Rair * Kelvin);
        end
    end

    
function toSIunit_T = toSIunit_T( Ins )
%Translate degC to Kelvin
toSIunit_T = Ins + 273.15;
end
function fromSIunit_T = fromSIunit_T( Ins )
%Translate Kelvin to degC
fromSIunit_T = Ins - 273.15;
end
%% Variable Table initializations

% k (temperature in K)
function vOut = InitAirTableK()
AirTableK = zeros(120,1);
%T (Kelvin)
AirTableK(1) = 200;
AirTableK(2) = 210;
AirTableK(3) = 220;
AirTableK(4) = 230;
AirTableK(5) = 240;

AirTableK(6) = 250;
AirTableK(7) = 260;
AirTableK(8) = 270;
AirTableK(9) = 280;
AirTableK(10) = 285;

AirTableK(11) = 290;
AirTableK(12) = 295;
AirTableK(13) = 300;
AirTableK(14) = 305;
AirTableK(15) = 310;

AirTableK(16) = 315;
AirTableK(17) = 320;
AirTableK(18) = 325;
AirTableK(19) = 330;
AirTableK(20) = 340;

AirTableK(21) = 350;
AirTableK(22) = 360;
AirTableK(23) = 370;
AirTableK(24) = 380;
AirTableK(25) = 390;

AirTableK(26) = 400;
AirTableK(27) = 410;
AirTableK(28) = 420;
AirTableK(29) = 430;
AirTableK(30) = 440;

AirTableK(31) = 450;
AirTableK(32) = 460;
AirTableK(33) = 470;
AirTableK(34) = 480;
AirTableK(35) = 490;

AirTableK(36) = 500;
AirTableK(37) = 510;
AirTableK(38) = 520;
AirTableK(39) = 530;
AirTableK(40) = 540;

AirTableK(41) = 550;
AirTableK(42) = 560;
AirTableK(43) = 570;
AirTableK(44) = 580;
AirTableK(45) = 590;

AirTableK(46) = 600;
AirTableK(47) = 610;
AirTableK(48) = 620;
AirTableK(49) = 630;
AirTableK(50) = 640;

AirTableK(51) = 650;
AirTableK(52) = 660;
AirTableK(53) = 670;
AirTableK(54) = 680;
AirTableK(55) = 690;

AirTableK(56) = 700;
AirTableK(57) = 710;
AirTableK(58) = 720;
AirTableK(59) = 730;
AirTableK(60) = 740;

AirTableK(61) = 750;
AirTableK(62) = 760;
AirTableK(63) = 780;
AirTableK(64) = 800;
AirTableK(65) = 820;

AirTableK(66) = 840;
AirTableK(67) = 860;
AirTableK(68) = 880;
AirTableK(69) = 900;
AirTableK(70) = 920;

AirTableK(71) = 940;
AirTableK(72) = 960;
AirTableK(73) = 980;
AirTableK(74) = 1000;
AirTableK(75) = 1020;

AirTableK(76) = 1040;
AirTableK(77) = 1060;
AirTableK(78) = 1080;
AirTableK(79) = 1100;
AirTableK(80) = 1120;

AirTableK(81) = 1140;
AirTableK(82) = 1160;
AirTableK(83) = 1180;
AirTableK(84) = 1200;
AirTableK(85) = 1220;

AirTableK(86) = 1240;
AirTableK(87) = 1260;
AirTableK(88) = 1280;
AirTableK(89) = 1300;
AirTableK(90) = 1320;

AirTableK(91) = 1340;
AirTableK(92) = 1360;
AirTableK(93) = 1380;
AirTableK(94) = 1400;
AirTableK(95) = 1420;

AirTableK(96) = 1440;
AirTableK(97) = 1460;
AirTableK(98) = 1480;
AirTableK(99) = 1500;
AirTableK(100) = 1520;

AirTableK(101) = 1540;
AirTableK(102) = 1560;
AirTableK(103) = 1580;
AirTableK(104) = 1600;
AirTableK(105) = 1620;

AirTableK(106) = 1640;
AirTableK(107) = 1660;
AirTableK(108) = 1680;
AirTableK(109) = 1700;
AirTableK(110) = 1750;

AirTableK(111) = 1800;
AirTableK(112) = 1850;
AirTableK(113) = 1900;
AirTableK(114) = 1950;
AirTableK(115) = 2000;

AirTableK(116) = 2050;
AirTableK(117) = 2100;
AirTableK(118) = 2150;
AirTableK(119) = 2200;
AirTableK(120) = 2250;

vOut = AirTableK;
end

% h (enthalpy)
function vOut = InitAirTableh()
AirTableh = zeros(120, 1); % initialize

AirTableh(1) = 199.97;
AirTableh(2) = 209.97;
AirTableh(3) = 219.97;
AirTableh(4) = 230.02;
AirTableh(5) = 240.02;

AirTableh(6) = 250.05;
AirTableh(7) = 260.09;
AirTableh(8) = 270.11;
AirTableh(9) = 280.133;
AirTableh(10) = 285.14;

AirTableh(11) = 290.16;
AirTableh(12) = 295.17;
AirTableh(13) = 300.19;
AirTableh(14) = 305.22;
AirTableh(15) = 310.24;

AirTableh(16) = 315.27;
AirTableh(17) = 320.29;
AirTableh(18) = 325.31;
AirTableh(19) = 330.34;
AirTableh(20) = 340.42;

AirTableh(21) = 350.49;
AirTableh(22) = 360.58;
AirTableh(23) = 370.67;
AirTableh(24) = 380.77;
AirTableh(25) = 390.88;

AirTableh(26) = 400.98;
AirTableh(27) = 411.12;
AirTableh(28) = 421.26;
AirTableh(29) = 431.43;
AirTableh(30) = 441.61;

AirTableh(31) = 451.8;
AirTableh(32) = 462.02;
AirTableh(33) = 472.24;
AirTableh(34) = 482.49;
AirTableh(35) = 492.74;

AirTableh(36) = 503.02;
AirTableh(37) = 513.32;
AirTableh(38) = 523.63;
AirTableh(39) = 533.98;
AirTableh(40) = 544.35;

AirTableh(41) = 555.74;
AirTableh(42) = 565.17;
AirTableh(43) = 575.59;
AirTableh(44) = 586.04;
AirTableh(45) = 596.52;

AirTableh(46) = 607.02;
AirTableh(47) = 617.53;
AirTableh(48) = 628.07;
AirTableh(49) = 638.63;
AirTableh(50) = 649.22;

AirTableh(51) = 659.84;
AirTableh(52) = 670.47;
AirTableh(53) = 681.14;
AirTableh(54) = 691.82;
AirTableh(55) = 702.52;

AirTableh(56) = 713.27;
AirTableh(57) = 724.04;
AirTableh(58) = 734.82;
AirTableh(59) = 745.62;
AirTableh(60) = 756.44;

AirTableh(61) = 767.29;
AirTableh(62) = 778.18;
AirTableh(63) = 800.03;
AirTableh(64) = 821.95;
AirTableh(65) = 843.98;

AirTableh(66) = 866.08;
AirTableh(67) = 888.27;
AirTableh(68) = 910.56;
AirTableh(69) = 932.93;
AirTableh(70) = 955.38;

AirTableh(71) = 977.92;
AirTableh(72) = 1000.55;
AirTableh(73) = 1023.25;
AirTableh(74) = 1046.04;
AirTableh(75) = 1068.89;

AirTableh(76) = 1091.85;
AirTableh(77) = 1114.86;
AirTableh(78) = 1137.89;
AirTableh(79) = 1161.07;
AirTableh(80) = 1184.28;

AirTableh(81) = 1207.57;
AirTableh(82) = 1230.92;
AirTableh(83) = 1254.34;
AirTableh(84) = 1277.79;
AirTableh(85) = 1301.31;

AirTableh(86) = 1324.93;
AirTableh(87) = 1348.55;
AirTableh(88) = 1372.24;
AirTableh(89) = 1395.97;
AirTableh(90) = 1419.76;

AirTableh(91) = 1443.6;
AirTableh(92) = 1467.49;
AirTableh(93) = 1491.44;
AirTableh(94) = 1515.42;
AirTableh(95) = 1539.44;

AirTableh(96) = 1563.51;
AirTableh(97) = 1587.63;
AirTableh(98) = 1611.79;
AirTableh(99) = 1635.97;
AirTableh(100) = 1660.23;

AirTableh(101) = 1684.51;
AirTableh(102) = 1708.82;
AirTableh(103) = 1733.17;
AirTableh(104) = 1757.57;
AirTableh(105) = 1782;

AirTableh(106) = 1806.46;
AirTableh(107) = 1830.96;
AirTableh(108) = 1855.5;
AirTableh(109) = 1880.1;
AirTableh(110) = 1941.6;

AirTableh(111) = 2003.3;
AirTableh(112) = 2065.3;
AirTableh(113) = 2127.4;
AirTableh(114) = 2189.7;
AirTableh(115) = 2252.1;

AirTableh(116) = 2314.6;
AirTableh(117) = 2377.7;
AirTableh(118) = 2440.3;
AirTableh(119) = 2503.2;
AirTableh(120) = 2566.4;

vOut = AirTableh;
end

% Pr (relative pressure)
function vOut = InitAirTablePr()
AirTablePr = zeros(120, 1); % initialize

AirTablePr(1) = 0.3363;
AirTablePr(2) = 0.3987;
AirTablePr(3) = 0.469;
AirTablePr(4) = 0.5477;
AirTablePr(5) = 0.6355;

AirTablePr(6) = 0.7329;
AirTablePr(7) = 0.8405;
AirTablePr(8) = 0.959;
AirTablePr(9) = 1.0889;
AirTablePr(10) = 1.1584;

AirTablePr(11) = 1.2311;
AirTablePr(12) = 1.3068;
AirTablePr(13) = 1.386;
AirTablePr(14) = 1.4686;
AirTablePr(15) = 1.5546;

AirTablePr(16) = 1.6442;
AirTablePr(17) = 1.7375;
AirTablePr(18) = 1.8345;
AirTablePr(19) = 1.9352;
AirTablePr(20) = 2.149;

AirTablePr(21) = 2.379;
AirTablePr(22) = 2.626;
AirTablePr(23) = 2.892;
AirTablePr(24) = 3.176;
AirTablePr(25) = 3.481;

AirTablePr(26) = 3.806;
AirTablePr(27) = 4.153;
AirTablePr(28) = 4.522;
AirTablePr(29) = 4.915;
AirTablePr(30) = 5.332;

AirTablePr(31) = 5.775;
AirTablePr(32) = 6.245;
AirTablePr(33) = 6.742;
AirTablePr(34) = 7.268;
AirTablePr(35) = 7.824;

AirTablePr(36) = 8.411;
AirTablePr(37) = 9.031;
AirTablePr(38) = 9.684;
AirTablePr(39) = 10.37;
AirTablePr(40) = 11.1;

AirTablePr(41) = 11.86;
AirTablePr(42) = 12.66;
AirTablePr(43) = 13.5;
AirTablePr(44) = 14.38;
AirTablePr(45) = 15.31;

AirTablePr(46) = 16.28;
AirTablePr(47) = 17.3;
AirTablePr(48) = 18.36;
AirTablePr(49) = 19.84;
AirTablePr(50) = 20.64;

AirTablePr(51) = 21.86;
AirTablePr(52) = 23.13;
AirTablePr(53) = 24.46;
AirTablePr(54) = 25.85;
AirTablePr(55) = 27.29;

AirTablePr(56) = 28.8;
AirTablePr(57) = 30.38;
AirTablePr(58) = 32.02;
AirTablePr(59) = 33.72;
AirTablePr(60) = 35.5;

AirTablePr(61) = 37.35;
AirTablePr(62) = 39.27;
AirTablePr(63) = 43.35;
AirTablePr(64) = 47.75;
AirTablePr(65) = 52.59;

AirTablePr(66) = 57.6;
AirTablePr(67) = 63.09;
AirTablePr(68) = 68.98;
AirTablePr(69) = 75.29;
AirTablePr(70) = 82.05;

AirTablePr(71) = 89.28;
AirTablePr(72) = 97;
AirTablePr(73) = 105.2;
AirTablePr(74) = 114;
AirTablePr(75) = 123.4;

AirTablePr(76) = 133.3;
AirTablePr(77) = 143.9;
AirTablePr(78) = 155.2;
AirTablePr(79) = 167.1;
AirTablePr(80) = 179.7;

AirTablePr(81) = 193.1;
AirTablePr(82) = 207.2;
AirTablePr(83) = 222.2;
AirTablePr(84) = 238;
AirTablePr(85) = 254.7;

AirTablePr(86) = 272.3;
AirTablePr(87) = 290.8;
AirTablePr(88) = 310.4;
AirTablePr(89) = 330.9;
AirTablePr(90) = 352.5;

AirTablePr(91) = 375.3;
AirTablePr(92) = 399.1;
AirTablePr(93) = 424.2;
AirTablePr(94) = 450.5;
AirTablePr(95) = 478;

AirTablePr(96) = 506.9;
AirTablePr(97) = 537.1;
AirTablePr(98) = 568.8;
AirTablePr(99) = 601.9;
AirTablePr(100) = 636.5;

AirTablePr(101) = 672.8;
AirTablePr(102) = 710.5;
AirTablePr(103) = 750;
AirTablePr(104) = 791.2;
AirTablePr(105) = 834.1;

AirTablePr(106) = 878.9;
AirTablePr(107) = 925.6;
AirTablePr(108) = 974.2;
AirTablePr(109) = 1025;
AirTablePr(110) = 1161;

AirTablePr(111) = 1310;
AirTablePr(112) = 1475;
AirTablePr(113) = 1655;
AirTablePr(114) = 1852;
AirTablePr(115) = 2068;

AirTablePr(116) = 2303;
AirTablePr(117) = 2559;
AirTablePr(118) = 2837;
AirTablePr(119) = 3138;
AirTablePr(120) = 3464;

vOut = AirTablePr;
end

% U (internal energy kJ/kg)
function vOut = InitAirTableU()
AirTableU = zeros(120, 1); % initialize

AirTableU(1) = 142.56;
AirTableU(2) = 149.69;
AirTableU(3) = 156.82;
AirTableU(4) = 164;
AirTableU(5) = 171.13;

AirTableU(6) = 178.28;
AirTableU(7) = 185.45;
AirTableU(8) = 192.6;
AirTableU(9) = 199.75;
AirTableU(10) = 203.33;

AirTableU(11) = 206.91;
AirTableU(12) = 210.49;
AirTableU(13) = 214.07;
AirTableU(14) = 217.67;
AirTableU(15) = 221.25;

AirTableU(16) = 224.85;
AirTableU(17) = 228.42;
AirTableU(18) = 232.02;
AirTableU(19) = 235.61;
AirTableU(20) = 242.82;

AirTableU(21) = 250.02;
AirTableU(22) = 257.24;
AirTableU(23) = 264.46;
AirTableU(24) = 271.69;
AirTableU(25) = 278.93;

AirTableU(26) = 286.16;
AirTableU(27) = 293.43;
AirTableU(28) = 300.69;
AirTableU(29) = 307.99;
AirTableU(30) = 315.3;

AirTableU(31) = 322.62;
AirTableU(32) = 329.97;
AirTableU(33) = 337.32;
AirTableU(34) = 344.7;
AirTableU(35) = 352.08;

AirTableU(36) = 359.49;
AirTableU(37) = 366.92;
AirTableU(38) = 374.36;
AirTableU(39) = 381.84;
AirTableU(40) = 389.34;

AirTableU(41) = 396.86;
AirTableU(42) = 404.42;
AirTableU(43) = 411.97;
AirTableU(44) = 419.55;
AirTableU(45) = 427.15;

AirTableU(46) = 434.78;
AirTableU(47) = 442.42;
AirTableU(48) = 450.09;
AirTableU(49) = 457.78;
AirTableU(50) = 465.5;

AirTableU(51) = 473.25;
AirTableU(52) = 481.01;
AirTableU(53) = 488.81;
AirTableU(54) = 496.62;
AirTableU(55) = 504.45;

AirTableU(56) = 512.33;
AirTableU(57) = 520.23;
AirTableU(58) = 528.14;
AirTableU(59) = 536.07;
AirTableU(60) = 544.02;

AirTableU(61) = 551.99;
AirTableU(62) = 560.01;
AirTableU(63) = 576.12;
AirTableU(64) = 592.3;
AirTableU(65) = 608.59;

AirTableU(66) = 624.95;
AirTableU(67) = 641.4;
AirTableU(68) = 657.95;
AirTableU(69) = 674.58;
AirTableU(70) = 691.28;

AirTableU(71) = 708.08;
AirTableU(72) = 725.02;
AirTableU(73) = 741.98;
AirTableU(74) = 758.94;
AirTableU(75) = 776.1;

AirTableU(76) = 793.36;
AirTableU(77) = 810.62;
AirTableU(78) = 827.88;
AirTableU(79) = 845.33;
AirTableU(80) = 862.79;

AirTableU(81) = 880.35;
AirTableU(82) = 897.91;
AirTableU(83) = 915.57;
AirTableU(84) = 933.33;
AirTableU(85) = 951.09;

AirTableU(86) = 968.95;
AirTableU(87) = 986.9;
AirTableU(88) = 1004.76;
AirTableU(89) = 1022.82;
AirTableU(90) = 1040.88;

AirTableU(91) = 1058.94;
AirTableU(92) = 1077.1;
AirTableU(93) = 1095.26;
AirTableU(94) = 1113.52;
AirTableU(95) = 1131.77;

AirTableU(96) = 1150.13;
AirTableU(97) = 1168.49;
AirTableU(98) = 1186.95;
AirTableU(99) = 1205.41;
AirTableU(100) = 1223.87;

AirTableU(101) = 1242.43;
AirTableU(102) = 1260.99;
AirTableU(103) = 1279.65;
AirTableU(104) = 1298.3;
AirTableU(105) = 1316.96;

AirTableU(106) = 1335.72;
AirTableU(107) = 1354.48;
AirTableU(108) = 1373.24;
AirTableU(109) = 1392.7;
AirTableU(110) = 1439.8;

AirTableU(111) = 1487.2;
AirTableU(112) = 1534.9;
AirTableU(113) = 1582.6;
AirTableU(114) = 1630.6;
AirTableU(115) = 1678.7;

AirTableU(116) = 1726.8;
AirTableU(117) = 1775.3;
AirTableU(118) = 1823.8;
AirTableU(119) = 1872.4;
AirTableU(120) = 1921.3;

vOut = AirTableU;
end

% Vr (relative volume)
function vOut = InitAirTableVr()
AirTableVr = zeros(120, 1); % initialize

AirTableVr(1) = 1707;
AirTableVr(2) = 1512;
AirTableVr(3) = 1346;
AirTableVr(4) = 1205;
AirTableVr(5) = 1084;

AirTableVr(6) = 979;
AirTableVr(7) = 887.8;
AirTableVr(8) = 808;
AirTableVr(9) = 738;
AirTableVr(10) = 706.1;

AirTableVr(11) = 676.1;
AirTableVr(12) = 647.9;
AirTableVr(13) = 621.2;
AirTableVr(14) = 596;
AirTableVr(15) = 572.3;

AirTableVr(16) = 549.8;
AirTableVr(17) = 528.6;
AirTableVr(18) = 508.4;
AirTableVr(19) = 489.4;
AirTableVr(20) = 454.1;

AirTableVr(21) = 422.2;
AirTableVr(22) = 393.4;
AirTableVr(23) = 367.2;
AirTableVr(24) = 343.4;
AirTableVr(25) = 321.5;

AirTableVr(26) = 301.6;
AirTableVr(27) = 283.3;
AirTableVr(28) = 266.6;
AirTableVr(29) = 251.1;
AirTableVr(30) = 236.8;

AirTableVr(31) = 223.6;
AirTableVr(32) = 211.4;
AirTableVr(33) = 200.1;
AirTableVr(34) = 189.5;
AirTableVr(35) = 179.7;

AirTableVr(36) = 170.6;
AirTableVr(37) = 162.1;
AirTableVr(38) = 154.1;
AirTableVr(39) = 146.7;
AirTableVr(40) = 139.7;

AirTableVr(41) = 133.1;
AirTableVr(42) = 127;
AirTableVr(43) = 121.2;
AirTableVr(44) = 115.7;
AirTableVr(45) = 110.6;

AirTableVr(46) = 105.8;
AirTableVr(47) = 101.2;
AirTableVr(48) = 96.92;
AirTableVr(49) = 92.84;
AirTableVr(50) = 88.99;

AirTableVr(51) = 85.34;
AirTableVr(52) = 81.89;
AirTableVr(53) = 78.61;
AirTableVr(54) = 75.5;
AirTableVr(55) = 72.56;

AirTableVr(56) = 69.76;
AirTableVr(57) = 67.07;
AirTableVr(58) = 64.53;
AirTableVr(59) = 62.13;
AirTableVr(60) = 59.82;

AirTableVr(61) = 57.63;
AirTableVr(62) = 55.54;
AirTableVr(63) = 51.64;
AirTableVr(64) = 48.08;
AirTableVr(65) = 44.84;

AirTableVr(66) = 41.85;
AirTableVr(67) = 39.12;
AirTableVr(68) = 36.61;
AirTableVr(69) = 34.31;
AirTableVr(70) = 32.18;

AirTableVr(71) = 30.22;
AirTableVr(72) = 28.4;
AirTableVr(73) = 26.73;
AirTableVr(74) = 25.17;
AirTableVr(75) = 23.72;

AirTableVr(76) = 23.29;
AirTableVr(77) = 21.14;
AirTableVr(78) = 19.98;
AirTableVr(79) = 18.896;
AirTableVr(80) = 17.886;

AirTableVr(81) = 16.946;
AirTableVr(82) = 16.064;
AirTableVr(83) = 15.241;
AirTableVr(84) = 14.47;
AirTableVr(85) = 13.747;

AirTableVr(86) = 13.069;
AirTableVr(87) = 12.435;
AirTableVr(88) = 11.835;
AirTableVr(89) = 11.275;
AirTableVr(90) = 10.747;

AirTableVr(91) = 10.247;
AirTableVr(92) = 9.78;
AirTableVr(93) = 9.337;
AirTableVr(94) = 8.919;
AirTableVr(95) = 8.526;

AirTableVr(96) = 8.153;
AirTableVr(97) = 7.801;
AirTableVr(98) = 7.468;
AirTableVr(99) = 7.152;
AirTableVr(100) = 6.854;

AirTableVr(101) = 6.569;
AirTableVr(102) = 6.301;
AirTableVr(103) = 6.046;
AirTableVr(104) = 5.804;
AirTableVr(105) = 5.574;

AirTableVr(106) = 5.355;
AirTableVr(107) = 5.147;
AirTableVr(108) = 4.949;
AirTableVr(109) = 4.761;
AirTableVr(110) = 4.328;

AirTableVr(111) = 3.994;
AirTableVr(112) = 3.601;
AirTableVr(113) = 3.295;
AirTableVr(114) = 3.022;
AirTableVr(115) = 2.776;

AirTableVr(116) = 2.555;
AirTableVr(117) = 2.356;
AirTableVr(118) = 2.175;
AirTableVr(119) = 2.012;
AirTableVr(120) = 1.864;

vOut = AirTableVr;
end

% S0 (Entropy kJ/kg * K, Reference Absolute Zero)
function vOut = InitAirTableS0()
AirTableS0 = zeros(120, 1); % initialize

AirTableS0(1) = 1.29559;
AirTableS0(2) = 1.34444;
AirTableS0(3) = 1.39105;
AirTableS0(4) = 1.43557;
AirTableS0(5) = 1.47824;

AirTableS0(6) = 1.51917;
AirTableS0(7) = 1.55848;
AirTableS0(8) = 1.59634;
AirTableS0(9) = 1.63279;
AirTableS0(10) = 1.65055;

AirTableS0(11) = 1.66802;
AirTableS0(12) = 1.68515;
AirTableS0(13) = 1.70203;
AirTableS0(14) = 1.71865;
AirTableS0(15) = 1.73498;

AirTableS0(16) = 1.75106;
AirTableS0(17) = 1.7669;
AirTableS0(18) = 1.78249;
AirTableS0(19) = 1.79783;
AirTableS0(20) = 1.8279;

AirTableS0(21) = 1.85708;
AirTableS0(22) = 1.88543;
AirTableS0(23) = 1.91313;
AirTableS0(24) = 1.94001;
AirTableS0(25) = 1.96633;

AirTableS0(26) = 1.99194;
AirTableS0(27) = 2.01699;
AirTableS0(28) = 2.04142;
AirTableS0(29) = 2.06533;
AirTableS0(30) = 2.0887;

AirTableS0(31) = 2.11161;
AirTableS0(32) = 2.13407;
AirTableS0(33) = 2.15604;
AirTableS0(34) = 2.1776;
AirTableS0(35) = 2.19876;

AirTableS0(36) = 2.21952;
AirTableS0(37) = 2.23993;
AirTableS0(38) = 2.25997;
AirTableS0(39) = 2.27967;
AirTableS0(40) = 2.29906;

AirTableS0(41) = 2.31809;
AirTableS0(42) = 2.33685;
AirTableS0(43) = 2.35531;
AirTableS0(44) = 2.37348;
AirTableS0(45) = 2.3914;

AirTableS0(46) = 2.40902;
AirTableS0(47) = 2.42644;
AirTableS0(48) = 2.44356;
AirTableS0(49) = 2.46048;
AirTableS0(50) = 2.47716;

AirTableS0(51) = 2.49364;
AirTableS0(52) = 2.50985;
AirTableS0(53) = 2.52589;
AirTableS0(54) = 2.54175;
AirTableS0(55) = 2.55731;

AirTableS0(56) = 2.57277;
AirTableS0(57) = 2.5881;
AirTableS0(58) = 2.60319;
AirTableS0(59) = 2.61803;
AirTableS0(60) = 2.6328;

AirTableS0(61) = 2.64737;
AirTableS0(62) = 2.66176;
AirTableS0(63) = 2.69013;
AirTableS0(64) = 2.71787;
AirTableS0(65) = 2.74504;

AirTableS0(66) = 2.7717;
AirTableS0(67) = 2.79783;
AirTableS0(68) = 2.82344;
AirTableS0(69) = 2.84856;
AirTableS0(70) = 2.87324;

AirTableS0(71) = 2.89748;
AirTableS0(72) = 2.92128;
AirTableS0(73) = 2.94468;
AirTableS0(74) = 2.9677;
AirTableS0(75) = 2.99034;

AirTableS0(76) = 3.0126;
AirTableS0(77) = 3.03449;
AirTableS0(78) = 3.05608;
AirTableS0(79) = 3.07732;
AirTableS0(80) = 3.09825;

AirTableS0(81) = 3.11883;
AirTableS0(82) = 3.13916;
AirTableS0(83) = 3.15916;
AirTableS0(84) = 3.17888;
AirTableS0(85) = 3.19834;

AirTableS0(86) = 3.21751;
AirTableS0(87) = 3.23638;
AirTableS0(88) = 3.2551;
AirTableS0(89) = 3.27345;
AirTableS0(90) = 3.2916;

AirTableS0(91) = 3.30959;
AirTableS0(92) = 3.32724;
AirTableS0(93) = 3.34474;
AirTableS0(94) = 3.362;
AirTableS0(95) = 3.37901;

AirTableS0(96) = 3.39586;
AirTableS0(97) = 3.41247;
AirTableS0(98) = 3.42892;
AirTableS0(99) = 3.44516;
AirTableS0(100) = 3.4612;

AirTableS0(101) = 3.47712;
AirTableS0(102) = 3.49276;
AirTableS0(103) = 3.50829;
AirTableS0(104) = 3.52364;
AirTableS0(105) = 3.53879;

AirTableS0(106) = 3.55381;
AirTableS0(107) = 3.56867;
AirTableS0(108) = 3.58335;
AirTableS0(109) = 3.5979;
AirTableS0(110) = 3.6336;

AirTableS0(111) = 3.6684;
AirTableS0(112) = 3.7023;
AirTableS0(113) = 3.7354;
AirTableS0(114) = 3.7677;
AirTableS0(115) = 3.7994;

AirTableS0(116) = 3.8303;
AirTableS0(117) = 3.8605;
AirTableS0(118) = 3.8901;
AirTableS0(119) = 3.9191;
AirTableS0(120) = 3.9474;

vOut = AirTableS0;
end


function vOut = InitAirTableK2()
% temperature in Kelvin for source 2 tables
AirTable = zeros(19, 1);
    for iT = 1:19
        AirTable(iT) =  50 + iT*50;
    end
vOut = AirTable;
end

function vOut = InitAirTabledV()
% dV (dynamic viscosity of dry air)
AirTable = zeros(19, 1);

AirTable(1) = 71.1;
AirTable(2) = 103.4;
AirTable(3) = 132.5;
AirTable(4) = 159.6;
AirTable(5) = 184.6;
AirTable(6) = 208.2;
AirTable(7) = 230.1;
AirTable(8) = 250.7;
AirTable(9) = 270.1;
AirTable(10) = 288.4;
AirTable(11) = 305.8;
AirTable(12) = 355.5;
AirTable(13) = 338.8;
AirTable(14) = 354.6;
AirTable(15) = 369.8;
AirTable(16) = 384.3;
AirTable(17) = 398.1;
AirTable(18) = 411.3;
AirTable(19) = 424.4;

vOut = AirTable * 10^-7;
end


function vOut = InitAirTablekV()
%   'kV' = Kinematic Viscosity (m^2/s)
AirTable = zeros(19,1);

AirTable(1) = 2.00;
AirTable(2) = 4.426;
AirTable(3) = 7.590;
AirTable(4) = 11.44;
AirTable(5) = 15.89;
AirTable(6) = 20.92;
AirTable(7) = 26.41;
AirTable(8) = 32.39;
AirTable(9) = 38.79;
AirTable(10) = 45.57;
AirTable(11) = 52.69;
AirTable(12) = 60.21;
AirTable(13) = 68.10;
AirTable(14) = 76.37;
AirTable(15) = 84.93;
AirTable(16) = 93.80;
AirTable(17) = 102.9;
AirTable(18) = 112.2;
AirTable(19) = 121.9;

vOut = AirTable.*10^-6;

end


function vOut = InitializeAirTablePt()
%   'Pt' = Prandlt Number (unitless)
AirTable = zeros(19,1);

AirTable(1) = 0.786;
AirTable(2) = 0.758;
AirTable(3) = 0.737;
AirTable(4) = 0.720;
AirTable(5) = 0.707;
AirTable(6) = 0.700;
AirTable(7) = 0.690;
AirTable(8) = 0.686;
AirTable(9) = 0.684;
AirTable(10) = 0.683;
AirTable(11) = 0.685;
AirTable(12) = 0.690;
AirTable(13) = 0.695;
AirTable(14) = 0.702;
AirTable(15) = 0.709;
AirTable(16) = 0.716;
AirTable(17) = 0.720;
AirTable(18) = 0.723;
AirTable(19) = 0.726;

vOut = AirTable;

end

function vOut = InitAirTablekT()
%   'kT' = Thermal conductivity (W/m*K)
AirTable = zeros(19,1);

AirTable(1) = 9.34;
AirTable(2) = 13.8;
AirTable(3) = 18.1;
AirTable(4) = 22.3;
AirTable(5) = 26.3;
AirTable(6) = 30.0;
AirTable(7) = 33.8;
AirTable(8) = 37.3;
AirTable(9) = 40.7;
AirTable(10) = 43.9;
AirTable(11) = 46.9;
AirTable(12) = 49.7;
AirTable(13) = 52.7;
AirTable(14) = 54.9;
AirTable(15) = 57.3;
AirTable(16) = 59.6;
AirTable(17) = 62.0;
AirTable(18) = 64.3;
AirTable(19) = 66.7;

vOut = AirTable*10^-3;

end





