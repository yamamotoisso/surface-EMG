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
% xlabel('{\fontname{TSTong}ʱ��}{\fontname{Times New Roman}(ms)}');
% ylabel('{\fontname{TSTong}���}{\fontname{Times New Roman}(mV)}');
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
% xlabel('{\fontname{TSTong}Ƶ��}{\fontname{Times New Roman}(Hz)}');
% ylabel('{\fontname{TSTong}���}{\fontname{Times New Roman}(dB)}');
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
IAV = []; %����ֵ����
MAV = []; %ƽ������ֵ
MAVS = []; %ƽ������ֵб��
WL = []; %���γ���
PV = []; %��ֵ
MV = []; %��ֵ(�������൱���ƶ�ƽ��ֵ)
VAR = []; %����
STD = []; %������
RMS = []; %������ֵ
MS = []; %��������
WAMP = [];%Willison��ֵ
KUR = [];%���
SKE = [];%ƫ��

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

