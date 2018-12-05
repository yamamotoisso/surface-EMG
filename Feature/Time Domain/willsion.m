clear all;
clc;
%% Read original signal
a =load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');
%% Parameter
b = [];
da = [];
db = [];
dc = [];
dd = [];
WAMPa = [];%Willison幅值
WAMPb = [];
WAMPc = [];
WAMPd = [];
%% Calculate
j = 1;

for i=1:50:9950;
    b = a(i:i+50);
    da = abs(diff(b));
    for ka =1:1:50
     if da(ka)>3;%threshold 
        da(ka) = 1;
     else
        da(ka) = 0;
        end 
    end
    
    WAMPa(j) = sum(da);
    
    db = abs(diff(b));
    for kb =1:1:50
     if db(kb)>6;%threshold 
        db(kb) = 1; 
     else
        db(kb) = 0;
        end 
    end
    
    WAMPb(j) = sum(db);
    
    dc = abs(diff(b));
    for kc =1:1:50
     if dc(kc)>12;%threshold 
        dc(kc) = 1;
     else
        dc(kc) = 0;
        end 
    end
    
    WAMPc(j) = sum(dc);
    
    dd = abs(diff(b));
    for kd =1:1:50
     if dd(kd)>21;%threshold 
        dd(kd) = 1;
     else
        dd(kd) = 0;
        end 
    end
    
    WAMPd(j) = sum(dd);
    j = j+1;
    
end

%% Plot figure
figure(1);
plot(WAMPa,'--xk','LineWidth',2);
hold on;
plot(WAMPb,'-.sb','LineWidth',2);
hold on;
plot(WAMPc,'-r','LineWidth',1);
hold on;
plot(WAMPd,':^m','LineWidth',2);
% grid on;
% title('不同阈值Willison幅值比较');
set(gca,'linewidth',1);
ylim([-inf inf]);
xlim([-inf 200]);
legend('{\fontname{STSong}阈值为}{\fontname{Times New Roman}3}','{\fontname{STSong}阈值为}{\fontname{Times New Roman}6}','{\fontname{STSong}阈值为}{\fontname{Times New Roman}12}','{\fontname{STSong}阈值为}{\fontname{Times New Roman}21}');
xlabel('{\fontname{STSong}时间窗个数}');
set(gca,'FontSize',20,'Fontname','Times New Roman');
box off;
% ylabel('{\fontname{STSong}幅值}');

