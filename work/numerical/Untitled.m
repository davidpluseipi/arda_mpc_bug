clear; clc
load('component_data.mat','component_data')
for i = 35:35
    if sum(contains(component_data.name, component_data.name(i))) ~= 1
        error('Variable names differ between the Excel and MATLAB.')
    end
end
%%
starting_row = 20;
n_variables = 11;
variable_names = cell(1,n_variables);
str = '';
str1 = '[0],';
str2 = '[0]';
last_row = starting_row + n_variables - 1;
for i = starting_row : last_row
    variable_names{i} = component_data.name{i};
    if i ~= last_row
        str = strcat(str, str1);
    else
        str = strcat(str, str2);
    end
end
save('component_data.mat','component_data','variable_names');
r = 30;
input = timetable(zeros(r,1),zeros(r,1),zeros(r,1),zeros(r,1),zeros(r,1),...
    zeros(r,1),zeros(r,1),zeros(r,1),zeros(r,1),zeros(r,1),zeros(r,1),...
    'VariableNames', variable_names(starting_row : starting_row + n_variables - 1),...
    'RowTimes', NaT(r,1));
input.Time.Format = 'yyyy-MM-dd HH:mm:ss.SSS';
i = 1;
s = RandStream('mt19937ar','Seed','shuffle');
t_start = tic;
while toc(t_start) < 60
   input.Time(i) = datetime('now');
   input.("Mass Flow Meter")(i) = randn(s);
   input.("Air Temp RTD")(i) = 2*randn(s);
   input.("Absolute Pressure Sensor")(i) = 3*randn(s);
   if i == r
       break
   end
   i = i + 1;
   pause(1)
end
head(input,5)
m = memory;
fprintf('used: %f\n', m.MemUsedMATLAB)
fprintf('available: %f\n', m.MaxPossibleArrayBytes)
fprintf('remaining: %f\n', m.MaxPossibleArrayBytes - m.MemUsedMATLAB)