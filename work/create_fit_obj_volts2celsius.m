function [thermocouple_fit_obj, gof] = create_fit_obj_volts2celsius()
%     x = 0:0.1:1.6; % mV
%     m = 24.81; 
%     b = 0.1321; 
%     y = m*x + b;
    
    % Table data in mV for K type thermocouple
    % https://www.pyromation.com/Downloads/Data/emfk_c.pdf
    x = [0 0.039 0.079 0.119 0.158 0.198 0.238 0.277 0.317 0.357 0.397];
    y = 0:10;
    x = [x 0.437 0.477 0.517 0.557 0.597 0.637 0.677 0.718 0.758 0.798];
    y = [y 11:20];
    x = [x 0.838 0.879 0.919 0.960 1.000 1.041 1.081 1.122 1.163 1.203];
    y = [y 21:30];
    x = [x 1.244 1.285 1.326 1.366 1.407 1.448 1.489 1.530 1.571 1.612];
    y = [y 31:40];
    
    
    %[x_data, y_data] = prepareCurveData(x, y);
    ft = fittype('poly1');
    [thermocouple_fit_obj, gof] = fit(x', y', ft);
    
    save thermocouple_volts2celsius.mat thermocouple_fit_obj gof
    
    figure
    plot(thermocouple_fit_obj, x, y)
    title('Specific Heat J/(kg K) vs Temp (K)')
    
end