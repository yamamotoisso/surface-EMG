clear all;
clc;
n=10000;%采样频率10000HZ
k=0:1/(n-1):1;
x=load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');
w=linspace(0,pi,10000);%0~pi的10000个等分数；
%linspace函数生成线性间隔向量，它与冒号运算符":"功能相似，且给出点的个数
X=abs(freqz(x,1,w));
%%freqz函数计算数字滤波器的频率响应的函数，abs函数取绝对值
figure(1);
subplot(2,1,1);
plot(k,x);
title('滤波前的有干扰的肌电信号波形');
subplot(2,1,2);
plot(w/pi,X);
title('滤波前的幅频特性（频率响应）');

%%%%%%%%%%%%%%%  滤出50HZ噪声的滤波器，采用IIR带阻滤波器  %%%%%%%%%%%%%%%
Fn=50;Fs=2200;
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
subplot(3,1,1);
plot(k,y1);
title('经带阻滤波后的波形图');
X=abs(freqz(y1,1,w));
subplot(3,1,2);
plot(w/pi,X);
title('经带阻滤波后的幅频特性');
subplot(3,1,3);
H1=abs(freqz(b,a));
w1 = linspace(0,pi,512);
plot(w1/pi,H1);
title('带阻滤波器的幅频特性');

figure(3);
subplot(2,1,1);
plot(k,x,'linewidth',2);
grid on;
title('滤波前原始信号');
subplot(2,1,2);
plot(k,y1,'r','linewidth',2);
grid on;
title('带阻滤波后的信号');

figure(4);
plot(k,x,'linewidth',2);
hold on;
plot(k,y1,'r','linewidth',2);
grid on;
legend('滤波前原始信号','带阻滤波后的信号');