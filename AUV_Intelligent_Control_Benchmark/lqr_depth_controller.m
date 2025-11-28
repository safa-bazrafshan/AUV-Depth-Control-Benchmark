function lqr_depth_controller()
% LQR controller for 1-DOF AUV depth regulation

    % Simulation parameters
    dt = 0.01;
    T = 50;
    time_lqr = 0:dt:T;

    % Desired depth
    z_ref = -20;
    x_ref = [z_ref; 0];

    % System parameters (match auv_dynamics)
    m = 50;
    b = 20;
    W = 500;
    B = 520;

    % Linearized A,B matrices
    A = [0 1;
         0 -b/m];
    Bmat = [0;
            1/m];

    % LQR weights
    Q = diag([100, 10]);
    R = 0.1;

    % Gain
    K = lqr(A, Bmat, Q, R);

    % Equilibrium input
    u_eq = (W - B);

    % Initial state
    x = [0; 0];

    % Logs (renamed for consistency)
    depth_lqr = zeros(length(time_lqr),1);
    vel_lqr   = zeros(length(time_lqr),1);
    u_lqr     = zeros(length(time_lqr),1);

    for i = 1:length(time_lqr)

        % State error
        e = x - x_ref;

        % Control
        u_fb = -K * e;
        u = u_eq + u_fb;

        % Update dynamics
        dx = auv_dynamics(x, u);
        x = x + dx * dt;

        % Log
        depth_lqr(i) = x(1);
        vel_lqr(i)   = x(2);
        u_lqr(i)     = u;
    end

    % Plot
    figure;
    subplot(3,1,1);
    plot(time_lqr, depth_lqr, 'LineWidth', 1.6);
    hold on; yline(z_ref, '--r');
    title('Closed-Loop Depth Response (LQR)');
    ylabel('Depth (m)');

    subplot(3,1,2);
    plot(time_lqr, vel_lqr, 'LineWidth', 1.6);
    ylabel('Vertical Velocity (m/s)');

    subplot(3,1,3);
    plot(time_lqr, u_lqr, 'LineWidth', 1.6);
    ylabel('Control Input (N)');
    xlabel('Time (s)');

    % Save MAT in main project folder
    save('lqr_response.mat', ...
        'time_lqr', 'depth_lqr', 'vel_lqr', 'u_lqr', 'K', 'Q', 'R');

    fprintf('LQR simulation complete. File saved as lqr_response.mat\n');

end
