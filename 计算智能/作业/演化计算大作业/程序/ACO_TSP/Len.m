function Pathlen = Len(CityData,PathRec)
%Len ����ÿ������һ������·�����ܳ���.
%���룺
%CityData��Ϊ��ȡ��10�����еĺ������������
%PathRec,��¼�������߹���·���ľ���
%�����Pathlen,Ϊ·������,
%%%mΪ����������nΪ��������
[m,n] = size(PathRec);
%%%%Pathelen���
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
