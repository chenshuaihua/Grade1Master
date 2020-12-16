function NewPol = CrossOver(GPol,Pc)
%CROSSOVER 对种群进行交叉
%输入： GPol，G编码后的种群    Pc,交叉后的概率
%输出：NewPol 交叉后的种群
[m,n] = size(GPol);
NewPol = zeros(m,n);
%%%相邻的两个个体之间 两两进行交换
for i = 1:2:m-1
    if rand < Pc
        %单点交叉
        ChangePoint = round(rand * n);
        NewPol(i,:) = [GPol(i,1:ChangePoint),GPol(i+1,ChangePoint+1:n)];
        NewPol(i+1,:) = [GPol(i+1,1:ChangePoint),GPol(i,ChangePoint+1:n)];
    else
        NewPol(i,:) = GPol(i,:);
        NewPol(i+1,:) = GPol(i+1,:);
    end
end
end

