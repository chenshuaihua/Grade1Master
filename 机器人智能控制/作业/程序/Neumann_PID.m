%%%%%%% ��ʼ����Ⱥ
N = 64;                         % ��ʼ��Ⱥ����
d = 1;                          % �ռ�ά��
ger = 50;                      % ����������     

kpvlimit = [-1, 1];               % �����ٶ�����
kivlimit = [-1, 1];               % �����ٶ�����
kdvlimit = [-1, 1];               % �����ٶ�����

kplimit = 30:40;
kilimit = 0.1:0.1:2;
kdlimit = 30:40;

kp1 = zeros(N,1);
ki1 = zeros(N,1);
kd1 = zeros(N,1);
w = 0.8;                        % ����Ȩ��
c1 = 1.5;                       % ����ѧϰ����
c2 = 1.5;                       % Ⱥ��ѧϰ���� 
for i = 1:d
    kpdata = kplimit(i, 1) + (kplimit(i, 11) - kplimit(i, 1)) * rand(N, d);%��ʼ��Ⱥ��λ��
    kidata = kilimit(i, 1) + (kilimit(i, 20) - kilimit(i, 1)) * rand(N, d);%��ʼ��Ⱥ��λ��
    kddata = kdlimit(i, 1) + (kdlimit(i, 11) - kdlimit(i, 1)) * rand(N, d);%��ʼ��Ⱥ��λ��
end
kpv = rand(N, d);                  % ��ʼ��Ⱥ���ٶ�
kiv = rand(N, d);                  % ��ʼ��Ⱥ���ٶ�
kdv = rand(N, d);                  % ��ʼ��Ⱥ���ٶ�

kpLocalIndex = zeros(N,1);
kiLocalIndex = zeros(N,1);
kdLocalIndex = zeros(N,1);               %%�ֲ�������Ӧ�ȵ�����λ��

kpLocalBest = zeros(N,1);
kiLocalBest = zeros(N,1);                %%�ֲ�������Ӧ��
kdLocalBest = zeros(N,1);

kpIndivBest = zeros(N, 1);               % ÿ���������ʷ�����Ӧ��
kiIndivBest = zeros(N, 1); 
kdIndivBest = zeros(N, 1); 

iter = 1;

J = zeros(N,1);
Jrecord = zeros(ger,1);
while iter <= ger    
    disp(['�����ѽ��е���  ',num2str(iter),'/',num2str(ger),'  ��'])
    for count = 1:N
        kp = kpdata(count);%%%%�������ģ���е�kp,ki,kd��������
        ki = kidata(count);
        kd = kddata(count);
        kp1(count) = kp;  %%��kp,ki,kd�����������м�¼
        ki1(count) = ki;
        kd1(count) = kd;
        [t] = sim('PID1',[0,10]);
        num = length(t);  %%%��¼t�ĳ��ȣ�
        output = getdatasamples(out,1:num);
        output1 = output(end,:);
        J(count) = output1;
    end
    [minJ,minindex] = min(J); %%%%%��¼��С��J
    Jrecord(iter,1) = minJ;
    for i = 1:N      
       if kpIndivBest(i) < J(i)
           kpIndivBest(i) = J(i);     % ���¸�����ʷ�����Ӧ��
           kp1(i,:) = kpdata(i,:);   % ���¸�����ʷ���λ��
       end 
       if kiIndivBest(i) < J(i)
           kiIndivBest(i) = J(i);     % ���¸�����ʷ�����Ӧ��
           ki1(i,:) = kidata(i,:);   % ���¸�����ʷ���λ��
       end 
       if kdIndivBest(i) < J(i)
           kdIndivBest(i) = J(i);     % ���¸�����ʷ�����Ӧ��
           kd1(i,:) = kddata(i,:);   % ���¸�����ʷ���λ��
       end 
    end
    
     %%%%��ŵ�����ṹ
     [kpLocalBest,kpLocalIndex] = NeumannStru(kpIndivBest,kp1);
     [kiLocalBest,kiLocalIndex] = NeumannStru(kiIndivBest,ki1);
     [kdLocalBest,kdLocalIndex] = NeumannStru(kdIndivBest,kd1);

     kpv = kpv * w + c1 * rand * (kp1 - kpdata) + c2 * rand * (kpLocalIndex - kpdata);% �ٶȸ���
     kiv = kiv * w + c1 * rand * (ki1 - kidata) + c2 * rand * (kiLocalIndex - kidata);% �ٶȸ���
     kdv = kdv * w + c1 * rand * (kd1 - kddata) + c2 * rand * (kdLocalIndex - kddata);% �ٶȸ���
     % �߽��ٶȴ���
     kpv(kpv > kpvlimit(2)) = kpvlimit(2);
     kpv(kpv < kpvlimit(1)) = kpvlimit(1);
     kiv(kiv > kivlimit(2)) = kivlimit(2);
     kiv(kiv < kivlimit(1)) = kivlimit(1);
     kdv(kdv > kdvlimit(2)) = kdvlimit(2);
     kdv(kdv < kdvlimit(1)) = kdvlimit(1);
     
     kpdata = kpdata + kpv;% λ�ø���
     kidata = kidata + kiv;% λ�ø���
     kddata = kddata + kdv;% λ�ø���
     
     % �߽�λ�ô���
     kpdata(kpdata > kplimit(11)) = kplimit(11);
     kpdata(kpdata < kplimit(1)) = kplimit(1);
     kidata(kidata > kilimit(20)) = kilimit(20);
     kidata(kidata < kilimit(1)) = kilimit(1);
     kddata(kddata > kdlimit(11)) = kdlimit(11);
     kddata(kddata < kdlimit(1)) = kdlimit(1);
     
     iter = iter+1;
end