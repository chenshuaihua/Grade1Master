a = Tr(10);
b = 1:1:256;
subplot(2,2,1)
plot(b,a,'linewidth',3)
xlabel('E=10')
axis([1,256,-inf,inf])

c = Tr(50);
d = 1:1:256;
subplot(2,2,2)
plot(d,c,'linewidth',3)
xlabel('E=50')
axis([1,256,-inf,inf])

e = Tr(100);
f = 1:1:256;
subplot(2,2,3)
plot(f,e,'linewidth',3)
xlabel('E=100')
axis([1,256,-inf,inf])

g = Tr(200);
h = 1:1:256;
subplot(2,2,4)
plot(h,g,'linewidth',3)
xlabel('E=200')
axis([1,256,-inf,inf])