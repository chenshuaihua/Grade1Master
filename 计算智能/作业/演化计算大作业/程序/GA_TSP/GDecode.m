function NewPol = GDecode(GPol)
%GDECODE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[m,n] = size(GPol);
for i=1:m
    %��ʼ����1--M
    temp=[1:1:n];
    for j=1:n
        %���뼯
        %temp(grePop(i,j))
        NewPol(i,j)=temp(GPol(i,j));
        %һ�д���һ�����滷��
        %ȥ��temp(grePop(i,j))
        temp(GPol(i,j))=[];
    end
end
end

