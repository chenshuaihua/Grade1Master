function dis = Distance(citydata)
%DISTANCE 计算若干个城市之间之间的距离，得到一个距离矩阵
%输入citydata：为所选城市的坐标矩阵
%输出dis，为一个距离矩阵
n = size(citydata,1);
dis = zeros(n,n);
for i = 1:n
    for j = 1:n
        if i ~= j
            dis(i,j) = sqrt(sum((citydata(i,:) - citydata(j,:)).^2));
        else
            dis(i,j) = 1e-4;      
        end
    end    
end
end

