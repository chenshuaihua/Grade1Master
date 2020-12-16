function [WorstIndiv,WorstFit] = Worst(Pol,Fit)
%WORST 此处显示有关此函数的摘要
%   此处显示详细说明
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

