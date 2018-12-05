%%%%%%%%%%%%%%%%   ��¼�ź�   %%%%%%%%%%%%%%%%%%%%
clear all%��������ڴ��еı���
close all%�ر����еĳ���ʹ���

n=9600;%����Ƶ��9600HZ
k=0:1/(n-1):1;
x=load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');

w=linspace(0,pi,10000);%0~pi��10000���ȷ�����
%linspace�����������Լ������������ð�������":"�������ƣ��Ҹ�����ĸ���
X=abs(freqz(x,1,w));
%%freqz�������������˲�����Ƶ����Ӧ�ĺ�����abs����ȡ����ֵ
figure(1);
subplot(2,1,1);
plot(x,'linewidth',2);
xlabel('{\fontname{STSong}ʱ��}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{STSong}��ֵ}{\fontname{Times New Roman}(mV)}');
title('{\fontname{STSong}ʱ����Ӧ}');
ylim([-inf inf]);
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
subplot(2,1,2);
plot(linspace(0,1000,10000),X,'linewidth',2);
xlabel('{\fontname{STSong}Ƶ��}{\fontname{Times New Roman}(Hz)}');
ylabel('{\fontname{STSong}��ֵ}{\fontname{Times New Roman}(dB)}');
%plot(w/pi,X);
title('{\fontname{STSong}Ƶ����Ӧ}');
ylim([-inf,inf]);
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
ylim([-inf,150000]);
%%%%%%%%%%%%%%%  �˳�50HZ�������˲���������IIR�����˲���  %%%%%%%%%%%%%%%
Fn=50;Fs=2300;
W3=0.4;
W0=2*pi*Fn/Fs;
beta=cos(W0);
alpha=min(roots([1,-2/cos(W3),1]));
%roots�����ʽ�ĸ���min�ҳ������е���СԪ��;
a=[1,-beta*(1+alpha),alpha];
b=[1,-2*beta,1]*(1+alpha)/2; % a,b Ϊ�˲���ϵ��
y1=filter(b,a,x); 
% FILTER��һά�����˲���������XΪ�˲�ǰ���У�YΪ�˲������У�
% B/A �ṩ�˲���ϵ����BΪ���ӣ� AΪ��ĸ 
% save('testdata3.mat','y1');

figure(2);
subplot(2,1,1);
plot(x,'linewidth',2);
xlabel('{\fontname{STSong}ʱ��}{\fontname{Times New Roman}(ms)}');
ylabel('��ֵ{\fontname{Times New Roman}(mV)}');
title('ʱ����Ӧ');
set(gca,'FontSize',20,'FontWeight','bold');
subplot(2,1,2);
fy = fft(x,n);
f = -0.5:1/n:0.5-1/n;
plot(f,fftshift(abs(fy)),'linewidth',2);
xlabel('Ƶ��{\fontname{Times New Roman}(Hz)}');
ylabel('��ֵ{\fontname{Times New Roman}(dB)}');
%plot(w/pi,X);
title('Ƶ����Ӧ');
set(gca,'FontSize',20,'FontWeight','bold');

figure(3);
subplot(2,1,1);
plot(linspace(0,1000,10000),X,'linewidth',2);
xlabel('Ƶ��{\fontname{Times New Roman}(Hz)}');
ylabel('��ֵ{\fontname{Times New Roman}(dB)}');
title('�˲�ǰ�ķ�Ƶ����');
set(gca,'FontSize',20,'FontWeight','bold');
X1=abs(freqz(y1,1,w));
subplot(2,1,2);
plot(linspace(0,1000,10000),X1,'linewidth',2);
xlabel('Ƶ��{\fontname{Times New Roman}(Hz)}');
ylabel('��ֵ{\fontname{Times New Roman}(dB)}');
title('�������˲���ķ�Ƶ����');
set(gca,'FontSize',20,'FontWeight','bold');
% subplot(3,1,3);
% H1=abs(freqz(b,a));
% w1 = linspace(0,pi,512);
% plot(w1/pi,H1);
% title('�����˲����ķ�Ƶ����');

figure(4);
plot(x,'b','LineWidth',2);
grid on;
hold on;
plot(y1,'r','LineWidth',2);
legend('�˲�ǰԭʼ�ź�','�˲�����ź�');
set(gca,'FontSize',30,'FontWeight','bold');
set(gca,'linewidth',3);
xlabel('ʱ��{\fontname{Times New Roman}(ms)}');
ylabel('��ֵ{\fontname{Times New Roman}(mV)}');

