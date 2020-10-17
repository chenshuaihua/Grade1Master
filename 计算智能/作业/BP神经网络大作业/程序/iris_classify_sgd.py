import random
import pandas as pd
import numpy as np
import datetime
import matplotlib.pyplot as plt
from pandas.plotting import radviz

'''
BP神经网络大作业：实现对鸢尾花(Iris)的三分类
鸢尾花数据集150个样本，3个类别，每个样本有4个特征
本作业中使用1层隐藏层，节点数选择8/9/10，选择10 11
隐藏层激励函数tanh,输出层激励函数softmax函数
目标函数使用交叉熵损失函数
使用随机梯度下降法
softmax函数输出结果后，怎么实现多分类？
对于三个输出，定义若输出为(1,0,0)则为第一类；(0,1,0)则为第二类，(0,0,1)则为第三类
'''


#初始化参数
def initialize_parameters(n_x, n_h, n_y):
    np.random.seed(2)

    # 权重和偏置矩阵
    w1 = np.random.randn(n_h, n_x) * 0.01
    b1 = np.zeros(shape=(n_h, 1))
    w2 = np.random.randn(n_y, n_h) * 0.01
    b2 = np.zeros(shape=(n_y, 1))

    # 通过字典存储参数
    parameters = {'w1': w1, 'b1': b1, 'w2': w2, 'b2': b2}

    return parameters


#实现softmax函数
def softmax(input_matrix):
    '''
    输入参数为:input_matrix
    '''
    #将输入的矩阵用array转化一下
    temp = np.array(input_matrix)
    #初始化一个120行3列的矩阵，用于暂时存放后面计算得到的结果,之后将其转置的结果转存到temp中
    temp_rows = temp.shape[0]
    temp_cols = temp.shape[1]
    mat_not_t = np.zeros((temp_cols,temp_rows))
    #对输入矩阵的每一列进行操作
    for input_matrix_column in range(0,temp_cols):
        #取以e为底的指数函数，计算输入矩阵中每一列中每一个元素为以e为底的指数函数幂次的指数函数值
        soft_exp = [np.exp(i) for i in temp[:,input_matrix_column]]
        #计算e^{i},从1到3的和
        sum_soft_exp = sum(soft_exp)
        #求每个元素所占概率比例，并将最终的计算结果保留四位小数
        mat_not_t[input_matrix_column,:] = [round(j/sum_soft_exp,4) for j in soft_exp]
    #将矩阵mat_not_t转置
    temp = mat_not_t.T
    return temp


#前向传播
def forward_propagation(X, parameters):
    w1 = parameters['w1']
    b1 = parameters['b1']
    w2 = parameters['w2']
    b2 = parameters['b2']

    # 通过前向传播来计算a2
    z1 = np.dot(w1, X) + b1     # 这个地方需注意矩阵加法：虽然(w1*X)和b1的维度不同，但可以相加
    a1 = np.tanh(z1)            # 使用tanh作为第一层的激活函数
    z2 = np.dot(w2, a1) + b2    #z2 3X120
    a2 = softmax(z2)            # 使用softmax函数作为第二层的激活函数

    # 通过字典存储参数
    cache = {'z1': z1, 'a1': a1, 'z2': z2, 'a2': a2}

    return a2, cache


#计算cost function
def compute_cost(a2, Y, parameters):
    m = Y.shape[1]      # Y的列数即为总的样本数

    # 采用交叉熵（cross-entropy）作为代价函数
    logprobs = np.multiply(np.log(a2 + 1e-5), Y) + np.multiply((1 - Y), np.log(1 - a2 + 1e-5 ))
    cost = - np.sum(logprobs) / m

    return cost


#反向传播（计算代价函数的导数）  
#随机梯度下降法更新网络权重，每次仅随机选取一个样本来求梯度，训练速度快
def backward_propagation(parameters, cache, X, Y):
    #m为样本总数
    m = Y.shape[1]
    
    w2 = parameters['w2']

    a1 = cache['a1']  #a1 10X120
    a2 = cache['a2']  #a2  3X120

    # 反向传播，计算dw1、db1、dw2、db2   
    #随机挑选一个样本
    rand_i = np.random.randint(m)
    #预测值与实际值的误差 维数3行1列  dz2 3X1
    dz2 = np.transpose([a2[:,rand_i]-Y[:,rand_i]])
    #同样将矩阵a1中对应的那一列选择出来 a1 10X1
    a1 = np.transpose([a1[:,rand_i]])
    a11 = a1.T  #1X10
    #dw2 3X10
    dw2 = np.dot(dz2, a11)
    #db2 3X1
    db2 = np.sum(dz2, axis=1, keepdims=True)
    #dz1  10X1       w2.T 10X3    dz2 3X1
    dz1 = np.multiply(np.dot(w2.T, dz2), 1 - np.power(a1, 2))
    #X 1X4 
    X = np.transpose([X[:,rand_i]]).T
    #dw1 10X4
    dw1 = np.dot(dz1, X)
    #db1 10X1
    db1 = np.sum(dz1, axis=1, keepdims=True)

    grads = {'dw1': dw1, 'db1': db1, 'dw2': dw2, 'db2': db2}

    return grads


#更新参数
#学习率设置的过大，如设置为0.005时，会导致最终得到的结果为nan
#但如果我们在np.log()函数中将浮点数的精度修改为1e-5
def update_parameters(parameters, grads, learning_rate=1):
    w1 = parameters['w1']
    b1 = parameters['b1']
    w2 = parameters['w2']
    b2 = parameters['b2']

    dw1 = grads['dw1']
    db1 = grads['db1']
    dw2 = grads['dw2']
    db2 = grads['db2']

    # 更新参数
    w1 = w1 - dw1 * learning_rate
    b1 = b1 - db1 * learning_rate
    w2 = w2 - dw2 * learning_rate
    b2 = b2 - db2 * learning_rate

    parameters = {'w1': w1, 'b1': b1, 'w2': w2, 'b2': b2}

    return parameters


#模型评估
def predict(parameters, x_test, y_test):
    w1 = parameters['w1']
    b1 = parameters['b1']
    w2 = parameters['w2']
    b2 = parameters['b2']
    
    z1 = np.dot(w1, x_test) + b1
    a1 = np.tanh(z1)
    z2 = np.dot(w2, a1) + b2
    a2 = softmax(z2)
    
    #结果的维度
    n_rows = y_test.shape[0]
    n_cols = y_test.shape[1]

    #预测值结果存储
    output = np.empty(shape=(n_rows, n_cols), dtype=int)

    for i in range(n_rows):
        for j in range(n_cols):
            if a2[i][j] > 0.5:
                output[i][j] = 1
            else:
                output[i][j] = 0

    print('预测结果：')
    print(output)
    print('真实结果：')
    print(y_test)

    count = 0
    for k in range(0, n_cols):
        if output[0][k] == y_test[0][k] and output[1][k] == y_test[1][k] and output[2][k] == y_test[2][k]:
            count = count + 1
        else:
            print(k)

    acc = count / int(y_test.shape[1]) * 100
    print('准确率：%.2f%%' % acc)

    return output


#建立神经网络
def nn_model(X, Y, n_h, n_input, n_output, num_iterations=10000, print_cost=False):
    np.random.seed(3)

    n_x = n_input           # 输入层节点数
    n_y = n_output          # 输出层节点数
    
    #创建两个空的数组，分别存放迭代次数和cost
    iter_nums = []
    costs = []
    
    # 1.初始化参数
    parameters = initialize_parameters(n_x, n_h, n_y)

    # 梯度下降循环
    for i in range(0, num_iterations):
        # 2.前向传播
        a2, cache = forward_propagation(X, parameters)
        # 3.计算代价函数
        cost = compute_cost(a2, Y, parameters)
        # 4.反向传播
        grads = backward_propagation(parameters, cache, X, Y)
        # 5.更新参数
        parameters = update_parameters(parameters, grads)

        # 每100次迭代，输出一次代价函数
        if print_cost and i % 100 == 0:
            print('迭代第%i次，代价函数为：%f' % (i, cost))
            iter_nums.append(i)
            costs.append(cost)
    #绘制折线图
    #横轴为迭代次数
    #纵轴为cost
    plt.plot(iter_nums,costs,linewidth=4)
    #设置图表标题
    plt.title("Cost Function Value Variation Curve",fontsize=20)
    #给图表坐标轴添加标签
    plt.xlabel("Iteration times",fontsize=12)
    plt.ylabel("Cost Function Value",fontsize=12)
    #设置坐标轴刻度标记的大小
    plt.tick_params(axis='both',labelsize=10)
    plt.show()
    return parameters



if __name__ == "__main__":
    # 读取数据
    data_set = pd.read_csv('E:\\研究生\研一\\上半学年\\计算智能\\作业\\BP神经网络大作业\\Data\\iris_training.csv', header=None)

    # 从csv文件中分别取出特征和标签，其中X代表鸢尾花的特征，Y代表鸢尾花的种类标签
    X = data_set.iloc[:, 0:4].values.T          # 前四列是特征，T表示转置
    Y = data_set.iloc[:, 4:].values.T           # 后三列是标签

    Y = Y.astype('uint8')

    # 开始训练
    start_time = datetime.datetime.now()
    # 输入4个节点，隐层10个节点，输出3个节点，迭代10000次
    #该程序中以隐含层10个节点为例，为了分析作业中的第二问，隐含层节点数目需要从4变化到14
    parameters = nn_model(X, Y, n_h=10, n_input=4, n_output=3, num_iterations=10000, print_cost=True)
    end_time = datetime.datetime.now()
    print("用时：" + str((end_time - start_time).seconds) + 's' + str(round((end_time - start_time).microseconds / 1000)) + 'ms')

    # 对模型进行测试
    data_test = pd.read_csv('E:\\研究生\\研一\\上半学年\\计算智能\\作业\\BP神经网络大作业\\Data\\iris_test.csv', header=None)
    x_test = data_test.iloc[:, 0:4].values.T
    y_test = data_test.iloc[:, 4:].values.T
    y_test = y_test.astype('uint8')

    result = predict(parameters, x_test, y_test)
    
    
    
    
    
    
    
    
    
    
