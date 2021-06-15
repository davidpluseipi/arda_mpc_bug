function [specific_heat_fit_obj, gof] = calculate_specific_heat_air()
    temp_data = 273.15 + [0:5:50, 60:10:100, 120:20:200]';
    c_data = [1006*ones(1,3) 1007*ones(1,10) 1008*ones(1,2) 1009 1011 1013 ...
        1016 1019 1023]';
    
    [xData, yData] = prepareCurveData(temp_data, c_data);
    ft = fittype( 'poly8' );
    [specific_heat_fit_obj, gof] = fit(xData, yData, ft, 'Normalize', 'on' );
    
    save specific_heat_table.mat specific_heat_fit_obj gof
    
    figure
    plot(specific_heat_fit_obj, temp_data, c_data)
    title('Specific Heat J/(kg K) vs Temp (K)')
    
end