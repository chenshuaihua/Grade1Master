In = 10;
Kp = 60;
Ki = 1;
Kd = 3;
[t] = sim('PID1',[0,30]);
output = getdatasamples(out,1:num);
output1 = output(end,:);
% figure(1);plot(time,out);grid on;






