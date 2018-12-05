clear all;
close all;
clc;

load fea.mat;
load pca.mat;
load hudgins.mat;
load TDfeature.mat;
load TD5.mat;
load TD6.mat;

%% Feature
TDfeature = [IAV;MAV;MAVS;WL;MV;VAR;STD;RMS;WAMP;PV;MS];
[coeff,score,latent] = princomp(zscore(TDfeature'));
PCA = score(:,1:5)';%PCA = (zscore(TDfeature')*coeff(:,1:5))';
% PCA = [MAVS;STD;MS;VAR;score(:,1)'];
FEA = [MAVS;STD;WAMP;MS;VAR];%Best feature
HUTD = [MAV;MAVS;WL;RMS;IAV];%hudgins TD feature

%% NNS
testinputs1= FEA6;
testinputs2= PCA6;
testinputs3= HUTD6;
testoutputs1 = net1(testinputs1);
testoutputs2 = net3(testinputs2);
testoutputs3 = net2(testinputs3);

% inputs = FEA;
% targets = T;
% hiddenLayerSize =13;
% net = patternnet(hiddenLayerSize);
% % For a list of all processing functions type: help nnprocess
% net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
% net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};
% % For a list of all data division functions type: help nndivide
% net.divideFcn = 'dividerand';  % Divide data randomly
% net.divideMode = 'sample';  % Divide up every sample
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 15/100;
% % For a list of all training functions type: help nntrain
% net.trainFcn = 'trainlm';  % Levenberg-Marquardt
% % For a list of all performance functions type: help nnperformance
% net.performFcn = 'mse';  % Mean squared error
% net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
%   'plotregression'};
% [net,tr] = train(net,inputs,targets);
% outputs = net(inputs);
% errors = gsubtract(targets,outputs);
% performance = perform(net,targets,outputs);
% trainTargets = targets .* tr.trainMask{1};
% valTargets = targets  .* tr.valMask{1};
% testTargets = targets  .* tr.testMask{1};
% trainPerformance = perform(net,trainTargets,outputs);
% valPerformance = perform(net,valTargets,outputs);
% testPerformance = perform(net,testTargets,outputs);
% figure, plotconfusion(targets,outputs);
% set(gca,'FontSize',15,'FontWeight','bold','Fontname','Times New Roman');
% testinputs1= FEA;
% testoutputs1 = net(testinputs1);
% 
% inputs = PCA;
% targets = T;
% hiddenLayerSize =13;
% net = patternnet(hiddenLayerSize);
% % For a list of all processing functions type: help nnprocess
% net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
% net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};
% % For a list of all data division functions type: help nndivide
% net.divideFcn = 'dividerand';  % Divide data randomly
% net.divideMode = 'sample';  % Divide up every sample
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 15/100;
% % For a list of all training functions type: help nntrain
% net.trainFcn = 'trainlm';  % Levenberg-Marquardt
% % For a list of all performance functions type: help nnperformance
% net.performFcn = 'mse';  % Mean squared error
% net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
%   'plotregression'};
% [net,tr] = train(net,inputs,targets);
% outputs = net(inputs);
% errors = gsubtract(targets,outputs);
% performance = perform(net,targets,outputs);
% trainTargets = targets .* tr.trainMask{1};
% valTargets = targets  .* tr.valMask{1};
% testTargets = targets  .* tr.testMask{1};
% trainPerformance = perform(net,trainTargets,outputs);
% valPerformance = perform(net,valTargets,outputs);
% testPerformance = perform(net,testTargets,outputs);
% figure, plotconfusion(targets,outputs);
% set(gca,'FontSize',15,'FontWeight','bold','Fontname','Times New Roman');
% testinputs2= PCA;
% testoutputs2 = net(testinputs2);
% 
% inputs = HUTD;
% targets = T;
% hiddenLayerSize =13;
% net = patternnet(hiddenLayerSize);
% % For a list of all processing functions type: help nnprocess
% net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
% net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};
% % For a list of all data division functions type: help nndivide
% net.divideFcn = 'dividerand';  % Divide data randomly
% net.divideMode = 'sample';  % Divide up every sample
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 15/100;
% % For a list of all training functions type: help nntrain
% net.trainFcn = 'trainlm';  % Levenberg-Marquardt
% % For a list of all performance functions type: help nnperformance
% net.performFcn = 'mse';  % Mean squared error
% net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
%   'plotregression'};
% [net,tr] = train(net,inputs,targets);
% outputs = net(inputs);
% errors = gsubtract(targets,outputs);
% performance = perform(net,targets,outputs);
% trainTargets = targets .* tr.trainMask{1};
% valTargets = targets  .* tr.valMask{1};
% testTargets = targets  .* tr.testMask{1};
% trainPerformance = perform(net,trainTargets,outputs);
% valPerformance = perform(net,valTargets,outputs);
% testPerformance = perform(net,testTargets,outputs);
% figure, plotconfusion(targets,outputs);
% set(gca,'FontSize',15,'FontWeight','bold','Fontname','Times New Roman');
% testinputs3= HUTD;
% testoutputs3 = net(testinputs3);
%%  Coding
[N1,I1]=max(testoutputs1);
Ta1 = [];
for ti=1:1:199
    switch I1(ti)
        case {1}
           Ta1(ti) = 1;
        case {2}
           Ta1(ti) = 2;
        case {3}
           Ta1(ti) = 3;
        case {4}
           Ta1(ti) = 4;
        case {5}
           Ta1(ti) = 0;
        
    end
end
[N2,I2]=max(testoutputs2);
Ta2 = [];
for ti=1:1:199
    switch I2(ti)
        case {1}
           Ta2(ti) = 1;
        case {2}
           Ta2(ti) = 2;
        case {3}
           Ta2(ti) = 3;
        case {4}
           Ta2(ti) = 4;
        case {5}
           Ta2(ti) = 0;
        
    end
end
[N3,I3]=max(testoutputs3);
Ta3 = [];
for ti=1:1:199
    switch I3(ti)
        case {1}
           Ta3(ti) = 1;
        case {2}
           Ta3(ti) = 2;
        case {3}
           Ta3(ti) = 3;
        case {4}
           Ta3(ti) = 4;
        case {5}
           Ta3(ti) = 0;
        
    end
end

%% Plot
figure(8);
plot(Tp,':.b','linewidth',2,'MarkerSize',40);
hold on;
plot(feata,'+r','LineWidth',4,'MarkerSize',20);
hold on;
plot(pcata,'om','LineWidth',1,'MarkerSize',15);
hold on;
plot(hutdta,'xk','LineWidth',2,'MarkerSize',10);
set(gca,'linewidth',1);
set(gca,'YTick',[0 1 2 3 4],'YTickLabel',{'{\fontname{Times New Roman}RT}','{\fontname{Times New Roman}WF}','{\fontname{Times New Roman}WE}','{\fontname{Times New Roman}FC}','{\fontname{Times New Roman}PS}'});
ylabel('Gesture');
set(gca,'FontSize',30,'FontWeight','bold','Fontname','Times New Roman');
legend({'Target','Envelope feature','PCA feature','Hudgins TD feature'});
set(gca,'FontSize',35,'Fontname','Times New Roman');
box off;

figure(9);
plot(Tp,':.b','linewidth',2,'MarkerSize',40);
hold on;
plot(Ta1,'+r','LineWidth',2,'MarkerSize',15);
hold on;
plot(Ta2,'om','LineWidth',1.5,'MarkerSize',10);
hold on;
plot(Ta3,'xk','LineWidth',2,'MarkerSize',15);
set(gca,'linewidth',1);
set(gca,'YTick',[0 1 2 3 4],'YTickLabel',{'{\fontname{Times New Roman}RT}','{\fontname{Times New Roman}WF}','{\fontname{Times New Roman}WE}','{\fontname{Times New Roman}FC}','{\fontname{Times New Roman}PS}'});
ylabel('Gesture');
set(gca,'FontSize',35,'FontWeight','bold','Fontname','Times New Roman');
legend({'Target','Envelope feature','PCA feature','Hudgins TD feature'});
set(gca,'FontSize',35,'Fontname','Times New Roman');
box off;

AVE = [71.12,62.33,54.34];
WF = [85.28,83.89,62.50];
WE = [53.06,30.00,40.00];
FC = [42.04,33.33,33.33];
PS = [78.59,68.13,41.47];
RT = [96.62,96.30,94.42];
F = [WF;WE;FC;PS;RT];
E1 = [4,4,2];
E2 = [2,4,4];
E3 = [4,4,1];
E4 = [6,4,2];
E5 = [1,1,1];
E = [E1;E2;E3;E4;E5];
P = [1,2,3,4,5;1,2,3,4,5;1,2,3,4,5];
er = 0.22;
P(1,:) = P(1,:)-er;
P(3,:) = P(3,:)+er;
figure(10);
bar(F,'LineWidth',1);
set(gca,'XTick',[1 2 3 4 5],'XTickLabel',{'WF','WE','FC','PS','RT'});
colormap([1.0 0.8 0.0;
    0.0 0.9 0.3;
    0.5 0.0 0.8]);
legend({'Envelope feature','PCA feature','Hudgins TD feature'},'Orientation','horizontal');
ylabel('Recognition accuracy rate(%)');
set(gca,'FontSize',35,'Fontname','Times New Roman');
set(gca,'linewidth',1,'FontWeight','bold');
xlim([0.6,5.5]);
ylim([0,99]);
box off;
hold on;
errorbar(P(1,:),F(:,1)',E(:,1)','k','Linestyle','none','lineWidth',2);
hold on;
errorbar(P(2,:),F(:,2)',E(:,2)','k','Linestyle','none','lineWidth',2);
hold on;
errorbar(P(3,:),F(:,3)',E(:,3)','k','Linestyle','none','lineWidth',2);
box off;

figure(11);
plot(F(:,1)','-.r','lineWidth',3,'MarkerSize',10);
hold on;
plot(F(:,2)','-ob','lineWidth',3,'MarkerSize',10);
hold on;
plot(F(:,3)','-xk','lineWidth',3,'MarkerSize',20);
box off;
set(gca,'XTick',[1 2 3 4 5],'XTickLabel',{'WF','WE','FC','PS','RT'});
legend({'Envelope feature','PCA feature','Hudgins TD feature'},'Orientation','horizontal');
ylabel('Recognition accuracy rate(%)');
set(gca,'FontSize',35,'Fontname','Times New Roman');
set(gca,'linewidth',1,'FontWeight','bold');
xlim([0.9,5.1]);
ylim([20,99]);