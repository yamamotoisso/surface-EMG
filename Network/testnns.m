close all
clear all
clc
load 'data1.mat';
inputs = FEA;
targets = T;
% ����һ��ģʽʶ�����磨����BP���磩��ͬʱ�����м����Ԫ�ĸ���������ʹ��20
hiddenLayerSize =13;
net = patternnet(hiddenLayerSize);

% �����ݽ���Ԥ��������ʹ���˹�һ��������һ�㲻���޸ģ�
% For a list of all processing functions type: help nnprocess
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};

% ��ѵ�����ݷֳ������֣�ѵ�����硢��֤���硢��������
% For a list of all data division functions type: help nndivide
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% ѵ������
% For a list of all training functions type: help nntrain
net.trainFcn = 'trainlm';  % Levenberg-Marquardt

% ʹ�þ����������������
% For a list of all performance functions type: help nnperformance
net.performFcn = 'mse';  % Mean squared error

% ��ͼ����
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};


% ��ʼѵ�����磨������ѵ������֤�Ĺ��̣�
[net,tr] = train(net,inputs,targets);

% ��������
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs)

% ���ѵ������֤�Ͳ��ԵĽ��
trainTargets = targets .* tr.trainMask{1};
valTargets = targets  .* tr.valMask{1};
testTargets = targets  .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,outputs)
valPerformance = perform(net,valTargets,outputs)
testPerformance = perform(net,testTargets,outputs)

% ���Բ鿴����ĸ�������
view(net)

% ���ݻ�ͼ�Ľ���������Ƿ�����
% Uncomment these lines to enable various plots.
figure, plotperform(tr)
figure, plottrainstate(tr)
figure, plotconfusion(targets,outputs)
figure, ploterrhist(errors)
% Test the Network
testinputs= FEA;
testoutputs = net(testinputs);



