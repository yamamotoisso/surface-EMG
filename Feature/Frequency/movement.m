clc;
clear all;

a = load ('testarduino.txt');
Ld = fda;
yl = filter(Ld,a);

for i=1:1:1000
   if abs(yl(i))>10
       yl(i)=10*yl(i);
   else
       yl(i)=yl(i);
   end
end

%% raw signal
figure(1);
subplot(211);
plot(yl,'r','LineWidth',2);
title('{\fontname{TSTong}时域响应}');
xlabel('{\fontname{TSTong}时间}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{TSTong}振幅}{\fontname{Times New Roman}(mV)}');
xlim([0 inf]);
ylim([-inf inf]);
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;

fs2 = 1024;
N2 = length(yl);
n2 = 0:N2-1;
t2 = n2/fs2;
y = fft(yl,N2);
mag2 = abs(y);
f2 = (0:N2-1)*fs2/N2;

subplot(212);
plot(f2(1:N2/2),10*mag2(1:N2/2)*2/N2,'r','LineWidth',2);
title('{\fontname{TSTong}频域响应}');
xlabel('{\fontname{TSTong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{TSTong}振幅}{\fontname{Times New Roman}(dB)}');
% xlim([0 inf]);
ylim([0 inf]);
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
box off;
%% clips
yl1 = yl(120:250);%1
yl2 = yl(320:430);%1
yl3 = yl(440:540);%0
yl4 = yl(540:680);%1
yl5 = yl(650:760);%0
yl6 = yl(760:870);%1
yl7 = yl(880:1000);%0
%% frequency
figure(2);
subplot(2,1,1);
meanfreq(yl1,1000);
set(gcf,'Color',[1,0.2,0.6]);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
grid off;
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
subplot(2,1,2);
medfreq(yl1,1000);
set(gcf,'Color',[1,0.2,0.6]);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
grid off;
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;

figure(3);
subplot(2,1,1);
meanfreq(yl2,1000);
set(gcf,'Color',[1,0.2,0.6]);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
grid off;
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
subplot(2,1,2);
medfreq(yl2,1000);
set(gcf,'Color',[1,0.2,0.6]);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
grid off;
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;

figure(4);
subplot(2,1,1);
meanfreq(yl3,1000);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
grid off;
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
subplot(2,1,2);
medfreq(yl3,1000);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
grid off;
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;

figure(5);
subplot(2,1,1);
meanfreq(yl4,1000);
set(gcf,'Color',[1,0.2,0.6]);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
grid off;
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
subplot(2,1,2);
medfreq(yl4,1000);
set(gcf,'Color',[1,0.2,0.6]);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
grid off;
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;

figure(6);
subplot(2,1,1);
meanfreq(yl5,1000);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
grid off;
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
subplot(2,1,2);
medfreq(yl5,1000);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
grid off;
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;

figure(7);
subplot(2,1,1);
meanfreq(yl6,1000);
set(gcf,'Color',[1,0.2,0.6]);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
grid off;
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
subplot(2,1,2);
medfreq(yl6,1000);
set(gcf,'Color',[1,0.2,0.6]);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
grid off;
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;

figure(8);
subplot(2,1,1);
meanfreq(yl7,1000);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
grid off;
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
subplot(2,1,2);
medfreq(yl7,1000);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
grid off;
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;