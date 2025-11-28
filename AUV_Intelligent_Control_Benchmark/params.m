function params = params()
% Returns AUV physical parameters and simulation settings

% Physical parameters
params.m = 50;            % mass of AUV (kg)
params.added_mass = 10;   % added mass in vertical direction (kg)
params.g = 9.81;          % gravity (m/s^2)
params.rho = 1025;        % water density (kg/m^3)
params.volume = 0.048;    % displaced volume (m^3)
params.W = params.m * params.g;            % weight (N)
params.B = params.rho * params.g * params.volume; % buoyancy (N)

% Hydrodynamic damping (quadratic drag)
params.C_d = 20;          % quadratic drag coefficient (N/(m/s)^2)

% Simulation settings
params.t0 = 0;
params.tf = 120;          % final time (s)
params.x0 = [0; 0];       % initial states: [depth (m); vertical velocity (m/s)]
                          % depth positive downward (convention)
% Disturbance settings (example: sinusoidal vertical force)
params.disturbance_amplitude = 15;   % N
params.disturbance_freq = 0.05;      % Hz

% Control limits (for later stages)
params.u_min = -200;      % min thrust (N)
params.u_max = 200;       % max thrust (N)

end
