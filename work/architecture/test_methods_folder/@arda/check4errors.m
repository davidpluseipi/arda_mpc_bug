function arda = check4errors(arda)
%% Check for errors
arda.alerts = cell(length(arda.errors), 1);

if arda.selftest_done
    % Check to see if any of the errors show up in the alert table
    if any(cellfun(@(x) ismember(string(x), arda.alert_table{:,1}), arda.errors))
        for i = 1:length(arda.errors)
            % Get the alert levels for each error
            arda.alerts{i} = arda.alert_table{arda.alert_table{:,1} == arda.errors{i}, 2};
        end
        take_action();
    end
end


function take_action()
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