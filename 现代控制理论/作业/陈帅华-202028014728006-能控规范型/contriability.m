function r = contriability(A,B)
%CONTRIABILITY ���ϵͳ���ܿ����б����Qc����
%�������Ϊ ϵͳ����A��n x n�����������B(n x 1)   
%�õ�����A������ ����Ļ�������������Ӧ������ͬ��
[n,~] = size(A);   
%����һ���վ���
Qc = [];
for i = 0:n-1
    %��A^i*B
    Qc = [Qc,A^i*B];
end
%��Qc����
r = rank(Qc);
end

