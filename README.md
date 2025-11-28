AUV Depth Control Benchmark
PID • LQR • Fuzzy Logic • Sliding Mode Control

A structured and reproducible benchmark for depth regulation of an Autonomous Underwater Vehicle (AUV) using four classical and intelligent controllers.
The project provides a unified simulation environment, clean MATLAB implementations, and comparative performance evaluation.

📌 Overview

This repository implements and compares:

PID Control (baseline controller)

LQR (optimal state-feedback)

Fuzzy Logic Control (FLC) (Mamdani-based intelligent controller)

Sliding Mode Control (SMC) (robust nonlinear control)

All controllers operate on the same 1-DOF vertical AUV dynamic model, making this repository suitable for:

Research benchmark

Academic coursework

Intelligent control experiments

Extensions to adaptive and RL-based controllers

⚙️ Features

Full MATLAB implementation — no toolboxes required except Fuzzy Logic Toolbox for FLC

Clean separation of controllers, model, and evaluation

Unified simulation parameters for fair comparison

Standard logging format (*.mat files)

High-quality comparison plots

Extendable architecture for new controllers


📘 AUV Dynamic Model

The benchmark uses a compact 2-state nonlinear model representing vertical motion:

𝑥
=
[
𝑧


𝑤
]
,
𝑧
˙
=
𝑤
x=[
z
w
	​

],
z
˙
=w
𝑤
˙
=
1
𝑚
(
𝑢
−
𝑑
(
𝑤
)
−
𝑚
𝑔
+
𝐵
)
w
˙
=
m
1
	​

(u−d(w)−mg+B)

This abstraction isolates control performance from hydrodynamic complexity.

🧠 Implemented Controllers
1. PID Controller

A baseline for comparison.
Performs reasonably well but limited robustness to disturbances.

2. LQR Controller

Optimal state-feedback with smooth and efficient actuation.
Shows strong transient behavior and stable convergence.

3. Fuzzy Logic Controller

Mamdani-type FIS, human-interpretable rules, smooth output.
Effective for nonlinear or uncertain environments.

4. Sliding Mode Control (SMC)

Robust to disturbances and parameter variations.
Fast convergence; aggressive control effort.

📊 Comparison Results

Three primary metrics are evaluated:

1. Depth Tracking

Transient performance and steady-state accuracy across controllers.

2. Error Evolution

How quickly each controller eliminates tracking error.

3. Control Input Profile

Aggressiveness, efficiency, and smoothness of actuation.

Figures are saved automatically under results/plots/.

▶️ Running the Benchmark

To evaluate all controllers:

compare_controllers


To run an individual controller:

pid_depth_controller
lqr_depth_controller
flc_depth_controller
smc_depth_controller

🧩 Extending the Work

This repository is designed to serve as a base for:

Adaptive controllers

Reinforcement Learning-based control

Fault-tolerant & robust control

Full 6-DOF AUV simulation

Contributions and pull requests are welcome.

🧑‍💻 Author

safa Bazrafshan
Graduate Researcher – Intelligent Control Systems
Email: safa.bazrafshan@gmail.com
website: safabazrafshan.com


⭐ If this repository helps your work, consider giving it a star.
