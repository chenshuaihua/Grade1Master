A = [-1 1 2;0 -2 1;0 0 -3];
B = [0;1;1];
C = [1 0 1];
[Ac,Bc,Cc] = luenberger(A,B,C);