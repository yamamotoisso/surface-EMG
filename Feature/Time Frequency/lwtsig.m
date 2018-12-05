clc;
clear all;

load tesignal.mat;

lshaar = liftwave('haar');
els = {'p',[-0.25 0.25],0};
lsnew = addlift(lshaar,els);

[cA,cD] = lwt(yl,lsnew);
xRec = ilwt(cA,cD,lsnew);
xDec = ilwt(yl,lsnew,2);

a1 = lwtcoef('a',xDec,lsnew,2,1);
a2 = lwtcoef('a',xDec,lsnew,2,2);
d1 = lwtcoef('d',xDec,lsnew,2,1);
d2 = lwtcoef('d',xDec,lsnew,2,2);

err = max(abs(yl-a2-d2-d1));
figure(1);
% subplot(311);
plot(yl);
title('{\fontname{TSTong}原始信号}');
xlabel('{\fontname{TSTong}时间}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{TSTong}幅值}{\fontname{Times New Roman}(mV)}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;

figure(2);
subplot(221);
plot(a2);
title('{\fontname{TSTong}重构第一层近似信号}');
xlabel('{\fontname{TSTong}时间}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{TSTong}幅值}{\fontname{Times New Roman}(mV)}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
subplot(222);
plot(a2);
title('{\fontname{TSTong}重构第二层近似信号}');
xlabel('{\fontname{TSTong}时间}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{TSTong}幅值}{\fontname{Times New Roman}(mV)}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
subplot(223);
plot(d1);
title('{\fontname{TSTong}重构第一层细节信号}');
xlabel('{\fontname{TSTong}时间}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{TSTong}幅值}{\fontname{Times New Roman}(mV)}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
subplot(224);
plot(d2);
title('{\fontname{TSTong}重构二层细节信号}');
xlabel('{\fontname{TSTong}时间}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{TSTong}幅值}{\fontname{Times New Roman}(mV)}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;