%%%%%%% ��ջ���
set(0,'defaultfigurecolor','w')
% parpool(4)  ����4�̲߳��м��㣬��MATLABʱ����һ�ξͿ��ԣ�����ᱨ��
clear
tic;  %��ʱ
disp(['��ʾ������ʼ���У����ݵ������ò�ͬ��������Ҫʱ��ϳ��������ĵȴ�'])
%%%%%% ������ʼ��
%����Ⱥ�㷨�е���������
c1 = 1.49445;
c2 = 1.49445;
w = 0.8;
maxgen=50;   % ��������  
sizepop=100;   %��Ⱥ��ģ
vartotal=3;         %��������

x_min=[0  0  0]';   %������Сֵ
x_max=[7  2  7]';   %�������ֵ
V_min= -0.2*(x_max-x_min);   %�ٶ���Сֵ
V_max= 0.2*(x_max-x_min);   %�ٶ����ֵ


%%%%%% ������ʼ���Ӻ��ٶ�
disp(['���ڳ�ʼ������������ٶ�'])
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



