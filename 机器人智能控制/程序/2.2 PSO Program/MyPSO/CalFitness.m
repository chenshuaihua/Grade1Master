function fitness=CalFitness(para)
% %Calculate the fitness using the input position of the swarm

% % fun1: f(x,y)=(x-5)^2+y^2
% x=para(1);
% y=para(2);
% fitness=(x-5)^2+y^2;

% fun2: f(x,y)=(x-5)^2+y^2

%fun2: Rosenbrock function
x=para(1);
y=para(2);
fitness=(1-x)^2+105*(y-x^2)^2;
% x=-10:.1:10;
% y=-10:.1:10;
% [X,Y]=meshgrid(x,y);
% Z=(1-X).^2+105*(Y-X.^2)^2;
% surf(X,Y,Z)

