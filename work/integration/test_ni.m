clear; clc; close all
obj = daq("ni");
obj.Rate = 100;
obj.addinput("cDAQ1Mod8","ai1","Thermocouple");
obj.addinput("cDAQ1Mod8","ai3","Thermocouple");
% arda.ni_daq_obj.addinput("cDAQ1Mod8","ai4","Thermocouple");
for i = 1:length(obj.Channels)
    obj.Channels(i).ThermocoupleType = "K";
end

% For NI9263 analog outputs, even numbers are high,
% and odd number pins are ground/common
obj.addoutput("cDAQ1Mod3","ao1","Voltage")

b = 60;
V = 10;
u1 = ones(b/2,1);
u2 = zeros(b/2,1);
voltage = V*[u1; u2];
output = zeros(length(voltage),3);
ts = tic;
k = ones(100, 1); % column vector
i = 1;
while toc(ts) < b
    write(obj, voltage(i));
    data = read(obj);
    output(i,1) = data.cDAQ1Mod8_ai1;
    output(i,2) = data.cDAQ1Mod8_ai3;
    output(i,3) = voltage(i);
    disp(i)
    disp(output(i,:))
    i = i + 1;
end
plot(output)