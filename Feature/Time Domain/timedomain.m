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

for i=1:50:9950;
    b = a(i:i+50);
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
%% Plot figure

figure(1);
plot(a,'LineWidth',2);
% ylim([-inf inf]);
% xlim([2300 6500]);
xlabel('{\fontname{TSTong}ʱ��}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{TSTong}��ֵ}{\fontname{Times New Roman}(mV)}');
% xlabel('{\fontname{Times New Roman}Times(ms)}');
% ylabel('{\fontname{Times New Roman}Amplitude(mV)}');
% title('�ɼ�����ԭʼ�ź�');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
% grid on;

figure(2);
subplot(511);
plot(IAV,'LineWidth',2);
% ylim([-inf inf]);
title('{\fontname{Times New Roman}IAV}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
% grid on;
hold on;
subplot(512);
plot(MAV,'LineWidth',2);
xlim([-inf inf]);
set(gca,'FontSize',20,'Fontname','Times New Roman');
title('{\fontname{Times New Roman}MAV}');
set(gca,'linewidth',1);
box off;
% grid on;
hold on;
subplot(513);
plot(MAVS,'LineWidth',2);
% ylim([-inf inf]);
title('{\fontname{Times New Roman}MAVS}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
% grid on;
hold on;
subplot(514);
plot(WL,'LineWidth',2);
% ylim([-inf inf]);
title('{\fontname{Times New Roman}WL}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
% grid on;
hold on;
subplot(515);
plot(PV,'LineWidth',2);
% ylim([-inf inf]);
title('{\fontname{Times New Roman}PV}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
% grid on;
hold on;

figure(3);
subplot(511);
plot(MV,'LineWidth',2);
ylim([-inf inf]);
title('{\fontname{Times New Roman}MV}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
% grid on;
hold on;
subplot(512);
plot(VAR,'LineWidth',2);
ylim([-inf inf]);
title('{\fontname{Times New Roman}VAR}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
% grid on;
hold on;
subplot(513);
ylim([-inf inf]);
plot(STD,'LineWidth',2);
title('STD');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
% grid on;
hold on;
subplot(514);
plot(RMS,'LineWidth',2);
ylim([-inf inf]);
title('{\fontname{Times New Roman}RMS}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
% grid on;
hold on;
subplot(515);
plot(MS,'LineWidth',2);
ylim([-inf inf]);
title('{\fontname{Times New Roman}MS}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
% grid on;
hold on;

T=[];
kk=1;
for ii =10:20:90
   T(kk,:) = [IAV(ii),MAV(ii),MAVS(ii),WL(ii),PV(ii),MV(ii),VAR(ii),STD(ii),RMS(ii),MS(ii),WAMP(ii)]; 
   kk = kk+1;
end

% figure(4);
% subplot(411);
% plot(SKE,'LineWidth',4);
% title('Skew');
% set(gca,'FontSize',20,'FontWeight','bold');
% set(gca,'linewidth',2);
% grid on;
% hold on;
% subplot(412);
% plot(STD,'LineWidth',4);
% title('STD');
% set(gca,'FontSize',20,'FontWeight','bold');
% set(gca,'linewidth',2);
% grid on;
% hold on;
% subplot(413);
% plot(VAR,'LineWidth',4);
% title('VAR');
% set(gca,'FontSize',20,'FontWeight','bold');
% set(gca,'linewidth',2);
% grid on;
% hold on;
% subplot(414);
% plot(WL,'LineWidth',4);
% title('WL');
% set(gca,'FontSize',20,'FontWeight','bold');
% set(gca,'linewidth',2);
% grid on;
% hold on;
con1 = xcorr(IAV);
con2 = xcorr(MAV);
con3 = xcorr(MAVS);
con4 = xcorr(WL);
con5 = xcorr(PV);
con6 = xcorr(MV);
con7 = xcorr(VAR);
con8 = xcorr(STD);
con9 = xcorr(RMS);
con10 = xcorr(MS);
con11 = xcorr(WAMP);
% figure(5);
% plot(con1);
% hold on;
% plot(con2);
% hold on;
% plot(con3);
% hold on;
% plot(con4);
% hold on;
% plot(con5);
% hold on;
% plot(con6);
% hold on;
% plot(con7);
% hold on;
% plot(con8);
% hold on;
% plot(con9);
% hold on;
% plot(con10);
% hold on;
% plot(con11);
% hold on;