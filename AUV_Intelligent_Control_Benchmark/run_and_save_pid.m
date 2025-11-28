% run_and_save_pid.m
% Run PID AW and save time,z_log,w_log,u_log to results/pid_aw_response.mat

cd(fileparts(mfilename('fullpath'))); % if running as script inside simulations
% (or just ensure current folder is simulations)

pid_depth_controller_aw  % run the controller (it will plot)
% assume pid_depth_controller_aw uses variables time,z_log,w_log,u_log in workspace
% if not, adapt names accordingly

% gather workspace vars (these names are used in our earlier PID file)
% if your pid file uses different names, replace accordingly
if exist('z_log','var') && exist('w_log','var') && exist('u_log','var') && exist('time','var')
    results_dir = fullfile('..','results');
    if ~exist(results_dir,'dir'), mkdir(results_dir); end
    save(fullfile(results_dir,'pid_aw_response.mat'),'time','z_log','w_log','u_log');
    fprintf('PID saved to %s\n', fullfile(results_dir,'pid_aw_response.mat'));
else
    error('Expected variables time,z_log,w_log,u_log not found after running pid_depth_controller_aw.');
end
