classdef arda < handle
    
    properties (SetObservable = true)
        listener_emergency
        listener_idle
        listener_off
        listener_self_test
        listener_startup
        %
        emergency_done
        idle_done
        off_done
        running_done
        self_test_done
        startup_done
        shutdown_done
    end
    
    properties
        air_temp
        alert_table
        baseline_data
        computer_power = 0
        component1 = 0
        component2 = 0
        component3 = 0
        self_test_data
    end
    
    events
        emergency
        idle
        off
        running
        self_test
        startup
        shutdown
    end
    
    methods
        function obj = arda()
            listener_emergency = addlistener(obj, 'emergency',...
                @arda.run_emergency);
            obj.listener_emergency = listener_emergency;
            
            listener_idle = addlistener(obj, 'idle',...
                @arda.run_idle);
            obj.listener_idle = listener_idle;
            
            listener_off = addlistener(obj, 'off',...
                @arda.run_off);
            obj.listener_off = listener_off;
            
            listener_self_test = addlistener(obj, 'self_test',...
                @arda.run_self_test);
            obj.listener_self_test = listener_self_test;
            
            listener_startup = addlistener(obj, 'startup',...
                @arda.run_startup);
            obj.listener_startup = listener_startup;
        end
        
        function obj = check_stuff(obj,~)
            obj.air_temp = obj.air_temp + 20;
            if obj.air_temp >= 200
                obj = arda.run_emergency;
            end
        end
    end
    
    methods (Static = true)
        function obj = run_emergency(obj,~)
            disp('Entry: emergency')
            obj.component1 = 0;
            obj.component2 = 0;
            obj.component3 = 0;
            obj.emergency_done = true;
            disp('Exit: emergency')
        end
        
        function obj = run_idle(obj,~)
            disp('Entry: idle')
            obj.idle_done = true;
            disp('Exit: idle')
        end
        
        function obj = run_off(obj,~)
            disp('Entry: off')
            obj.computer_power = 1;
            obj.component1 = 0;
            obj.component2 = 0;
            obj.component3 = 0;
            obj.off_done = true;
            disp('Exit: off')
        end
        
        function obj = run_self_test(obj,~)
            disp('Entry: self_test')
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
                    error('Self test failed to acquire data to mactch the baseline.')
                end
                count = count + 1;
            end
            obj.self_test_done = true;
            disp('Exit: self_test')
        end
               
        function obj = run_startup(obj,~)
            disp('Entry: startup') 
            obj.component1 = 1;
            obj.component2 = 1;
            obj.component3 = 1;
            S = load('matlab.mat','T');
            obj.alert_table = S.T;
            obj.startup_done = 1;
            disp('Exit: startup') 
        end
    end
    
end