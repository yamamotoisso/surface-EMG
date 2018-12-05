% clear all;
clc;

x=load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata5.txt');
xa = x(450:8300);

figure(1);
subplot(211);
plot(xa,'LineWidth',2);
title('Time domain response');
xlabel('Time(ms)');
ylabel('Amplitude(mV)')
% xlabel('{\fontname{TSTong}时间}{\fontname{Times New Roman}(ms)}');
% ylabel('{\fontname{TSTong}振幅}{\fontname{Times New Roman}(mV)}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'xticklabel',get(gca,'xtick'),'yticklabel',get(gca,'ytick'));
% grid on;
box off;

subplot(212);
fs = 1000;
N = length(xa);
n = 0:N-1;
t = n/fs;
y = fft(xa,N);
mag = abs(y);
f = (0:N-1)*fs/N;

plot(f(1:N/2),mag(1:N/2)*2/N,'LineWidth',2);
title('Frequency domain response');
xlabel('Frequncey(Hz)');
ylabel('Magnitude(dB)')
% xlabel('{\fontname{TSTong}频率}{\fontname{Times New Roman}(Hz)}');
% ylabel('{\fontname{TSTong}振幅}{\fontname{Times New Roman}(dB)}');
xlim([0 inf]);
% yt = 50:50:500;
% set(gca,'XTick',yt);
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'xticklabel',get(gca,'xtick'),'yticklabel',get(gca,'ytick'));
% grid on;
box off;


%% Parameter
b = [];
c = [];
d = [];
IAV = []; %绝对值积分
MAV = []; %平均绝对值
MAVS = []; %平均绝对值斜率
WL = []; %波形长度
PV = []; %峰值
MV = []; %均值(本例中相当于移动平均值)
VAR = []; %方差
STD = []; %均方差
RMS = []; %均方根值
MS = []; %波形因子
WAMP = [];%Willison幅值
KUR = [];%峰度
SKE = [];%偏度

%% Calculate
j = 1;

for i=1:50:7850;
    b = xa(i:i+50);
    IAV(j) = sum(abs(b));
    MAV(j) = sum(abs(b))/length(b);%iemg
    MAVS(j) = sum(diff(abs(b)))/length(b);
    WL(j) = sum(abs(diff(b)));
    c = sort(b,'descend');
    PV(j) = sum(c(1:10))/10;
    MV(j) = mean(b);
    VAR(j) = var(b);
    STD(j) = std(b);
    RMS(j) = sqrt(sum(b.^2)/length(b));
    MS(j) = sqrt(sum(b.^2)/length(b))/mean(b);
    KUR(j) = kurtosis(b);
    SKE(j) = skewness(b);
    d = abs(diff(b));
    for k =1:1:50
     if d(k)>12;%threshold 
        d(k) = 1;
     else
        d(k) = 0;
        end 
    end

    WAMP(j) = sum(d);
    j = j+1;
    
end
figure(2);
subplot(511);
plot(MAVS,'LineWidth',2);
title('{\fontname{Times New Roman}MAVS}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
hold on;
subplot(512);
plot(WL,'LineWidth',2);
title('{\fontname{Times New Roman}WL}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
hold on;
subplot(513);
plot(VAR,'LineWidth',2);
title('{\fontname{Times New Roman}VAR}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
hold on;
subplot(514);
plot(STD,'LineWidth',2);
title('{\fontname{Times New Roman}STD}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
hold on;
subplot(515);
plot(MS,'LineWidth',2);
title('{\fontname{Times New Roman}MS}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
hold on;

