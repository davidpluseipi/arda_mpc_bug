function output = capture_data(p, total_time)
%% DAQ Setup

% Create and modify the DAQ object
ni_daq_obj = daq("ni");
ni_daq_obj.Rate = 100;
ni_daq_obj.addinput("cDAQ1Mod8","ai1","Thermocouple");
ni_daq_obj.addinput("cDAQ1Mod8","ai3","Thermocouple");
for j = 1:length(ni_daq_obj.Channels)
    ni_daq_obj.Channels(j).ThermocoupleType = "J";
end

%% Capture Data

% Preallocate memory for the timetable
TT = timetable(NaT(total_time,1),...
    zeros(total_time,1), zeros(total_time,1),...
    'VariableNames', {'T_g', 'T_h'});

% Capture the data for the desired amount of time
t = datetime('now');
i = 1;
while datetime('now') - t < duration(0,0,total_time)
    
    daq_data = read(ni_daq_obj);  % takes about a second
    TT.T_g(i) = daq_data.cDAQ1Mod8_ai1;
    TT.T_h(i) = daq_data.cDAQ1Mod8_ai3;
    send(p, TT.T_g(i))
    send(p, TT.T_h(i))
    TT.Time(i) = datetime('now');
    i = i + 1;
    
end
output = TT;
end