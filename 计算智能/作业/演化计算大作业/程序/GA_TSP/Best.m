function [BestIndiv,BestFit,BestLen] = Best(Pol,Fit,len)
%BEST �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[m,~] = size(Pol);
BestIndiv = Pol(1,:);
BestFit = Fit(1);
BestLen = len(1);
for i = 2:m
    if Fit(i) > BestFit
        BestIndiv = Pol(i,:);
        BestFit = Fit(i);
    end
    if len(i) < BestLen
        BestLen = len(i);
    end
        
end
end

