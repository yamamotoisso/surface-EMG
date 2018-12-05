clear all;
clc;

a = load ('testarduino.txt');
% set(gcf,'position',get(0,'ScreenSize'));
figure(1);
subplot(211);
plot(a,'LineWidth',2);
title('{\fontname{TSTong}时域响应}');
xlabel('{\fontname{TSTong}时间}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{TSTong}振幅}{\fontname{Times New Roman}(mV)}');
xlim([0 inf]);
ylim([-inf inf]);
set(gca,'FontSize',20,'Fontname','Times New Roman');
% set(gca,'xticklabel',get(gca,'xtick'),'yticklabel',get(gca,'ytick'));
% grid on;
box off;

subplot(212);
fs1 = 1024;
N1 = length(a);
n1 = 0:N1-1;
t1 = n1/fs1;
y = fft(a,N1);
mag1 = abs(y);
f1 = (0:N1-1)*fs1/N1;

plot(f1(1:N1/2),mag1(1:N1/2)*2/N1,'LineWidth',2);
title('{\fontname{TSTong}频域响应}');
xlabel('{\fontname{TSTong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{TSTong}振幅}{\fontname{Times New Roman}(dB)}');
xlim([0 inf]);
% ylim([0 inf]);
set(gca,'FontSize',20,'Fontname','Times New Roman');
% % set(gca,'xticklabel',get(gca,'xtick'),'yticklabel',get(gca,'ytick'));
% % grid on;
box off;

figure(2);

Ld = fda;
yl = filter(Ld,a);
subplot(211);
% % yl1 = [];
% % for i=1:1:1000
% %    if abs(yl(i))>10
% %        yl(i)=10*yl(i);
% %    else
% %        yl(i)=yl(i);
% %    end
% % end
plot(yl,'r','LineWidth',2);
title('{\fontname{TSTong}时域响应}');
xlabel('{\fontname{TSTong}时间}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{TSTong}振幅}{\fontname{Times New Roman}(mV)}');
xlim([0 inf]);
ylim([-inf inf]);
% set(gca,'FontSize',20,'FontWeight','bold');
set(gca,'FontSize',20,'Fontname','Times New Roman');

box off;
% set(gca,'xticklabel',get(gca,'xtick'),'yticklabel',get(gca,'ytick'));
% grid on;

subplot(212);
fs2 = 1024;
N2 = length(yl);
n2 = 0:N2-1;
t2 = n2/fs2;
y = fft(yl,N2);
mag2 = abs(y);
f2 = (0:N2-1)*fs2/N2;

plot(f2(1:N2/2),10*mag2(1:N2/2)*2/N2,'r','LineWidth',2);
title('{\fontname{TSTong}频域响应}');
xlabel('{\fontname{TSTong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{TSTong}振幅}{\fontname{Times New Roman}(dB)}');
xlim([0 inf]);
ylim([0 inf]);
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
% set(gca,'xticklabel',get(gca,'xtick'),'yticklabel',get(gca,'ytick'));
% grid on;


%% Parameter
fb = [];
fc = [];
fd = [];
IAV = [];
MAV = [];
MAVS = [];
WL = []; 
PV = []; 
MV = []; 
VAR = [];
STD = []; 
RMS = []; 
MS = []; 
WAMP = [];


%% Feature extracte
fj = 1;

for i=1:50:950;
    fb = yl(i:i+50);
    %fb = ProcessingSignal(i:i+50);
    IAV(fj) = sum(abs(fb));
    MAV(fj) = sum(abs(fb))/length(fb);
    MAVS(fj) = sum(diff(abs(fb)))/length(fb);
    WL(fj) = sum(abs(diff(fb)));
    fc = sort(fb,'descend');
    PV(fj) = sum(fc(1:10))/10;
    MV(fj) = mean(fb);
    VAR(fj) = var(fb);
    STD(fj) = std(fb);
    RMS(fj) = sqrt(sum(fb.^2)/length(fb));
    MS(fj) = sqrt(sum(fb.^2)/length(fb))/mean(fb);
    fd = abs(diff(fb));
    for fk =1:1:50
     if fd(fk)>3;%threshold 
        fd(fk) = 1;
     else
        fd(fk) = 0;
        end 
    end

    WAMP(fj) = sum(fd);
    fj = fj+1;
    
end

FEA = [MAVS;STD;WAMP;RMS;MS;VAR];%Best feature

figure(3);
subplot(311);
plot(MAVS,'LineWidth',2);
title('{\fontname{Times New Roman}MAVS}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
grid on;
hold on;
subplot(312);
plot(STD,'LineWidth',2);
title('{\fontname{Times New Roman}STD}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
grid on;
hold on;
subplot(313);
plot(WAMP,'LineWidth',2);
title('{\fontname{Times New Roman}WAMP}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
grid on;
hold on;

figure(4);
subplot(311);
plot(RMS,'LineWidth',2);
title('{\fontname{Times New Roman}RMS}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
grid on;
hold on;
subplot(312);
plot(MS,'LineWidth',2);
title('{\fontname{Times New Roman}MS}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
grid off;
hold on;
subplot(313);
plot(VAR,'LineWidth',2);
title('{\fontname{Times New Roman}VAR}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;
grid off;
hold on;

%% frequency
L1=length(yl);
fs3 = 1024;
cx1=xcorr(yl,'unbiased');%计算x的自相关函数
cxk1=fft(cx1,L1);
px1=abs(cxk1);%求功率谱密度
pxx1=10*log10(px1);
f1=(0:L1-1)*fs3/L1;

figure(5);
% subplot(2,1,1);
plot(f1(1:L1/2),pxx1(1:L1/2),'LineWidth',2);
xlim([0 500]);
ylim([-inf inf]);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱}{\fontname{Times New Roman}(dB)}');
% title('{\fontname{Times New Roman}PSD}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
% grid on  %做功率谱图
df1=fs3/L1;
p1=(sum(px1(1:L1/2-1))+sum(px1(1:L1/2)))/2.*df1;
pf1=(sum(px1(1:L1/2-1).*[1:L1/2-1]'.*df1)+sum(px1(1:L1/2).*[1:L1/2]'.*df1))/2*df1;
MPF1=pf1/p1;%求平均功率频率
box off;

N1=1;pp1=0;
while abs(pp1-p1/2)>(px1(N1)+px1(N1+1))/2*df1
    pp1=pp1+(px1(N1)+px1(N1+1))/2*df1;
    N1=N1+1;
end
n_1=(N1+N1+1)/2;
MF1=df1*n_1;%求中值频率

figure(6);
subplot(2,1,1);
plot(yl,'r','LineWidth',2);
title('{\fontname{TSTong}时域响应}');
xlabel('{\fontname{TSTong}时间}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{TSTong}幅值}{\fontname{Times New Roman}(mV)}');
xlim([0 inf]);
ylim([-inf inf]);
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;

subplot(2,1,2);
c = rceps(yl);
c(1:10) = 0.1*c(1:10);
c(150:200) = 5*c(150:200);
c(980:1000) = 0.01*c(980:1000);
plot(c,'LineWidth',2);
ylim([-0.2 0.2]);
xlabel('{\fontname{STSong}采样点}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{STSong}幅值}{\fontname{Times New Roman}(dB)}');
title('{\fontname{Times New Roman}CEP}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;

figure(7);
subplot(2,1,1);
meanfreq(yl,1000);
ylim([-inf inf]);
grid off;
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
% title('{\fontname{STSong}平均频率估计：}{\fontname{Times New Roman}1.083Hz}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
subplot(2,1,2);
medfreq(yl,1000);
ylim([-inf inf]);
grid off;
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
% title('{\fontname{STSong}中值频率估计：}{\fontname{Times New Roman}0.0291Hz}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
