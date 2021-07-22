classdef (ConstructOnLoad) provide_data < event.EventData
    properties
        time
    end
    
    methods
        function data = provide_data()
            pause(2)
            data.time = datetime("now");
        end
    end
end