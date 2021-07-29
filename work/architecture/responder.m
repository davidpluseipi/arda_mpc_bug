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
        function obj = responder(thing)
            listener_emergency = addlistener(thing, 'emergency',...
                @responder.run_emergency);
            obj.listener_emergency = listener_emergency; % Save listener handle
            
            listener_idle = addlistener(thing, 'idle', ...
                @responder.run_idle);
            obj.listener_idle = listener_idle;
            
            listener_prestartup = addlistener(thing, 'prestartup', ...
                @responder.run_prestartup);
            obj.listener_prestartup = listener_prestartup;
            
            listener_selftest = addlistener(thing, 'selftest', ...
                @responder.run_selftest);
            obj.listener_selftest = listener_selftest;
            
            listener_shutdown = addlistener(thing, 'shutdown', ...
                @responder.run_shutdown);
            obj.listener_shutdown = listener_shutdown;
            
            listener_startup = addlistener(thing, 'startup', ...
                @responder.run_startup);
            obj.listener_startup = listener_startup;
        end
        
    end
    
    methods (Static)
        % Static method
        function run_emergency(obj,~)
            disp('Entry: emergency')
            obj.component1 = 0;
            obj.component2 = 0;
            obj.component3 = 0;
            obj.emergency_done = true;
            disp('Exit: emergency')
        end
        
        % Static method
        function run_idle(obj,~)
            disp('Entry: idle')
            obj.idle_done = true;
            disp('Exit: idle')
        end
        
        % Static method
        function run_prestartup(obj,~)
            disp('Entry: prestartup')
            obj.computer_power = true;
            obj.component1 = false;
            obj.component2 = false;
            obj.component3 = false;
            obj.prestartup_done = true;
            disp('Exit: prestartup')
        end
        
        % Static method
        function run_selftest(obj,~)
            
            try
                disp('Entry: selftest')
                S = load('self_test.mat','A');
                obj.baseline_data = S.A;
                obj.self_test_data = zeros(1,numel(obj.baseline_data));
                count = 1;
                while ~isequal(obj.self_test_data, obj.baseline_data)
                    % Acquire data
                    for i = 1:10
                        obj.self_test_data(i) = i;
                    end
                    if count >= 3
                        error('medium error')
                    end
                    count = count + 1;
                end
                
            catch er
                i = length(obj.errors)+1;
                obj.errors(i) = {er.message};
            end
            
            obj.selftest_done = true;
            disp('Exit: selftest')
            
        end
        
        % Static method
        function run_shutdown(obj,~)
           disp('Entry: shutdown')
           obj.component1 = false;
           obj.component2 = false;
           obj.component3 = false;
           obj.shutdown_done = true;
           disp('Exit: shutdown')
        end
        
        % Static method
        function run_startup(obj,~)
            disp('Entry: startup')
            obj.component1 = true;
            obj.component2 = true;
            obj.component3 = true;
            S = load('matlab.mat','T');
            obj.alert_table = S.T;
            obj.startup_done = true;
            disp('Exit: startup')
        end
        
    end
    
end






























