function Population = Popul(IndivNum,CityNum)
%POPUL �˺��������������һ����С����Ⱥ
%IndivNum ��ʾ��������������Ⱥ��С
%CityNum ��ʾһ�������а����ĳ�������
Population = zeros(IndivNum,CityNum);
for i = 1:IndivNum
    Population(i,:) = randperm(CityNum);
end
end

