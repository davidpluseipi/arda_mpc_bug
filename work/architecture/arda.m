classdef arda < handle
    
    properties (SetObservable = true)
        emergency_done = false
        idle_done = false
        prestartup_done = false
        running_done = false
        selftest_done = false
        startup_done = false
        shutdown_done = false
        data

    end
    
    properties
        air_temp = 20
        alert_table
        baseline_data
        computer_power = 0
        component1 = 0
        component2 = 0
        component3 = 0
        self_test_data
        alerts = cell(0,1)
        errors = cell(0,1)
        red_alert = false
        yellow_alert = false
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
        % Ordinary method
        function obj = do_stuff(obj)
            
        end
        
        function check4errors(arda)
            %% Check for errors
            arda.alerts = cell(length(arda.errors), 1);
            
            if arda.selftest_done
                % Check to see if any of the errors show up in the alert table
                if any(cellfun(@(x) ismember(string(x), arda.alert_table{:,1}), arda.errors))
                    for i = 1:length(arda.errors)
                        % Get the alert levels for each error
                        arda.alerts{i} = arda.alert_table{arda.alert_table{:,1} == arda.errors{i}, 2};
                    end
                end
            end
            
            % Handle red alerts
            if any(cellfun(@(x) ismember("red", x), arda.alerts))
                arda.red_alert = true;
                notify(bob, 'emergency')
            end
            
            % Handle yellow alerts
            if any(cellfun(@(x) ismember("yellow", x), arda.alerts))
                arda.yellow_alert = true;
                notify(arda, 'shutdown')
            end
            
        end
    end
    
end