# -*- coding: utf-8 -*-
"""
Created on Sat Oct  3 10:58:27 2020

@author: ILQMN
"""

import pandas as pd
import numpy as np
data_set = pd.read_csv('E:\\研究生\研一\\上半学年\\计算智能\\作业\\BP神经网络大作业\\Data\\iris_training.csv', header=None)
## 第1种取数据方法：
X = data_set.iloc[:, 0:4].values.T          # 前四列是特征，T表示转置
Y = data_set.iloc[:, 4:].values.T           # 后三列是标签
#temp = np.array(X)
#XX = X.T
m = X.shape[1]
#随机挑选一个样本
rand_i = np.random.randint(m)
       
    
#随机挑选一个样本
rand_i = np.random.randint(m)
    #预测值与实际值的误差 维数3行1列  dz2 3X1
#dz2 = np.array(Y[:,rand_i])
dz3 = np.transpose([Y[:,rand_i]])
dz4 = np.transpose([Y[:,rand_i]]).T
print(dz3)
#同样将矩阵a1中对应的那一列选择出来 a1_new 1X4
a1_new = np.array(X[:,rand_i])
a1_new2 = np.transpose([a1_new])
a3 = a1_new2.T
print(a3)
    #dw2 3X10
#dw2 = np.dot(dz3, a3)