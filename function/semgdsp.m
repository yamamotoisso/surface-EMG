%%%%%%%%%%%%%%%%   ��¼�ź�   %%%%%%%%%%%%%%%%%%%%
clear all%��������ڴ��еı���
close all%�ر����еĳ���ʹ���

n=10000;%����Ƶ��10000HZ
k=0:1/(n-1):1;
x=load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');
w=linspace(0,pi,10000);%0~pi��10000���ȷ�����
%linspace�����������Լ������������ð�������":"�������ƣ��Ҹ�����ĸ���
X=abs(freqz(x,1,w));
%%freqz�������������˲�����Ƶ����Ӧ�ĺ�����abs����ȡ����ֵ
figure(1);
subplot(2,1,1);
plot(x,'linewidth',2);
xlabel('ʱ��/S');
ylabel('��ֵ/mV');
title('�˲�ǰ���и��ŵļ����źŲ���');
set(gca,'FontSize',20,'FontWeight','bold');
subplot(2,1,2);
plot(linspace(0,1000,10000),X,'linewidth',2);
xlabel('Ƶ��/Hz');
ylabel('��ֵ/mV');
%plot(w/pi,X);
title('�˲�ǰ�ķ�Ƶ���ԣ�Ƶ����Ӧ��');
set(gca,'FontSize',20,'FontWeight','bold');

%%%%%%%%%%%%%%%  �˳�50HZ�������˲���������IIR�����˲���  %%%%%%%%%%%%%%%
Fn=50;Fs=2300;
W3=0.4;
W0=2*pi*Fn/Fs;
beta=cos(W0);
alpha=min(roots([1,-2/cos(W3),1]));
%roots�����ʽ�ĸ���min�ҳ������е���СԪ��;
a=[1,-beta*(1+alpha),alpha];
b=[1,-2*beta,1]*(1+alpha)/2; % a,b Ϊ�˲���ϵ��
y1=filter(b,a,x); 
% FILTER��һά�����˲���������XΪ�˲�ǰ���У�YΪ�˲������У�
% B/A �ṩ�˲���ϵ����BΪ���ӣ� AΪ��ĸ 
% save('testdata3.mat','y1');

figure(2);
subplot(3,1,1);
plot(k,y1);
title('�������˲���Ĳ���ͼ');
X=abs(freqz(y1,1,w));
subplot(3,1,2);
plot(w/pi,X);
title('�������˲���ķ�Ƶ����');
subplot(3,1,3);
H1=abs(freqz(b,a));
w1 = linspace(0,pi,512);
plot(w1/pi,H1);
title('�����˲����ķ�Ƶ����');

figure(3);
plot(x,'b','LineWidth',2);
grid on;
hold on;
plot(y1,'r','LineWidth',2);
legend('�˲�ǰԭʼ�ź�','�˲�����ź�');
set(gca,'FontSize',30,'FontWeight','bold');
set(gca,'linewidth',3);
xlabel('ʱ��/S');
ylabel('��ֵ/mV');

%%%%%%%%������ȡ%%%%%%%%%%%

B = [];
C = [];
D = [];
IAV = []; %����ֵ����
MAV = []; %ƽ������ֵ
MAVS = []; %ƽ������ֵб��
WL = []; %���γ���
PV = []; %��ֵ
% ZC = []; %�������
SSC = []; %б�ʱ仯��
MV = []; %��ֵ(�������൱���ƶ�ƽ��ֵ)
VAR = []; %����
STD = []; %������
RMS = []; %������ֵ
MS = []; %��������
% MA = []; %�ƶ���ֵ
WAMP = [];%Willison��ֵ

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


%�����ϵ��
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

