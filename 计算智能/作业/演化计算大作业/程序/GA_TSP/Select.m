function NewPol = Select(Pol,fitness)
%SELECT ����Ⱥ����ѡ��
%���룺
%Pol,��Ⱥ
%fitness����Ӧ�Ⱦ���
%�����
%ѡ������Ⱥ
[m,~] = size(Pol);
TotalFitness = sum(fitness);
%%%%�������и������Ӧ��������ۼƷֲ�����
Profitness = cumsum(fitness/TotalFitness);
%%%%����m��0��1�ڵ������,����С��������
randnumber = sort(rand(m,1));
NewCount = 1;
OldCount = 1;
while NewCount <= m
    if randnumber(NewCount) < Profitness(OldCount)
        NewPol(NewCount,:) = Pol(OldCount,:);
        NewCount = NewCount + 1;
    else
        OldCount = OldCount + 1;
    end
end
end

