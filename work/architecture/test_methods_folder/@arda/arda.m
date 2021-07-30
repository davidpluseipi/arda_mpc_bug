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
        air_temp = 20
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
    end
    
    properties 
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
        check4errors(arda)
        obj = do_stuff(obj)
        log_error(arda, er)
    end
    
end