classdef (ConstructOnLoad) responder < handle
    
   properties
      listener_handle1 
      lh2
      lh3
      lh4
      lh5
      lh6
      lh7
   end
   
   methods
      function obj = responder(thing)
         the_listener_handle = addlistener(thing, 'startup_complete',...
             @responder.startup_exit);
         obj.listener_handle1 = the_listener_handle; % Save listener handle
         
         lh2 = addlistener(thing, 'self_test_complete', ...
             @responder.self_test_exit);
         obj.lh2 = lh2;
         
         lh3 = addlistener(thing, 'beginning_emergency_procedures', ...
             @responder.emergency_entry);
         obj.lh3 = lh3;
         
         lh4 = addlistener(thing, 'emergency_procedures_complete', ...
             @responder.emergency_exit);
         obj.lh4 = lh4;
         
         lh5 = addlistener(thing, 'beginning_shutdown', ...
             @responder.shutdown_entry);
         obj.lh5 = lh5;
         
         lh6 = addlistener(thing, 'arda_shutdown_complete', ...
             @responder.shutdown_exit);
         obj.lh6 = lh6;
         
         lh7 = addlistener(thing, 'issue', @responder.f3);
         obj.lh7 = lh7;
      end
   end
   
   methods (Static)
       
      function startup_exit(obj,~)
          obj.startup_done = true;
          disp('Exiting State: startup')
      end
      
      function self_test_exit(obj,~)
          obj.self_test_done = true;
          disp('Exiting State: self_test')
      end
      
      function emergency_entry(~,~)
          for i = 1:3
              beep
              pause(0.5)
          end
          disp('Entering State: emergency')
      end
      
      function emergency_exit(obj,~)
          obj.emergency_procedures_done = true;
          disp('Exiting State: emergency')
      end
      
      function shutdown_entry(~,~)
          for i = 1:2
              beep
              pause(.5)
          end
     
      end
      
      function shutdown_exit(obj,~)
         obj.arda_shutdown_done = true;
         disp('Exiting State: shutdown')         
      end
      
   end
   
end






























