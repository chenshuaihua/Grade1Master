%%%%读取的数据打乱的情况下进行的分类

%%%%%%%读取iris.csv中的数据
iris_data = csvread('E:\研究生\研一\上半学年\计算智能\作业\模糊系统大作业\数据\iris - 副本.csv');
rand_position = randperm(size(iris_data,1));
iris_shuffle_data = iris_data(rand_position,:);
iris_shuffle_data_1 = iris_shuffle_data(:,1:4);
[centers,U,obj_fcn] = fcm(iris_shuffle_data_1,3,[2.0;500;1e-5;1]);

cluster_class = zeros(150,1);
count_right = 0;

[temp3,index3] = max(centers(:,1),[],1); 
[temp1,index1] = min(centers(:,1),[],1);
index2 = 6 - index3 - index1;

for i = 1:150
    if(U(index1,i) > 0.5)
        cluster_class(i) = 1;
    elseif(U(index2,i) > 0.5)
        cluster_class(i) = 2;
    elseif(U(index3,i) > 0.5)
        cluster_class(i) = 3;
    end
end

for j = 1:150
    if(iris_shuffle_data(j,5) == cluster_class(j))
        count_right = count_right + 1;  
    end
end
accuracy = count_right/150;
disp(accuracy)
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