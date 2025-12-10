# 🎯 Adversary Emulation & Detection Engineering  
### *APT29 Simulation using Atomic Red Team + Sysmon*

Welcome to the project where we intentionally “hack ourselves” — safely, of course.  
This repository showcases a full adversary emulation exercise modeled after **APT29 (Cozy Bear)**, one of the most stealthy and persistent threat groups in the world. Instead of reading about their tactics, we recreated several of them in a controlled Windows lab and captured their footprints using **Sysmon**.

This project demonstrates the full attack → log → detect workflow that real security teams use.  
If you want to understand how offensive techniques translate into defensive visibility, you're in the right place.

---

## 🧠 What This Project Does
This project simulates several MITRE ATT&CK techniques using **Atomic Red Team**, and then collects every trace of activity using **Sysmon**. The goal is simple:  
**run safe attacks, study the logs, and prove detection coverage.**

We executed the following techniques:

- **T1053.005 – Scheduled Task**
- **T1036 – Masquerading**
- **T1566.002 – Spearphishing Link**
- **T1574.002 – DLL Side‑Loading**
- **T1047 – WMI Execution** *(the only one that failed)*

Four out of five executed perfectly. WMI didn’t cooperate — but that happens in real adversary emulation too.

---

## 📊 What We Found
Running these tests generated **50+ Sysmon events**, including:

- Process creation  
- DLL loading  
- File writes  
- Command execution  
- Scheduled task operations  
- Abnormal binary renaming patterns  

Each event served as evidence that the simulation ran correctly and that the system was monitoring the right behaviors.

All results were saved in **timestamped log files** inside the `/Logs` directory.  
Yes, it’s as clean and organized as it sounds.

---

## ⚙️ How It Works
The entire simulation is powered by one PowerShell script.  
It loops through several MITRE technique IDs and runs each Atomic test automatically.

You get:

- Automatic log directory creation  
- Timestamped log files  
- Success + failure tracking  
- Clean output  
- Easy repeatability  

You can add new techniques by simply adding another ID to the `$TestIDs` array.

---

## 🚀 How to Run This Yourself
1. Install **Sysmon**  
2. Install **Atomic Red Team**  
3. Clone this repository  
4. Open PowerShell **as Administrator**  
5. Run the script: run-tests.ps1
6. Watch the magic happen  
7. View the logs.
8. Open Sysmon logs in Event Viewer to analyze every detail.

If you enjoy hunting malware-like activity without actual malware…  
welcome to the club.

---

## 🛡️ Safety First
All tests used in this project are **benign**, **safe**, and **designed for controlled environments**.  
No real malware.  
No destructive behavior.  
Just clean, structured adversary simulation.

Windows security controls remained active the entire time.  
Sysmon ensured full visibility into every action taken.

---

## 📉 Limitations
This project is Windows-only because:

- Atomic Red Team is Windows‑focused  
- Sysmon is designed for Windows  
- Kali Linux lacked compatible versions for these tools  

Future versions may expand into SIEM dashboards, Sigma rules, ELK integration, or lateral movement chains.

---

## 📚 Tools Used
- **Atomic Red Team** – runs safe MITRE‑aligned attack simulations  
- **Sysmon** – collects low-level system telemetry  
- **MITRE ATT&CK Framework** – maps the techniques to real-world adversaries  
- **PowerShell** – automation, scripting, logging  

---

## 🤝 Want to Contribute?
Feel free to fork, iterate, and expand the attack set.  
Add more techniques, detection rules, or dashboards.  
Pull requests are always welcome.

---

## 📝 Final Notes
If you’ve ever wanted to see how APT‑style attacks actually look under the hood — this project gives you that visibility. Learn how adversaries behave, how defenders detect, and why detection engineering is one of the most important skills in cybersecurity.

Enjoy the repo, and happy hunting. 🔍🐾
