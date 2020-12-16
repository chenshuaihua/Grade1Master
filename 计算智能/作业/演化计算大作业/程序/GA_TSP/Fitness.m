function [Pathlen,Fit] = Fitness(CityData,Pol)
%Fitness ����ÿһ���������Ӧ�ȵ�ֵ����Ӧ��=1/ÿһ�������·�����ȣ���Ӧ��Խ�󣬸ø���Խ��.
%���룺
%CityData��Ϊ��ȡ��10�����еĺ������������
%Pol,Ϊ���ɵ���Ⱥ
%�����
%Pathlen,Ϊ·�����ȣ�FitΪ��Ӧ��
[m,n] = size(Pol);
%%%%Pathelen���
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

