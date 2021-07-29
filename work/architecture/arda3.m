classdef arda3 < handle
   
    properties (SetObservable = true)
        listener_handle
        done
        time_done
    end
    
    properties
        data {mustBeVector} = 0:10
        result {mustBeNumeric}
    end
    
    events
       emergency 
    end
        
    methods
        function obj = arda3()
            listener_handle = addlistener(obj, 'emergency',...
                @arda3.do_emergency_procedures);
            obj.listener_handle = listener_handle;
        end
        
        function obj = check_stuff(obj, Q)
            obj.result = max(obj.data);
            pause(0.2)
            obj.done = true;
            send(Q, obj)
        end
    end
    
    methods (Static = true)
        function do_emergency_procedures(obj,~)
            disp('emergency procedures complete') 
            obj.time_done = datetime('now');
        end
    end
    
end