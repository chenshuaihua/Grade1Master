# Predictive Active Steering Control  for Autonomous Vehicle Systems



## 一.相关概念先导

Model Predictive Control(MPC)模型预测控制

其优势在于，它是一个多变量控制器，通过考虑所有因素同时控制输出。

**三要素**：==预测模型==（预测系统未来状态），==滚动优化==（数值求解优化问题，通过某一性能指标的最优，确定未来最优的控制作用），==反馈校正==（每个采样时刻，通过**实际输出**对模型的**预测输出**进行修正，然后再进行新的优化）

**基本原理**：在当前时刻采样系统的状态，求取一个有限时域的**开环优化问题**，得到一个控制序列，但它只把控制序列的**第一个元素**作用于系统；下一采样时刻，重新采样系统的状态得到控制序列。预测时域是滚动的，所有MPC又称为==滚动时域控制==

<img src="E:\研究生\研一\上半学年\基础学术论文写作\图片\MPC基本原理.PNG" style="zoom:70%;" />

<img src="E:\研究生\研一\上半学年\基础学术论文写作\图片\MPC优化问题描述.PNG" style="zoom:80%;" />

**特点一**

模型形式不重要，强调模型的功能：==预测系统未来动态==

**特点二**

滚动优化，k时刻：k→k+N       k+1时刻：k+1→k+N+1

预测时域滚动向前

好处：通过求解相对容易的开环优化问题得到闭环控制

**特点三**

==显示和主动处理约束==

**特点四**

前馈+反馈控制结构

<img src="E:\研究生\研一\上半学年\基础学术论文写作\图片\MPC简单例子.PNG" style="zoom:67%;" />

## 二.论文内容

### Abstract

A MPC approach for controlling an active front steering system in an autonomous vehicle is presented.

compute ==the front steering angle== in order to follow the trajectory on slippery roads at the highest entry speed.

Approach1: use a nonlinear model 

Approcah2:successive online linearization of the vehicle model

### Introduction

Passive safety focuses on the structural integrity.

Active safety focuses on better vehicle controllability and stability.

In the paper, it focuses on the control of yaw and lateral vehicle dynamics via active front steering. ==Input: the front steering angle.==     ==The goal: to follow the desired trajectory or target as close as possible while fulfilling all the requirements.==

### Section II 

The part describes the used vehicle dynamical model with a brief discussion on the models.

$F_{l},F_{c},F_{x},F_{y},F_{z}$

$I,X,Y$

$a,b$

$g$ gravitational constant; $m$ car mass

$r,s$

$v_{l},v_{c}$

$x,y$

$\alpha$ slip angle      $\delta$ wheel steering angle



all of the forces which affect vehicle handling are produced by the tires. Therefore it is important to use a realistic nonlinear tire model. Most of the existing tire models are "semi-empirical" in nature. This uses a Pacejka tire model . 

### Section III

The part introduces a simplified hierarchical framework for autonomous vehicle guidance.(一个简化的分层框架)

Fig3: Trajectory-Mode Generator, Trajectory-Mode Replanning, Low_level Control System,Vehicle and environment.

前三个模块的解和通常被称为 系统guidance and navigation control  GNC  系统

### Section IV

The part formulates the control problem when the nonlinear
and the linear prediction models are used. 

the front steering angle is chosen as control input.

#### **Section IV-A**: 

nonlinear vehicle model 

就是提出了一个非线性模型，然后写出了cost function，同时满足一系列约束条件，目的就是想让cost function最小。

#### Section IV-B: 

 LTV MPC controller

每个time step 都对上述的那个非线性模型线性化，就得到了一个状态空间

也能将这个模型看作一个QP quadratic program  二次规划

### Section V 

The double lane change scenario is described .

#### A Trajectory Generation

写了几个方程，可以直接用nonlinear model生成；或者做一个假设，然后可以用LTI MPC生成

#### B The experimental setup

对实验的相关平台和设备进行了介绍

### Section VI

The experimental and simulation results are presented. 

A:three types of MPC controllers will be presented. These controllers have been derived by the MPC problem formulations presented in Sections IV -A and IV -B and will be referred to as Controller A, B, and C.

接下来会对这三种控制器进行介绍，如将仿真结果与实验结果进行比较。



### Section VII    Conclusions

The part concludes remarks which highlight future research directions.























