function data = serialread(sname,time)
s = serial(sname);
set(s,'BaudRate',9600);
fopen(s);
data = [];
t = 0;
%delete(instrfindall)
%instrfindall可以找到所有的串口
while(t<time)
    b = str2num(fgetl(s));  %用函数fget(s)从缓冲区读取串口数据，当出现终止符（换行符）停止。
    data = [data,b];                       %所以在Arduino程序里要使用Serial.println()
    figure(1);
    plot(data);
    grid on;
    t = t+ 1;
    drawnow;
    
end

fclose(s);
pause(0.5);
close(figure(1));
end

