classdef (ConstructOnLoad) provide_data < event.EventData
    properties
        A
        time
        i
    end
    
    methods
        function data = provide_data()
            data.time = datetime("now");
            data.A = 1:5;
        end
    end
end