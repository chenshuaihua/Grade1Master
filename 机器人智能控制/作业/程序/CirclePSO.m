%%%%%%% ��ʼ����Ⱥ
%%%%���Ժ���
f= @(x)x .* sin(3.*x) .* cos(2 * x) - 2 * x .* sin(3 * x); 
figure(1);
ezplot(f,[0,0.01,20]);
N = 64;                         % ��ʼ��Ⱥ����
d = 1;                          % �ռ�ά��
ger = 300;                      % ����������     
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
plot(xm, f(xm), 'r*');title('��ʼ״̬ͼ');
figure(2)
hold on
%%%%%%% Ⱥ�����
iter = 1;
record = zeros(ger, 1);          %%%%%%��¼
     fx = f(x) ; % ���嵱ǰ��Ӧ��   
     for i = 1:N      
        if IndivBest(i) < fx(i)
            IndivBest(i) = fx(i);     % ���¸�����ʷ�����Ӧ��
            xm(i,:) = x(i,:);   % ���¸�����ʷ���λ��
        end 
     end
     %%%%ÿ�����Ӻ���һ�����ӽ��бȽ�
     for j = 1:N
         if j == N
            if IndivBest(N) < IndivBest(1)
               LocalBest(N) = IndivBest(1);
               localindex(N) = xm(1,:);
            else
               LocalBest(N) = IndivBest(N);
               localindex(N) = xm(N,:);
            end
         elseif IndivBest(j) < IndivBest(j+1)
             LocalBest(i) = IndivBest(j+1);
             localindex(j) = xm(j+1,:);
         else
             LocalBest(j) = IndivBest(j);
             localindex(j) = xm(j,:);
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
     pause(0.05)
     iter = iter+1;
end
figure(3);plot(record);title('��������')
xlabel('��������')
ylabel('y')
x0 = 0 : 0.01 : 20;
figure(4);plot(x0, f(x0), 'b-', x, f(x), 'r*');
title('��������λ��')
xlabel('x')
ylabel('y')
disp(['���ֵ��',num2str(fym)]);