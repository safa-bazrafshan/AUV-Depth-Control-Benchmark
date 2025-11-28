function pid_depth_controller_aw()

    % Simulation parameters
    dt = 0.01;
    T = 50;
    time = 0:dt:T;

    % Desired depth
    z_ref = -20;

    % Initial state
    x = [0; 0];

    % Tuned PID gains
    Kp = 3.2;
    Ki = 0.5;
    Kd = 1.4;

    % Actuator saturation
    u_max = 1500;
    u_min = -1500;

    % Anti-windup gain
    Kaw = 0.4;

    % Internal variables
    integral_error = 0;
    prev_error = 0;

    % Logs
    z_log = zeros(length(time),1);
    w_log = zeros(length(time),1);
    u_log = zeros(length(time),1);
    u_raw_log = zeros(length(time),1);

    for i = 1:length(time)

        z = x(1);

        % Error
        error = z_ref - z;

        % PID control before saturation
        derivative_error = (error - prev_error) / dt;
        u_raw = Kp*error + Ki*integral_error + Kd*derivative_error;
        prev_error = error;

        % Saturation
        u = min(max(u_raw, u_min), u_max);

        % Anti-windup correction
        aw_term = Kaw * (u - u_raw);
        integral_error = integral_error + (error + aw_term) * dt;

        % Dynamics update
        dx = auv_dynamics(x, u);
        x = x + dx * dt;

        % Logging
        z_log(i) = x(1);
        w_log(i) = x(2);
        u_log(i) = u;
        u_raw_log(i) = u_raw;
    end

    % Plot results
    figure;

    subplot(4,1,1);
    plot(time, z_log, 'LineWidth', 1.6);
    hold on;
    yline(z_ref,'--r');
    title('Depth Response with PID + Anti-Windup');
    ylabel('Depth (m)');

    subplot(4,1,2);
    plot(time, w_log, 'LineWidth', 1.6);
    ylabel('Vertical Velocity');

    subplot(4,1,3);
    plot(time, u_log, 'LineWidth', 1.6);
    ylabel('Saturated Input');

    subplot(4,1,4);
    plot(time, u_raw_log, 'LineWidth', 1.3);
    ylabel('Raw PID Input');
    xlabel('Time (s)');

end
