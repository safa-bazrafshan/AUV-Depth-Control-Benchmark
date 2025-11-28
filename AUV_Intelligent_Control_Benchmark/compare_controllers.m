%% compare_controllers.m
clear; clc; close all;

% reference depth used for error calculation if error variables missing
z_ref = -20;

% helper for existence of files
hasFile = @(f) exist(f,'file')==2;

% load PID if exists
pid_ok = false;
if hasFile('pid_response.mat')
    s = load('pid_response.mat');
    % expected names: time_pid, depth_pid, vel_pid, u_pid, error_pid (optional)
    if isfield(s,'time_pid'), time_pid = s.time_pid; end
    if isfield(s,'depth_pid'), depth_pid = s.depth_pid; end
    if isfield(s,'vel_pid'), vel_pid = s.vel_pid; end
    if isfield(s,'u_pid'), u_pid = s.u_pid; end
    if isfield(s,'error_pid'), error_pid = s.error_pid; end
    pid_ok = true;
end

% load LQR if exists
lqr_ok = false;
if hasFile('lqr_response.mat')
    s = load('lqr_response.mat');
    if isfield(s,'time_lqr'), time_lqr = s.time_lqr; end
    if isfield(s,'depth_lqr'), depth_lqr = s.depth_lqr; end
    if isfield(s,'vel_lqr'), vel_lqr = s.vel_lqr; end
    if isfield(s,'u_lqr'), u_lqr = s.u_lqr; end
    if isfield(s,'error_lqr'), error_lqr = s.error_lqr; end
    lqr_ok = true;
end

% load FLC if exists
flc_ok = false;
if hasFile('flc_response.mat')
    s = load('flc_response.mat');
    if isfield(s,'time_flc'), time_flc = s.time_flc; end
    if isfield(s,'depth_flc'), depth_flc = s.depth_flc; end
    if isfield(s,'vel_flc'), vel_flc = s.vel_flc; end
    if isfield(s,'u_flc'), u_flc = s.u_flc; end
    if isfield(s,'error_flc'), error_flc = s.error_flc; end
    flc_ok = true;
end

% load SMC if exists
smc_ok = false;
if hasFile('smc_response.mat')
    s = load('smc_response.mat');
    if isfield(s,'time_smc'), time_smc = s.time_smc; end
    if isfield(s,'depth_smc'), depth_smc = s.depth_smc; end
    if isfield(s,'vel_smc'), vel_smc = s.vel_smc; end
    if isfield(s,'u_smc'), u_smc = s.u_smc; end
    if isfield(s,'error_smc'), error_smc = s.error_smc; end
    smc_ok = true;
end

% make plots folder if not exist
plots_dir = fullfile(pwd,'plots');
if ~exist(plots_dir,'dir'), mkdir(plots_dir); end

% --- Prepare legend entries dynamically and plot Depth ---
figure; hold on; grid on;
legendEntries = {};

if pid_ok && exist('time_pid','var') && exist('depth_pid','var')
    h1 = plot(time_pid, depth_pid, 'r', 'LineWidth', 1.5);
    legendEntries{end+1} = 'PID';
end
if lqr_ok && exist('time_lqr','var') && exist('depth_lqr','var')
    h2 = plot(time_lqr, depth_lqr, 'b', 'LineWidth', 1.5);
    legendEntries{end+1} = 'LQR';
end
if flc_ok && exist('time_flc','var') && exist('depth_flc','var')
    h3 = plot(time_flc, depth_flc, 'g', 'LineWidth', 1.5);
    legendEntries{end+1} = 'FLC';
end
if smc_ok && exist('time_smc','var') && exist('depth_smc','var')
    h4 = plot(time_smc, depth_smc, 'm', 'LineWidth', 1.5);
    legendEntries{end+1} = 'SMC';
end

xlabel('Time (s)'); ylabel('Depth (m)');
title('Depth Response Comparison');
if ~isempty(legendEntries), legend(legendEntries,'Location','best'); end
saveas(gcf, fullfile(plots_dir,'depth_comparison.png'));

% --- Error comparison (compute if missing) ---
figure; hold on; grid on;
legendEntries = {};

if pid_ok && exist('time_pid','var') && exist('depth_pid','var')
    if ~exist('error_pid','var'), error_pid = z_ref - depth_pid; end
    plot(time_pid, error_pid, 'r', 'LineWidth', 1.5); legendEntries{end+1} = 'PID'; 
end
if lqr_ok && exist('time_lqr','var') && exist('depth_lqr','var')
    if ~exist('error_lqr','var'), error_lqr = z_ref - depth_lqr; end
    plot(time_lqr, error_lqr, 'b', 'LineWidth', 1.5); legendEntries{end+1} = 'LQR';
end
if flc_ok && exist('time_flc','var') && exist('depth_flc','var')
    if ~exist('error_flc','var'), error_flc = z_ref - depth_flc; end
    plot(time_flc, error_flc, 'g', 'LineWidth', 1.5); legendEntries{end+1} = 'FLC';
end
if smc_ok && exist('time_smc','var') && exist('depth_smc','var')
    if ~exist('error_smc','var'), error_smc = z_ref - depth_smc; end
    plot(time_smc, error_smc, 'm', 'LineWidth', 1.5); legendEntries{end+1} = 'SMC';
end

xlabel('Time (s)'); ylabel('Error (m)');
title('Error Comparison (z_{ref} - z)');
if ~isempty(legendEntries), legend(legendEntries,'Location','best'); end
saveas(gcf, fullfile(plots_dir,'error_comparison.png'));

% --- Thrust / control input comparison ---
figure; hold on; grid on;
legendEntries = {};

if pid_ok && exist('time_pid','var') && exist('u_pid','var')
    plot(time_pid, u_pid, 'r', 'LineWidth', 1.5); legendEntries{end+1} = 'PID';
end
if lqr_ok && exist('time_lqr','var') && exist('u_lqr','var')
    plot(time_lqr, u_lqr, 'b', 'LineWidth', 1.5); legendEntries{end+1} = 'LQR';
end
if flc_ok && exist('time_flc','var') && exist('u_flc','var')
    plot(time_flc, u_flc, 'g', 'LineWidth', 1.5); legendEntries{end+1} = 'FLC';
end
if smc_ok && exist('time_smc','var') && exist('u_smc','var')
    plot(time_smc, u_smc, 'm', 'LineWidth', 1.5); legendEntries{end+1} = 'SMC';
end

xlabel('Time (s)'); ylabel('Control Input (N)');
title('Control Input Comparison');
if ~isempty(legendEntries), legend(legendEntries,'Location','best'); end
saveas(gcf, fullfile(plots_dir,'thrust_comparison.png'));

fprintf('Comparison finished. Figures saved in folder: %s\n', plots_dir);
