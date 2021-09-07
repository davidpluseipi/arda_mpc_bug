function get_stats(sensor,in1,in2)

arguments
    sensor
    in1 (1,:) char = ''
    in2 (1,1) {mustBeNumericOrLogical} = false
end

sensor.mu = mean(sensor.data.Variables);
sensor.sigma = std(sensor.data.Variables);

if contains(in1,'Figure') && in2 == true
    figure
    histogram(round(sensor.data.Variables))
    ref = randn(1,numel(sensor.data.Variables));
    figure
    plot(sort(sensor.data.Variables), sort(ref)) % q-q plot
end

end