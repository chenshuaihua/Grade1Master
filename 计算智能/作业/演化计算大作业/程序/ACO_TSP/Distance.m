function dis = Distance(citydata)
%DISTANCE �������ɸ�����֮��֮��ľ��룬�õ�һ���������
%����citydata��Ϊ��ѡ���е��������
%���dis��Ϊһ���������
n = size(citydata,1);
dis = zeros(n,n);
for i = 1:n
    for j = 1:n
        if i ~= j
            dis(i,j) = sqrt(sum((citydata(i,:) - citydata(j,:)).^2));
        else
            dis(i,j) = 1e-4;      
        end
    end    
end
end

