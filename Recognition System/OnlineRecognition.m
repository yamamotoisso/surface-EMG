close all;
clear all;
clc;
%% Online Recognition via trained nns
%delete(instrfindall)
%% Input
SerialName = 'COM4';
Time = input('Input the Time(>50)= ');
X = sprintf('it will be show %d times in one record.',Time/50);
disp(X);
OriginalSignal = serialread(SerialName,Time);
%% Parameter
MAVS = [];
VAR = [];
STD = []; 
RMS = []; 
MS = []; 
WAMP = [];
Result =[];
seed = 1;
%% Loop
for n=1:1:3;
%% SerialRead
OriginalSignal = serialread(SerialName,Time);
OriginalSignal(Time+1) = 0;
%% Feature Extracte
%fb = OriginalSignal;
fj = 1;
fb = [];
for i=1:50:Time;
    fb = OriginalSignal(i:i+50);
    MAVS(fj) = sum(diff(abs(fb)))/length(fb);
    VAR(fj) = var(fb);
    STD(fj) = std(fb);
    RMS(fj) = sqrt(sum(fb.^2)/length(fb));
    MS(fj) = sqrt(sum(fb.^2)/length(fb))/mean(fb);
    fc = abs(diff(fb));
    for fk =1:1:50;
        if fc(fk)>12;%threshold 
            fc(fk) = 1;
        else
            fc(fk) = 0;
        end 
    end
    WAMP(fj) = sum(fc);
    fj = fj+1;
end

%Best feature
FEA = [MAVS;STD;WAMP;RMS;MS;VAR];
%% NNS
load testnet.mat
testinputs= FEA;
testoutputs = net(testinputs);
%% Encoding
space = Time/50;
[N,I]=max(testoutputs);
Ta = [];
for ti=1:1:space;
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

%% Show
for ti =1:1:space;
    switch Ta(ti)
        case {1}
           picshow(1);
        case {2}
           picshow(2);
        case {3}
           picshow(3);
        case {4}
           picshow(4);
        case {0}
           picshow(0); 
    end
end
%%Record
step = space-1;
Result(seed:seed+step) = Ta;
seed =seed+space;
%the number of Result is n*space
end
disp(sprintf('We have %d results in totally.',length(Result)));
figure(3);
plot(Result,'-+b','linewidth',2);
grid on;
title('Rsult');
set(gca,'FontSize',20,'FontWeight','bold');
set(gca,'linewidth',2);
set(gca,'YTick',[0 1 2 3 4],'YTickLabel',{'{\fontname{Times New Roman}RT}','{\fontname{Times New Roman}WF}','{\fontname{Times New Roman}WE}','{\fontname{Times New Roman}FC}','{\fontname{Times New Roman}PS}'});
set(gca,'FontSize',20,'FontWeight','bold');
save('\\192.168.0.102\e\matlabdata\Result.mat','Result');
pause(10);
Result = [0,0,0];
save('\\192.168.0.102\e\matlabdata\Result.mat','Result');


% OriginalSignal = serialread(SerialName,Time);
% %% Parameter
% MAVS = [];
% VAR = [];
% STD = []; 
% RMS = []; 
% MS = []; 
% WAMP = [];
% Result =[];
% seed = 1;
% %% Loop
% for n=1:1:1;
% %% SerialRead
% OriginalSignal = serialread(SerialName,Time);
% OriginalSignal(Time+1) = 0;
% %% Feature Extracte
% %fb = OriginalSignal;
% fj = 1;
% fb = [];
% for i=1:50:Time;
%     fb = OriginalSignal(i:i+50);
%     MAVS(fj) = sum(diff(abs(fb)))/length(fb);
%     VAR(fj) = var(fb);
%     STD(fj) = std(fb);
%     RMS(fj) = sqrt(sum(fb.^2)/length(fb));
%     MS(fj) = sqrt(sum(fb.^2)/length(fb))/mean(fb);
%     fc = abs(diff(fb));
%     for fk =1:1:50;
%         if fc(fk)>12;%threshold 
%             fc(fk) = 1;
%         else
%             fc(fk) = 0;
%         end 
%     end
%     WAMP(fj) = sum(fc);
%     fj = fj+1;
% end
% 
% %Best feature
% FEA = [MAVS;STD;WAMP;RMS;MS;VAR];
% %% NNS
% load testnet.mat
% testinputs= FEA;
% testoutputs = net(testinputs);
% %% Encoding
% space = Time/50;
% [N,I]=max(testoutputs);
% Ta = [];
% for ti=1:1:space;
%     switch I(ti)
%         case {1}
%            Ta(ti) = 1;
%         case {2}
%            Ta(ti) = 2;
%         case {3}
%            Ta(ti) = 3;
%         case {4}
%            Ta(ti) = 4;
%         case {5}
%            Ta(ti) = 0;
%         
%     end
% end
% 
% %% Show
% for ti =1:1:space;
%     switch Ta(ti)
%         case {1}
%            picshow(1);
%         case {2}
%            picshow(2);
%         case {3}
%            picshow(3);
%         case {4}
%            picshow(4);
%         case {0}
%            picshow(0); 
%     end
% end
% %%Record
% step = space-1;
% Result(seed:seed+step) = Ta;
% seed =seed+space;
% %the number of Result is n*space
% end
% disp(sprintf('We have %d results in totally.',length(Result)));
% figure(3);
% plot(Result,'-+b','linewidth',2);
% grid on;
% title('Rsult');
% set(gca,'FontSize',20,'FontWeight','bold');
% set(gca,'linewidth',2);
% set(gca,'YTick',[0 1 2 3 4],'YTickLabel',{'RT','WF','WE','FC','PS'});
% set(gca,'FontSize',20,'FontWeight','bold');
% save('\\192.168.0.102\e\matlabdata\Result.mat','Result');
% pause(10);
% Result = [0,0,0];
% save('\\192.168.0.102\e\matlabdata\Result.mat','Result');
