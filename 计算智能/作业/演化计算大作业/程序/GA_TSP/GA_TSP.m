
%%%��ȡ34�����е����ݣ�������ѡȡǰʮ������
CityDataOri = csvread('E:\�о���\��һ\�ϰ�ѧ��\��������\��ҵ\�ݻ��������ҵ\����\ChineseCity.csv');
CityNum = 10;
CityData = CityDataOri(1:CityNum,:);

%%%%���еĺ�������
HorCoor = CityData(:,1);
VerCoor = CityData(:,2);

%%%%%��ʼ���Ŵ��㷨�Ĳ���
indiv = 50;%%%%%����50��
ITER = 300;%%%%��������300��
Pc = 0.9; %%%%�������0.9
Pm = 0.3;%%%%�������0.05
BestRoute = zeros(ITER,CityNum);%%%ÿһ�ε���ʱ�õ������·��       
BestLength = zeros(ITER,1);%%%%ÿһ�ε���ʱ�õ������·���ĳ���  
AverLen = zeros(ITER,1);%%%%ÿһ�ε���ʱ·����ƽ������  

%%%%%������Ⱥ��ʼ�������������ʮ������
Population = Popul(indiv,CityNum);
[len1,fit1] = Fitness(CityData,Population);

for iter = 1:ITER
    [len,fit] = Fitness(CityData,Population);
    %%%%%%����ÿһ�ε����õ���ƽ������
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
    %ѡ�����
    newpol = Select(Population,fit);
    Gcode = GEncode(newpol);
    %�������
    newPol2 = CrossOver(Gcode,Pc);
    
    %�������
    newPol3 = Mutation(newPol2,Pm);
    Population = GDecode(newPol3);
    
end

[bestIndiv,bestFit,bestLen] = Best(Population,fit,len);
disp(['��̾���Ϊ' num2str(bestLen)]);
disp(['���·��Ϊ' num2str([bestIndiv bestIndiv(1)])]);

%%%%%%%%�Եõ��Ľ�����п��ӻ�
figure(1)
plot([CityData(bestIndiv,1);CityData(bestIndiv(1),1)],[CityData(bestIndiv,2);CityData(bestIndiv(1),2)],'b*-','Linewidth',2);
for i = 1:size(CityData,1)
    text(CityData(i,1),CityData(i,2),['   ' num2str(i)]);
end
%%%%%%�Գ��е��Ⱥ�˳����б�ע�������������յ�
text(CityData(bestIndiv(1),1),CityData(bestIndiv(1),2),'      Start');
text(CityData(bestIndiv(end),1),CityData(bestIndiv(end),2),'      End');
xlabel('������');
ylabel('������');
title('GA����·��')

figure(2)
plot(1:ITER,BestLength,'b',1:ITER,AverLen,'r','Linewidth',1)
xlabel('��������')
ylabel('����')
title('ƽ����������̾���Ա�ͼ')


