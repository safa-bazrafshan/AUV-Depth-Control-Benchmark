function smc_depth_controller()
% Sliding Mode Controller for 1-DOF AUV depth regulation

    % Simulation parameters
    dt = 0.01;
    T = 50;
    time_smc = 0:dt:T;

    % Desired depth
    z_ref = -20;

    % Initial state [depth; velocity]
    x = [0; 0];

    % SMC parameters (tune if needed)
    lambda = 2;
    eta = 500;

    % Actuator saturation
    u_max = 1500;
    u_min = -1500;

    % Logs
    depth_smc = zeros(length(time_smc),1);
    vel_smc   = zeros(length(time_smc),1);
    u_smc     = zeros(length(time_smc),1);

    for i = 1:length(time_smc)
        z = x(1);
        w = x(2);

        % Sliding surface
        s = (z - z_ref) + lambda * w;

        % Equivalent control (simple linear approximation)
        u_eq = 50 * (z_ref - z) - 20 * w;

        % Switching control (with sign)
        u_s = -eta * sign(s);

        % Total control
        u = u_eq + u_s;

        % Saturation
        u = max(min(u, u_max), u_min);

        % Update dynamics
        dx = auv_dynamics(x, u);
        x = x + dx * dt;

        % Logging
        depth_smc(i) = x(1);
        vel_smc(i)   = x(2);
        u_smc(i)     = u;
    end

    % Save results in current folder
    save('smc_response.mat', 'time_smc', 'depth_smc', 'vel_smc', 'u_smc');

    fprintf('SMC simulation complete. smc_response.mat created.\n');
end

