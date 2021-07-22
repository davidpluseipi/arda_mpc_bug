classdef thing_with_boolean_state < handle
    
   properties
      estop {mustBeNumericOrLogical} = false
      speed
      value
   end
   
   events
      toggled_state
   end
   
   methods
       
      function event_data = set2(obj, new_state)
         if new_state ~= obj.state
            obj.state = new_state;
            event_data = provide_data();
            notify(obj, 'toggled_state', event_data);
         else
            event_data = provide_data();
            notify(obj, 'toggled_state', event_data);
         end
      end
      
   end
end