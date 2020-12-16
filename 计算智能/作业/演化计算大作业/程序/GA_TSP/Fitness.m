function [Pathlen,Fit] = Fitness(CityData,Pol)
%Fitness 计算每一个个体的适应度的值，适应度=1/每一个个体的路径长度，适应度越大，该个体越好.
%输入：
%CityData，为读取的10个城市的横纵坐标的数据
%Pol,为生成的种群
%输出：
%Pathlen,为路径长度；Fit为适应度
[m,n] = size(Pol);
%%%%Pathelen存放
Pathlen = zeros(m,1);

for i  = 1:m
    for j = 1:n
        if j==10
            Pathlen(i,1) = ((CityData(Pol(i,j),1)-CityData(Pol(i,1),1))^2 + (CityData(Pol(i,j),2)-CityData(Pol(i,1),2))^2)^0.5+Pathlen(i,1);
        else
            Pathlen(i,1)=((CityData(Pol(i,j),1)-CityData(Pol(i,j+1),1))^2 + (CityData(Pol(i,j),2)-CityData(Pol(i,j+1),2))^2)^0.5 + Pathlen(i,1);
        end
    end
end
Fit = 1./Pathlen;
end

