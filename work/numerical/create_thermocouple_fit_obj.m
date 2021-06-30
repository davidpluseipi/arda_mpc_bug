function [thermocouple_fit_obj, gof] = create_thermocouple_fit_obj(type)
%     x = 0:0.1:1.6; % mV
%     m = 24.81;
%     b = 0.1321;
%     y = m*x + b;

switch type
    case 'K'
        % Table data in mV for K type thermocouple
        % https://www.pyromation.com/Downloads/Data/emfk_c.pdf
        x=[0 0.039 0.079 0.119 0.158 0.198 0.238 0.277 0.317 0.357 0.397 ...
             0.437 0.477 0.517 0.557 0.597 0.637 0.677 0.718 0.758 0.798 ...
             0.838 0.879 0.919 0.960 1.000 1.041 1.081 1.122 1.163 1.203 ...
             1.244 1.285 1.326 1.366 1.407 1.448 1.489 1.530 1.571 1.612];
                
    case 'J'
        x=[0 0.050 0.101 0.151 0.202 0.253 0.303 0.354 0.405 0.456 0.507 ...
             0.558 0.609 0.660 0.711 0.762 0.814 0.865 0.916 0.968 1.019 ...
             1.071 1.122 1.174 1.226 1.277 1.329 1.381 1.433 1.485 1.537 ...
             1.589 1.641 1.693 1.745 1.797 1.849 1.902 1.954 2.006 2.059];
                
end
y = 0:length(x)-1;
%[x_data, y_data] = prepareCurveData(x, y);
ft = fittype('poly8');
[thermocouple_fit_obj, gof] = fit(x', y', ft);

save thermocouple_fit_obj.mat thermocouple_fit_obj gof

figure
plot(thermocouple_fit_obj, x, y)
title('Specific Heat J/(kg K) vs Temp (K)')

end