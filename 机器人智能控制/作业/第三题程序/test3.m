N = 64;
kplimit = 10:80;
kilimit = 0:30;
kdlimit = 10:50;
d = 1;
% for i = 1:d
%     kp = kplimit(i, 1) + (kplimit(i, 2) - kplimit(i, 1)) * rand(N, d);%��ʼ��Ⱥ��λ��
%     ki = kilimit(i, 1) + (kilimit(i, 2) - kilimit(i, 1)) * rand(N, d);%��ʼ��Ⱥ��λ��
%     kd = kdlimit(i, 1) + (kdlimit(i, 2) - kdlimit(i, 1)) * rand(N, d);%��ʼ��Ⱥ��λ��
% end
for i = 1:d
    kp = kplimit(i, 1) + (kplimit(i, 2) - kplimit(i, 1)) * rand(N, d);%��ʼ��Ⱥ��λ��
    ki = kilimit(i, 1) + (kilimit(i, 2) - kilimit(i, 1)) * rand(N, d);%��ʼ��Ⱥ��λ��
    kd = kdlimit(i, 1) + (kdlimit(i, 2) - kdlimit(i, 1)) * rand(N, d);%��ʼ��Ⱥ��λ��
end