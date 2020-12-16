%%%%%%% 初始化种群
f= @(x)x .* sin(3.*x) .* cos(2 * x) - 2 * x .* sin(3 * x); % 函数表达式
figure(1);
N = 64;                         % 初始种群个数
d = 1;                          % 空间维数
ger = 100;                      % 最大迭代次数     
limit = [0, 20];                % 设置位置参数限制
vlimit = [-1, 1];               % 设置速度限制
w = 0.8;                        % 惯性权重
c1 = 0.5;                       % 自我学习因子
c2 = 0.5;                       % 群体学习因子 
for i = 1:d
    x = limit(i, 1) + (limit(i, 2) - limit(i, 1)) * rand(N, d);%初始种群的位置
end
v = rand(N, d);                  % 初始种群的速度
xm = x;                          % 每个个体的历史最佳位置
ym = zeros(1, d);                % 种群的历史最佳位置
localindex = zeros(N,1);
IndivBest = zeros(N, 1);               % 每个个体的历史最佳适应度
fym = -inf;                      % 种群历史最佳适应度
LocalBest = zeros(N,1);
hold on
plot(xm, f(xm), 'r*');title('初始状态');
figure(2)
%%%%%%% 群体更新
iter = 1;
record = zeros(ger, 1);          % 记录器
while iter <= ger
     fx = f(x) ; % 个体当前适应度   
     for i = 1:N      
        if IndivBest(i) < fx(i)
            IndivBest(i) = fx(i);     % 更新个体历史最佳适应度
            xm(i,:) = x(i,:);   % 更新个体历史最佳位置
        end 
     end
     %%%%每个粒子和下一个粒子进行比较
     for j = 1:N
         if j == 1
               IndivTemp1 = [IndivBest(1),IndivBest(2),IndivBest(N)];
               LocalBest(1) = max(IndivTemp1);
               if LocalBest(1) == IndivBest(1)
                   localindex(1) = xm(1,:);              
               elseif LocalBest(1) == IndivBest(2)
                   localindex(1) = xm(2,:);
               else
                   localindex(1) = xm(N,:);
               end
         elseif j == N
               IndivTemp1 = [IIndivBest(1),IndivBest(N-1),IndivBest(N)];
               LocalBest(N) = max(IndivBest(1),IndivBest(N-1),IndivBest(N));
               if LocalBest(N) == IndivBest(1)
                   localindex(N) = xm(1,:);              
               elseif LocalBest(N) == IndivBest(N-1)
                   localindex(N) = xm(N-1,:);
               else
                   localindex(N) = xm(N,:);
               end
         else
               LocalBest(i) = max(IndivBest(i),IndivBest(i+1),IndivBest(i-1));
               if LocalBest(i) == IndivBest(i)
                   localindex(i) = xm(i,:);              
               elseif LocalBest(i) == IndivBest(i-1)
                   localindex(i) = xm(i-1,:);
               else
                   localindex(i) = xm(i+1,:);
               end
         end
     end
     
     if fym < max(IndivBest)
         [fym, nmax] = max(IndivBest);   % 更新群体历史最佳适应度
         ym = xm(nmax, :);      % 更新群体历史最佳位置
     end
%      v = v * w + c1 * rand * (xm - x) + c2 * rand * (repmat(ym, N, 1) - x);% 速度更新
     v = v * w + c1 * rand * (xm - x) + c2 * rand * (localindex - x);% 速度更新
     % 边界速度处理
     v(v > vlimit(2)) = vlimit(2);
     v(v < vlimit(1)) = vlimit(1);
     x = x + v;% 位置更新
     % 边界位置处理
     x(x > limit(2)) = limit(2);
     x(x < limit(1)) = limit(1);
     record(iter) = fym;%最大值记录
     x0 = 0 : 0.01 : 20;
     plot(x0, f(x0), 'b-', x, f(x), 'r*');title('粒子位置变化')
     xlabel('x')
     ylabel('y')
     pause(0.1)
     iter = iter+1;
end
figure(3);plot(record);title('收敛过程')
x0 = 0 : 0.01 : 20;
figure(4);plot(x0, f(x0), 'b-', x, f(x), 'r*');
title('粒子最终位置')
xlabel('x')
ylabel('y')
disp(['最大值：',num2str(fym)]);