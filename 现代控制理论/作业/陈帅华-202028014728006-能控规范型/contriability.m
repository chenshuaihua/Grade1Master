function r = contriability(A,B)
%CONTRIABILITY 求解系统的能控性判别矩阵Qc的秩
%输入参数为 系统矩阵A（n x n）、输入矩阵B(n x 1)   
%得到矩阵A的行数 方阵的话，行数和列数应该是相同的
[n,~] = size(A);   
%定义一个空矩阵
Qc = [];
for i = 0:n-1
    %求A^i*B
    Qc = [Qc,A^i*B];
end
%求Qc的秩
r = rank(Qc);
end

