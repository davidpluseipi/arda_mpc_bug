function live_plot(ax,x,y)
%% Plots x,y data in blue dots
% Inputs:
%   h: figure handle
%   x: independent variable
%   y: dependent variable
%
% Outputs:
%   status: success or failure to plot
%
% Copyright, David Meissner 2021
%%
hold on
plot(ax,x,y,'.b')

end