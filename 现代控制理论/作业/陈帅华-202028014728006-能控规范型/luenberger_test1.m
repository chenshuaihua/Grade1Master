A = [1 0 2;2 1 1;1 0 -2];
B = [1;2;1];
C = [0 1 1];
[Ac,Bc,Cc] = luenberger(A,B,C);

