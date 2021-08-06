clear; clc
obj = daq("ni");
obj.Rate = 100;
obj.addinput("cDAQ1Mod8","ai1","Thermocouple");
obj.addinput("cDAQ1Mod8","ai3","Thermocouple");
        % arda.ni_daq_obj.addinput("cDAQ1Mod8","ai4","Thermocouple");
for j = 1:length(obj.Channels)
    obj.Channels(j).ThermocoupleType = "J";
end
obj.addoutput("cDAQ1Mod3","ao1","Voltage")
k = ones(300*100,1);
readwrite(obj, 10*k)