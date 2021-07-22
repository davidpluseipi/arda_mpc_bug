classdef thing_that_responds < handle
    
   properties
      listener_handle % Property for listener handle
   end
   
   methods
      function obj = thing_that_responds(thing_with_boolean_state)
         the_listener_handle = addlistener(thing_with_boolean_state, 'toggled_state',...
             @thing_that_responds.handle_event);
         obj.listener_handle = the_listener_handle; % Save listener handle
      end
   end
   
   methods (Static)
       
      function handle_event(src,~)
         if src.state
            disp('Output from object of class thing_that_responds:')
            disp('toggled_state event has occurred. State of thing_with_boolean_state object is true.')
            emergency
         else
            disp('Output from object of class thing_that_responds:')
            disp('toggled_state event has occurred. State of thing_with_boolean_state object is false.')
         end
      end
      
   end
   
end