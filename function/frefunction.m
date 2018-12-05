clear all;
clc;

x = load ('fredata.mat');
xa = x.Data(100:31600);

figure(1);
subplot(211);
plot(xa,'LineWidth',2);
axis([100 inf,-0.2 0.2]);
title('时域响应');
xlabel('时间/s');
ylabel('振幅');
set(gca,'FontSize',20,'FontWeight','bold');
set(gca,'xticklabel',get(gca,'xtick'),'yticklabel',get(gca,'ytick'));
grid on;

subplot(212);
fs = 1024;
N = length(xa);
n = 0:N-1;
t = n/fs;
y = fft(xa,N);
mag = abs(y);
f = (0:N-1)*fs/N;

plot(f(1:N/2),mag(1:N/2)*2/N,'LineWidth',2);
title('频域响应');
xlabel('频率/Hz');
ylabel('振幅');
xlim([0 300]);
ylim([0 inf]);
set(gca,'FontSize',20,'FontWeight','bold');
set(gca,'xticklabel',get(gca,'xtick'),'yticklabel',get(gca,'ytick'));
grid on;
