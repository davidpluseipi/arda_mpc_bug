classdef calculator < handle
   
    properties (SetObservable = true)
        done {mustBeNumericOrLogical} = false
    end
    
    properties
        data {mustBeVector} = 0:10
        result {mustBeNumeric}
    end
    
    methods
        function obj = change_stuff(obj)
            obj.result = mean(obj.data);
            obj.done = true;
            pause(3)
        end
    end
    
end