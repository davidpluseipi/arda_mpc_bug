function run_shutdown(obj,~)

% Static method
%disp('Entry: shutdown')

obj.component1 = false;
obj.component2 = false;
obj.component3 = false;
obj.shutdown_done = true;

%disp('Exit: shutdown')

end