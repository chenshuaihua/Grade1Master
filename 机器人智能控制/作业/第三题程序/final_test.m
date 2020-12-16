%%%%%%% ��ʼ����Ⱥ
N = 64;                         % ��ʼ��Ⱥ����
d = 1;                          % �ռ�ά��
maxgen=50;   % ��������  
sizepop=100;   %��Ⱥ��ģ
vartotal=3;         %��������

x_min=[5  0.1  5]';   %������Сֵ
x_max=[40  5  40]';   %�������ֵ
V_min= -0.2*(x_max-x_min);   %�ٶ���Сֵ
V_max= 0.2*(x_max-x_min);   %�ٶ����ֵ

kp1 = zeros(N,1);
ki1 = zeros(N,1);
kd1 = zeros(N,1);
w = 0.8;                        % ����Ȩ��
c1 = 0.7;                       % ����ѧϰ����
c2 = 0.7;                       % Ⱥ��ѧϰ���� 
for i=1:sizepop
    %�������һ����Ⱥ
    pop(i,:)= x_min' + 0.5*(x_max-x_min)'.*(ones(1,vartotal)+rands(1,vartotal));    %��ʼ��Ⱥ
    V(i,:)=  V_min' + 0.5*(V_max-V_min)'.*(ones(1,vartotal)+rands(1,vartotal));    %��ʼ���ٶ�
    %������Ӧ��
    fitness(i)=optfun(pop(i,:));   %Ⱦɫ�����Ӧ��
end
disp(['��ʼ����ɡ�����������'])
%����õ�Ⱦɫ��
[bestfitness,bestindex]=min(fitness);  %[��Сֵ  �к�]
zbest=pop(bestindex,:);   %ȫ�����
gbest=pop;    %�������
fitnessgbest=fitness;   %���������Ӧ��ֵ
fitnesszbest=bestfitness;   %ȫ�������Ӧ��ֵ


%%%%%%%% ����Ѱ��
for i=1:maxgen   %ÿһ�ε�������
    disp(['-----------------------------------------------------------'])
    disp(['�����ѽ��е���  ',num2str(i),'/',num2str(maxgen),'  ��'])
    for j=1:sizepop  %����ÿ������
        
        %�ٶȸ���
        V(j,:) = w*V(j,:) + c1*rand*(gbest(j,:) - pop(j,:)) + c2*rand*(zbest - pop(j,:)); %�ٶȸ��¹�ʽ
        for k=1:vartotal       %ÿ������
            if V(j,k)>V_max(k)  %���ٶ����ֵ���޶�
                V(j,k)=V_max(k);
            end
            if V(j,k)<V_min(k)  %���ٶ���Сֵ���޶�
                V(j,k)=V_min(k);
            end
        end
        
        %��Ⱥ����
        pop(j,:,:)=pop(j,:)+0.5*V(j,:);   %λ�ø��¹�ʽ
        for k=1:vartotal       %ÿ������
            if pop(j,k)>x_max(k)  %��λ�����ֵ���޶�
                pop(j,k)=x_max(k);
            end
            if pop(j,k)<x_min(k)  %��λ����Сֵ���޶�
                pop(j,k)=x_min(k); 
            end
        end
        
        %����Ӧ����
        if rand>0.8  %����Ϊ1-0.8
            k=ceil(vartotal*rand);   %ceilΪ����ȡ��
            pop(j,k)=x_min(k)' + (x_max(k)-x_min(k))'*rand;    %��ĳ�����ӵ�λ�ñ�Ϊ���ֵ���ı�һ�����꣬��һ��û�䣩
        end
    end
    parfor j=1:sizepop  %����ÿ������  
        %��Ӧ��ֵ
        fitness(j)=optfun(pop(j,:));  %������Ӧ��
    end    
    for j=1:sizepop  %����ÿ������    
        %�������Ÿ���
        if fitness(j) < fitnessgbest(j)  %���������Ӧ�ȳ��ָ�Сֵ
            gbest(j,:) = pop(j,:);        %���¸��������Ӧ��λ��
            fitnessgbest(j) = fitness(j);  %���¸��������Ӧ��
        end
        
        %Ⱥ�����Ÿ���
        if fitness(j) < fitnesszbest  %Ⱥ�������Ӧ�ȳ��ָ�Сֵ
            zbest = pop(j,:);  %����Ⱥ�������Ӧ��λ��
            fitnesszbest = fitness(j); %����Ⱥ�������Ӧ��
        end
        
    end
    yy(i)=fitnesszbest;    %�Ż����̴洢
    disp(['������Ӧ��Ϊ  ',num2str(fitnesszbest)])  
    disp([' x = ',num2str(zbest)])
end

%%%%%%%%% �������
figure(1);
plot(yy,'-*')
title(['��Ӧ������  ' '��ֹ������' num2str(maxgen)]);
xlabel('��������');ylabel('��Ӧ��');

toc
zbest
optfun(zbest)
% delete(gcp('nocreate'))


% 
% kpLocalIndex = zeros(N,1);
% kiLocalIndex = zeros(N,1);
% kdLocalIndex = zeros(N,1);
% 
% kpIndivBest = zeros(N, 1);               % ÿ���������ʷ�����Ӧ��
% kiIndivBest = zeros(N, 1); 
% kdIndivBest = zeros(N, 1); 
% 
% kpLocalBest = zeros(N,1);
% kiLocalBest = zeros(N,1);
% kdLocalBest = zeros(N,1);
% hold on
% %plot(xm, f(xm), 'ro');title('��ʼ״̬ͼ');
% %figure(2)
% %%%%%%% Ⱥ�����
% iter = 1;
% %record = zeros(ger, 1);          % ��¼��
% J = zeros(N,1);
% while iter <= ger    
%     for count = 1:N
%         kp = kpdata(count);
%         ki = kidata(count);
%         kd = kddata(count);
%         kp1(count) = kp;
%         ki1(count) = ki;
%         kd1(count) = kd;
%         [t] = sim('PID1',[0,10]);
%         num = length(t);
%         output = getdatasamples(out,1:num);
%         output1 = output(end,:);
%         J(count) = output1;
%     end
%     [minJ,minindex] = min(J); 
%     for i = 1:N      
%        if kpIndivBest(i) < J(i)
%            kpIndivBest(i) = J(i);     % ���¸�����ʷ�����Ӧ��
%            kp1(i,:) = kpdata(i,:);   % ���¸�����ʷ���λ��
%        end 
%        if kiIndivBest(i) < J(i)
%            kiIndivBest(i) = J(i);     % ���¸�����ʷ�����Ӧ��
%            ki1(i,:) = kidata(i,:);   % ���¸�����ʷ���λ��
%        end 
%        if kdIndivBest(i) < J(i)
%            kdIndivBest(i) = J(i);     % ���¸�����ʷ�����Ӧ��
%            kd1(i,:) = kddata(i,:);   % ���¸�����ʷ���λ��
%        end 
%     end
%     
%      %%%%��ŵ�����ṹ
%      [kpLocalBest,kpLocalIndex] = NeumannStru(kpIndivBest,kp1);
%      [kiLocalBest,kiLocalIndex] = NeumannStru(kiIndivBest,ki1);
%      [kdLocalBest,kdLocalIndex] = NeumannStru(kdIndivBest,kd1);
% %      
% %      if fym < max(IndivBest)
% %          [fym, nmax] = max(IndivBest);   % ����Ⱥ����ʷ�����Ӧ��
% %          ym = xm(nmax, :);      % ����Ⱥ����ʷ���λ��
% %      end
% %      v = v * w + c1 * rand * (xm - x) + c2 * rand * (repmat(ym, N, 1) - x);% �ٶȸ���
%      kpv = kpv * w + c1 * rand * (kp1 - kpdata) + c2 * rand * (kpLocalIndex - kpdata);% �ٶȸ���
%      kiv = kiv * w + c1 * rand * (ki1 - kidata) + c2 * rand * (kiLocalIndex - kidata);% �ٶȸ���
%      kdv = kdv * w + c1 * rand * (kd1 - kddata) + c2 * rand * (kdLocalIndex - kddata);% �ٶȸ���
%      % �߽��ٶȴ���
%      kpv(kpv > kpvlimit(2)) = kpvlimit(2);
%      kpv(kpv < kpvlimit(1)) = kpvlimit(1);
%      kiv(kiv > kivlimit(2)) = kivlimit(2);
%      kiv(kiv < kivlimit(1)) = kivlimit(1);
%      kdv(kdv > kdvlimit(2)) = kdvlimit(2);
%      kdv(kdv < kdvlimit(1)) = kdvlimit(1);
%      
%      kpdata = kpdata + kpv;% λ�ø���
%      kidata = kidata + kiv;% λ�ø���
%      kddata = kddata + kdv;% λ�ø���
%      
%      % �߽�λ�ô���
%      kpdata(kpdata > kplimit(2)) = kplimit(2);
%      kpdata(kpdata < kplimit(1)) = kplimit(1);
%      kidata(kidata > kplimit(2)) = kilimit(2);
%      kidata(kidata < kplimit(1)) = kilimit(1);
%      kddata(kddata > kdlimit(2)) = kdlimit(2);
%      kddata(kddata < kdlimit(1)) = kdlimit(1);
%      
%      iter = iter+1;
% end
