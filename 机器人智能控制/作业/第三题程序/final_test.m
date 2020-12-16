%%%%%%% 初始化种群
N = 64;                         % 初始种群个数
d = 1;                          % 空间维数
maxgen=50;   % 进化次数  
sizepop=100;   %种群规模
vartotal=3;         %变量个数

x_min=[5  0.1  5]';   %变量最小值
x_max=[40  5  40]';   %变量最大值
V_min= -0.2*(x_max-x_min);   %速度最小值
V_max= 0.2*(x_max-x_min);   %速度最大值

kp1 = zeros(N,1);
ki1 = zeros(N,1);
kd1 = zeros(N,1);
w = 0.8;                        % 惯性权重
c1 = 0.7;                       % 自我学习因子
c2 = 0.7;                       % 群体学习因子 
for i=1:sizepop
    %随机产生一个种群
    pop(i,:)= x_min' + 0.5*(x_max-x_min)'.*(ones(1,vartotal)+rands(1,vartotal));    %初始种群
    V(i,:)=  V_min' + 0.5*(V_max-V_min)'.*(ones(1,vartotal)+rands(1,vartotal));    %初始化速度
    %计算适应度
    fitness(i)=optfun(pop(i,:));   %染色体的适应度
end
disp(['初始化完成。进入计算过程'])
%找最好的染色体
[bestfitness,bestindex]=min(fitness);  %[最小值  列号]
zbest=pop(bestindex,:);   %全局最佳
gbest=pop;    %个体最佳
fitnessgbest=fitness;   %个体最佳适应度值
fitnesszbest=bestfitness;   %全局最佳适应度值


%%%%%%%% 迭代寻优
for i=1:maxgen   %每一次迭代更新
    disp(['-----------------------------------------------------------'])
    disp(['运算已进行到第  ',num2str(i),'/',num2str(maxgen),'  代'])
    for j=1:sizepop  %遍历每个粒子
        
        %速度更新
        V(j,:) = w*V(j,:) + c1*rand*(gbest(j,:) - pop(j,:)) + c2*rand*(zbest - pop(j,:)); %速度更新公式
        for k=1:vartotal       %每个变量
            if V(j,k)>V_max(k)  %对速度最大值的限定
                V(j,k)=V_max(k);
            end
            if V(j,k)<V_min(k)  %对速度最小值的限定
                V(j,k)=V_min(k);
            end
        end
        
        %种群更新
        pop(j,:,:)=pop(j,:)+0.5*V(j,:);   %位置更新公式
        for k=1:vartotal       %每个变量
            if pop(j,k)>x_max(k)  %对位置最大值的限定
                pop(j,k)=x_max(k);
            end
            if pop(j,k)<x_min(k)  %对位置最小值的限定
                pop(j,k)=x_min(k); 
            end
        end
        
        %自适应变异
        if rand>0.8  %概率为1-0.8
            k=ceil(vartotal*rand);   %ceil为向上取整
            pop(j,k)=x_min(k)' + (x_max(k)-x_min(k))'*rand;    %将某个粒子的位置变为随机值（改变一个坐标，另一个没变）
        end
    end
    parfor j=1:sizepop  %遍历每个粒子  
        %适应度值
        fitness(j)=optfun(pop(j,:));  %计算适应度
    end    
    for j=1:sizepop  %遍历每个粒子    
        %个体最优更新
        if fitness(j) < fitnessgbest(j)  %个体最佳适应度出现更小值
            gbest(j,:) = pop(j,:);        %更新个体最佳适应度位置
            fitnessgbest(j) = fitness(j);  %更新个体最佳适应度
        end
        
        %群体最优更新
        if fitness(j) < fitnesszbest  %群体最佳适应度出现更小值
            zbest = pop(j,:);  %更新群体最佳适应度位置
            fitnesszbest = fitness(j); %更新群体最佳适应度
        end
        
    end
    yy(i)=fitnesszbest;    %优化过程存储
    disp(['最优适应度为  ',num2str(fitnesszbest)])  
    disp([' x = ',num2str(zbest)])
end

%%%%%%%%% 结果分析
figure(1);
plot(yy,'-*')
title(['适应度曲线  ' '终止代数＝' num2str(maxgen)]);
xlabel('进化代数');ylabel('适应度');

toc
zbest
optfun(zbest)
% delete(gcp('nocreate'))


% 
% kpLocalIndex = zeros(N,1);
% kiLocalIndex = zeros(N,1);
% kdLocalIndex = zeros(N,1);
% 
% kpIndivBest = zeros(N, 1);               % 每个个体的历史最佳适应度
% kiIndivBest = zeros(N, 1); 
% kdIndivBest = zeros(N, 1); 
% 
% kpLocalBest = zeros(N,1);
% kiLocalBest = zeros(N,1);
% kdLocalBest = zeros(N,1);
% hold on
% %plot(xm, f(xm), 'ro');title('初始状态图');
% %figure(2)
% %%%%%%% 群体更新
% iter = 1;
% %record = zeros(ger, 1);          % 记录器
% J = zeros(N,1);
% while iter <= ger    
%     for count = 1:N
%         kp = kpdata(count);
%         ki = kidata(count);
%         kd = kddata(count);
%         kp1(count) = kp;
%         ki1(count) = ki;
%         kd1(count) = kd;
%         [t] = sim('PID1',[0,10]);
%         num = length(t);
%         output = getdatasamples(out,1:num);
%         output1 = output(end,:);
%         J(count) = output1;
%     end
%     [minJ,minindex] = min(J); 
%     for i = 1:N      
%        if kpIndivBest(i) < J(i)
%            kpIndivBest(i) = J(i);     % 更新个体历史最佳适应度
%            kp1(i,:) = kpdata(i,:);   % 更新个体历史最佳位置
%        end 
%        if kiIndivBest(i) < J(i)
%            kiIndivBest(i) = J(i);     % 更新个体历史最佳适应度
%            ki1(i,:) = kidata(i,:);   % 更新个体历史最佳位置
%        end 
%        if kdIndivBest(i) < J(i)
%            kdIndivBest(i) = J(i);     % 更新个体历史最佳适应度
%            kd1(i,:) = kddata(i,:);   % 更新个体历史最佳位置
%        end 
%     end
%     
%      %%%%冯诺依曼结构
%      [kpLocalBest,kpLocalIndex] = NeumannStru(kpIndivBest,kp1);
%      [kiLocalBest,kiLocalIndex] = NeumannStru(kiIndivBest,ki1);
%      [kdLocalBest,kdLocalIndex] = NeumannStru(kdIndivBest,kd1);
% %      
% %      if fym < max(IndivBest)
% %          [fym, nmax] = max(IndivBest);   % 更新群体历史最佳适应度
% %          ym = xm(nmax, :);      % 更新群体历史最佳位置
% %      end
% %      v = v * w + c1 * rand * (xm - x) + c2 * rand * (repmat(ym, N, 1) - x);% 速度更新
%      kpv = kpv * w + c1 * rand * (kp1 - kpdata) + c2 * rand * (kpLocalIndex - kpdata);% 速度更新
%      kiv = kiv * w + c1 * rand * (ki1 - kidata) + c2 * rand * (kiLocalIndex - kidata);% 速度更新
%      kdv = kdv * w + c1 * rand * (kd1 - kddata) + c2 * rand * (kdLocalIndex - kddata);% 速度更新
%      % 边界速度处理
%      kpv(kpv > kpvlimit(2)) = kpvlimit(2);
%      kpv(kpv < kpvlimit(1)) = kpvlimit(1);
%      kiv(kiv > kivlimit(2)) = kivlimit(2);
%      kiv(kiv < kivlimit(1)) = kivlimit(1);
%      kdv(kdv > kdvlimit(2)) = kdvlimit(2);
%      kdv(kdv < kdvlimit(1)) = kdvlimit(1);
%      
%      kpdata = kpdata + kpv;% 位置更新
%      kidata = kidata + kiv;% 位置更新
%      kddata = kddata + kdv;% 位置更新
%      
%      % 边界位置处理
%      kpdata(kpdata > kplimit(2)) = kplimit(2);
%      kpdata(kpdata < kplimit(1)) = kplimit(1);
%      kidata(kidata > kplimit(2)) = kilimit(2);
%      kidata(kidata < kplimit(1)) = kilimit(1);
%      kddata(kddata > kdlimit(2)) = kdlimit(2);
%      kddata(kddata < kdlimit(1)) = kdlimit(1);
%      
%      iter = iter+1;
% end
