close all;
clear all;
clc;
%% Offline Recongnition
%delete(instrfindall)
%% Input
SerialName = 'COM4';
Time = input('Input the Time(>50)= ');
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
