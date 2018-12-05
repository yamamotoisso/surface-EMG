clear all;
clc;
%% Read original signal
a =load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');
%% Parameter
b = [];
c = [];
d = [];
IAV = []; %����ֵ����
MAV = []; %ƽ������ֵ
MAVS = []; %ƽ������ֵб��
WL = []; %���γ���
PV = []; %��ֵ
% ZC = []; %�������
% SSC = []; %б�ʱ仯��
MV = []; %��ֵ(�������൱���ƶ�ƽ��ֵ)
VAR = []; %����
STD = []; %������
RMS = []; %������ֵ
MS = []; %��������
% MA = []; %�ƶ���ֵ
WAMP = [];%Willison��ֵ
%�����
MAD = [];%ƽ������ƫ��
KUR = [];%���
SKE = [];%ƫ��
MOM = [];%���ľ�
COV = [];%Э����
%% Calculate
j = 1;

for i=1:50:9950;
    b = a(i:i+50);
    IAV(j) = sum(abs(b));
    MAV(j) = sum(abs(b))/length(b);
    MAVS(j) = sum(diff(abs(b)))/length(b);
    WL(j) = sum(abs(diff(b)));
    c = sort(b,'descend');
    PV(j) = sum(c(1:10))/10;
    
    MV(j) = mean(b);
    VAR(j) = var(b);
    STD(j) = std(b);
    RMS(j) = sqrt(sum(b.^2)/length(b));
    MS(j) = sqrt(sum(b.^2)/length(b))/mean(b);
    MAD(j) = mad(b);
    KUR(j) = kurtosis(b);
    SKE(j) = skewness(b);
    MOM(j) = moment(b,4);
    COV(j) = cov(b);
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

FEA = [MAVS;STD;WAMP;RMS;MS;VAR];%Best feature

%% Plot figure

figure(1);
plot(a);
title('Original Signal');
grid on;

figure(2);
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


figure(3);
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

figure (4);
plot(WAMP);
title('Willson Amplitude');
grid on;
hold on;

%% Best Feature
figure(5);
title('The Best Feature A');
subplot(311);
plot(STD,'LineWidth',2);
grid on;
title('Standard Deviation');
subplot(312);
plot(WAMP,'LineWidth',2);
grid on;
title('Willsion Amplitude');
subplot(313);
plot(MAVS,'LineWidth',2);
title('Mean Absoulute Value Slope');
grid on;
figure(6);
title('The Best Feature A');
subplot(311);
plot(RMS,'LineWidth',2);
grid on;
title('Root Mean Square');
subplot(312);
plot(VAR,'LineWidth',2);
grid on;
title('Variance');
subplot(313);
plot(MS,'LineWidth',2);
grid on;
title('Form Factor');
%% �����ϵ��
cons = xcorr(RMS); %�����
con1 = corrcoef(RMS,MAV);
con2 = corrcoef(RMS,PV);
con3 = corrcoef(RMS,MV); 
con4 = corrcoef(RMS,IAV);
con5 = corrcoef(RMS,WL);
CON = [con1;con2;con3;con4;con5];

