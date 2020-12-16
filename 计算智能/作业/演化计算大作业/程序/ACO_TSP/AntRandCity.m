function start = AntRandCity(ant_number,city_number)
%ANTRANDCITY 将初始化后的若干蚂蚁随机分别放到n个城市上
%输入：ant_number，蚂蚁数量；city_number：城市数量、
%输出：start
start = zeros(ant_number,1);
for i = 1:ant_number
    start(i) = randperm(city_number,1);
end
end

