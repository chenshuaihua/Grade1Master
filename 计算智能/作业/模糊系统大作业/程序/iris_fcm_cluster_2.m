%%%%读取的数据打乱的情况下进行的分类

%%%%%%%读取iris.csv中的数据
%%%%%%%训练集105条数据，测试集45条数据
%%%%%%%类别分别为1、2、3
iris_data = csvread('E:\研究生\研一\上半学年\计算智能\作业\模糊系统大作业\数据\iris - 副本.csv');
rand_position = randperm(size(iris_data,1));
iris_shuffle_data = iris_data(rand_position,:);
x = iris_shuffle_data(:,1:4);
y = iris_shuffle_data(:,5);
x_train = x(1:105,:);
y_train = y(1:105,:);
x_test = x(106:150,:);
y_test = y(106:150,:);

%%%%%设置传入fcm函数中的参数
Nc = 3;
M = 2.0;
maxIter = 100;
minImprove = 1e-6;
clusteringOptions = [M maxIter minImprove true];

%%%%%使用fcm函数进行聚类
[centers,U,obj_fcn] = fcm(x_train,Nc,clusteringOptions);

cluster_class = zeros(105,1);
count_right = 0;

[temp3,index3] = max(centers(:,1),[],1); 
[temp1,index1] = min(centers(:,1),[],1);
index2 = 6 - index3 - index1;

for i = 1:size(x_train,1)
    if(U(index1,i) > 0.5)
        cluster_class(i) = 1;
    elseif(U(index2,i) > 0.5)
        cluster_class(i) = 2;
    elseif(U(index3,i) > 0.5)
        cluster_class(i) = 3;
    end
end

for j = 1:size(x_train,1)
    if(y_train(j) == cluster_class(j))
        count_right = count_right + 1;  
    end
end
accuracy = count_right/(size(x_train,1));
disp(accuracy)


%%%%%计算测试集中的每一个数据点与三个聚类中心之间的距离
eucli = zeros(1,3);
y_temp = zeros(45,1);
count_right2 = 0;
for i = 1:size(x_test,1)
    eucli = pdist2(x_test(i,:),centers);
    [temp4,index4] = min(eucli(1,:),[],2);
    if(index4 == index1)
        y_temp(i) = 1;
    elseif(index4 == index2)
        y_temp(i) = 2;
    elseif(index4 == index3)
        y_temp(i) = 3;
    end
end

for i = 1:size(x_test,1)
    if( y_test(i) == y_temp(i))
        count_right2 = count_right2 + 1;
    end
end

test_accuracy = count_right2/(size(x_test,1));
disp(test_accuracy)



% figure(1)
% subplot(3,1,1);
% plot(U(1,:),'-b');
% title('隶属度矩阵值')
% ylabel('第一类')
% subplot(3,1,2);
% plot(U(2,:),'-r');
% ylabel('第二类')
% subplot(3,1,3);
% plot(U(3,:),'-g');
% xlabel('样本数')
% ylabel('第三类')
% figure(2)
% grid on
% plot(obj_fcn);
% title('目标函数变化值');
% xlabel('迭代次数')
% ylabel('目标函数值')