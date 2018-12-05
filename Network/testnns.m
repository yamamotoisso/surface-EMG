close all
clear all
clc
load 'data1.mat';
inputs = FEA;
targets = T;
% 创建一个模式识别网络（两层BP网络），同时给出中间层神经元的个数，这里使用20
hiddenLayerSize =13;
net = patternnet(hiddenLayerSize);

% 对数据进行预处理，这里使用了归一化函数（一般不用修改）
% For a list of all processing functions type: help nnprocess
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};

% 把训练数据分成三部分，训练网络、验证网络、测试网络
% For a list of all data division functions type: help nndivide
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% 训练函数
% For a list of all training functions type: help nntrain
net.trainFcn = 'trainlm';  % Levenberg-Marquardt

% 使用均方误差来评估网络
% For a list of all performance functions type: help nnperformance
net.performFcn = 'mse';  % Mean squared error

% 画图函数
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};


% 开始训练网络（包含了训练和验证的过程）
[net,tr] = train(net,inputs,targets);

% 测试网络
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs)

% 获得训练、验证和测试的结果
trainTargets = targets .* tr.trainMask{1};
valTargets = targets  .* tr.valMask{1};
testTargets = targets  .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,outputs)
valPerformance = perform(net,valTargets,outputs)
testPerformance = perform(net,testTargets,outputs)

% 可以查看网络的各个参数
view(net)

% 根据画图的结果，决定是否满意
% Uncomment these lines to enable various plots.
figure, plotperform(tr)
figure, plottrainstate(tr)
figure, plotconfusion(targets,outputs)
figure, ploterrhist(errors)
% Test the Network
testinputs= FEA;
testoutputs = net(testinputs);



