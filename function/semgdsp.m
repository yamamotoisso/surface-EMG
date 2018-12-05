%%%%%%%%%%%%%%%%   记录信号   %%%%%%%%%%%%%%%%%%%%
clear all%清除所有内存中的变量
close all%关闭所有的程序和窗口

n=10000;%采样频率10000HZ
k=0:1/(n-1):1;
x=load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');
w=linspace(0,pi,10000);%0~pi的10000个等分数；
%linspace函数生成线性间隔向量，它与冒号运算符":"功能相似，且给出点的个数
X=abs(freqz(x,1,w));
%%freqz函数计算数字滤波器的频率响应的函数，abs函数取绝对值
figure(1);
subplot(2,1,1);
plot(x,'linewidth',2);
xlabel('时间/S');
ylabel('幅值/mV');
title('滤波前的有干扰的肌电信号波形');
set(gca,'FontSize',20,'FontWeight','bold');
subplot(2,1,2);
plot(linspace(0,1000,10000),X,'linewidth',2);
xlabel('频率/Hz');
ylabel('幅值/mV');
%plot(w/pi,X);
title('滤波前的幅频特性（频率响应）');
set(gca,'FontSize',20,'FontWeight','bold');

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
plot(x,'b','LineWidth',2);
grid on;
hold on;
plot(y1,'r','LineWidth',2);
legend('滤波前原始信号','滤波后的信号');
set(gca,'FontSize',30,'FontWeight','bold');
set(gca,'linewidth',3);
xlabel('时间/S');
ylabel('幅值/mV');

%%%%%%%%特征提取%%%%%%%%%%%

B = [];
C = [];
D = [];
IAV = []; %绝对值积分
MAV = []; %平均绝对值
MAVS = []; %平均绝对值斜率
WL = []; %波形长度
PV = []; %峰值
% ZC = []; %过零点数
SSC = []; %斜率变化率
MV = []; %均值(本例中相当于移动平均值)
VAR = []; %方差
STD = []; %均方差
RMS = []; %均方根值
MS = []; %波形因子
% MA = []; %移动均值
WAMP = [];%Willison幅值

j = 1;

for i=1:50:9950;
    B = y1(i:i+50);
    IAV(j) = sum(abs(B));
    MAV(j) = sum(abs(B))/length(B);
    MAVS(j) = sum(diff(abs(B)))/length(B);
    WL(j) = sum(abs(diff(B)));
    C = sort(B,'descend');
    PV(j) = sum(C(1:10))/10;
    
    MV(j) = mean(B);
    VAR(j) = var(B);
    STD(j) = std(B);
    RMS(j) = sqrt(sum(B.^2)/length(B));
    MS(j) = sqrt(sum(B.^2)/length(B))/mean(B);
    D = abs(diff(B));
    for K =1:1:50
     if D(K)>10;
        D(K) = 1;
     else
        D(K) = 0;
        end 
    end

    WAMP(j) = sum(D);
    j = j+1;
    
end
FEA = [MAVS;STD;WAMP;RMS];
figure(4);
plot(y1);
title('Original Signal');
grid on;

figure(5);
subplot(511);
plot(IAV);
title('Integral Absolute Value');
grid on;
hold on;
subplot(512);
plot(MAV);
title('Mean Absolute Value');
grid on;
hold on;
subplot(513);
plot(MAVS);
title('Mean Absoulute Value Slope');
grid on;
hold on;
subplot(514);
plot(WL);
title('Waveform Length');
grid on;
hold on;
subplot(515);
plot(PV);
title('Peak Value');
grid on;
hold on;


figure(6);
subplot(511);
plot(MV);
title('Mean Value');
grid on;
hold on;
subplot(512);
plot(VAR);
title('Variance');
grid on;
hold on;
subplot(513);
plot(STD);
title('Standard Deviation');
grid on;
hold on;
subplot(514);
plot(RMS);
title('Root Mean Square');
grid on;
hold on;
subplot(515);
plot(MS);
title('Form Factor');
grid on;
hold on;

figure (7);
plot(WAMP);
title('Willson Amplitude');
grid on;
hold on;

figure(8);
plot(MAV,'b','LineWidth',2);
hold on;
plot(PV,'--og','LineWidth',2);
hold on;
plot(MV,'-.vy','LineWidth',2);
hold on;
plot(RMS,':r','LineWidth',2);
hold on;
plot(WAMP,'m','LineWidth',2);
hold on;
grid on;
legend('MAV','PV','MV','RMS','WAMP');

figure(9);
subplot(211);
plot(MAVS,'b','LineWidth',2);
title('MAVS');
grid on;
subplot(212);
plot(STD,'r','LineWidth',2);
title('STD');
grid on;


%求相关系数
con1 = corrcoef(RMS,MAV);
con2 = corrcoef(RMS,PV);
con3 = corrcoef(RMS,MV);
CON = [con1;con2;con3];
disp(CON);
T = [];
ib =1;
T(1) = 0;
for ib = 2:1:20;
    if STD(ib)>18
        T(ib) = 1;
    else
        T(ib) = 0;
    end
end

for ib = 20:1:28;
    if STD(ib)>10
        T(ib) = 2;
    else
        T(ib) = 0;
    end
end

for ib = 28:1:35;
    if STD(ib)>10
        T(ib) = 3;
    else
        T(ib) = 0;
    end
end

for ib = 35:1:45;
    if STD(ib)>15
        T(ib) = 4;
    else
        T(ib) = 0;
    end
end

for ib = 45:1:60;
    if STD(ib)>18
        T(ib) = 1;
    else
        T(ib) = 0;
    end
end

for ib = 60:1:80;
    if STD(ib)>10
        T(ib) = 2;
    else
        T(ib) = 0;
    end
end

for ib = 80:1:100;
    if STD(ib)>10
        T(ib) = 3;
    else
        T(ib) = 0;
    end
end

for ib = 100:1:125;
    if STD(ib)>10
        T(ib) = 4;
    else
        T(ib) = 0;
    end
end

for ib = 125:1:140;
    if STD(ib)>10
        T(ib) = 1;
    else
        T(ib) = 0;
    end
end

for ib = 140:1:160;
    if STD(ib)>10
        T(ib) = 2;
    else
        T(ib) = 0;
    end
end

for ib = 160:1:199;
    T(ib) = 0;
end

