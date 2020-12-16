%%%读取34个城市的数据，并从中选取前十个城市
CityDataOri = csvread('E:\研究生\研一\上半学年\计算智能\作业\演化计算大作业\数据\ChineseCity.csv');
CityNum = 10;
CityData = CityDataOri(1:CityNum,:);

%%%%%% 初始化蚁群优化算法的参数
ITER = 200;%%%% 最大迭代次数 
antnumber = 50;%%蚂蚁数量
beta = 5; %%启发式因子的重要程度
alpha = 0.9;%%信息素重要程度
rho = 0.1;%%信息素挥发因子    
Q = 1;%%蚂蚁信息素总量 

%%%%%%初始化路径相关参数
dis = Distance(CityData);%%%%% 得到这10个城市相互之间的距离
ita = 1./dis;%%%%%ita表示连接边e_{ij}距离的倒数  
Tau = ones(CityNum,CityNum);%%%%%Tau_{ij}连接边e_{ij}上的信息素    
PathRecord = zeros(antnumber,CityNum);%%%%%对路径进行记录
BestRoute = zeros(ITER,CityNum);%%%每一次迭代时得到的最好路径       
BestLength = zeros(ITER,1);%%%%每一次迭代时得到的最好路径的长度  
AverLen = zeros(ITER,1);%%%%每一次迭代时路径的平均长度  

for  iterori = 1:ITER
      BeginningCity = AntRandCity(antnumber,CityNum);%%%随机产生各个蚂蚁的起点城市
      PathRecord(:,1) = BeginningCity;
      CityInd = 1:CityNum;
      for i = 1:antnumber
         for j = 2:CityNum
             %%%%%禁忌表
             tabu = PathRecord(i,1:(j - 1));          
             CanVisitInd = ~ismember(CityInd,tabu);
             CanVisit = CityInd(CanVisitInd);
             P = CanVisit;
             %%%%%%%%根据概率选择下一城市
             for k = 1:length(CanVisit)
                 P(k) = Tau(tabu(end),CanVisit(k))^alpha * ita(tabu(end),CanVisit(k))^beta;
             end
             P = P/sum(P);
            %%%%%使用轮盘赌法进行选择
            Pc = cumsum(P);     
            target_index = find(Pc >= rand); 
            target = CanVisit(target_index(1));
            PathRecord(i,j) = target;
         end
      end
      Length = Len(CityData,PathRecord);
      %%%%%%计算最短路径距离及平均距离
      if iterori == 1
          [MinLength,MinInd] = min(Length);
          BestLength(iterori) = MinLength;  
          BestRoute(iterori,:) = PathRecord(MinInd,:);
          AverLen(iterori) = mean(Length);
      else
          [MinLength,MinInd] = min(Length);
          BestLength(iterori) = min(BestLength(iterori - 1),MinLength);
          AverLen(iterori) = mean(Length);
          if BestLength(iterori) == MinLength
              BestRoute(iterori,:) = PathRecord(MinInd,:);
          else
              BestRoute(iterori,:) = BestRoute((iterori-1),:);
          end
      end
      DeltaTau = zeros(CityNum,CityNum);
      % 逐个蚂蚁计算
      for r = 1:antnumber
          %%%%信息素增量的更新
          for s = 1:(CityNum - 1)
              DeltaTau(PathRecord(r,s),PathRecord(r,s+1)) = DeltaTau(PathRecord(r,s),PathRecord(r,s+1)) + Q/Length(r);
          end
          DeltaTau(PathRecord(r,CityNum),PathRecord(r,1)) = DeltaTau(PathRecord(r,CityNum),PathRecord(r,1)) + Q/Length(r);
      end
      %%%%信息素量的更新
      Tau = (1-rho) * Tau + DeltaTau;

    %%%%%最佳路径的迭代变化过程
    [ShortestLength,index] = min(BestLength(1:iterori));
    ShortestRoute = BestRoute(index,:);
    %%%%%%对
    PathRecord = zeros(antnumber,CityNum);
end
[ShortestLength,index] = min(BestLength);
ShortestRoute = BestRoute(index,:);
disp(['最短距离:' num2str(ShortestLength)]);
disp(['最短路径:' num2str([ShortestRoute ShortestRoute(1)])]);

%%%%%%对得到的结果进行可视化
figure(1)
plot([CityData(ShortestRoute,1);CityData(ShortestRoute(1),1)],[CityData(ShortestRoute,2);CityData(ShortestRoute(1),2)],'b*-','Linewidth',2);
for i = 1:size(CityData,1)
    text(CityData(i,1),CityData(i,2),['   ' num2str(i)]);
end
%%%%%%对城市的先后顺序进行标注，并标明起点和终点
text(CityData(ShortestRoute(1),1),CityData(ShortestRoute(1),2),'       Start');
text(CityData(ShortestRoute(end),1),CityData(ShortestRoute(end),2),'       End');
xlabel('横坐标')
ylabel('纵坐标')
title('ACO最优路径')
figure(2)
plot(1:ITER,BestLength,'b',1:ITER,AverLen,'r','Linewidth',1)
xlabel('迭代次数')
ylabel('距离')
title('平均距离与最短距离对比图')