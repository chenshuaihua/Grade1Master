%用于计算控制系统在给定P,I,D参数下的目标函数
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

