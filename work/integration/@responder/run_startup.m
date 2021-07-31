function run_startup(obj,~)

% Static method
disp('Entry: startup')
obj.component1 = true;
obj.component2 = true;
obj.component3 = true;
S = load('load4startup.mat','alert_table');
obj.alert_table = S.alert_table;
obj.startup_done = true;
disp('Exit: startup')

end