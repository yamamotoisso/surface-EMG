clear all;
clc;
%% Read original signal
a =load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata6.txt');
%% Parameter
b = [];
c = [];
d = [];
IAV = []; %����ֵ����
MAV = []; %ƽ������ֵ
MAVS = []; %ƽ������ֵб��
WL = []; %���γ���
PV = []; %��ֵ
MV = []; %��ֵ(�������൱���ƶ�ƽ��ֵ)
VAR = []; %����
STD = []; %������
RMS = []; %������ֵ
MS = []; %��������
WAMP = [];%Willison��ֵ
KUR = [];%���
SKE = [];%ƫ��

%% Calculate
j = 1;

for i=1:50:9950;
    b = a(i:i+50);
    IAV(j) = sum(abs(b));
    MAV(j) = sum(abs(b))/length(b);%iemg
    MAVS(j) = sum(diff(abs(b)))/length(b);
    WL(j) = sum(abs(diff(b)));
    c = sort(b,'descend');
    PV(j) = sum(c(1:10))/10;
    MV(j) = mean(b);
    VAR(j) = var(b);
    STD(j) = std(b);
    RMS(j) = sqrt(sum(b.^2)/length(b));
    MS(j) = sqrt(sum(b.^2)/length(b))/mean(b);
    KUR(j) = kurtosis(b);
    SKE(j) = skewness(b);
    d = abs(diff(b));
    for k =1:1:50
     if d(k)>12;%threshold 
        d(k) = 1;
     else
        d(k) = 0;
        end 
    end

    WAMP(j) = sum(d);
    j = j+1;
    
end
%% Feature
TDfeature = [IAV;MAV;MAVS;WL;MV;VAR;STD;RMS;WAMP;PV;MS];
[coeff,score,latent] = princomp(zscore(TDfeature'));
PCA6 = score(:,1:5)';%PCA = (zscore(TDfeature')*coeff(:,1:5))';
FEA6 = [MAVS;STD;WL;MS;VAR];%Best feature
HUTD6 = [MAV;MAVS;WL;RMS;IAV];%hudgins TD feature