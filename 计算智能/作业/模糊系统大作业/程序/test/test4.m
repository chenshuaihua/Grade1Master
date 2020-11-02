%%%%��ȡ������δ���ҵ�����½��еķ���

%%%%%%%��ȡiris.csv�е�����
%%%%%%%ѵ����105�����ݣ����Լ�45������
iris_data = csvread('E:\�о���\��һ\�ϰ�ѧ��\��������\��ҵ\ģ��ϵͳ����ҵ\����\iris - ����.csv');
rand_position = randperm(size(iris_data,1));
iris_shuffle_data = iris_data(rand_position,:);
x_train = iris_shuffle_data(1:105,:);
y_train = x_train(:,5);
x_test = iris_shuffle_data(106:150,:);
y_test = x_test(:,5);

%%%%%���ô���fcm�����еĲ���
Nc = 4;
M = 2.0;
maxIter = 100;
minImprove = 1e-6;
clusteringOptions = [M maxIter minImprove true];

%%%%%ʹ��fcm�������о���
[centers,U,obj_fcn] = fcm(x_train,Nc,clusteringOptions);

centers_5thcol_round = round(centers(:,5));
centers_changed = [centers(:,1:4),centers_5thcol_round];

cluster_class = zeros(105,1);
count_right = 0;

index1 = find(centers_changed(:,5) == 1 );
index2 = find(centers_changed(:,5) == 2 );
index3 = find(centers_changed(:,5) == 3 );

for i = 1:size(x_train,1)
    if(size(index1,1)==2)
        if (U(index1(1),i) > 0.5) || (U(index1(2),i) > 0.5)
            cluster_class(i) = 1;
        elseif (U(index2,i) > 0.5)
            cluster_class(i) = 2;
        elseif (U(index3,i) > 0.5)  
            cluster_class(i) = 3;
        end
    elseif(size(index2,1)==2)
         if (U(index1,i) > 0.5) 
            cluster_class(i) = 1;
        elseif (U(index2(1),i) > 0.5) || (U(index2(2),i) > 0.5)
            cluster_class(i) = 2;
        elseif (U(index3,i) > 0.5) 
            cluster_class(i) = 3;
         end
    elseif(size(index3,1)==2)
         if (U(index1,i) > 0.5)
            cluster_class(i) = 1;
        elseif (U(index2,i) > 0.5)
            cluster_class(i) = 2;
        elseif (U(index3(1),i) > 0.5)  || (U(index3(2),i) > 0.5)
            cluster_class(i) = 3;
         end
    end
end

for j = 1:size(x_train,1)
    if(y_train(j) == cluster_class(j))
        count_right = count_right + 1;  
    end
end
accuracy = count_right/(size(x_train,1));
disp(accuracy)

%%%%%������Լ��е�ÿһ�����ݵ���������������֮��ľ���
eucli = zeros(1,Nc);
y_temp = zeros(45,1);
count_right2 = 0;
for i = 1:size(x_test,1)
    eucli = pdist2(x_test(i,:),centers);
    [temp4,index4] = min(eucli(1,:),[],2);
    if(size(index1,1)==2)
        if(index4 == index1(1)) || (index4 == index1(2))
            y_temp(i) = 1;
        elseif(index4 == index2)
            y_temp(i) = 2;
        elseif(index4 == index3)
            y_temp(i) = 3;
        end
    elseif(size(index2,1)==2) 
        if(index4 == index1)
            y_temp(i) = 1;
        elseif(index4 == index2(1)) || (index4 == index2(2))
            y_temp(i) = 2;
        elseif(index4 == index3)
            y_temp(i) = 3;
        end
    elseif(size(index3,1)==2)
        if(index4 == index1)
            y_temp(i) = 1;
        elseif(index4 == index2)
            y_temp(i) = 2;
        elseif(index4 == index3(1)) || (index4 == index3(2))
            y_temp(i) = 3;
        end
    end
end

for i = 1:size(x_test,1)
    if( y_test(i) == y_temp(i))
        count_right2 = count_right2 + 1;
    end
end

test_accuracy = count_right2/(size(x_test,1));
disp(test_accuracy)





