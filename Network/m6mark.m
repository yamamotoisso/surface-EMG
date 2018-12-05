clc;
clear all;

load('6mark.mat');

figure(1);
subplot(211);
plot(Tp,'-+b','linewidth',2);
% grid on;
title('{\fontname{TSTong}目标量}');
% title('Target');
set(gca,'FontSize',20,'FontWeight','bold','Fontname','Times New Roman');
set(gca,'linewidth',1);
set(gca,'YTick',[0 1 2 3 4 6],'YTickLabel',{'{\fontname{Times New Roman}RT}','{\fontname{Times New Roman}WF}','{\fontname{Times New Roman}WE}','{\fontname{Times New Roman}FC}','{\fontname{Times New Roman}PS}','{\fontname{Times New Roman}US}'});
set(gca,'FontSize',20,'FontWeight','bold');
% ylabel('Gesture');
ylabel('{\fontname{TSTong}手势}');
xlabel('{\fontname{TSTong}时间窗个数}');
box off;

subplot(212);
plot(Tamark,'-or','LineWidth',2);
hold on;
plot(Ta,'-.xb','LineWidth',1.5);
% plot(Ta2,'vg','LineWidth',2);
% legend({'Optimal envelope TD feature','Hudgins TD feature'});
% grid on;
title('{\fontname{TSTong}输出量}');
% title('Output');
legend({'{\fontname{TSTong}标记特征量}','{\fontname{TSTong}未标记特征量}'});
set(gca,'FontSize',20,'FontWeight','bold','Fontname','Times New Roman');
set(gca,'linewidth',1);
set(gca,'YTick',[0 1 2 3 4 6],'YTickLabel',{'{\fontname{Times New Roman}RT}','{\fontname{Times New Roman}WF}','{\fontname{Times New Roman}WE}','{\fontname{Times New Roman}FC}','{\fontname{Times New Roman}PS}','{\fontname{Times New Roman}US}'});
set(gca,'FontSize',20,'FontWeight','bold');
% ylabel('Gesture');
ylabel('{\fontname{TSTong}手势}');
xlabel('{\fontname{TSTong}时间窗个数}');
box off;
