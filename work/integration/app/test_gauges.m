bob = arda();
app = gauges();
for i = 1:30
    pause(1)
    bob.T_g = 273.15 + i;
    bob.T_h = 275.15 + i;
    bob.P_h(i) = i/3;
    app.AirCGauge.Value = bob.T_g - 273.15;
    app.HeaterCGauge.Value = bob.T_h - 273.15;
    app.PowerVGauge.Value = bob.P_h(i);
end