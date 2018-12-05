clc;
clear all;

x=load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');
A=[];
D=[];

figure(1);
plot(x,'LineWidth',2);
set(gca,'FontSize',20,'Fontname','Times New Roman');

%% Feature
figure(2);
[C,L] = wavedec(x,5,'bior3.7');

for i =1:5
    a = wrcoef('d',C,L,'bior3.7',6-i);
    subplot(5,1,i);
    plot(a,'b','LineWidth',2);
    axis tight;
    ylabel(['a',num2str(6-i)]);
    box off;
    set(gca,'FontSize',20,'Fontname','Times New Roman');
    A(:,i)=a;
end
figure(3);
for i =1:5
    d = wrcoef('d',C,L,'bior3.7',6-i);
    subplot(5,1,i);
    plot(d,'r','LineWidth',2);
    axis tight;
    ylabel(['d',num2str(6-i)]);
    box off;
    set(gca,'FontSize',20,'Fontname','Times New Roman');
    D(:,i)=d;
end

%% Encoding
T = [];
zero =[0;0;0;0;1];
class1 =[1;0;0;0;0];
class2 =[0;1;0;0;0];
class3 =[0;0;1;0;0];
class4 =[0;0;0;1;0];
for j=1:10000;
    T(j,:)=zero;
end
for k=553:600;
    T(j,:)=class1;
end
for k=1047:1085;
    T(j,:)=class2;
end
for k=1422:1500;
    T(j,:)=class3;
end
for k=1899:1949;
    T(j,:)=class4;
end
for k=2700:2767;
    T(j,:)=class1;
end
for k=3470:3544;
    T(j,:)=class2;
end
for k=4570:4622;
    T(j,:)=class3;
end
for k=5898:5968;
    T(j,:)=class4;
end
for k=6777:6812;
    T(j,:)=class1;
end
for k=7823:7872;
    T(j,:)=class2;
end

A1=A(1:2000,:);
T1=T(1:2000,:);
%% NNS
inputs = A1;
targets = T1;

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

% Test the Network
testinputs= A1;
testoutputs = net(testinputs);

