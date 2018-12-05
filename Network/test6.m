clear all;
close all;
clc;

%% Load signal
OriginalSignalA =load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');
OriginalSignalB =load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata5.txt');
OriginalSignalA(10001) = 85;
OriginalSignalB(10001) = 45;
%% Signal processing
n=10000;
k=0:1/(n-1):1;
w=linspace(0,pi,10000);
X=abs(freqz(OriginalSignalA,1,w));

%% Filter design
Fn=50;Fs=2200;
W3=0.4;
W0=2*pi*Fn/Fs;
beta=cos(W0);
alpha=min(roots([1,-2/cos(W3),1]));
a=[1,-beta*(1+alpha),alpha];
b=[1,-2*beta,1]*(1+alpha)/2;
ProcessingSignal=filter(b,a,OriginalSignalA); 


%% Parameter
fb = [];
fc = [];
fd = [];
fbb = [];
fcc = [];
fdd = [];
IAVA = [];
MAVA = [];
MAVSA = [];
WLA = []; 
PVA = []; 
MVA = []; 
VARA = [];
STDA = []; 
RMSA = []; 
MSA = []; 
WAMPA = [];
IAVB = [];
MAVB = [];
MAVSB = [];
WLB = []; 
PVB = []; 
MVB = []; 
VARB = [];
STDB = []; 
RMSB = []; 
MSB = []; 
WAMPB = [];


%% Feature extracte
fjj = 1;
for ii=1:50:9950;
    fbb = OriginalSignalA(ii:ii+50);
    %fb = ProcessingSignal(i:i+50);
    IAVA(fjj) = sum(abs(fbb));
    MAVA(fjj) = sum(abs(fbb))/length(fbb);
    MAVSA(fjj) = sum(diff(abs(fbb)))/length(fbb);
    WLA(fjj) = sum(abs(diff(fbb)));
    fcc = sort(fbb,'descend');
    PVA(fjj) = sum(fcc(1:10))/10;
    MVA(fjj) = mean(fbb);
    VARA(fjj) = var(fbb);
    STDA(fjj) = std(fbb);
    RMSA(fjj) = sqrt(sum(fbb.^2)/length(fbb));
    MSA(fjj) = sqrt(sum(fbb.^2)/length(fbb))/mean(fbb);
    fdd = abs(diff(fbb));
    for fkk =1:1:50
     if fdd(fkk)>12;%threshold 
        fdd(fkk) = 1;
     else
        fdd(fkk) = 0;
        end 
    end

    WAMPA(fjj) = sum(fdd);
    fjj = fjj+1;
    
end
FEAA = [MAVSA;STDA;WAMPA;RMSA;MSA;VARA];%Best feature

fj = 1;
for i=1:50:9950;
    fb = OriginalSignalB(i:i+50);
    %fb = ProcessingSignal(i:i+50);
    IAVB(fj) = sum(abs(fb));
    MAVB(fj) = sum(abs(fb))/length(fb);
    MAVSB(fj) = sum(diff(abs(fb)))/length(fb);
    WLB(fj) = sum(abs(diff(fb)));
    fc = sort(fb,'descend');
    PVB(fj) = sum(fc(1:10))/10;
    MVB(fj) = mean(fb);
    VARB(fj) = var(fb);
    STDB(fj) = std(fb);
    RMSB(fj) = sqrt(sum(fb.^2)/length(fb));
    MSB(fj) = sqrt(sum(fb.^2)/length(fb))/mean(fb);
    fd = abs(diff(fb));
    for fk =1:1:50
     if fd(fk)>5;%threshold 
        fd(fk) = 1;
     else
        fd(fk) = 0;
        end 
    end

    WAMPB(fj) = sum(fd);
    fj = fj+1;
    
end
FEAB = [MAVSB;STDB;WAMPB;RMSB;MSB;VARB];

%% Encode
T = [];
T(:,1) = [0;0;0;0;1];
for ib = 2:1:20;
    if STDA(ib)>18
        T(:,ib) = [1;0;0;0;0];
        %T(ib) = 1;
    else
        T(:,ib) = [0;0;0;0;1];
    end
end

for ib = 20:1:28;
    if STDA(ib)>10
        T(:,ib) = [0;1;0;0;0];
        %T(ib) = 2;
    else
        T(:,ib) = [0;0;0;0;1];
    end
end

for ib = 28:1:35;
    if STDA(ib)>10
        T(:,ib) = [0;0;1;0;0];
        %T(ib) = 3;
    else
        T(:,ib) = [0;0;0;0;1];
    end
end

for ib = 35:1:45;
    if STDA(ib)>15
        T(:,ib) = [0;0;0;1;0];
        %T(ib) = 4;
    else
        T(:,ib) = [0;0;0;0;1];
    end
end

for ib = 45:1:60;
    if STDA(ib)>18
        T(:,ib) = [1;0;0;0;0];
        %T(ib) = 1;
    else
        T(:,ib) = [0;0;0;0;1];
    end
end

for ib = 60:1:80;
    if STDA(ib)>20
        T(:,ib) = [0;1;0;0;0];
        %T(ib) = 2;
    else
        T(:,ib) = [0;0;0;0;1];
    end
end

for ib = 80:1:100;
    if STDA(ib)>20
        T(:,ib) = [0;0;1;0;0];
        %T(ib) = 3;
    else
        T(:,ib) = [0;0;0;0;1];
    end
end

for ib = 100:1:125;
    if STDA(ib)>20
        T(:,ib) = [0;0;0;1;0];
        %T(ib) = 4;
    else
        T(:,ib) = [0;0;0;0;1];
    end
end

for ib = 125:1:140;
    if STDA(ib)>20
        T(:,ib) = [1;0;0;0;0];
        %T(ib) = 1;
    else
        T(:,ib) = [0;0;0;0;1];
    end
end

for ib = 140:1:160;
    if STDA(ib)>20
        T(:,ib) = [0;1;0;0;0];
        %T(ib) = 2;
    else
        T(:,ib) = [0;0;0;0;1];
    end
end

for ib = 160:1:199;
    T(:,ib) = [0;0;0;0;1];
end

%%  NNS
inputs = FEAA;
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
testinputs= FEAB;
testoutputs = net(testinputs);

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
        
    end
end

[Ne,Ie]=max(errors);
Te = [];
for ti=1:1:199
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
for ip=1:1:199
   Tp(ip) = 1*T(1,ip)+2*T(2,ip)+3*T(3,ip)+4*T(4,ip)+0*T(5,ip); 
end

%% Plot
figure(5);
subplot(211);
plot(Tp,'-+b','linewidth',2);
% grid on;
title('目标量');
set(gca,'FontSize',20,'FontWeight','bold');
set(gca,'linewidth',2);
set(gca,'YTick',[0 1 2 3 4],'YTickLabel',{'{\fontname{Times New Roman}RT}','{\fontname{Times New Roman}WF}','{\fontname{Times New Roman}WE}','{\fontname{Times New Roman}FC}','{\fontname{Times New Roman}PS}'});
set(gca,'FontSize',20,'FontWeight','bold');
ylabel('手势');

subplot(212);
plot(Ta,'-*r','LineWidth',2);
% grid on;
title('输出量');
ylabel('手势');
set(gca,'FontSize',20,'FontWeight','bold');
set(gca,'linewidth',2);
set(gca,'YTick',[0 1 2 3 4],'YTickLabel',{'{\fontname{Times New Roman}RT}','{\fontname{Times New Roman}WF}','{\fontname{Times New Roman}WE}','{\fontname{Times New Roman}FC}','{\fontname{Times New Roman}PS}'});
set(gca,'FontSize',20,'FontWeight','bold');
