clear all;
clc;

a = load ('testarduino.txt');

figure(1);
subplot(211);
plot(a,'LineWidth',2);
title('{\fontname{TSTong}�ɼ����ļ����ź�}');
xlabel('{\fontname{TSTong}ʱ��}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{TSTong}���}{\fontname{Times New Roman}(mV)}');
% xlim([0 inf]);
ylim([0.1 inf]);
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;

subplot(212);
Ld = fda;
yl = filter(Ld,a);
% % yl1 = [];
% % for i=1:1:1000
% %    if abs(yl(i))>10
% %        yl(i)=10*yl(i);
% %    else
% %        yl(i)=yl(i);
% %    end
% % end
plot(yl,'r','LineWidth',2);
title('{\fontname{TSTong}�˲���ļ����ź�}');
xlabel('{\fontname{TSTong}ʱ��}{\fontname{Times New Roman}(s)}');
ylabel('{\fontname{TSTong}���}{\fontname{Times New Roman}(mV)}');
% xlim([0 inf]);
ylim([-inf inf]);
% set(gca,'FontSize',20,'FontWeight','bold');
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;


