%% ��ʼ�������ռ�
clc
clear
close all

%% ��������
load fisheriris

%% ��ά����ʾ��
% ���곤�Ⱥͻ�����ɢ��ͼ
figure(1);
speciesNum = grp2idx(species);
gscatter(meas(:,3),meas(:,4),speciesNum,['r','g','b'])
% ���곤�ȺͿ�ȵ�PCA����
% measRe = score*coeff'+repmat(mu,size(score,1),1);
[coeff,score,latent,tsquared explained,mu] = pca(meas(:,3:4));
hold on
plot(mu(1)+[0 coeff(1,1)],mu(2)+[0 coeff(2,1)],'r')
plot(mu(1)+[0 coeff(1,2)],mu(2)+[0 coeff(2,2)],'g')
hold off
axis equal
axis([-1 7 -1 7])
xlabel('���곤��')
ylabel('������')

%% ��ά����ʾ��
%% ���ɷַ��� Principal Component Analysis
% measRe = score*coeff'+repmat(mu,size(score,1),1);
[coeff, score, latent, tsquared, explained, mu] = pca(meas);
% PLotMatrix����ɢ��ͼ����
% ��ʼ����ͼ����
hf  = figure(2);
hf.Units = 'Pixels';
% set(hf,'Units','Pixels');
hf.Position = [50 50 800 800];
% ����ɢ��ͼ����
speciesNum = grp2idx(species);
[H,AX,BigAx] = gplotmatrix(score,[],speciesNum,['r','g','b']);
legend(AX(13+3),{'Setosa ɽ�β','Versicolor ��ɫ�β','Virginica ���������β'},'Location','northwest','FontWeight','Bold','Fontsize',10)
title(BigAx,'�β������PCAɢ��ͼ����','FontWeight','Bold','Fontsize',16)
%���������
xlabel(AX(4),{'Component 1';'�ɷ�1'},'FontWeight','Bold','Fontsize',12)
xlabel(AX(8+1),{'Component 2';'�ɷ�2'},'FontWeight','Bold','Fontsize',12)
xlabel(AX(12+2),{'Component 3','�ɷ�3'},'FontWeight','Bold','Fontsize',12)
xlabel(AX(16+3),{'Component 4','�ɷ�4'},'FontWeight','Bold','Fontsize',12)
% ���������
ylabel(AX(1),{'Component 1';'�ɷ�1'},'FontWeight','Bold','Fontsize',12)
ylabel(AX(2),{'Component 2';'�ɷ�2'},'FontWeight','Bold','Fontsize',12)
ylabel(AX(3),{'Component 3','�ɷ�3'},'FontWeight','Bold','Fontsize',12)
ylabel(AX(4),{'Component 4','�ɷ�4'},'FontWeight','Bold','Fontsize',12)
% Biplot��������ͼ
hf2 = figure(3);
vbls={'��Ƭ����','��Ƭ���','���곤��','������'};
biplot(coeff(:,1:3),'Score',score(:,1:3),'Varlabels',vbls);
