clear all;
close all;
clc;

%% Load signal
OriginalSignal =load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');

%% Signal processing
n=10000;
k=0:1/(n-1):1;
w=linspace(0,pi,10000);
X=abs(freqz(OriginalSignal,1,w));

%% Filter design
Fn=50;Fs=2200;
W3=0.4;
W0=2*pi*Fn/Fs;
beta=cos(W0);
alpha=min(roots([1,-2/cos(W3),1]));
a=[1,-beta*(1+alpha),alpha];
b=[1,-2*beta,1]*(1+alpha)/2;
ProcessingSignal=filter(b,a,OriginalSignal); 


%% Parameter
fb = [];
fc = [];
fd = [];
IAV = [];
MAV = [];
MAVS = [];
WL = []; 
PV = []; 
MV = []; 
VAR = [];
STD = []; 
RMS = []; 
MS = []; 
WAMP = [];


%% Feature extracte
fj = 1;

for i=1:50:9950;
    fb = OriginalSignal(i:i+50);
    %fb = ProcessingSignal(i:i+50);
    IAV(fj) = sum(abs(fb));
    MAV(fj) = sum(abs(fb))/length(fb);
    MAVS(fj) = sum(diff(abs(fb)))/length(fb);
    WL(fj) = sum(abs(diff(fb)));
    fc = sort(fb,'descend');
    PV(fj) = sum(fc(1:10))/10;
    MV(fj) = mean(fb);
    VAR(fj) = var(fb);
    STD(fj) = std(fb);
    RMS(fj) = sqrt(sum(fb.^2)/length(fb));
    MS(fj) = sqrt(sum(fb.^2)/length(fb))/mean(fb);
    fd = abs(diff(fb));
    for fk =1:1:50
     if fd(fk)>12;%threshold 
        fd(fk) = 1;
     else
        fd(fk) = 0;
        end 
    end

    WAMP(fj) = sum(fd);
    fj = fj+1;
    
end

TDfeature = [IAV;MAV;MAVS;WL;MV;VAR;STD;RMS;WAMP;PV;MS];
Rfeature = [WL;PV;IAV;MAV;MV;RMS;WAMP];
% [coeff,score,latent] = princomp(TDfeature');
[coeff,score,latent] = princomp(zscore(TDfeature'));
PCA = score(:,1:5)';%PCA = (zscore(TDfeature')*coeff(:,1:5))';
% PCA = [MAVS;STD;MS;VAR;score(:,1)'];
FEA = [MAVS;STD;WL;MS;VAR];%Best feature
HUTD = [MAV;MAVS;WL;RMS;IAV];%hudgins TD feature

%% Encode
T = [];
jb =1;
zero =[0;0;0;0;1];
class1 =[1;0;0;0;0];
class2 =[0;1;0;0;0];
class3 =[0;0;1;0;0];
class4 =[0;0;0;1;0];
T(:,1) = zero;
for ib = 2:1:20;
    if STD(ib)>18
        T(:,ib) = class1;
        %T(ib) = 1;
    else
        T(:,ib) = zero;
    end
end

for ib = 20:1:28;
    if STD(ib)>10
        T(:,ib) = class2;
        %T(ib) = 2;
    else
        T(:,ib) = zero;
    end
end

for ib = 28:1:35;
    if STD(ib)>10
        T(:,ib) = class3;
        %T(ib) = 3;
    else
        T(:,ib) = zero;
    end
end

for ib = 35:1:45;
    if STD(ib)>15
        T(:,ib) = class4;
        %T(ib) = 4;
    else
        T(:,ib) = zero;
    end
end

for ib = 45:1:60;
    if STD(ib)>18
        T(:,ib) = class1;
        %T(ib) = 1;
    else
        T(:,ib) = zero;
    end
end

for ib = 60:1:80;
    if STD(ib)>20
        T(:,ib) = class2;
        %T(ib) = 2;
    else
        T(:,ib) = zero;
    end
end

for ib = 80:1:100;
    if STD(ib)>20
        T(:,ib) = class3;
        %T(ib) = 3;
    else
        T(:,ib) = zero;
    end
end

for ib = 100:1:125;
    if STD(ib)>20
        T(:,ib) = class4;
        %T(ib) = 4;
    else
        T(:,ib) = zero;
    end
end

for ib = 125:1:140;
    if STD(ib)>20
        T(:,ib) = class1;
        %T(ib) = 1;
    else
        T(:,ib) = zero;
    end
end

for ib = 140:1:160;
    if STD(ib)>20
        T(:,ib) = class2;
        %T(ib) = 2;
    else
        T(:,ib) = zero;
    end
end

for ib = 160:1:199;
    T(:,ib) = zero;
end


%%  NNS1
inputs = FEA;
targets = T;

hiddenLayerSize =13;
net = patternnet(hiddenLayerSize);


% For a list of all processing functions type: help nnprocess
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};


% For a list of all data division functions type: help nndivide
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;


% For a list of all training functions type: help nntrain
net.trainFcn = 'trainlm';  % Levenberg-Marquardt


% For a list of all performance functions type: help nnperformance
net.performFcn = 'mse';  % Mean squared error


% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression'};



[net,tr] = train(net,inputs,targets);


outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);

trainTargets = targets .* tr.trainMask{1};
valTargets = targets  .* tr.valMask{1};
testTargets = targets  .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,outputs);
valPerformance = perform(net,valTargets,outputs);
testPerformance = perform(net,testTargets,outputs);

% view(net);

% Uncomment these lines to enable various plots.
% figure, plotperform(tr);
% figure, plottrainstate(tr);
figure, plotconfusion(targets,outputs);
set(gca,'FontSize',15,'FontWeight','bold','Fontname','Times New Roman');
% figure, ploterrhist(errors);

% Test the Network
testinputs= FEA;
testoutputs = net(testinputs);

%%  Coding1
[N,I]=max(testoutputs);
Ta = [];
for ti=1:1:199
    switch I(ti)
        case {1}
           Ta(ti) = 1;
        case {2}
           Ta(ti) = 2;
        case {3}
           Ta(ti) = 3;
        case {4}
           Ta(ti) = 4;
        case {5}
           Ta(ti) = 0;
        
    end
end

%% Codeplot
Tp = [];
ip =1;
for ip=1:1:199
   Tp(ip) = 1*T(1,ip)+2*T(2,ip)+3*T(3,ip)+4*T(4,ip)+0*T(5,ip); 
end

%%  NNS2
inputs2 = HUTD;
targets2 = T;
hiddenLayerSize =13;
net2 = patternnet(hiddenLayerSize);

% For a list of all processing functions type: help nnprocess
net2.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net2.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};

% For a list of all data division functions type: help nndivide
net2.divideFcn = 'dividerand';  % Divide data randomly
net2.divideMode = 'sample';  % Divide up every sample
net2.divideParam.trainRatio = 70/100;
net2.divideParam.valRatio = 15/100;
net2.divideParam.testRatio = 15/100;

% For a list of all training functions type: help nntrain
net2.trainFcn = 'trainlm';  % Levenberg-Marquardt

% For a list of all performance functions type: help nnperformance
net2.performFcn = 'mse';  % Mean squared error

% For a list of all plot functions type: help nnplot
net2.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression'};

[net2,tr2] = train(net2,inputs2,targets2);

outputs2 = net2(inputs2);
errors2 = gsubtract(targets2,outputs2);
performance2 = perform(net2,targets2,outputs2);

trainTargets2 = targets2 .* tr2.trainMask{1};
valTargets2 = targets2  .* tr2.valMask{1};
testTargets2 = targets2  .* tr2.testMask{1};
trainPerformance2 = perform(net2,trainTargets2,outputs2);
valPerformance2 = perform(net2,valTargets2,outputs2);
testPerformance2 = perform(net2,testTargets2,outputs2);

% view(net);
% Uncomment these lines to enable various plots.
% figure, plotperform(tr);
% figure, plottrainstate(tr);
figure, plotconfusion(targets2,outputs2);
set(gca,'FontSize',15,'FontWeight','bold','Fontname','Times New Roman');
% figure, ploterrhist(errors);

% Test the Network
testinputs2= HUTD;
testoutputs2 = net(testinputs2);

%%  Coding2
[N,I]=max(testoutputs2);
Ta2 = [];
for ti=1:1:199
    switch I(ti)
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

%%  NNS3
inputs3 = PCA;
targets3 = T;
hiddenLayerSize =13;
net3 = patternnet(hiddenLayerSize);

% For a list of all processing functions type: help nnprocess
net3.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net3.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};

% For a list of all data division functions type: help nndivide
net3.divideFcn = 'dividerand';  % Divide data randomly
net3.divideMode = 'sample';  % Divide up every sample
net3.divideParam.trainRatio = 70/100;
net3.divideParam.valRatio = 15/100;
net3.divideParam.testRatio = 15/100;

% For a list of all training functions type: help nntrain
net3.trainFcn = 'trainlm';  % Levenberg-Marquardt

% For a list of all performance functions type: help nnperformance
net3.performFcn = 'mse';  % Mean squared error

% For a list of all plot functions type: help nnplot
net3.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression'};

[net3,tr3] = train(net3,inputs3,targets3);

outputs3 = net3(inputs3);
errors = gsubtract(targets3,outputs3);
performance = perform(net3,targets3,outputs3);

trainTargets3 = targets3 .* tr3.trainMask{1};
valTargets3 = targets3  .* tr3.valMask{1};
testTargets3 = targets3  .* tr3.testMask{1};
trainPerformance = perform(net3,trainTargets3,outputs3);
valPerformance = perform(net3,valTargets3,outputs3);
testPerformance = perform(net3,testTargets3,outputs3);

% view(net);
% Uncomment these lines to enable various plots.
% figure, plotperform(tr);
% figure, plottrainstate(tr);
figure, plotconfusion(targets3,outputs3);
set(gca,'FontSize',15,'FontWeight','bold','Fontname','Times New Roman');
% figure, ploterrhist(errors);

% Test the Network
testinputs3= PCA;
testoutputs3 = net(testinputs3);

%%  Coding3
[N,I]=max(testoutputs3);
Ta3 = [];
for ti=1:1:199
    switch I(ti)
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
subplot(211);
plot(Tp,'-+b','linewidth',2);
% grid on;
% title('{\fontname{TSTong}目标量}');
title('Target');
set(gca,'FontSize',20,'FontWeight','bold','Fontname','Times New Roman');
set(gca,'linewidth',1);
set(gca,'YTick',[0 1 2 3 4],'YTickLabel',{'{\fontname{Times New Roman}RT}','{\fontname{Times New Roman}WF}','{\fontname{Times New Roman}WE}','{\fontname{Times New Roman}FC}','{\fontname{Times New Roman}PS}'});
set(gca,'FontSize',20,'FontWeight','bold');
ylabel('Gesture');
% ylabel('{\fontname{TSTong}手势}');
% xlabel('{\fontname{TSTong}时间窗个数}');
box off;

subplot(212);
plot(Ta,'-or','LineWidth',2);
hold on;
plot(Ta2,'dg','LineWidth',1.5);
hold on;
plot(Ta3,'xk','LineWidth',1);
legend({'Envelope feature','Hudgins TD feature','PCA feature'});
% grid on;
% title('{\fontname{TSTong}输出量}');
title('Output');
set(gca,'FontSize',20,'FontWeight','bold','Fontname','Times New Roman');
set(gca,'linewidth',1);
set(gca,'YTick',[0 1 2 3 4],'YTickLabel',{'{\fontname{Times New Roman}RT}','{\fontname{Times New Roman}WF}','{\fontname{Times New Roman}WE}','{\fontname{Times New Roman}FC}','{\fontname{Times New Roman}PS}'});
set(gca,'FontSize',20,'FontWeight','bold');
ylabel('Gesture');
% ylabel('{\fontname{TSTong}手势}');
% xlabel('{\fontname{TSTong}时间窗个数}');
box off;

figure(9);
plot(Tp,':.b','linewidth',2,'MarkerSize',40);
hold on;
plot(Ta,'+r','LineWidth',2,'MarkerSize',15);
hold on;
plot(Ta2,'om','LineWidth',1.5,'MarkerSize',10);
hold on;
plot(Ta3,'xk','LineWidth',2,'MarkerSize',15);

set(gca,'linewidth',1);
set(gca,'YTick',[0 1 2 3 4],'YTickLabel',{'{\fontname{Times New Roman}RT}','{\fontname{Times New Roman}WF}','{\fontname{Times New Roman}WE}','{\fontname{Times New Roman}FC}','{\fontname{Times New Roman}PS}'});
ylabel('Gesture');
set(gca,'FontSize',20,'FontWeight','bold','Fontname','Times New Roman');
legend({'Target','Envelope feature','Hudgins TD feature','PCA feature'});
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
