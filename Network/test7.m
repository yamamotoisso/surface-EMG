close all;
clear all;
clc;


%% Load signal
OriginalSignal =load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata5.txt');
OriginalSignal(10001) = 45;
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
KUR =[];
SKE =[];
MAD =[];
%% Feature extracte
fj = 1;

for i=1:50:9950;
    fb = OriginalSignal(i:i+50);
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
    KUR(fj) = kurtosis(fb);
    SKE(fj) = skewness(fb);
    
    fd = abs(diff(fb));
    for fk =1:1:50
     if fd(fk)>5;%threshold 
        fd(fk) = 1;
     else
        fd(fk) = 0;
        end 
    end

    WAMP(fj) = sum(fd);
    fj = fj+1;
    
end
MAD = STD;
FEA = [MAVS;STD;WAMP;RMS;MS;VAR];%Best feature


%% Correlation
cons = xcorr(RMS); %自相关
con1 = corrcoef(RMS,MAV);
con2 = corrcoef(RMS,PV);
con3 = corrcoef(RMS,MV); 
con4 = corrcoef(RMS,IAV);
con5 = corrcoef(RMS,WL);
CON = [con1;con2;con3;con4;con5];
%% Encode
T = [];
ib = 1;
zero =[0;0;0;0;1;0];
class1 =[1;0;0;0;0;0];
class2 =[0;1;0;0;0;0];
class3 =[0;0;1;0;0;0];
class4 =[0;0;0;1;0;0];

class6 =[0;0;0;0;0;1];
class7 =[0;0;0;0;0;1];

T(:,1) = zero;

for ib = 2:1:16;
    if STD(ib)>10
        T(:,ib) = class1;
        %T(ib) = 1;
    else
        T(:,ib) = zero;
    end
end

for ib = 17:1:22;
    if STD(ib)>8
        T(:,ib) = class2;
        %T(ib) = 2;
    else
        T(:,ib) = zero;
    end
end
for ib = 23:1:30;
    if STD(ib)>10
        T(:,ib) = class3;
        %T(ib) = 3;
    else
        T(:,ib) = zero;
    end
end

for ib = 31:1:39;
    if STD(ib)>10
        T(:,ib) = class4;
        %T(ib) = 4;
    else
        T(:,ib) = zero;
    end
end

for ib = 40:1:49;
    if STD(ib)>10
        T(:,ib) = class6;
        %T(ib) = 6;
    else
        T(:,ib) = zero;
    end
end

for ib = 50:1:60;
    if STD(ib)>2
        T(:,ib) = class7;
        %T(ib) = 7;
    else
        T(:,ib) = zero;
    end
end

for ib = 61:1:70;
    if STD(ib)>10
        T(:,ib) = class1;
        %T(ib) = 1;
    else
        T(:,ib) = zero;
    end
end

for ib = 71:1:81;
    if STD(ib)>10
        T(:,ib) = class2;
        %T(ib) = 2;
    else
        T(:,ib) = zero;
    end
end

for ib = 82:1:100;
    if STD(ib)>10
        T(:,ib) = class3;
        %T(ib) = 3;
    else
        T(:,ib) = zero;
    end
end

for ib = 101:1:120;
    if STD(ib)>10
        T(:,ib) = class4;
        %T(ib) = 4;
    else
        T(:,ib) = zero;
    end
end

for ib = 121:1:140;
    if STD(ib)>10
        T(:,ib) = class6;
        %T(ib) = 6;
    else
        T(:,ib) = zero;
    end
end

for ib = 140:1:160;
    if STD(ib)>1
        T(:,ib) = class7;
        %T(ib) = 7;
    else
        T(:,ib) = zero;
    end
end

for ib = 160:1:199;
    if STD(ib)>10
        T(:,ib) = class1;
        %T(ib) = 1;
    else
        T(:,ib) = zero;
    end
end


%%  NNS
inputs = FEA;
targets = T;

hiddenLayerSize =10;
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
figure, plotperform(tr);
figure, plottrainstate(tr);
figure, plotconfusion(targets,outputs);
figure, ploterrhist(errors);

% Test the Network
testinputs= FEA;
testoutputs = net(testinputs);
testoutputss =testoutputs';
%%  Coding
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
        case {6}
           Ta(ti) = 6;
    end
end

%% Codeplot
Tp = [];
ip =1;
for ip=1:1:199
   Tp(ip) = 1*T(1,ip)+2*T(2,ip)+3*T(3,ip)+4*T(4,ip)+0*T(5,ip)+6*T(6,ip); 
end

%% Plot
figure(5);
subplot(211);
plot(Tp,'-+b','linewidth',2);
% grid on;
title('{\fontname{STSong}目标量}');
set(gca,'FontSize',20,'FontWeight','bold');
set(gca,'linewidth',2);
set(gca,'YTick',[0 1 2 3 4 6],'YTickLabel',{'{\fontname{Times New Roman}RT}','{\fontname{Times New Roman}WF}','{\fontname{Times New Roman}WE}','{\fontname{Times New Roman}FC}','{\fontname{Times New Roman}PS}','{\fontname{Times New Roman}US}'});
set(gca,'FontSize',20,'FontWeight','bold');
ylabel('手势');
xlabel('时间窗个数');

subplot(212);
plot(Ta,'-*r','LineWidth',2);
% grid on;
title('输出量');
ylabel('手势');
xlabel('时间窗个数');
set(gca,'FontSize',20,'FontWeight','bold');
set(gca,'linewidth',2);
set(gca,'YTick',[0 1 2 3 4 6],'YTickLabel',{'{\fontname{Times New Roman}RT}','{\fontname{Times New Roman}WF}','{\fontname{Times New Roman}WE}','{\fontname{Times New Roman}FC}','{\fontname{Times New Roman}PS}','{\fontname{Times New Roman}US}'});
set(gca,'FontSize',20,'FontWeight','bold');