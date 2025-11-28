# 🚢 AUV Depth Control Benchmark  
### Comparative Study of PID, LQR, FLC, and SMC Controllers

This repository provides a complete and unified benchmark for depth control of an Autonomous Underwater Vehicle (AUV).  
Four classical and intelligent control strategies are implemented, simulated, and compared under a consistent dynamic model.

---

## 📌 **Controllers Implemented**
- **PID Controller** (baseline method)  
- **LQR Controller** (optimal control)  
- **Fuzzy Logic Controller (FLC)**  
- **Sliding Mode Controller (SMC)** (robust nonlinear method)

Each controller is evaluated in terms of:
- Depth tracking accuracy  
- Control effort  
- Convergence and dynamic response  

---

## 📁 **Repository Structure**

```
AUV-Depth-Control-Benchmark/
│
├── pid_depth_controller.m
├── lqr_depth_controller.m
├── flc_depth_controller.m
├── smc_depth_controller.m
├── auv_dynamics.m
├── compare_controllers.m
│
├── results/
│   ├── *.mat
│   └── plots/*.png
│
└── report/
    └── AUV_Depth_Control_Report.pdf
```

---

## ▶️ **How to Run**

1. Generate simulation results for each controller:
   ```matlab
   pid_depth_controller
   lqr_depth_controller
   flc_depth_controller
   smc_depth_controller
   ```

2. Run the comparison script:
   ```matlab
   compare_controllers
   ```

All figures and MAT files will be saved automatically in the `results/` directory.

---

## 🛠 **Requirements**
- MATLAB R2021a or newer  
- Fuzzy Logic Toolbox (for FLC)  

---

## 📊 **Features**
- Unified AUV dynamic model  
- Modular controller implementations  
- Automatic result logging  
- Clean visual comparison figures  
- Complete final PDF report included  

---

## 📑 **Report**
A full technical report—including methodology, modeling, controller design, simulation results, and discussion—is available in:

```
/report/AUV_Depth_Control_Report.pdf
```

---

## ✨ **Author**
**Safa Bazrafshan**

---

## ⭐ If you find this work useful...
Please consider starring the repository.  
It helps others discover the project and supports further work in AUV control systems.
