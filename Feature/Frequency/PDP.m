function [ PSD,MDF,MPF ] = PDP( data,fs )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
L=length(data);
cx=xcorr(data,'unbiased');
cxk=fft(cx,L);
px=abs(cxk);%�������ܶ�
PSD = 10*log10(px);
% f=(0:L-1)*fs/L;
% plot(f1(1:L1/2),pxx1(1:L1/2))
% xlabel('Ƶ��/Hz');ylabel('������/dB');
% title('ƽ��������ͼ');
% grid on  %��������ͼ
df=fs/L;
p=(sum(px(1:L/2-1))+sum(px(1:L/2)))/2.*df;
pf=(sum(px(1:L/2-1).*[1:L/2-1]'.*df)+sum(px(1:L/2).*[1:L/2]'.*df))/2*df;
MPF = pf/p; %��ƽ������Ƶ��
N=1;
pp=0;
while abs(pp-p/2)>(px(N)+px(N+1))/2*df
    pp=pp+(px(N)+px(N+1))/2*df;
    N=N+1;
end
n=(N+N+1)/2;
MDF = df*n; %����ֵƵ��


end

