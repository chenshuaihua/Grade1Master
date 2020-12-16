function Population = Popul(IndivNum,CityNum)
%POPUL 此函数用于随机生成一定大小的种群
%IndivNum 表示个体数量，即种群大小
%CityNum 表示一个个体中包含的城市数量
Population = zeros(IndivNum,CityNum);
for i = 1:IndivNum
    Population(i,:) = randperm(CityNum);
end
end

