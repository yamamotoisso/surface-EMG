clear all;
clc;
%% Read original signal
a =load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');
STD = [];
b = [];
%% Calculate
j = 1;
for i=1:50:9950;
    b = a(i:i+50);
    STD(j) = std(b);                     
    j = j+1;   
end
%% Encode
T = [];
jb =1;
T(:,1) = [0;0;0;0;0;0];
for ib = 2:1:20;
    if STD(ib)>18
        T(:,ib) = [1;0;0;0;0;0];
        %T(ib) = 1;
    else
        T(:,ib) = [0;0;0;0;0;0];
    end
end

for ib = 20:1:28;
    if STD(ib)>10
        T(:,ib) = [0;1;0;0;0;0];
        %T(ib) = 2;
    else
        T(:,ib) = [0;0;0;0;0;0];
    end
end

for ib = 28:1:35;
    if STD(ib)>10
        T(:,ib) = [0;0;1;0;0;0];
        %T(ib) = 3;
    else
        T(:,ib) = [0;0;0;0;0;0];
    end
end

for ib = 35:1:45;
    if STD(ib)>15
        T(:,ib) = [0;0;0;1;0;0];
        %T(ib) = 4;
    else
        T(:,ib) = [0;0;0;0;0;0];
    end
end

for ib = 45:1:60;
    if STD(ib)>18
        T(:,ib) = [1;0;0;0;0;0];
        %T(ib) = 1;
    else
        T(:,ib) = [0;0;0;0;0;0];
    end
end

for ib = 60:1:80;
    if STD(ib)>20
        T(:,ib) = [0;1;0;0;0;0];
        %T(ib) = 2;
    else
        T(:,ib) = [0;0;0;0;0;0];
    end
end

for ib = 80:1:100;
    if STD(ib)>20
        T(:,ib) = [0;0;1;0;0;0];
        %T(ib) = 3;
    else
        T(:,ib) = [0;0;0;0;0;0];
    end
end

for ib = 100:1:125;
    if STD(ib)>20
        T(:,ib) = [0;0;0;1;0;0];
        %T(ib) = 4;
    else
        T(:,ib) = [0;0;0;0;0;0];
    end
end

for ib = 125:1:140;
    if STD(ib)>20
        T(:,ib) = [1;0;0;0;0;0];
        %T(ib) = 1;
    else
        T(:,ib) = [0;0;0;0;0;0];
    end
end

for ib = 140:1:160;
    if STD(ib)>20
        T(:,ib) = [0;1;0;0;0;0];
        %T(ib) = 2;
    else
        T(:,ib) = [0;0;0;0;0;0];
    end
end

for ib = 160:1:199;
    T(:,ib) = [0;0;0;0;0;0];
end

%% Codeplot
Tp = [];
ip =1;
for ip=1:1:199
   Tp(ip) = 1*T(1,ip)+2*T(2,ip)+3*T(3,ip)+4*T(4,ip)+5*T(5,ip)+6*T(6,ip); 
end

%% Plot
figure(1);
subplot(211);
plot(STD,'linewidth',3);
title('STD');
grid on;
hold on;
subplot(212);
plot(Tp,'linewidth',3);
grid on;
title('Target');

