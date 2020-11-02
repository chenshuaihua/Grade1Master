%%%%��ȡ�����ݴ��ҵ�����½��еķ���
%%%%%%%ѵ����105�����ݣ����Լ�45������
%%%%%%%���ֱ�Ϊ1��2��3
%%%%%%���ú���fcm3
iris_data = csvread('E:\�о���\��һ\�ϰ�ѧ��\��������\��ҵ\ģ��ϵͳ����ҵ\����\iris - ����.csv');
rand_position = randperm(size(iris_data,1));
iris_shuffle_data = iris_data(rand_position,:);
x = iris_shuffle_data(:,1:4);
y = iris_shuffle_data(:,5);
x_train = x(1:105,:);
y_train = y(1:105,:);
x_test = x(106:150,:);
y_test = y(106:150,:);


%%%%%%%ԭʼ���ݿ��ӻ�
setosaIndex = iris_shuffle_data(:,5)==1;
versicolorIndex = iris_shuffle_data(:,5)==2;
virginicaIndex = iris_shuffle_data(:,5)==3;

setosa = iris_shuffle_data(setosaIndex,:);
versicolor = iris_shuffle_data(versicolorIndex,:);
virginica = iris_shuffle_data(virginicaIndex,:);

Characteristics = {'sepal length','sepal width','petal length','petal width'};
pairs = [1 2; 1 3; 1 4; 2 3; 2 4; 3 4];

for z = 1:6
    x_feature = pairs(z,1); 
    y_feature = pairs(z,2);   
    subplot(2,3,z)
    plot([setosa(:,x_feature) versicolor(:,x_feature) virginica(:,x_feature)],...
         [setosa(:,y_feature) versicolor(:,y_feature) virginica(:,y_feature)], '.')
    xlabel(Characteristics{x_feature})
    ylabel(Characteristics{y_feature})
end

%%%%%���ô���fcm�����еĲ���
Nc = 3;
M = 2.0;
maxIter = 100;
minImprove = 1e-6;
clusteringOptions = [M maxIter minImprove true];

%%%%%ʹ��fcm�������о���
[centers,U,obj_fcn,train_error_list] = fcm3(x_train,y_train,Nc,clusteringOptions);
%%%%��Ҫ���ƾ����������������仯������ʱ������ȡ��ע��
% plot(train_error_list,'LineWidth',3);
% xlabel('��������')
% ylabel('�������')
% title('�������Ϊ3')
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


%%%%%������Լ��е�ÿһ�����ݵ���������������֮��ľ���
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
%%%%%%������Ծ���
for i = 1:size(x_test,1)
    if( y_test(i) == y_temp(i))
        count_right2 = count_right2 + 1;
    end
end

test_accuracy = count_right2/(size(x_test,1));
disp(test_accuracy)
%%%%%%%%%���ƾ�������Ӧͼ��
for i = 1:6
    subplot(2,3,i);
    for j = 1:Nc
        x = pairs(i,1);
        y = pairs(i,2);
        text(centers(j,x),centers(j,y),int2str(j),'FontWeight','bold');
    end
end

