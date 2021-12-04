function T = make_smooth_step(step_time, initial_value, final_value, Ts,...
    simulation_stop_time, variable_str)

persistent plotted

a = (final_value - initial_value)/2;
xc = 4 + step_time;

yc = initial_value + a;
time = 0 : Ts : simulation_stop_time;
data = a * tanh(time - xc) + yc;
data = data - abs(initial_value - data(1));
T = timetable(seconds(time'),data','VariableNames',{variable_str});


% if isempty(plotted) || plotted <= 3
%     figure
%     plot(T.Time, T.(variable_str))
%     grid on
%     title(variable_str)
% 
%     if isempty(plotted)
%         plotted = 1;
%     else
%         plotted = plotted + 1;
%     end
% end

end