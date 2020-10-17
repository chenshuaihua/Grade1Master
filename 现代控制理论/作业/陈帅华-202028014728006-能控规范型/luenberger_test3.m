A = [0 0 0;0 0 0;0 0 0];
B = [1;2;1];
C = [0 1 1];
[Ac,Bc,Cc] = luenberger(A,B,C);