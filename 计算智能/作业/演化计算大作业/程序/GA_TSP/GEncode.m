function Gcode = GEncode(Pol)
%GENCODE 对种群中的每一个个体进行G编码
%输入 Pol：为一个矩阵，行数为个体数量，列数为城市数量
[m,n] = size(Pol);
Gcode = zeros(m,n);
for i=1:m
      seq = 1:1:m;
      for j = 1:n
         location = find(Pol(i,j)==seq);
         Gcode(i,j) = location(1);
         seq(location(1)) = [];
      end
end
end

