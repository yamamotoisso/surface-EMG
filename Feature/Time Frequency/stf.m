clc;
clear all;

load tesignal.mat;

for i=1:1:1000
   if abs(yl(i))>10
       yl(i)=100*yl(i);
   else
       yl(i)=yl(i);
   end
end

% [s,f,t] = spectrogram(yl);
[s,f,t] = spectrogram(yl,256,250,256,1000);

figure(1);
% subplot(211);
% plot(yl,'r','LineWidth',2);
% xlabel('{\fontname{TSTong}时间}{\fontname{Times New Roman}(s)}');
% ylabel('{\fontname{TSTong}幅值}{\fontname{Times New Roman}(mV)}');
% set(gca,'FontSize',20,'Fontname','Times New Roman');
% box off;
% 
% subplot(212);
% subplot(211);
figure(1);
imagesc(100*t,f,10*log10(abs(s)));
c = colorbar;
c.Label.String = '{\fontname{TSTong}相对功率谱密度}{\fontname{Times New Roman}(dB/Hz)}';
caxis([5,44]);
set(gca, 'YDir', 'normal');
axis tight;
xlabel('{\fontname{TSTong}时间}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{TSTong}频率}{\fontname{Times New Roman}(Hz)}');
title('STFT');
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;

y2= hilbert(yl);
[swv,t2,f2] = tfrwv(y2);

figure(2);
% subplot(212);
imagesc(t2/10,1000*f2,10*log10(abs(swv)));
c = colorbar;
c.Label.String = '{\fontname{TSTong}相对功率谱密度}{\fontname{Times New Roman}(dB/Hz)}';
set(gca, 'YDir', 'normal');
xlabel('{\fontname{TSTong}时间}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{TSTong}频率}{\fontname{Times New Roman}(Hz)}');
xlim([0,99]);
ylim([0,500]);
caxis([-5,80]);
title('WVD');
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;