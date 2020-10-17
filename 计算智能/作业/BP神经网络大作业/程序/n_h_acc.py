# -*- coding: utf-8 -*-
"""
Created on Sat Oct  3 22:39:40 2020

@author: ILQMN
"""
import pandas as pd
import matplotlib.pyplot as plt
#该程序绘制了使用随机梯度下降法更新权重时，隐含层不同结点数目与分类精度之间的折线图 此时梯度更新步长为0.005

#读取数据
n_h_acc = pd.read_csv('E:\\研究生\研一\\上半学年\\计算智能\\作业\\BP神经网络大作业\\Data\\n_h_nums_acc.csv', header=None)

# 从csv文件中分别取出隐含层节点个数n_h和准确率acc，
n_h = n_h_acc.iloc[:, 0].values         #第一列
acc = n_h_acc.iloc[:, 1].values         # 第二列

#绘制折线图
#横轴为迭代次数
#纵轴为cost
plt.plot(n_h,acc,linewidth=4)
#设置图表标题
plt.title("Classification Accuracy Variation Curve",fontsize=20)
#给图表坐标轴添加标签
plt.xlabel("n_h",fontsize=12)
plt.ylabel("accuracy",fontsize=12)
#设置坐标轴刻度标记的大小
plt.tick_params(axis='both',labelsize=10)
plt.show()