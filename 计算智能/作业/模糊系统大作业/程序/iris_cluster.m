%%%%%%%读取iris.csv中的数据
iris_data = csvread('E:\研究生\研一\上半学年\计算智能\作业\模糊系统大作业\数据\iris.csv');
iris_data_1 = iris_data(:,1:4);
[center,U,obj_fcn] = fcm(iris_data_1,3,[2.0;500;1e-5;1]);
U_T = U';
cluster_class = zeros(150,1);
count_right = 0;
for i = 1:150
    if(U_T(i,1) > 0.5)
        cluster_class(i) = 0;
    elseif(U_T(i,2) > 0.5)
        cluster_class(i) = 1;
    elseif(U_T(i,3) > 0.5)
        cluster_class(i) = 2;
    end
end

figure(1)
subplot(3,1,1);
plot(U(1,:),'-b');
title('隶属度矩阵值')
ylabel('第一类')
subplot(3,1,2);
plot(U(2,:),'-r');
ylabel('第二类')
subplot(3,1,3);
plot(U(3,:),'-g');
xlabel('样本数')
ylabel('第三类')
figure(2)
grid on
plot(obj_fcn);
title('目标函数变化值');
xlabel('迭代次数')
ylabel('目标函数值')