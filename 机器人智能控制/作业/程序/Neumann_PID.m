%%%%%%% 初始化种群
N = 64;                         % 初始种群个数
d = 1;                          % 空间维数
ger = 50;                      % 最大迭代次数     

kpvlimit = [-1, 1];               % 设置速度限制
kivlimit = [-1, 1];               % 设置速度限制
kdvlimit = [-1, 1];               % 设置速度限制

kplimit = 30:40;
kilimit = 0.1:0.1:2;
kdlimit = 30:40;

kp1 = zeros(N,1);
ki1 = zeros(N,1);
kd1 = zeros(N,1);
w = 0.8;                        % 惯性权重
c1 = 1.5;                       % 自我学习因子
c2 = 1.5;                       % 群体学习因子 
for i = 1:d
    kpdata = kplimit(i, 1) + (kplimit(i, 11) - kplimit(i, 1)) * rand(N, d);%初始种群的位置
    kidata = kilimit(i, 1) + (kilimit(i, 20) - kilimit(i, 1)) * rand(N, d);%初始种群的位置
    kddata = kdlimit(i, 1) + (kdlimit(i, 11) - kdlimit(i, 1)) * rand(N, d);%初始种群的位置
end
kpv = rand(N, d);                  % 初始种群的速度
kiv = rand(N, d);                  % 初始种群的速度
kdv = rand(N, d);                  % 初始种群的速度

kpLocalIndex = zeros(N,1);
kiLocalIndex = zeros(N,1);
kdLocalIndex = zeros(N,1);               %%局部最优适应度的索引位置

kpLocalBest = zeros(N,1);
kiLocalBest = zeros(N,1);                %%局部最优适应度
kdLocalBest = zeros(N,1);

kpIndivBest = zeros(N, 1);               % 每个个体的历史最佳适应度
kiIndivBest = zeros(N, 1); 
kdIndivBest = zeros(N, 1); 

iter = 1;

J = zeros(N,1);
Jrecord = zeros(ger,1);
while iter <= ger    
    disp(['运算已进行到第  ',num2str(iter),'/',num2str(ger),'  代'])
    for count = 1:N
        kp = kpdata(count);%%%%输入进入模型中的kp,ki,kd三个参数
        ki = kidata(count);
        kd = kddata(count);
        kp1(count) = kp;  %%对kp,ki,kd三个参数进行记录
        ki1(count) = ki;
        kd1(count) = kd;
        [t] = sim('PID1',[0,10]);
        num = length(t);  %%%记录t的长度，
        output = getdatasamples(out,1:num);
        output1 = output(end,:);
        J(count) = output1;
    end
    [minJ,minindex] = min(J); %%%%%记录最小的J
    Jrecord(iter,1) = minJ;
    for i = 1:N      
       if kpIndivBest(i) < J(i)
           kpIndivBest(i) = J(i);     % 更新个体历史最佳适应度
           kp1(i,:) = kpdata(i,:);   % 更新个体历史最佳位置
       end 
       if kiIndivBest(i) < J(i)
           kiIndivBest(i) = J(i);     % 更新个体历史最佳适应度
           ki1(i,:) = kidata(i,:);   % 更新个体历史最佳位置
       end 
       if kdIndivBest(i) < J(i)
           kdIndivBest(i) = J(i);     % 更新个体历史最佳适应度
           kd1(i,:) = kddata(i,:);   % 更新个体历史最佳位置
       end 
    end
    
     %%%%冯诺依曼结构
     [kpLocalBest,kpLocalIndex] = NeumannStru(kpIndivBest,kp1);
     [kiLocalBest,kiLocalIndex] = NeumannStru(kiIndivBest,ki1);
     [kdLocalBest,kdLocalIndex] = NeumannStru(kdIndivBest,kd1);

     kpv = kpv * w + c1 * rand * (kp1 - kpdata) + c2 * rand * (kpLocalIndex - kpdata);% 速度更新
     kiv = kiv * w + c1 * rand * (ki1 - kidata) + c2 * rand * (kiLocalIndex - kidata);% 速度更新
     kdv = kdv * w + c1 * rand * (kd1 - kddata) + c2 * rand * (kdLocalIndex - kddata);% 速度更新
     % 边界速度处理
     kpv(kpv > kpvlimit(2)) = kpvlimit(2);
     kpv(kpv < kpvlimit(1)) = kpvlimit(1);
     kiv(kiv > kivlimit(2)) = kivlimit(2);
     kiv(kiv < kivlimit(1)) = kivlimit(1);
     kdv(kdv > kdvlimit(2)) = kdvlimit(2);
     kdv(kdv < kdvlimit(1)) = kdvlimit(1);
     
     kpdata = kpdata + kpv;% 位置更新
     kidata = kidata + kiv;% 位置更新
     kddata = kddata + kdv;% 位置更新
     
     % 边界位置处理
     kpdata(kpdata > kplimit(11)) = kplimit(11);
     kpdata(kpdata < kplimit(1)) = kplimit(1);
     kidata(kidata > kilimit(20)) = kilimit(20);
     kidata(kidata < kilimit(1)) = kilimit(1);
     kddata(kddata > kdlimit(11)) = kdlimit(11);
     kddata(kddata < kdlimit(1)) = kdlimit(1);
     
     iter = iter+1;
end