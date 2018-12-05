fs=9600;
L1=length(yb);
cx1=xcorr(yb,'unbiased');
cxk1=fft(cx1,L1);
px1=abs(cxk1);%求功率谱密度
pxx1=10*log10(px1);
f1=(0:L1-1)*fs/L1;
plot(f1(1:L1/2),pxx1(1:L1/2))
xlabel('频率/Hz');ylabel('功率谱/dB');
title('平均功率谱图');
grid on  %做功率谱图
df1=fs/L1;
p1=(sum(px1(1:L1/2-1))+sum(px1(1:L1/2)))/2.*df1;
pf1=(sum(px1(1:L1/2-1).*[1:L1/2-1]'.*df1)+sum(px1(1:L1/2).*[1:L1/2]'.*df1))/2*df1;
MPF1=pf1/p1 %求平均功率频率
N1=1;pp1=0;
while abs(pp1-p1/2)>(px1(N1)+px1(N1+1))/2*df1
    pp1=pp1+(px1(N1)+px1(N1+1))/2*df1;
    N1=N1+1;
end
n_1=(N1+N1+1)/2;
MF1=df1*n_1 %求中值频率