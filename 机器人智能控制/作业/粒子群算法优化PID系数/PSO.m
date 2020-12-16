%%%%%%% 清空环境
set(0,'defaultfigurecolor','w')
% parpool(4)  启用4线程并行计算，打开MATLAB时运行一次就可以，否则会报错
clear
tic;  %计时
disp(['提示：程序开始运行，根据电脑配置不同，可能需要时间较长，请耐心等待'])
%%%%%% 参数初始化
%粒子群算法中的两个参数
c1 = 1.49445;
c2 = 1.49445;
w = 0.8;
maxgen=50;   % 进化次数  
sizepop=100;   %种群规模
vartotal=3;         %变量个数

x_min=[0  0  0]';   %变量最小值
x_max=[7  2  7]';   %变量最大值
V_min= -0.2*(x_max-x_min);   %速度最小值
V_max= 0.2*(x_max-x_min);   %速度最大值


%%%%%% 产生初始粒子和速度
disp(['正在初始化粒子坐标和速度'])
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



