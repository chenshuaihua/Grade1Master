%%%%%%% ��ʼ����Ⱥ
f= @(x)x .* sin(3.*x) .* cos(2 * x) - 2 * x .* sin(3 * x); % �������ʽ
figure(1);
N = 64;                         % ��ʼ��Ⱥ����
d = 1;                          % �ռ�ά��
ger = 100;                      % ����������     
limit = [0, 20];                % ����λ�ò�������
vlimit = [-1, 1];               % �����ٶ�����
w = 0.8;                        % ����Ȩ��
c1 = 0.5;                       % ����ѧϰ����
c2 = 0.5;                       % Ⱥ��ѧϰ���� 
for i = 1:d
    x = limit(i, 1) + (limit(i, 2) - limit(i, 1)) * rand(N, d);%��ʼ��Ⱥ��λ��
end
v = rand(N, d);                  % ��ʼ��Ⱥ���ٶ�
xm = x;                          % ÿ���������ʷ���λ��
ym = zeros(1, d);                % ��Ⱥ����ʷ���λ��
localindex = zeros(N,1);
IndivBest = zeros(N, 1);               % ÿ���������ʷ�����Ӧ��
fym = -inf;                      % ��Ⱥ��ʷ�����Ӧ��
LocalBest = zeros(N,1);
hold on
plot(xm, f(xm), 'r*');title('��ʼ״̬');
figure(2)
%%%%%%% Ⱥ�����
iter = 1;
record = zeros(ger, 1);          % ��¼��
while iter <= ger
     fx = f(x) ; % ���嵱ǰ��Ӧ��   
     for i = 1:N      
        if IndivBest(i) < fx(i)
            IndivBest(i) = fx(i);     % ���¸�����ʷ�����Ӧ��
            xm(i,:) = x(i,:);   % ���¸�����ʷ���λ��
        end 
     end
     %%%%ÿ�����Ӻ���һ�����ӽ��бȽ�
     for j = 1:N
         if j == 1
               IndivTemp1 = [IndivBest(1),IndivBest(2),IndivBest(N)];
               LocalBest(1) = max(IndivTemp1);
               if LocalBest(1) == IndivBest(1)
                   localindex(1) = xm(1,:);              
               elseif LocalBest(1) == IndivBest(2)
                   localindex(1) = xm(2,:);
               else
                   localindex(1) = xm(N,:);
               end
         elseif j == N
               IndivTemp1 = [IIndivBest(1),IndivBest(N-1),IndivBest(N)];
               LocalBest(N) = max(IndivBest(1),IndivBest(N-1),IndivBest(N));
               if LocalBest(N) == IndivBest(1)
                   localindex(N) = xm(1,:);              
               elseif LocalBest(N) == IndivBest(N-1)
                   localindex(N) = xm(N-1,:);
               else
                   localindex(N) = xm(N,:);
               end
         else
               LocalBest(i) = max(IndivBest(i),IndivBest(i+1),IndivBest(i-1));
               if LocalBest(i) == IndivBest(i)
                   localindex(i) = xm(i,:);              
               elseif LocalBest(i) == IndivBest(i-1)
                   localindex(i) = xm(i-1,:);
               else
                   localindex(i) = xm(i+1,:);
               end
         end
     end
     
     if fym < max(IndivBest)
         [fym, nmax] = max(IndivBest);   % ����Ⱥ����ʷ�����Ӧ��
         ym = xm(nmax, :);      % ����Ⱥ����ʷ���λ��
     end
%      v = v * w + c1 * rand * (xm - x) + c2 * rand * (repmat(ym, N, 1) - x);% �ٶȸ���
     v = v * w + c1 * rand * (xm - x) + c2 * rand * (localindex - x);% �ٶȸ���
     % �߽��ٶȴ���
     v(v > vlimit(2)) = vlimit(2);
     v(v < vlimit(1)) = vlimit(1);
     x = x + v;% λ�ø���
     % �߽�λ�ô���
     x(x > limit(2)) = limit(2);
     x(x < limit(1)) = limit(1);
     record(iter) = fym;%���ֵ��¼
     x0 = 0 : 0.01 : 20;
     plot(x0, f(x0), 'b-', x, f(x), 'r*');title('����λ�ñ仯')
     xlabel('x')
     ylabel('y')
     pause(0.1)
     iter = iter+1;
end
figure(3);plot(record);title('��������')
x0 = 0 : 0.01 : 20;
figure(4);plot(x0, f(x0), 'b-', x, f(x), 'r*');
title('��������λ��')
xlabel('x')
ylabel('y')
disp(['���ֵ��',num2str(fym)]);