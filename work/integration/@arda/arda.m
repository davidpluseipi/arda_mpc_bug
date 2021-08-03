classdef arda < handle
    
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
    end
    
    properties % gas mixture and simulation
        m_a (1,1) {mustBeNumeric}
        m_steam
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
        x_0 (12,1) {mustBeNumeric} = zeros(12,1)
        settings (1,1) {isstruct} = struct(...
            'setpoints', struct('T', 40, 'phi', 0.50),...
            'T_g_sim', 20,...
            'T_o', 20,...
            'T_h', 50,...
            'T_s', 1,...
            'total_time', 30,... % 30=1min irl
            'off', 1e6,...
            'simulation_only', false,...
            'ni', true,...
            'arduino', true);
        max_iterations (1,1) {mustBeNumeric} = 30*60
        arduino_daq_obj {isobject}
        sensor_dht22 {isobject}
        ni_daq_obj {isobject}
        progress_bar (1,1) {mustBeNumericOrLogical} = true
        fig
        dialog_box
        specific_heat_fit_obj {isobject}
        draw_times
    end
    
    properties % controls
       pid (1,1) {isobject}
       pid_phi (1,1) {isobject}
    end
    
    properties % outputs
        outputs
        T_g_out
        T_h_out
        T_o_out
        p_v_out
        p_a_out
        q_out
        phi_out
        p_s_out
        P_h_out
    end
    
    properties % constants
        constants (1,4) {isvector}
        R_a (1,1) {mustBeNumeric}
        R_v (1,1) {mustBeNumeric}
        R_go (1,1) {mustBeNumeric}
        R_hg (1,1) {mustBeNumeric}
    end
    
    properties
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
            obj.T_g_out = zeros(obj.max_iterations, 1);
            obj.T_h_out = zeros(obj.max_iterations, 1);
            obj.T_o_out = zeros(obj.max_iterations, 1);
            obj.p_v_out = zeros(obj.max_iterations, 1);
            obj.p_a_out = zeros(obj.max_iterations, 1);
            obj.q_out = zeros(obj.max_iterations, 1);
            obj.phi_out = zeros(obj.max_iterations, 1);
            obj.p_s_out = zeros(obj.max_iterations, 1);
            obj.P_h_out = zeros(obj.max_iterations, 1);
            obj.m_steam = zeros(obj.max_iterations, 1);
            obj.draw_times = 1:2:obj.max_iterations;
        end
        
        check4errors(arda)
        arda = do_stuff(arda)
        log_error(arda, er)
    end
    
end