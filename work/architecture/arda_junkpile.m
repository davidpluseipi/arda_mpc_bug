classdef arda_junkpile < handle
    properties
        computer_power {mustBeNumericOrLogical} = 1
        sensors {isstruct} = struct('sensor1', 0, 'sensor2', 0)
        blower_power {mustBeNumericOrLogical} = 0
        startup_done {mustBeNumericOrLogical} = 0
        self_test_done {mustBeNumericOrLogical} = 0
        arda_shutdown_done {mustBeNumericOrLogical} = 0
        emergency_procedures_done {mustBeNumericOrLogical} = 0
        errors {iscell} = cell(0,1)
    end
    
    events
        startup_complete
        self_test_complete
        run_complete
        beginning_shutdown
        arda_shutdown_complete
        beginning_emergency_procedures
        emergency_procedures_complete
        issue
    end
    
    methods
        function T = startup(obj)
            try
            disp('Entering State: startup')
            obj.sensors.sensor1 = true;
            obj.sensors.sensor2 = true;
            obj.blower_power = true;
            S = load('matlab.mat','T');
            T = S.T; % alert table (matches small, medium, and large errors with green, yellow, and red)
            error('medium error') % INSERTED ERROR
            catch er
                obj.logit(er)
            end
            notify(obj,'startup_complete')
        end
        
        function self_test(obj)
            try
                disp('Entering State: self_test')
                % Load baseline
                S = load('self_test.mat','A');
                % Acquire data
                A2 = [1:9, 9];
                if ~isequal(S.A, A2)
                    error('large error')
                end
            catch er
                obj.logit(er)
            end
            notify(obj,'self_test_complete')
        end
        
        function emergency(obj)
            notify(obj,'beginning_emergency_procedures')
            disp('Entering State: emergency')
            obj.blower_power = 0;
            obj.computer_power = 0;
            notify(obj,'emergency_procedures_complete')
            
            return
        end
        
        function shutdown(obj)
            notify(obj,'beginning_shutdown')
            disp('Entering State: shutdown')
            f = fieldnames(obj.sensors);
            
            for i = 1:length(f)
                obj.sensors.f(i) = 0;
            end
            
            obj.blower_power = 0;
            % Save all data
            notify(obj,'arda_shutdown_complete')
        end
        
        function logit(obj, er)
            obj.errors = [obj.errors; {er.message}];
        end
    end
    
end