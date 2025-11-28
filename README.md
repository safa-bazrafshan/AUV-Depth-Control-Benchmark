AUV Depth Control Benchmark

This repository provides a complete benchmark and comparison of four classical and intelligent controllers for Autonomous Underwater Vehicle (AUV) depth regulation. The project includes unified MATLAB simulations, plots, and analysis for:

PID Controller

LQR Controller

Fuzzy Logic Controller (FLC)

Sliding Mode Controller (SMC)

The benchmark evaluates performance in terms of depth tracking, control effort, and system behavior under the same dynamic model.

Repository Structure

pid_depth_controller.m

lqr_depth_controller.m

flc_depth_controller.m

smc_depth_controller.m

auv_dynamics.m

compare_controllers.m

results/ (MAT-files + figures)

report/ (Final PDF report)

Features

Unified dynamic model for all simulations

Individual controller implementations

Automatic result saving (MAT & PNG)

Comparison plots (depth, velocity, control input)

Final technical report included

Requirements

MATLAB R2021a or later

Fuzzy Logic Toolbox (for FLC)

How to Run

Run each controller file to generate results:
pid_depth_controller
lqr_depth_controller
flc_depth_controller
smc_depth_controller

Run the comparison script:
compare_controllers

This will generate all comparison plots and store them in the results folder.

Citation

If you use this benchmark, please cite or reference the repository.

Author

Safa Bazrafshan

