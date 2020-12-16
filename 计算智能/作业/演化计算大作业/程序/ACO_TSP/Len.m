function Pathlen = Len(CityData,PathRec)
%Len 计算每个蚂蚁一次所走路径的总长度.
%输入：
%CityData，为读取的10个城市的横纵坐标的数据
%PathRec,记录蚂蚁所走过的路径的矩阵，
%输出：Pathlen,为路径长度,
%%%m为蚂蚁数量，n为城市数量
[m,n] = size(PathRec);
%%%%Pathelen存放
Pathlen = zeros(m,1);

for i  = 1:m
    for j = 1:n
        if j==10
            Pathlen(i,1) = ((CityData(PathRec(i,j),1)-CityData(PathRec(i,1),1))^2 + (CityData(PathRec(i,j),2)-CityData(PathRec(i,1),2))^2)^0.5+Pathlen(i,1);
        else
            Pathlen(i,1)=((CityData(PathRec(i,j),1)-CityData(PathRec(i,j+1),1))^2 + (CityData(PathRec(i,j),2)-CityData(PathRec(i,j+1),2))^2)^0.5 + Pathlen(i,1);
        end
    end
end
end
