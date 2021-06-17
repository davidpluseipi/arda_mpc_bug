function [yss2] = filter_stuff(y, Fs)
%% Reference: Matlab Central 
% Originally coded by: Mathieu Noe
%Fs = 100;
samples = length(y);
dt = 1/Fs;
t = (0:samples-1)*dt;
%%%%%%%%%%%%%%%%
% smart filter V2 : simple first order low pass filter (2 stages in series),
% the filtering effect is increased with signal amplitude in 3 discrete steps
% like filtfilt, the filtering is applied once in forward time and back in
% reversed time to cancel phase lag
threshold1 = 0.05;  smoothing_factor1 = 0.90; %0.65;
threshold2 = 0.5;   smoothing_factor2 = 0.85;
% forward filering (2 stage in series of first order filter)
y_norm = abs(y)./max(y); % signal normalization (for flter parameters usage)
alpha = zeros(size(y));
alpha(y_norm>threshold1) = smoothing_factor1;
alpha(y_norm>threshold2) = smoothing_factor2;
ys = zeros(size(y));
ys2 = zeros(size(y));
ys(1) = y(1);
ys2(1) = ys(1);
for ci = 2:samples
    ys(ci) = alpha(ci).*ys(ci-1)  + (1-alpha(ci)).*y(ci);
    ys2(ci) = alpha(ci).*ys2(ci-1)  + (1-alpha(ci)).*ys(ci);
end
clear ys
% backward filtering (2 stage in series of first order filter)
y_norm = abs(ys2)./max(ys2); % signal normalization (for flter parameters usage)
alpha = zeros(size(y));
alpha(y_norm>threshold1) = smoothing_factor1;
alpha(y_norm>threshold2) = smoothing_factor2;
yss = zeros(size(y));
yss(1) = ys2(samples);
yss2(1) = yss(1);
for ci = 2:samples
    yss(ci) = alpha(samples-ci+1).*yss(ci-1)  + (1-alpha(samples-ci+1)).*ys2(samples-ci+1);
    yss2(ci) = alpha(samples-ci+1).*yss2(ci-1)  + (1-alpha(samples-ci+1)).*yss(ci);
end
clear yss
yss2 = yss2(end:-1:1);
%figure
  % plot(t,y,t,ys2,t,yss2);legend('Raw','Smoothed fw','Smoothed fw + bckward');
%subplot(2,1,1)
%plot(t,y,t,yss2)
%legend('Raw','Smoothed');
%title(['Data samples at Fs = ' num2str(round(Fs)) ' Hz / Smoothed with home made filter' ]);
%grid on

% subplot(2,1,2)
% plot(t,alpha)
% legend('alpha');
% grid on

end