function [Ac,Bc,Cc] = luenberger(A,B,C)
%luenberger 求解系统的luenberger能控规范型
%输入参数为系统矩阵A(n x n)、输入矩阵B(n x 1)、输出矩阵C(1 x n)
%输出参数为Ac Bc Cc三个矩阵（能控规范型）
%系统不能控时，令Ac Bc Cc三个矩阵均等于0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%得到矩阵A，B，C的维数
[n,~] = size(A);  
[n,~] = size(B);
[~,n] = size(C);
%求A的特征多项式前面的系数（b是一个1 X n+1 的行向量 如A的特征多项式为s^3+2s^2+5s+4时,b=[1 2 5 4]）
b = poly(A);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%能控性判别
r = contriability(A,B);
%系统能控时
if r ==n 
    disp('系统能控')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %求Ac
    %I_n_1表示n-1阶的单位矩阵
    I_n_1 = eye(n-1);
    %Z_n_1表示n-1 x 1的列向量
    Z_n_1 =zeros(n-1,1);
    %将I_n_1和Z_n_1组合为n-1 x n 维的矩阵 Temp
    Temp = [Z_n_1,I_n_1];
    %coff是一个1 x n的行向量，表示Ac的最后一行
    coff = zeros(1,n);
    for  m = 2:n+1
        coff(m-1) = -b(n+3-m);
    end
    %组合得到Ac
    Ac = [Temp;coff];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %求Bc
    Bc = [Z_n_1;1];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %求Cc
    %Cc定义为一个1Xn的全零行向量
    Cc = zeros(1,n);
    %两层for循环，计算beta_0→beta_n-1的值
    for j = 0:n-1
        for i = 0:n-2-j
            if n-2-j == 0
                %Cc(j+1),因为matlab索引从1开始，
                Cc(j+1) = Cc(j+1) + b(i+2)*C*B;
            else
                Cc(j+1) = Cc(j+1) + b(i+2)*C*A^(n-2-i)*B;
            end
        end
        Cc(j+1) = C*A^(n-1-j)*B + Cc(j+1);
    end
    disp('Ac=')
    disp(Ac)
    disp('Bc=')
    disp(Bc)
    disp('Cc=')
    disp(Cc)
%系统不能控时
else
    disp('系统不能控')
    Ac = 0;
    Bc = 0;
    Cc = 0;
return 
end
end

