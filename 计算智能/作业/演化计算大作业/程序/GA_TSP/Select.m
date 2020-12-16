function NewPol = Select(Pol,fitness)
%SELECT 对种群进行选择
%输入：
%Pol,种群
%fitness，适应度矩阵
%输出：
%选择后的种群
[m,~] = size(Pol);
TotalFitness = sum(fitness);
%%%%根据所有个体的适应度求解其累计分布概率
Profitness = cumsum(fitness/TotalFitness);
%%%%生成m个0—1内的随机数,并从小到大排列
randnumber = sort(rand(m,1));
NewCount = 1;
OldCount = 1;
while NewCount <= m
    if randnumber(NewCount) < Profitness(OldCount)
        NewPol(NewCount,:) = Pol(OldCount,:);
        NewCount = NewCount + 1;
    else
        OldCount = OldCount + 1;
    end
end
end

