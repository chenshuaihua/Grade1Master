A = [1 2 0;3 -1 1;0 2 0];
B = [2;1;1];
C = [0 0 1];
[Ac,Bc,Cc] = luenberger(A,B,C);