clear all;
close all;
clc;

%% Load signal
OriginalSignal =load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');
OriginalSignal(10001) = 0;

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

for i=1:50:10000;
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

FEA = [MAVS;STD;WAMP;RMS;MS;VAR];%Best feature


%% Correlation
cons = xcorr(RMS); %×ÔÏà¹Ø
con1 = corrcoef(RMS,MAV);
con2 = corrcoef(RMS,PV);
con3 = corrcoef(RMS,MV); 
con4 = corrcoef(RMS,IAV);
con5 = corrcoef(RMS,WL);
CON = [con1;con2;con3;con4;con5];

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

for ib = 160:1:200;
    T(:,ib) = zero;
end


%%  NNS
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

view(net);


% Uncomment these lines to enable various plots.
figure, plotperform(tr);
figure, plottrainstate(tr);
figure, plotconfusion(targets,outputs);
figure, ploterrhist(errors);

% Test the Network
testinputs= FEA;
testoutputs = net(testinputs);

%%  Coding
[N,I]=max(testoutputs);
Ta = [];
for ti=1:1:200
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

[Ne,Ie]=max(errors);
Te = [];
for ti=1:1:200
    switch Ie(ti)
        case {1}
           Te(ti) = 1;
        case {2}
           Te(ti) = 2;
        case {3}
           Te(ti) = 3;
        case {4}
           Te(ti) = 4;
        case {5}
           Te(ti) = 0;
        
    end
end

%% Codeplot
Tp = [];
ip =1;
for ip=1:1:200
   Tp(ip) = 1*T(1,ip)+2*T(2,ip)+3*T(3,ip)+4*T(4,ip)+0*T(5,ip); 
end

%% Plot
figure(5);
subplot(211);
plot(Tp,'-+b','linewidth',2);
grid on;
title('Target');
set(gca,'FontSize',20,'FontWeight','bold');
set(gca,'linewidth',2);
set(gca,'YTick',[0 1 2 3 4],'YTickLabel',{'RT','WF','WE','FC','PS'});
set(gca,'FontSize',20,'FontWeight','bold');
subplot(212);
plot(Ta,'-*r','LineWidth',2);
grid on;
title('Outputs');
set(gca,'FontSize',20,'FontWeight','bold');
set(gca,'linewidth',2);
set(gca,'YTick',[0 1 2 3 4],'YTickLabel',{'RT','WF','WE','FC','PS'});
set(gca,'FontSize',20,'FontWeight','bold');
