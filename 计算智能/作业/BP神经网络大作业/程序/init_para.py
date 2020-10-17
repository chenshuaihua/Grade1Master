# -*- coding: utf-8 -*-
"""
Created on Sat Oct  3 19:25:00 2020

@author: ILQMN
"""

import numpy as np

n_x = 4
n_h = 10
n_y = 3
#初始化动量值
v_dw1 = np.zeros(shape=(n_h,n_x))
v_db1 = np.zeros(shape=(n_h, 1))
v_dw2 = np.zeros(shape=(n_y, n_h))
v_db2 = np.zeros(shape=(n_y, 1))