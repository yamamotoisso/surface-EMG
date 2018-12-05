%% test for princomp(Principal Component Analysis)
% 20170706 BY Hubery_Zhang
clear;
clc;
%% load data set
load cities;
%% box plot forratings data
% To get a quickimpression of the ratings data, make a box plot
figure(1);
boxplot(ratings,'orientation','horizontal','labels',categories);
grid on;
%% pre-process
stdr =std(ratings);
sr =ratings./repmat(stdr,329,1);
%% use princomp
[coeff,score,latent,tsquare]= princomp(sr);
%% �����ȡ���ɷ�,�ﵽ��Ϊ��Ŀ��
% ͨ��latent,����֪����ȡǰ�������ɷ־Ϳ�����.
% ͼ�е��߱�ʾ���ۻ��������ͳ̶�.
% ͨ����ͼ���Կ���ǰ�߸����ɷֿ��Ա�ʾ��ԭʼ���ݵ�90%.
% ������90%��������ֻ����ȡǰ�߸����ɷּ���,�����ﵽ���ɷ���ȡ��Ŀ��.
figure(2);
percent_explained= 100*latent/sum(latent); %cumsum(latent)./sum(latent)
pareto(percent_explained);
xlabel('PrincipalComponent');
ylabel('VarianceExplained (%)');
%% Visualizing theResults
% �������������ֱ��ʾ��һ���ɷֺ͵ڶ����ɷ�
% ��ɫ�ĵ����329���۲���,����������Ǹ�score
% ��ɫ�������ķ���ͳ��ȱ�ʾ��ÿ��ԭʼ�������µ����ɷֵĹ���,����������Ǹ�coeff.
figure(3);
biplot(coeff(:,1:2),'scores',score(:,1:2),...
'varlabels',categories);
axis([-0.20 0.60 -.50 0.50]);
