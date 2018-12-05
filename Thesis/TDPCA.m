clc;
clear all;
close all;

%% Load signal
OriginalSignal =load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');

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
for i=1:50:9950;
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

TDfeature = [IAV;MAV;MAVS;WL;MV;VAR;STD;RMS;WAMP;PV;MS];
Rfeature = [WL;PV;IAV;MAV;MV;RMS;WAMP];
% [coeff,score,latent] = princomp(TDfeature');
[coeff,score,latent] = princomp(zscore(TDfeature'));
PCA = score(:,1:5)';%PCA = (zscore(TDfeature')*coeff(:,1:5))';
% PCA = [MAVS;STD;MS;VAR;score(:,1)'];
FEA = [MAVS;STD;WL;MS;VAR];%Best feature
HUTD = [MAV;MAVS;WL;RMS;IAV];%hudgins TD feature

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

for ib = 160:1:199;
    T(:,ib) = zero;
end

%% Codeplot
Tp = [];
ip =1;
for ip=1:1:199
   Tp(ip) = 1*T(1,ip)+2*T(2,ip)+3*T(3,ip)+4*T(4,ip)+0*T(5,ip); 
end

%% PCA
figure(1);
categories = {' ','MAV(IAV, MV)','MAVS','WL',' ','VAR','STD','RMS','WAMP','PV','MS'};
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',categories,'LineWidth',2,'MarkerSize',30,'MarkerFaceColor','r');
set(gca,'FontSize',25,'FontWeight','bold','Fontname','Times New Roman');
box off;
axis([-0.1 0.61 -0.3 0.6]);
grid off;

figure(2);
percent_explained= 100*latent/sum(latent); %cumsum(latent)./sum(latent)
% pareto(percent_explained);
bar(percent_explained,0.5);
colormap([0 0.4 0.9]);
xlabel('{\fontname{STSong}主成分}');
ylabel('{\fontname{STSong}贡献率}{\fontname{Times New Roman}(%)}');
% xlabel('PrincipalComponent');
% ylabel('VarianceExplained (%)');
xlim([0.6,11.3]);
ylim([0,105]);
percent_explained = 10*percent_explained/10;
for i =1:length(percent_explained)
%    text(i-0.30,percent_explained(i)+1.5,num2str(percent_explained(i)),'Fontsize',20,'Fontname','Times New Roman');
     percent_total(i) = sum(percent_explained(1:i,:));
     text(i-0.20,percent_total(i)+3.2,num2str(percent_total(i)),'Fontsize',30,'FontWeight','bold','Fontname','Times New Roman');
   
end
hold on;
plot(percent_total,'-+r','lineWidth',2.5);
set(gca,'FontSize',35,'FontWeight','bold','Fontname','Times New Roman');
set(gca,'linewidth',1);
box off;

figure(3);
speciesNum = grp2idx(Tp');
[H,AX,BigAx] = gplotmatrix(score(:,1:5),[],speciesNum,['r','g','b','c','m'],['x','+','o','s','d'],8,'off');
size = 20;
legend(AX(20+5),{'RT','WF','WE','FC','PS'},'Location','northwest','Orientation','horizontal','FontWeight','Bold','Fontname','Times New Roman','Fontsize',size-5);
xlabel(AX(5),{'{\fontname{STSong}主成分}{\fontname{Times New Roman}1}'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
xlabel(AX(10+1),{'{\fontname{STSong}主成分}{\fontname{Times New Roman}2}'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
xlabel(AX(15+2),{'{\fontname{STSong}主成分}{\fontname{Times New Roman}3}'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
xlabel(AX(20+3),{'{\fontname{STSong}主成分}{\fontname{Times New Roman}4}'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
xlabel(AX(25+4),{'{\fontname{STSong}主成分}{\fontname{Times New Roman}5}'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
ylabel(AX(1),{'{\fontname{STSong}主成分}{\fontname{Times New Roman}1}'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
ylabel(AX(2),{'{\fontname{STSong}主成分}{\fontname{Times New Roman}2}'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
ylabel(AX(3),{'{\fontname{STSong}主成分}{\fontname{Times New Roman}3}'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
ylabel(AX(4),{'{\fontname{STSong}主成分}{\fontname{Times New Roman}4}'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
ylabel(AX(5),{'{\fontname{STSong}主成分}{\fontname{Times New Roman}5}'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
set(AX,'LineWidth',1.5);

% xlabel(AX(5),{'Component 1'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
% xlabel(AX(10+1),{'Component 2'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
% xlabel(AX(15+2),{'Component 3'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
% xlabel(AX(20+3),{'Component 4'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
% xlabel(AX(25+4),{'Component 5'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
% ylabel(AX(1),{'Component 1'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
% ylabel(AX(2),{'Component 2'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
% ylabel(AX(3),{'Component 3'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
% ylabel(AX(4),{'Component 4'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
% ylabel(AX(5),{'Component 5'},'FontWeight','Bold','Fontname','Times New Roman','Fontsize',size);
set(AX,'LineWidth',1.5);
