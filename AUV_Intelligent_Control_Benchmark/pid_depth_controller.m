function pid_depth_controller()

    % Simulation parameters
    dt = 0.01;
    T = 50;
    time_pid = 0:dt:T;

    % Desired depth (meters)
    z_ref = -20;

    % Initial states [z; w]
    x = [0; 0];

    % PID gains
    Kp = 4;
    Ki = 0.8;
    Kd = 2;

    integral_error = 0;
    prev_error = 0;

    % Storage vectors
    depth_pid = zeros(length(time_pid),1);
    vel_pid   = zeros(length(time_pid),1);
    u_pid     = zeros(length(time_pid),1);
    error_pid = zeros(length(time_pid),1);

    for i = 1:length(time_pid)

        z = x(1);

        % Error terms
        error = z_ref - z;
        integral_error = integral_error + error * dt;
        derivative_error = (error - prev_error) / dt;
        prev_error = error;

        % PID control law
        u = Kp*error + Ki*integral_error + Kd*derivative_error;

        % System dynamics
        dx = auv_dynamics(x, u);
        x = x + dx * dt;

        % Logging
        depth_pid(i) = x(1);
        vel_pid(i)   = x(2);
        u_pid(i)     = u;
        error_pid(i) = error;
    end

    % Create results folder if needed
    if ~exist('results','dir')
        mkdir('results');
    end

    % Save output
    save('results/pid_response.mat', ...
        'time_pid','depth_pid','vel_pid','u_pid','error_pid');

    % Plot
    figure;
    subplot(3,1,1);
    plot(time_pid, depth_pid, 'LineWidth', 1.8); hold on;
    yline(z_ref, '--r');
    xlabel('Time (s)');
    ylabel('Depth (m)');
    title('PID Depth Response');

    subplot(3,1,2);
    plot(time_pid, vel_pid, 'LineWidth', 1.8);
    xlabel('Time (s)');
    ylabel('Vertical Velocity');

    subplot(3,1,3);
    plot(time_pid, u_pid, 'LineWidth', 1.8);
    xlabel('Time (s)');
    ylabel('Control Input');

    fprintf('\nPID simulation complete. File saved as results/pid_response.mat\n');

end
