function [WorstIndiv,WorstFit] = Worst(Pol,Fit)
%WORST �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[m,~] = size(Pol);
WorstIndiv = Pol(1,:);
WorstFit = Fit(1);
for i = 2:m
    if Fit(i) < WorstFit
        WorstIndiv = Pol(i,:);
        WorstFit = Fit(i);
    end
end
end

