classdef sensor < handle
    properties
        data 
        mu      (1,1) {mustBeNumeric}
        sigma   (1,1) {mustBeNumeric}
        start
        stop
        wire    (1,:) 
        raw
        description (1,:) 
    end
    
    methods
        function obj = sensor()
            
        end
        
        get_stats(sensor,in1,in2)
    end
end