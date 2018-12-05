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
%% 如何提取主成分,达到降为的目的
% 通过latent,可以知道提取前几个主成分就可以了.
% 图中的线表示的累积变量解释程度.
% 通过看图可以看出前七个主成分可以表示出原始数据的90%.
% 所以在90%的意义下只需提取前七个主成分即可,进而达到主成分提取的目的.
figure(2);
percent_explained= 100*latent/sum(latent); %cumsum(latent)./sum(latent)
pareto(percent_explained);
xlabel('PrincipalComponent');
ylabel('VarianceExplained (%)');
%% Visualizing theResults
% 横坐标和纵坐标分别表示第一主成分和第二主成分
% 红色的点代表329个观察量,其坐标就是那个score
% 蓝色的向量的方向和长度表示了每个原始变量对新的主成分的贡献,其坐标就是那个coeff.
figure(3);
biplot(coeff(:,1:2),'scores',score(:,1:2),...
'varlabels',categories);
axis([-0.20 0.60 -.50 0.50]);
