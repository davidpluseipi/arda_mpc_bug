classdef (ConstructOnLoad) responder < handle
    
    properties
        
        listener_emergency
        listener_idle
        listener_prestartup
        listener_selftest
        listener_shutdown
        listener_startup
        
    end
    
    methods
        % Constructor
        function obj = responder(arda_obj)
            arguments
                arda_obj handle
            end
            
            listener_emergency = addlistener(arda_obj, 'emergency',...
                @responder.run_emergency);
            obj.listener_emergency = listener_emergency; % Save listener handle
            
            listener_idle = addlistener(arda_obj, 'idle', ...
                @responder.run_idle);
            obj.listener_idle = listener_idle;
            
            listener_prestartup = addlistener(arda_obj, 'prestartup', ...
                @responder.run_prestartup);
            obj.listener_prestartup = listener_prestartup;
            
            listener_selftest = addlistener(arda_obj, 'selftest', ...
                @responder.run_selftest);
            obj.listener_selftest = listener_selftest;
            
            listener_shutdown = addlistener(arda_obj, 'shutdown', ...
                @responder.run_shutdown);
            obj.listener_shutdown = listener_shutdown;
            
            listener_startup = addlistener(arda_obj, 'startup', ...
                @responder.run_startup);
            obj.listener_startup = listener_startup;
            
        end
        
    end
    
    methods (Static)
        
        run_emergency(obj,~)
        run_idle(obj,~)
        run_prestartup(obj,~)
        run_selftest(obj,~)
        run_shutdown(obj,~)
        run_startup(obj,~)
        
    end
    
end






























