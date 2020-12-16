x = 0:0.01:20;
f= x .* sin(3.*x) .* cos(2 * x) - 2 * x .* sin(3 * x); % 函数表达式
plot(x,f,'linewidth',1)
title('测试函数')
xlabel('x');
ylabel('y');