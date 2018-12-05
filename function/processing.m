clear all;
clc;
n=10000;%����Ƶ��10000HZ
k=0:1/(n-1):1;
x=load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');
w=linspace(0,pi,10000);%0~pi��10000���ȷ�����
%linspace�����������Լ������������ð�������":"�������ƣ��Ҹ�����ĸ���
X=abs(freqz(x,1,w));
%%freqz�������������˲�����Ƶ����Ӧ�ĺ�����abs����ȡ����ֵ
figure(1);
subplot(2,1,1);
plot(k,x);
title('�˲�ǰ���и��ŵļ����źŲ���');
subplot(2,1,2);
plot(w/pi,X);
title('�˲�ǰ�ķ�Ƶ���ԣ�Ƶ����Ӧ��');

%%%%%%%%%%%%%%%  �˳�50HZ�������˲���������IIR�����˲���  %%%%%%%%%%%%%%%
Fn=50;Fs=2200;
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
subplot(3,1,1);
plot(k,y1);
title('�������˲���Ĳ���ͼ');
X=abs(freqz(y1,1,w));
subplot(3,1,2);
plot(w/pi,X);
title('�������˲���ķ�Ƶ����');
subplot(3,1,3);
H1=abs(freqz(b,a));
w1 = linspace(0,pi,512);
plot(w1/pi,H1);
title('�����˲����ķ�Ƶ����');

figure(3);
subplot(2,1,1);
plot(k,x,'linewidth',2);
grid on;
title('�˲�ǰԭʼ�ź�');
subplot(2,1,2);
plot(k,y1,'r','linewidth',2);
grid on;
title('�����˲�����ź�');

figure(4);
plot(k,x,'linewidth',2);
hold on;
plot(k,y1,'r','linewidth',2);
grid on;
legend('�˲�ǰԭʼ�ź�','�����˲�����ź�');