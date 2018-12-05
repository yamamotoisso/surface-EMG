clc;
clear all;

x = load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');


L1=length(x);
fs = 2000;
cx1=xcorr(x,'unbiased');%计算x的自相关函数
cxk1=fft(cx1,L1);
px1=abs(cxk1);%求功率谱密度
pxx1=10*log10(px1);
f1=(0:L1-1)*fs/L1;

figure(1);
% subplot(3,2,1)
subplot(2,1,1);
plot(f1(1:L1/2),pxx1(1:L1/2),'LineWidth',2);
xlim([0 500]);
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱}{\fontname{Times New Roman}(dB)}');
title('{\fontname{Times New Roman}PSD}');
set(gca,'FontSize',20,'FontWeight','bold','Fontname','Times New Roman');
box off;
% grid on  %做功率谱图
df1=fs/L1;
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

subplot(2,1,2);
c = rceps(x);
plot(c,'LineWidth',2);
xlim([0 500]);
xlabel('{\fontname{STSong}倒频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱}{\fontname{Times New Roman}(dB)}');
title('{\fontname{Times New Roman}CEP}');
set(gca,'FontSize',20,'FontWeight','bold','Fontname','Times New Roman');
box off;

figure(2);
subplot(2,1,1);
meanfreq(x,1000);
grid off;
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
title('{\fontname{STSong}平均频率估计：}{\fontname{Times New Roman}1.083Hz}');
set(gca,'FontSize',20,'FontWeight','bold','Fontname','Times New Roman');
box off;
subplot(2,1,2);
medfreq(x,1000);
grid off;
xlabel('{\fontname{STSong}频率}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}功率谱密度}{\fontname{Times New Roman}(dB/Hz)}');
title('{\fontname{STSong}中值频率估计：}{\fontname{Times New Roman}0.0291Hz}');
set(gca,'FontSize',20,'FontWeight','bold','Fontname','Times New Roman');
box off;