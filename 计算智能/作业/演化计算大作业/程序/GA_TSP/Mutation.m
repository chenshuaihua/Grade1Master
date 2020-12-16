function NewPol = Mutation(GPol,Pm)
%MUTATION 对个体进行变异操作
%输入： GPol：选择后的结果
%输出： NewPol：变异后的种群
[m,n] = size(GPol);
NewPol = zeros(m,n);
a = rand(m,1);
for i = 1:m
    if a(i,1) < Pm
        %随机选取基因变异的位置
        MPoint = randperm(9,1);
        %变异位置的数
        MNumber = randperm(n - MPoint + 1,1);
        GPol(i,MPoint) = MNumber;
        NewPol(i,:) = GPol(i,:);
    else
        NewPol(i,:) = GPol(i,:);
    end
end
% for j = 1:m
%     [length,fit] = Fitness(CityData,GPol)
%     if fit()
% end
end

