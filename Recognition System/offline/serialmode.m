
%delete(instrfindall)
s = serial('COM4');  %���崮�ڶ���
set(s,'BaudRate',9600);  %���ò�����s
fopen(s);  %�򿪴��ڶ���s
%% Parameter

interval = 2000  
passo = 1;
t = 0;
x = [];
fid = fopen('testdataDYX.txt','a');
%% Read sinal
while(t<interval)
    b = str2num(fgetl(s));  %�ú���fget(s)�ӻ�������ȡ�������ݣ���������ֹ�������з���ֹͣ��
    x = [x,b];                       %������Arduino������Ҫʹ��Serial.println()
    plot(x);
    grid
    t = t+ passo;
    drawnow;
end

%% Save data
fclose(s);  %�رմ��ڶ���s

fprintf(fid,'%d\r\n',x);
fclose(fid);