# -*- coding: utf-8 -*-
"""
Created on Sun Oct  4 00:20:42 2020

@author: ILQMN
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

#该程序绘制了使用动量法更新权重时，不同的梯度更新步长与分类精度之间的折线图 此时隐含层节点个数为10
#读取数据
mom_lr_acc = pd.read_csv('E:\\研究生\研一\\上半学年\\计算智能\\作业\\BP神经网络大作业\\Data\\mom_learning_rate_acc.csv', header=None)

# 从csv文件中分别取出隐含层节点个数n_h和准确率acc，
learning_rate = mom_lr_acc.iloc[:, 0].values         #第一列
learning_rate = np.log10(learning_rate)
acc = mom_lr_acc.iloc[:, 1].values                # 第二列

#绘制折线图
#横轴为迭代次数
#纵轴为cost
plt.plot(learning_rate,acc,linewidth=4)
#设置图表标题
plt.title("Classification Accuracy Variation Curve",fontsize=20)
#给图表坐标轴添加标签
plt.xlabel("momentum-learning_rate(base-10 logarithm)",fontsize=12)
plt.ylabel("accuracy",fontsize=12)
#设置坐标轴刻度标记的大小
plt.tick_params(axis='both',labelsize=10)
plt.show()