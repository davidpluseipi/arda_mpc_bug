function define_constants(arda)

arda.R_a = 287.058;      % J/(kg*K), Specific Gas Constant, dry air
arda.R_v = 461.495;      % J/(kg*K), Specific Gas Constant, water vapor
arda.R_go = 0.03;        % K/W, Thermal resistance of the gas mixture to outside interface (1 inch insulation)
arda.R_hg = 0.005;       % K/W, Thermal resistance of the heater to gax mixture interface

% Create a vector for specific heat of air
% Ref: https://www.me.psu.edu/cimbala/me433/Links/Table_A_9_CC_Properties_of_Air.pdf
if exist('specific_heat_table.mat', 'file')
    S = load('specific_heat_table.mat','specific_heat_fit_obj');
    arda.specific_heat_fit_obj = S.specific_heat_fit_obj;
else
    [arda.specific_heat_fit_obj, ~] = calculate_specific_heat_data();
end


end