clear all;
clc;

x = load ('fredata.mat');
xa = x.Data(100:31600);

figure(1);
subplot(211);
plot(xa,'LineWidth',2);
axis([100 inf,-0.2 0.2]);
title('{\fontname{TSTong}时域响应}');
xlabel('{\fontname{TSTong}时间}{\fontname{Times New Roman}(ms)}');
ylabel('{\fontname{TSTong}振幅}{\fontname{Times New Roman}(mV)}');
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
title('{\fontname{TSTong}频域响应}');
xlabel('{\fontname{TSTong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{TSTong}振幅}{\fontname{Times New Roman}(dB)}');
xlim([0 inf]);
yt = 50:50:500;
set(gca,'XTick',yt);
set(gca,'FontSize',20,'Fontname','Times New Roman');
set(gca,'xticklabel',get(gca,'xtick'),'yticklabel',get(gca,'ytick'));
% grid on;
box off;
