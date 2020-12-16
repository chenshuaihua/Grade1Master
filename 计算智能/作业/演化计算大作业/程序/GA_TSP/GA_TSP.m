
%%%读取34个城市的数据，并从中选取前十个城市
CityDataOri = csvread('E:\研究生\研一\上半学年\计算智能\作业\演化计算大作业\数据\ChineseCity.csv');
CityNum = 10;
CityData = CityDataOri(1:CityNum,:);

%%%%城市的横纵坐标
HorCoor = CityData(:,1);
VerCoor = CityData(:,2);

%%%%%初始化遗传算法的参数
indiv = 50;%%%%%个体50个
ITER = 300;%%%%迭代次数300次
Pc = 0.9; %%%%交叉概率0.9
Pm = 0.3;%%%%变异概率0.05
BestRoute = zeros(ITER,CityNum);%%%每一次迭代时得到的最好路径       
BestLength = zeros(ITER,1);%%%%每一次迭代时得到的最好路径的长度  
AverLen = zeros(ITER,1);%%%%每一次迭代时路径的平均长度  

%%%%%进行种群初始化，随机生成五十个个体
Population = Popul(indiv,CityNum);
[len1,fit1] = Fitness(CityData,Population);

for iter = 1:ITER
    [len,fit] = Fitness(CityData,Population);
    %%%%%%计算每一次迭代得到的平均距离
    if iter == 1
        [min_Length,min_index] = min(len);
        BestLength(iter) = min_Length;  
        BestRoute(iter,:) = Population(min_index,:);
        AverLen(iter) = mean(len);
    else
        [min_Length,min_index] = min(len);
        BestLength(iter) = min(BestLength(iter - 1),min_Length);
        AverLen(iter) = mean(len);
        if BestLength(iter) == min_Length
              BestRoute(iter,:) = Population(min_index,:);
        else
            BestRoute(iter,:) = BestRoute((iter-1),:);
        end
      
    end
    %选择操作
    newpol = Select(Population,fit);
    Gcode = GEncode(newpol);
    %交叉操作
    newPol2 = CrossOver(Gcode,Pc);
    
    %变异操作
    newPol3 = Mutation(newPol2,Pm);
    Population = GDecode(newPol3);
    
end

[bestIndiv,bestFit,bestLen] = Best(Population,fit,len);
disp(['最短距离为' num2str(bestLen)]);
disp(['最短路径为' num2str([bestIndiv bestIndiv(1)])]);

%%%%%%%%对得到的结果进行可视化
figure(1)
plot([CityData(bestIndiv,1);CityData(bestIndiv(1),1)],[CityData(bestIndiv,2);CityData(bestIndiv(1),2)],'b*-','Linewidth',2);
for i = 1:size(CityData,1)
    text(CityData(i,1),CityData(i,2),['   ' num2str(i)]);
end
%%%%%%对城市的先后顺序进行标注，并标明起点和终点
text(CityData(bestIndiv(1),1),CityData(bestIndiv(1),2),'      Start');
text(CityData(bestIndiv(end),1),CityData(bestIndiv(end),2),'      End');
xlabel('横坐标');
ylabel('纵坐标');
title('GA最优路径')

figure(2)
plot(1:ITER,BestLength,'b',1:ITER,AverLen,'r','Linewidth',1)
xlabel('迭代次数')
ylabel('距离')
title('平均距离与最短距离对比图')


