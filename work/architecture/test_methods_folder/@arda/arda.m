classdef arda < handle
    
    properties (SetObservable = true)
        emergency_done = false
        idle_done = false
        prestartup_done = false
        running_done = false
        selftest_done = false
        startup_done = false
        shutdown_done = false
    end
    
    properties
        alert_table
        baseline_data
        computer_power = 0
        component1 = 0
        component2 = 0
        component3 = 0
        selftest_data
        alerts = cell(1,0)
        errors = cell(1,0)
        red_alert = false
        yellow_alert = false
        idx {mustBeNumeric}
        parallel
        pool
    end
    
    properties
        air_temp = 20
    end
    
    properties
        fail_overtemp = false
        fail_selftest = false
    end
    
    events
        emergency
        idle
        prestartup
        running
        selftest
        startup
        shutdown
    end
    
    methods
        % Constructor
        function obj = arda()
            if nargin ~= 0
                error('arda class accepts 0 arguments.')
            end
        end
        
        check4errors(arda)
        obj = do_stuff(obj)
        log_error(arda, er)
    end
    
end