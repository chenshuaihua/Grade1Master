function [Ac,Bc,Cc] = luenberger(A,B,C)
%luenberger ���ϵͳ��luenberger�ܿع淶��
%�������Ϊϵͳ����A(n x n)���������B(n x 1)���������C(1 x n)
%�������ΪAc Bc Cc���������ܿع淶�ͣ�
%ϵͳ���ܿ�ʱ����Ac Bc Cc�������������0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�õ�����A��B��C��ά��
[n,~] = size(A);  
[n,~] = size(B);
[~,n] = size(C);
%��A����������ʽǰ���ϵ����b��һ��1 X n+1 �������� ��A����������ʽΪs^3+2s^2+5s+4ʱ,b=[1 2 5 4]��
b = poly(A);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�ܿ����б�
r = contriability(A,B);
%ϵͳ�ܿ�ʱ
if r ==n 
    disp('ϵͳ�ܿ�')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %��Ac
    %I_n_1��ʾn-1�׵ĵ�λ����
    I_n_1 = eye(n-1);
    %Z_n_1��ʾn-1 x 1��������
    Z_n_1 =zeros(n-1,1);
    %��I_n_1��Z_n_1���Ϊn-1 x n ά�ľ��� Temp
    Temp = [Z_n_1,I_n_1];
    %coff��һ��1 x n������������ʾAc�����һ��
    coff = zeros(1,n);
    for  m = 2:n+1
        coff(m-1) = -b(n+3-m);
    end
    %��ϵõ�Ac
    Ac = [Temp;coff];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %��Bc
    Bc = [Z_n_1;1];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %��Cc
    %Cc����Ϊһ��1Xn��ȫ��������
    Cc = zeros(1,n);
    %����forѭ��������beta_0��beta_n-1��ֵ
    for j = 0:n-1
        for i = 0:n-2-j
            if n-2-j == 0
                %Cc(j+1),��Ϊmatlab������1��ʼ��
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
%ϵͳ���ܿ�ʱ
else
    disp('ϵͳ���ܿ�')
    Ac = 0;
    Bc = 0;
    Cc = 0;
return 
end
end

