function start = AntRandCity(ant_number,city_number)
%ANTRANDCITY ����ʼ�����������������ֱ�ŵ�n��������
%���룺ant_number������������city_number������������
%�����start
start = zeros(ant_number,1);
for i = 1:ant_number
    start(i) = randperm(city_number,1);
end
end

