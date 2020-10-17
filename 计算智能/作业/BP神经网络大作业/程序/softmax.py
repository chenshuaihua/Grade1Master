# -*- coding: utf-8 -*-
"""
Created on Thu Oct  1 23:05:29 2020

@author: ILQMN
"""
import numpy as np


#实现softmax函数
def softmax(input_matrix):
    '''
    输入参数为:input_matrix
    '''
    #将输入的矩阵用array转化一下
    temp = np.array(input_matrix)
    #初始化一个4行3列的矩阵，用于暂时存放后面计算得到的结果,之后将其转置的结果转存到temp中
    mat_not_t = np.zeros((4,3))
    #对输入矩阵的每一列进行操作
    for input_matrix_column in range(0,4):
        #取以e为底的指数函数，计算输入矩阵中每一列中每一个元素为以e为底的指数函数幂次的指数函数值
        soft_exp = [np.exp(i) for i in temp[:,input_matrix_column]]
        #计算e^{i},从1到3的和
        sum_soft_exp = sum(soft_exp)
        #求每个元素所占概率比例，并将最终的计算结果保留四位小数
        mat_not_t[input_matrix_column,:] = [round(j/sum_soft_exp,4) for j in soft_exp]
    #将矩阵mat_not_t转置
    temp = mat_not_t.T
    return temp
    
a = [[1,2,3,4],[4,7,9,8],[2,6,9,5]]
print(a)
b = softmax(a)
print(b)


    
    
    
    
    

