function dx = auv_dynamics(x, u)

    % States
    z = x(1);
    w = x(2);

    % Parameters
    m = 50;          % mass (kg)
    b = 20;          % damping
    W = 500;         % weight (N)
    B = 520;         % buoyancy (N)
    disturbance = 2 * sin(0.3 * z);

    % Vertical force
    Fz = -(W - B) - b*w + u + disturbance;

    % Dynamics
    dz = w;
    dw = Fz / m;

    dx = [dz; dw];
end
