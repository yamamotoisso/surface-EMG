%%%%%%%%%%%%%%%%   记录信号   %%%%%%%%%%%%%%%%%%%%
clear all%清除所有内存中的变量
close all%关闭所有的程序和窗口

n=9600;%采样频率9600HZ
k=0:1/(n-1):1;
x=load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');

w=linspace(0,pi,10000);%0~pi的10000个等分数；
%linspace函数生成线性间隔向量，它与冒号运算符":"功能相似，且给出点的个数
X=abs(freqz(x,1,w));
%%freqz函数计算数字滤波器的频率响应的函数，abs函数取绝对值
figure(1);
subplot(2,1,1);
plot(x,'linewidth',2);
xlabel('{\fontname{STSong}时间}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{STSong}幅值}{\fontname{Times New Roman}(mV)}');
title('{\fontname{STSong}时域响应}');
ylim([-inf inf]);
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
subplot(2,1,2);
plot(linspace(0,1000,10000),X,'linewidth',2);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}幅值}{\fontname{Times New Roman}(dB)}');
%plot(w/pi,X);
title('{\fontname{STSong}频率响应}');
ylim([-inf,inf]);
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
ylim([-inf,150000]);
%%%%%%%%%%%%%%%  滤出50HZ噪声的滤波器，采用IIR带阻滤波器  %%%%%%%%%%%%%%%
Fn=50;Fs=2300;
W3=0.4;
W0=2*pi*Fn/Fs;
beta=cos(W0);
alpha=min(roots([1,-2/cos(W3),1]));
%roots求多项式的根，min找出数组中的最小元素;
a=[1,-beta*(1+alpha),alpha];
b=[1,-2*beta,1]*(1+alpha)/2; % a,b 为滤波器系数
y1=filter(b,a,x); 
% FILTER是一维数字滤波器，输入X为滤波前序列，Y为滤波后序列，
% B/A 提供滤波器系数，B为分子， A为分母 
% save('testdata3.mat','y1');

figure(2);
subplot(2,1,1);
plot(x,'linewidth',2);
xlabel('{\fontname{STSong}时间}{\fontname{Times New Roman}(ms)}');
ylabel('幅值{\fontname{Times New Roman}(mV)}');
title('时域响应');
set(gca,'FontSize',20,'FontWeight','bold');
subplot(2,1,2);
fy = fft(x,n);
f = -0.5:1/n:0.5-1/n;
plot(f,fftshift(abs(fy)),'linewidth',2);
xlabel('频率{\fontname{Times New Roman}(Hz)}');
ylabel('幅值{\fontname{Times New Roman}(dB)}');
%plot(w/pi,X);
title('频率响应');
set(gca,'FontSize',20,'FontWeight','bold');

figure(3);
subplot(2,1,1);
plot(linspace(0,1000,10000),X,'linewidth',2);
xlabel('频率{\fontname{Times New Roman}(Hz)}');
ylabel('幅值{\fontname{Times New Roman}(dB)}');
title('滤波前的幅频特性');
set(gca,'FontSize',20,'FontWeight','bold');
X1=abs(freqz(y1,1,w));
subplot(2,1,2);
plot(linspace(0,1000,10000),X1,'linewidth',2);
xlabel('频率{\fontname{Times New Roman}(Hz)}');
ylabel('幅值{\fontname{Times New Roman}(dB)}');
title('经带阻滤波后的幅频特性');
set(gca,'FontSize',20,'FontWeight','bold');
% subplot(3,1,3);
% H1=abs(freqz(b,a));
% w1 = linspace(0,pi,512);
% plot(w1/pi,H1);
% title('带阻滤波器的幅频特性');

figure(4);
plot(x,'b','LineWidth',2);
grid on;
hold on;
plot(y1,'r','LineWidth',2);
legend('滤波前原始信号','滤波后的信号');
set(gca,'FontSize',30,'FontWeight','bold');
set(gca,'linewidth',3);
xlabel('时间{\fontname{Times New Roman}(ms)}');
ylabel('幅值{\fontname{Times New Roman}(mV)}');

