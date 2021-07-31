function [output] = arda_numerical(settings)
%% [output] = arda_numerical(settings)
% Inputs:
%   A structure with the following fields:
%   setpoints       : Structure with the following fields:
%       T           : Temperature setpoint (C)
%       phi         : Relative humidity setpoint (%)
%   T_g0_sim        : Initial gas mixture temperature for simulations (C)
%   T_o             : Outside (ambient) temperature (C)
%   T_h0            : Initial temperature of the heater (C)
%   T_s             : Length of time step (s)
%   N               : Number of steps
%   off             : Iteration at which to stop the simulation
%   simulation      : Indicator to run simulation or include hardware (T/F)
%   ni              : Indicator to include NI hardware (T/F)
%   arduino         : Indicator to include Arduino hardware (T/F)
%
% Outputs:
%   output          : A table with the following variables
%       T_g         : Temperature of the gas mixture (C)
%       T_h         : Temperature of the heater (C)
%       T_o         : Outside (ambient) temperature (C)
%       p_v         : Partial pressure of vapor (kPa)
%       p_a         : Partial pressure of dry air (kPa)
%       q           : Unused
%       phi         : Relative Humidity (%)
%       p_s         : Saturation Vapor Pressure of gas mixture (kPa)
%       P_h         : Power setting of the heater (commanded) 
%
% Example:
% settings = struct(...
%     'delta_T', 20,...
%     'T_o', 30,...
%     'T_h0', 50,...
%     'T_s', 1,...
%     'N', 180,...
%     'off', 1e6,...
%     'simulation', false,...
%     'ni', true,...
%     'arduino', false);
%
% data = arda_numerical(settings);
%
%% Setup Arduino

%% Setup Hardware






%% Do Everything
set(0,'DefaultFigureWindowStyle','docked')






set(0,'DefaultFigureWindowStyle','normal')





































