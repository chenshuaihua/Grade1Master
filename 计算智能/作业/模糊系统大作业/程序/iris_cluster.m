%%%%%%%��ȡiris.csv�е�����
iris_data = csvread('E:\�о���\��һ\�ϰ�ѧ��\��������\��ҵ\ģ��ϵͳ����ҵ\����\iris.csv');
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
title('�����Ⱦ���ֵ')
ylabel('��һ��')
subplot(3,1,2);
plot(U(2,:),'-r');
ylabel('�ڶ���')
subplot(3,1,3);
plot(U(3,:),'-g');
xlabel('������')
ylabel('������')
figure(2)
grid on
plot(obj_fcn);
title('Ŀ�꺯���仯ֵ');
xlabel('��������')
ylabel('Ŀ�꺯��ֵ')