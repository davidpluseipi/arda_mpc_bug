function setup_hardware(arda)
if ~arda.simulation_only
    %% Setup Arduino
    if arda.using_arduino_hardware
        arda.arduino_daq_obj = arduino('COM4' ,'Uno', 'Libraries',...
            {'Adafruit/DHT22'});
        
        % Heater
        configurePin(arda.arduino_daq_obj,'D2','DigitalOutput');
        
        % Temperature / Humidity
        arda.sensor_dht22 = addon(arda.arduino_daq_obj, 'Adafruit/DHT22',...
            'A0');
    end
    
    %% Setup NI
    if arda.using_ni_hardware
        arda.ni_daq_obj = daq("ni");
        arda.ni_daq_obj.Rate = 100;
        arda.ni_daq_obj.addinput("cDAQ1Mod8","ai1","Thermocouple");
        arda.ni_daq_obj.addinput("cDAQ1Mod8","ai3","Thermocouple");
        % arda.ni_daq_obj.addinput("cDAQ1Mod8","ai4","Thermocouple");
        for j = 1:length(arda.ni_daq_obj.Channels)
            arda.ni_daq_obj.Channels(j).ThermocoupleType = "J";
        end
    end
end
end