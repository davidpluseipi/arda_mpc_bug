function setup_hardware(arda)
if ~arda.simulation_only
    %% Setup Arduino
    if arda.using_arduino_hardware
        arda.arduino_daq_obj = arduino('COM4' ,'Uno', 'Libraries',...
            {'Adafruit/DHT22'});
        
        if strcmp(arda.heater,'arduino')
            % Heater
            configurePin(arda.arduino_daq_obj,'D2','DigitalOutput');
        end
        
        configurePin(arda.arduino_daq_obj,'D6','DigitalOutput'); % light
        
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
            arda.ni_daq_obj.Channels(j).ThermocoupleType = "K";
        end
        
        %% Analog input module
        arda.ni_daq_obj.addinput("cDAQ1Mod5","ai0","Voltage")
        
        %% Analog output module
        arda.ni_daq_obj.addoutput("cDAQ1Mod3","ao1","Voltage");
    end
end
end