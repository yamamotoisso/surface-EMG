function data = serialread(sname,time)
s = serial(sname);
set(s,'BaudRate',9600);
fopen(s);
data = [];
t = 0;
%delete(instrfindall)
%instrfindall�����ҵ����еĴ���
while(t<time)
    b = str2num(fgetl(s));  %�ú���fget(s)�ӻ�������ȡ�������ݣ���������ֹ�������з���ֹͣ��
    data = [data,b];                       %������Arduino������Ҫʹ��Serial.println()
    figure(1);
    plot(data);
    grid on;
    t = t+ 1;
    drawnow;
    
end
pause(1);
fclose(s);

close(figure(1));
end

