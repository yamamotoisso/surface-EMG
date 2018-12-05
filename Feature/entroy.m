clear all;
clc;
%% Read original signal
a =load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');
%% Parameter
b = [];
c = [];
d = [];
IAV = []; %绝对值积分
MAV = []; %平均绝对值
MAVS = []; %平均绝对值斜率
WL = []; %波形长度
PV = []; %峰值
MV = []; %均值(本例中相当于移动平均值)
VAR = []; %方差
STD = []; %均方差
RMS = []; %均方根值
MS = []; %波形因子
WAMP = [];%Willison幅值
KUR = [];%峰度
SKE = [];%偏度

%% Calculate
j = 1;

for i=1:50:9950;
    b = a(i:i+50);
    IAV(j) = sum(abs(b));
    MAV(j) = sum(abs(b))/length(b);
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
e1 = entropy(IAV);
e2 = entropy(MAV);
e3 = entropy(MAVS);
e4 = entropy(WL);
e5 = entropy(PV);
e6 = entropy(MV);
e7 = entropy(VAR);
e8 = entropy(STD);
e9 = entropy(RMS);
e10 = entropy(MS);
e11 = entropy(WAMP);
E = [e1;e2;e3;e4;e5;e6;e7;e8;e9;e10;e11];
sample = 200;
y1 = yyshang(IAV,sample);
y2 = yyshang(MAV,sample);
y3 = yyshang(MAVS,sample);
y4 = yyshang(WL,sample);
y5 = yyshang(PV,sample);
y6 = yyshang(MV,sample);
y7 = yyshang(VAR,sample);
y8 = yyshang(STD,sample);
y9 = yyshang(RMS,sample);
y10 = yyshang(MS,sample);
y11 = yyshang(WAMP,sample);
Y = [y1;y2;y3;y4;y5;y6;y7;y8;y9;y10;y11];

