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
        function obj = get_stats(obj,in1,in2)
            arguments
                obj
                in1 (1,:) char = ''
                in2 (1,1) {mustBeNumericOrLogical} = false
            end
            
            obj.mu = mean(obj.data.Variables);
            obj.sigma = std(obj.data.Variables);
            
            if contains(in1,'Figure') && in2 == true
                figure
                histogram(round(obj.data.Variables))
                ref = randn(1,numel(obj.data.Variables));
                figure
                plot(sort(obj.data.Variables), sort(ref)) % q-q plot
            end
            
        end
    end
end