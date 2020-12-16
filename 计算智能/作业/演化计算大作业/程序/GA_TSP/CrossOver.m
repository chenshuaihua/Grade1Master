function NewPol = CrossOver(GPol,Pc)
%CROSSOVER ����Ⱥ���н���
%���룺 GPol��G��������Ⱥ    Pc,�����ĸ���
%�����NewPol ��������Ⱥ
[m,n] = size(GPol);
NewPol = zeros(m,n);
%%%���ڵ���������֮�� �������н���
for i = 1:2:m-1
    if rand < Pc
        %���㽻��
        ChangePoint = round(rand * n);
        NewPol(i,:) = [GPol(i,1:ChangePoint),GPol(i+1,ChangePoint+1:n)];
        NewPol(i+1,:) = [GPol(i+1,1:ChangePoint),GPol(i,ChangePoint+1:n)];
    else
        NewPol(i,:) = GPol(i,:);
        NewPol(i+1,:) = GPol(i+1,:);
    end
end
end

