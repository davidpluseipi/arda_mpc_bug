function [bob] = fake_main(bob, options)
%% [ARDA_OBJ] = MAIN(ARDA_OBJ) runs the aRDA with preselected options.
arguments
    bob
    options.app
end

if bob.using_app && ~isempty(options.app)

    app = options.app;

else

    app = arda_app();
    app.RunButton.Enable = "off";
    app.CreateNewButton.Enable = "off";
    app.LoadExistingButton.Enable = "off";
    app.EditCurrentButton.Enable = "off";
    app.HeaterDropDown.Value = bob.heater;
    app.max_iterationsEditField_2.Value = bob.max_iterations;
    app.LivePlotCheckBox.Value = bob.live_plot;
    app.SimulationonlyCheckBox.Value = bob.simulation_only;
    app.UsingArduinoHardwareCheckBox.Value = bob.using_arduino_hardware;
    app.UsingNIHardwareCheckBox.Value = bob.using_ni_hardware;
    app.ProgressBarCheckBox.Value = bob.progress_bar;
    app.UsingLIDARCheckBox.Value = bob.using_lidar;
    app.UsingRHsensorCheckBox.Value = bob.using_relative_humidity_sensor;
    app.UsingloadcellCheckBox.Value = bob.using_load_cell;

end

t = 1:bob.max_iterations;
y = t;
app.more_sensors_app.UIAxes.XLim = [0 bob.max_iterations];
app.more_sensors_app.UIAxes.YLim = [0 max(y)];

for i = 1:bob.max_iterations

    plot(app.more_sensors_app.UIAxes, t(i), y(i))
    pause(0.1)

end

end