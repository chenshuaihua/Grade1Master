x = 0:0.01:20;
f= x .* sin(3.*x) .* cos(2 * x) - 2 * x .* sin(3 * x); % �������ʽ
plot(x,f,'linewidth',1)
title('���Ժ���')
xlabel('x');
ylabel('y');