function run_prestartup(obj,~)

% Static method
%disp('Entry: prestartup')
obj.computer_power = true;
obj.component1 = false;
obj.component2 = false;
obj.component3 = false;
obj.prestartup_done = true;
%disp('Exit: prestartup')

end