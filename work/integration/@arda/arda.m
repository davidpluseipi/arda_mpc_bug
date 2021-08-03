classdef arda < handle
    
    properties % constants
        constants (1,4) {isvector}
        R_a (1,1) {mustBeNumeric}
        R_v (1,1) {mustBeNumeric}
        R_go (1,1) {mustBeNumeric}
        R_hg (1,1) {mustBeNumeric}
    end
    
    properties % controls
        pid (1,1) {isobject}
        pid_phi (1,1) {isobject}
    end
    
    properties (SetObservable = true)
        emergency_done (1,1) {mustBeNumericOrLogical} = false
        idle_done (1,1) {mustBeNumericOrLogical} = false
        prestartup_done (1,1) {mustBeNumericOrLogical} = false
        running_done (1,1) {mustBeNumericOrLogical} = false
        selftest_done (1,1) {mustBeNumericOrLogical} = false
        startup_done (1,1) {mustBeNumericOrLogical} = false
        shutdown_done (1,1) {mustBeNumericOrLogical} = false
    end
    
    properties
        alert_table {istable}
        baseline_data {isvector}
        computer_power (1,1) {mustBeNumericOrLogical} = false
        component1 (1,1) {mustBeNumericOrLogical} = false
        component2 (1,1) {mustBeNumericOrLogical} = false
        component3 (1,1) {mustBeNumericOrLogical} = false
        selftest_data {isvector}
        alerts {iscell} = cell(1,0)
        errors {iscell} = cell(1,0)
        red_alert (1,1) {mustBeNumericOrLogical} = false
        yellow_alert (1,1) {mustBeNumericOrLogical} = false
        idx (1,1) {mustBeNumeric} = 1
        parallel (1,1) {mustBeNumericOrLogical} = false;
        pool
        fig
        dialog_box
        specific_heat_fit_obj {isobject}
        draw_times
        arduino_daq_obj {isobject}
        sensor_dht22 {isobject}
        ni_daq_obj {isobject}
    end
    
    properties % gas mixture and simulation
        x_0 (12,1) {mustBeNumeric} = zeros(12,1)
        m_a (1,1) {mustBeNumeric}
        
        m_v (1,1) {mustBeNumeric}
        p_a (1,1) {mustBeNumeric}
        p_g (1,1) {mustBeNumeric}
        p_s (1,1) {mustBeNumeric}
        p_v (1,1) {mustBeNumeric}
        phi (1,1) {mustBeNumeric}
        rho_a (1,1) {mustBeNumeric}
        T_g (1,1) {mustBeNumeric} = 20
        T_o (1,1) {mustBeNumeric}
        T_h (1,1) {mustBeNumeric}
        V_g (1,1) {mustBeNumeric}
        
        outputs
        P_h
        m_steam
    end
    
    properties % settings
        settings (1,1) {isstruct} = struct(...
            'T_g_sim', 20,...
            'T_o', 20,...
            'T_h', 100);
        step_size (1,1) {mustBeNumeric} = 1
        max_iterations (1,1) {mustBeNumeric} = 600
        temperature_setpoint (1,1) {mustBeNumeric} = 35
        relative_humidity_setpoint (1,1) {mustBeNumeric} = 0.5
        progress_bar (1,1) {mustBeNumericOrLogical} = false
        live_plot (1,1) {mustBeNumericOrLogical} = true
        simulation_only (1,1) {mustBeNumericOrLogical} = false
        using_ni_hardware (1,1) {mustBeNumericOrLogical} = false
        using_arduino_hardware (1,1) {mustBeNumericOrLogical} = false
        heater {ischar} = 'arduino'
    end
    
    properties % failures
        fail_overtemp (1,1) {mustBeNumericOrLogical} = false
        fail_selftest (1,1) {mustBeNumericOrLogical} = false
    end
    
    events
        emergency
        idle
        prestartup
        running
        selftest
        startup
        shutdown
    end
    
    methods
        % Constructor
        function obj = arda()
            if nargin ~= 0
                error('arda class accepts 0 arguments.')
            end
            obj.m_steam = zeros(obj.max_iterations, 1);
            obj.P_h = zeros(obj.max_iterations, 1);
            obj.draw_times = 1:2:obj.max_iterations;
        end
        
        check4errors(arda)
        arda = tune_new_controller(arda)
        log_error(arda, er)
    end
    
end