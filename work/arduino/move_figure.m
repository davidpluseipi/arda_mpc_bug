function move_figure(handle, location)
%% Sets figure position based on predetermined locations
% Source: MATLAB Central
% User: sanderos (26 Nov 2015)
%% 
switch location 
    case 1      
        % right screen middle top
        pos = 1e3*[3.3578    0.6418    0.5600    0.4200];
    case 2      
        % right screen middle bottom
        pos = 1e3*[3.3602    0.1338    0.5600    0.4200];
    case 3
        % right screen far right top
        pos = 1e3*[3.9202    0.6442    0.5600    0.4200];
    case 4
        % right screen far right bottom
        pos = 1e3*[3.9138    0.1226    0.5600    0.4200];
    otherwise
        error('This setting is not defined')
end

set(handle,'Position',pos)

end
%set(0, 'DefaultFigurePosition', Pos);