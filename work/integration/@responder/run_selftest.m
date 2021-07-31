function run_selftest(obj,~)

% Static method
try
    disp('Entry: selftest')
    S = load('load4selftest.mat','A');
    obj.baseline_data = S.A;
    obj.selftest_data = zeros(1,numel(obj.baseline_data));
    count = 1;
    while ~isequal(obj.selftest_data, obj.baseline_data)
        % Acquire data
        for i = 1:10
            if ~obj.fail_selftest
                obj.selftest_data(i) = i;
            else
                obj.selftest_data(i) = 0.9*i;
            end
        end
        if count >= 3
            error('medium error')
        end
        count = count + 1;
    end
    
catch er
    obj.log_error(er.message)
end

obj.selftest_done = true;
disp('Exit: selftest')

end