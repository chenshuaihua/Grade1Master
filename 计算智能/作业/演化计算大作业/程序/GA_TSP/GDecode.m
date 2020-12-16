function NewPol = GDecode(GPol)
%GDECODE 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n] = size(GPol);
for i=1:m
    %初始数据1--M
    temp=[1:1:n];
    for j=1:n
        %解码集
        %temp(grePop(i,j))
        NewPol(i,j)=temp(GPol(i,j));
        %一行代表一个生存环境
        %去掉temp(grePop(i,j))
        temp(GPol(i,j))=[];
    end
end
end

