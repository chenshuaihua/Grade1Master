%���ڼ������ϵͳ�ڸ���P,I,D�����µ�Ŀ�꺯��
function y=optfun(x)
assignin('base','Kp',x(1));
assignin('base','Ki',x(2));
assignin('base','Kd',x(3));
[t_time,x_state,y_out]=sim('untitled1',[0,50]);
m = length(t_time);
tsdata = getdatasamples(y_out,1:m);
e = abs(1-tsdata);
for i = 1:length(t_time)
    J = J + t_time(i)*e(i);
end
y=J;
end

