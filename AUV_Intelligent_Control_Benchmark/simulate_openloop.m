% simulate_openloop.m
% Run an open-loop simulation of the 1-DOF AUV depth dynamics
% with zero control input (u = 0) to inspect natural response + disturbance.

clear; close all; clc;

% Add paths (adjust if needed)
addpath('../dynamics');

% Load parameters
params = params();

% Define control input function (open-loop: zero control)
u_func = @(t, x) 0;

% Time span and initial condition
tspan = [params.t0 params.tf];
x0 = params.x0;

% ODE solver options
opts = odeset('RelTol',1e-6,'AbsTol',1e-8);

% Run simulation
[t, x] = ode45(@(tt,xx) auv_dynamics(tt, xx, u_func, params), tspan, x0, opts);

% Extract states
depth = x(:,1);   % depth (m)
vel = x(:,2);     % vertical velocity (m/s)

% Create results directory if not exist
results_dir = fullfile('..','results');
if ~exist(results_dir, 'dir')
    mkdir(results_dir);
end

% Save results
save(fullfile(results_dir, 'openloop.mat'), 't', 'depth', 'vel', 'params');

% Plot results
figure;
subplot(2,1,1);
plot(t, depth, 'LineWidth', 1.5);
grid on;
xlabel('Time (s)');
ylabel('Depth (m)');
title('Open-loop Depth Response (positive downward)');

subplot(2,1,2);
plot(t, vel, 'LineWidth', 1.5);
grid on;
xlabel('Time (s)');
ylabel('Vertical Velocity (m/s)');
title('Open-loop Vertical Velocity');

% Save figure
saveas(gcf, fullfile(results_dir, 'openloop_response.png'));

fprintf('Open-loop simulation complete. Results saved to %s\n', results_dir);
