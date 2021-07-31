function [p_s] = calculate_saturation_pressure(T)

if T >= 647.096 || T < 273.15
    
    fprintf(['\nInitial temperature is %.3f K. Valid range in Kelvin is '...
        '273.15 < T < 647.096\n'], T)
    error(['Temperature out of valid range for valid saturation pressure '...
        'calculation.'])
    
else
    
    teta = T - 0.23855557567849 / (T - 650.17534844798);
    A = teta ^ 2 + 1167.0521452767 * teta - 724213.16703206;
    B = -17.073846940092 * teta ^ 2 + 12020.82470247 * teta - 3232555.0322333;
    C = 14.91510861353 * teta ^ 2 - 4823.2657361591 * teta + 405113.40542057;
    p_4 = (2 * C / (-B + (B ^ 2 - 4 * A * C) ^ 0.5)) ^ 4;
    p_s = p_4 * 1000;  % convert to kPa
    
end

end