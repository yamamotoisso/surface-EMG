clc;
clear all;
x = load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');
figure(1);
subplot(7,1,1);
plot(x);
ylabel('Signal');
axis tight;
[C,L] = wavedec(x,6,'db5');
for i =1:6
    a = wrcoef('d',C,L,'db5',7-i);
    subplot(7,1,i+1);
    plot(a);
    axis tight;
    ylabel(['a',num2str(7-i)]);
end
figure(2);
subplot(7,1,1);
plot(x);
ylabel('Signal');
axis tight;
[C,L] = wavedec(x,6,'db5');
for i =1:6
    d = wrcoef('d',C,L,'db5',7-i);
    subplot(7,1,i+1);
    plot(d);
    axis tight;
    ylabel(['d',num2str(7-i)]);
end
