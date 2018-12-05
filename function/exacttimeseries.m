clear all;
clc;
%% Read original signal
a =load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');
%% Parameter
b = [];
GEO = [];%���ξ�ֵ
HAR = [];%���;�ֵ
TRI = [];%��β����ƽ��ֵ
RAG = [];%����
NOR = [];%ģ

MAD = [];%ƽ������ƫ��
KUR = [];%���
SKE = [];%ƫ��
MOM = [];%���ľ�
COV = [];%Э����
AUC = [];%����غ���
%% Calculate
j = 1;

for i=1:50:9950;
    b = a(i:i+50);
    GEO(j) = geomean(b);
    HAR(j) = harmmean(b);
    TRI(j) = trimmean(b,10);
    RAG(j) = range(b);
    NOR(j) = norm(b);
    
    MAD(j) = mad(b);
    KUR(j) = kurtosis(b);
    SKE(j) = skewness(b);
    COV(j) = cov(b);
    
    j = j+1;
    
end


%% Plot Figure
figure(1);
subplot(311);
plot(GEO);
hold on;
plot(MAD);
hold on;
plot(RAG);
grid on;
legend('GEO','MAD','RAG');
subplot(312);
plot(KUR);
hold on;
plot(SKE);
grid on;
legend('KUR','SKE');
subplot(313);
plot(COV);
grid on;
legend('COV');
%% Correlation Coefficient
con1 = corrcoef(GEO,HAR);
con2 = corrcoef(GEO,TRI);
con3 = corrcoef(GEO,NOR);

CON=[con1;con2;con3];