%%%%读取的数据未打乱的情况下进行的分类

iris = csvread('E:\研究生\研一\上半学年\计算智能\作业\模糊系统大作业\数据\iris - 副本.csv');
iris_data = iris(:,1:4);

setosaIndex = iris(:,5)==1;
versicolorIndex = iris(:,5)==2;
virginicaIndex = iris(:,5)==3;

setosa = iris(setosaIndex,:);
versicolor = iris(versicolorIndex,:);
virginica = iris(virginicaIndex,:);

Characteristics = {'sepal length','sepal width','petal length','petal width'};
pairs = [1 2; 1 3; 1 4; 2 3; 2 4; 3 4];

for i = 1:6
    x = pairs(i,1); 
    y = pairs(i,2);   
    subplot(2,3,i)
    plot([setosa(:,x) versicolor(:,x) virginica(:,x)],...
         [setosa(:,y) versicolor(:,y) virginica(:,y)], '.')
    xlabel(Characteristics{x})
    ylabel(Characteristics{y})
end

Nc = 3;
M = 2.0;
maxIter = 100;
minImprove = 1e-6;

clusteringOptions = [M maxIter minImprove true];
[centers,U] = fcm(iris_data,Nc,clusteringOptions);


[temp3,index3] = max(centers(:,1),[],1); 
[temp1,index1] = min(centers(:,1),[],1);
index2 = 6 - index3 - index1;
CL1 = 0;
CL2 = 0;
CL3 = 0;
CL  = 0;
for i = 1:50
    if(U(index1,i) > 0.5)
        CL1 = CL1 + 1;
    end
end
for i = 51:100
    if(U(index2,i) > 0.5)
        CL2 = CL2 + 1;
    end
end
for i = 101:150
    if(U(index3,i) > 0.5)
        CL3 = CL3 + 1;
    end
end
CL = CL1 + CL2 + CL3;
accuracy = CL/(size(iris,1));

disp(accuracy);
% for i = 1:6
%     subplot(2,3,i);
%     for j = 1:Nc
%         x = pairs(i,1);
%         y = pairs(i,2);
%         text(centers(j,x),centers(j,y),int2str(j),'FontWeight','bold');
%     end
% end








