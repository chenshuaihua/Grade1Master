function NewPol = Mutation(GPol,Pm)
%MUTATION �Ը�����б������
%���룺 GPol��ѡ���Ľ��
%����� NewPol����������Ⱥ
[m,n] = size(GPol);
NewPol = zeros(m,n);
a = rand(m,1);
for i = 1:m
    if a(i,1) < Pm
        %���ѡȡ��������λ��
        MPoint = randperm(9,1);
        %����λ�õ���
        MNumber = randperm(n - MPoint + 1,1);
        GPol(i,MPoint) = MNumber;
        NewPol(i,:) = GPol(i,:);
    else
        NewPol(i,:) = GPol(i,:);
    end
end
% for j = 1:m
%     [length,fit] = Fitness(CityData,GPol)
%     if fit()
% end
end

