x = 10:0.1:40;
y = x.*sin(2.*x).*cos(5*x)-3.*x.*sin(6.*x);
plot(x,y)