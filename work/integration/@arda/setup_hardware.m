function setup_hardware(arda)



if ~arda.simulation_only
       
    %% Setup Arduino
    if arda.using_arduino_hardware
        try
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
        catch er
            warning('Arduino hardware may not be setup correctly.')
            throw(er)
        end
        
    end
    
    %% Setup NI
    if arda.using_ni_hardware
        try
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
            arda.ni_daq_obj.addinput("cDAQ1Mod5","ai1","Voltage")
            
            %% Analog output module
            arda.ni_daq_obj.addoutput("cDAQ1Mod3","ao0","Voltage");
            arda.ni_daq_obj.addoutput("cDAQ1Mod3","ao1","Voltage");
            
        catch er
            
            warning(['Maybe ARDA electronics are not powered on. Or try ',...
                'restarting your system.'])
            throw(er)
        end
    end
    
    %% LIDAR
    if arda.using_lidar
        arda.pipe = realsense.pipeline();
        arda.point_cloud = realsense.pointcloud();
        arda.profile = arda.pipe.start();
    end
    
    %% Load cell
    if arda.using_load_cell
        arda.load_cell_obj = serialport("COM5",9600);
        configureTerminator(arda.load_cell_obj,"CR/LF")
    end
    
end
end