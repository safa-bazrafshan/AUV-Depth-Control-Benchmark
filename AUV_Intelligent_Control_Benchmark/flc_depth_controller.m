function flc_depth_controller()
    % Fuzzy Logic Controller for 1-DOF AUV Depth Regulation

    % Simulation parameters
    dt = 0.01;
    T = 50;
    time_flc = 0:dt:T;

    % Desired depth
    z_ref = -20;

    % Initial state [z; w]
    x = [0; 0];

    % Load Fuzzy Logic System
    fis = readfis('auv_depth_fuzzy');

    % Logs
    depth_flc = zeros(length(time_flc),1);
    vel_flc   = zeros(length(time_flc),1);
    u_flc     = zeros(length(time_flc),1);

    % Actuator limits
    u_max = 1500;
    u_min = -1500;

    for i = 1:length(time_flc)

        z = x(1);
        w = x(2);

        % Inputs to FIS
        e  = z_ref - z;
        de = -w;

        % Fuzzy output
        u  = evalfis(fis, [e, de]);

        % Saturation
        u = max(min(u, u_max), u_min);

        % Update system
        dx = auv_dynamics(x, u);
        x = x + dx * dt;

        % Logs
        depth_flc(i) = x(1);
        vel_flc(i)   = x(2);
        u_flc(i)     = u;
    end

    % ---- Save Results ----
    save('flc_response.mat', ...
        'time_flc', 'depth_flc', 'vel_flc', 'u_flc');

    fprintf('FLC simulation complete. flc_response.mat created.\n');
end
