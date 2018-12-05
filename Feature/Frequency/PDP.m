function [ PSD,MDF,MPF ] = PDP( data,fs )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
L=length(data);
cx=xcorr(data,'unbiased');
cxk=fft(cx,L);
px=abs(cxk);%求功率谱密度
PSD = 10*log10(px);
% f=(0:L-1)*fs/L;
% plot(f1(1:L1/2),pxx1(1:L1/2))
% xlabel('频率/Hz');ylabel('功率谱/dB');
% title('平均功率谱图');
% grid on  %做功率谱图
df=fs/L;
p=(sum(px(1:L/2-1))+sum(px(1:L/2)))/2.*df;
pf=(sum(px(1:L/2-1).*[1:L/2-1]'.*df)+sum(px(1:L/2).*[1:L/2]'.*df))/2*df;
MPF = pf/p; %求平均功率频率
N=1;
pp=0;
while abs(pp-p/2)>(px(N)+px(N+1))/2*df
    pp=pp+(px(N)+px(N+1))/2*df;
    N=N+1;
end
n=(N+N+1)/2;
MDF = df*n; %求中值频率


end

