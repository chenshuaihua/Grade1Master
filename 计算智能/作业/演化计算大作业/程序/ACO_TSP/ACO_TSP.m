%%%��ȡ34�����е����ݣ�������ѡȡǰʮ������
CityDataOri = csvread('E:\�о���\��һ\�ϰ�ѧ��\��������\��ҵ\�ݻ��������ҵ\����\ChineseCity.csv');
CityNum = 10;
CityData = CityDataOri(1:CityNum,:);

%%%%%% ��ʼ����Ⱥ�Ż��㷨�Ĳ���
ITER = 200;%%%% ���������� 
antnumber = 50;%%��������
beta = 5; %%����ʽ���ӵ���Ҫ�̶�
alpha = 0.9;%%��Ϣ����Ҫ�̶�
rho = 0.1;%%��Ϣ�ػӷ�����    
Q = 1;%%������Ϣ������ 

%%%%%%��ʼ��·����ز���
dis = Distance(CityData);%%%%% �õ���10�������໥֮��ľ���
ita = 1./dis;%%%%%ita��ʾ���ӱ�e_{ij}����ĵ���  
Tau = ones(CityNum,CityNum);%%%%%Tau_{ij}���ӱ�e_{ij}�ϵ���Ϣ��    
PathRecord = zeros(antnumber,CityNum);%%%%%��·�����м�¼
BestRoute = zeros(ITER,CityNum);%%%ÿһ�ε���ʱ�õ������·��       
BestLength = zeros(ITER,1);%%%%ÿһ�ε���ʱ�õ������·���ĳ���  
AverLen = zeros(ITER,1);%%%%ÿһ�ε���ʱ·����ƽ������  

for  iterori = 1:ITER
      BeginningCity = AntRandCity(antnumber,CityNum);%%%��������������ϵ�������
      PathRecord(:,1) = BeginningCity;
      CityInd = 1:CityNum;
      for i = 1:antnumber
         for j = 2:CityNum
             %%%%%���ɱ�
             tabu = PathRecord(i,1:(j - 1));          
             CanVisitInd = ~ismember(CityInd,tabu);
             CanVisit = CityInd(CanVisitInd);
             P = CanVisit;
             %%%%%%%%���ݸ���ѡ����һ����
             for k = 1:length(CanVisit)
                 P(k) = Tau(tabu(end),CanVisit(k))^alpha * ita(tabu(end),CanVisit(k))^beta;
             end
             P = P/sum(P);
            %%%%%ʹ�����̶ķ�����ѡ��
            Pc = cumsum(P);     
            target_index = find(Pc >= rand); 
            target = CanVisit(target_index(1));
            PathRecord(i,j) = target;
         end
      end
      Length = Len(CityData,PathRecord);
      %%%%%%�������·�����뼰ƽ������
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
      % ������ϼ���
      for r = 1:antnumber
          %%%%��Ϣ�������ĸ���
          for s = 1:(CityNum - 1)
              DeltaTau(PathRecord(r,s),PathRecord(r,s+1)) = DeltaTau(PathRecord(r,s),PathRecord(r,s+1)) + Q/Length(r);
          end
          DeltaTau(PathRecord(r,CityNum),PathRecord(r,1)) = DeltaTau(PathRecord(r,CityNum),PathRecord(r,1)) + Q/Length(r);
      end
      %%%%��Ϣ�����ĸ���
      Tau = (1-rho) * Tau + DeltaTau;

    %%%%%���·���ĵ����仯����
    [ShortestLength,index] = min(BestLength(1:iterori));
    ShortestRoute = BestRoute(index,:);
    %%%%%%��
    PathRecord = zeros(antnumber,CityNum);
end
[ShortestLength,index] = min(BestLength);
ShortestRoute = BestRoute(index,:);
disp(['��̾���:' num2str(ShortestLength)]);
disp(['���·��:' num2str([ShortestRoute ShortestRoute(1)])]);

%%%%%%�Եõ��Ľ�����п��ӻ�
figure(1)
plot([CityData(ShortestRoute,1);CityData(ShortestRoute(1),1)],[CityData(ShortestRoute,2);CityData(ShortestRoute(1),2)],'b*-','Linewidth',2);
for i = 1:size(CityData,1)
    text(CityData(i,1),CityData(i,2),['   ' num2str(i)]);
end
%%%%%%�Գ��е��Ⱥ�˳����б�ע�������������յ�
text(CityData(ShortestRoute(1),1),CityData(ShortestRoute(1),2),'       Start');
text(CityData(ShortestRoute(end),1),CityData(ShortestRoute(end),2),'       End');
xlabel('������')
ylabel('������')
title('ACO����·��')
figure(2)
plot(1:ITER,BestLength,'b',1:ITER,AverLen,'r','Linewidth',1)
xlabel('��������')
ylabel('����')
title('ƽ����������̾���Ա�ͼ')