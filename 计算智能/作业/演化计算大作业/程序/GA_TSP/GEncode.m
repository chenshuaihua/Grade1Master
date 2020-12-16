function Gcode = GEncode(Pol)
%GENCODE ����Ⱥ�е�ÿһ���������G����
%���� Pol��Ϊһ����������Ϊ��������������Ϊ��������
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

