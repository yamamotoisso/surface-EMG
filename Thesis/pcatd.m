clc;
clear all;

load('ntd.mat');
pca = load('npca.mat');

figure(1);
subplot(211);
plot(Tp,'-+b','linewidth',2);
% grid on;
title('{\fontname{TSTong}Ŀ����}');
% title('Target');
set(gca,'FontSize',20,'FontWeight','bold','Fontname','Times New Roman');
set(gca,'linewidth',1);
set(gca,'YTick',[0 1 2 3 4],'YTickLabel',{'{\fontname{Times New Roman}RT}','{\fontname{Times New Roman}WF}','{\fontname{Times New Roman}WE}','{\fontname{Times New Roman}FC}','{\fontname{Times New Roman}PS}'});
set(gca,'FontSize',20,'FontWeight','bold');
% ylabel('Gesture');
ylabel('{\fontname{TSTong}����}');
xlabel('{\fontname{TSTong}ʱ�䴰����}');
box off;

subplot(212);
plot(Ta,'-or','LineWidth',2);
hold on;
plot(pca.Ta,'-.xb','LineWidth',1.5);
% plot(Ta2,'vg','LineWidth',2);
% legend({'Optimal envelope TD feature','Hudgins TD feature'});
% grid on;
title('{\fontname{TSTong}�����}');
% title('Output');
legend({'TD{\fontname{TSTong}����}','PCA{\fontname{TSTong}����}'},'Orientation','horizontal');
set(gca,'FontSize',20,'FontWeight','bold','Fontname','Times New Roman');
set(gca,'linewidth',1);
set(gca,'YTick',[0 1 2 3 4],'YTickLabel',{'{\fontname{Times New Roman}RT}','{\fontname{Times New Roman}WF}','{\fontname{Times New Roman}WE}','{\fontname{Times New Roman}FC}','{\fontname{Times New Roman}PS}'});
set(gca,'FontSize',20,'FontWeight','bold');
% ylabel('Gesture');
ylabel('{\fontname{TSTong}����}');
xlabel('{\fontname{TSTong}ʱ�䴰����}');
box off;
