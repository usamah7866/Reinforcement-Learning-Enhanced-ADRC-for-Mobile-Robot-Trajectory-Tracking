# Reinforcement-Learning-Enhanced-ADRC-for-Mobile-Robot-Trajectory-Tracking
An innovative  approach to tune the parameters of ADRC using Reinforcement Learning (RL) based on Deep Deterministic Policy Gradient  (DDPG) for a Differential Drive Mobile Robot (DDMR). 

# Abstract
In recent years, the application of robotics has significantly advanced many fields, providing robust performance and efficiency in complex tasks without the need for human intervention. Robot control is a key area of robotics that has received a lot of interest and technological development. Active Disturbance Rejection Controllers (ADRCs) are widely adopted due to several features, including their ability to maintain robust performance and effectively reject disturbances. The manual tuning of controller parameters is time-consuming and highlights the need for automation. This paper presents an innovative approach to tune the parameters of ADRC using Reinforcement Learning (RL) based on Deep Deterministic Policy Gradient (DDPG) for a Differential Drive Mobile Robot (DDMR). The RL agent learns the ideal parameters of the ADRC through real-time, iterative interactions with the simulated environment, improving ADRC’s performance without manual tuning. Simulation results demonstrate the effectiveness of the proposed idea in improving the trajectory tracking performance. Combining RL and ADRC provides a promising automated controller tuning solution, opening the door to more intelligent and adaptive robotic systems.

# Run Instructions
1.Download Matlab 2024b and Simulink.

2.Run RL agent MATLAB script file to train the agent or add already trianed agent file into RL agent block present in Simulink Model.

3.Run Simulation File.

# Gallery

Architecture Overview
<img width="6948" height="1910" alt="Architecture overview" src="https://github.com/user-attachments/assets/3b251012-44ca-4165-9c55-21ac0b38ed5b" />

ADRC Structure
![ADRC](https://github.com/user-attachments/assets/7f3d07d9-39c8-4ea4-8a0e-0dd43eab4a3a)


Reinforcement Learning Structure
![RL](https://github.com/user-attachments/assets/7631fd92-3f86-46f7-93bf-36e037d8b698)

# Authors
Usama Habib
Mohanned Nasir
Raouf Fareh
