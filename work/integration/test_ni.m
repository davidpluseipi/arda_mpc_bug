%%
clear; clc; close all
obj = daq("ni");
obj.Rate = 100;

% %% Temperature input module
% obj.addinput("cDAQ1Mod8","ai1","Thermocouple");
% obj.addinput("cDAQ1Mod8","ai3","Thermocouple");
% % arda.ni_daq_obj.addinput("cDAQ1Mod8","ai4","Thermocouple");
% for i = 1:length(obj.Channels)
%     obj.Channels(i).ThermocoupleType = "K";
% end
% 
% %% Analog input module
obj.addinput("cDAQ1Mod5","ai1","Voltage")

%% Analog output module
% For NI9263 analog outputs, even numbers are high,
% and odd number pins are ground/common
%obj.addoutput("cDAQ1Mod3","ao0","Voltage")
%obj.addoutput("cDAQ1Mod3","ao1","Voltage")

% digital out
obj.addoutput("cDAQ1Mod1","port0/line0","Digital")

%% Setup
% b = obj.Rate*60;
% V = [10 5];
% u1 = ones(round(b/2),1);
% u2 = zeros(round(b/2),1);
% voltage = [V(1)*u1; V(2)*u1];
% output = zeros(length(voltage),3);
% ts = tic;
% k = ones(2, 1); % column vector
% i = 1;
%data = read(obj, 60);
%% Loop
% while toc(ts) < b
k = 0
a = ones(100,1);
A = [k*a;
     0*a;
     k*a;
     0*a;
     k*a;
     0*a;
     k*a;
     0*a;
     k*a;
     0*a;
     0*a;
     0*a;
     0*a;
     0*a;
     0*a;
     0*a;
     0*a;
     0*a;
     0*a;
     0*a;];
 while true
    data = readwrite(obj, A);
 end
%     output(i,1) = data.cDAQ1Mod8_ai1;
%     output(i,2) = data.cDAQ1Mod8_ai3;
%     output(i,3) = voltage(i);
%     output(i,4) = data.cDAQ1Mod5_ai0;
%     disp(i)
%     disp(output(i,:))
%     i = i + 1;
% end
% stackedplot(data)
% save run_4.mat