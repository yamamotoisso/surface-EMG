clear all;
clc;

a = load ('testarduino.txt');
Ld = fda;
yl = filter(Ld,a);
% for i=1:1:1000
%    if abs(yl(i))>10
%        yl(i)=10*yl(i);
%    else
%        yl(i)=yl(i);
%    end
% end

%% Feature
iemg = []; %积分肌电值
psd = []; %功率谱密度
mpf = []; %中值频率
mdf = []; %均值频率
ent = []; %谱熵
cep = []; %倒谱系数
fs = 9600;
N1 =1;
pp1 = 0;
i = 1;
for j=1:50:950;
    yb = yl(j:j+50);
    L = length(yb);
    iemg(i) = sum(abs(yb))/L; 
    [psd(:,i),mdf(i),mpf(i)] = PDP(yb,fs);
    
    ent(i) = entropy(yb);
    cep(:,i) = rceps(yb);

    i = i + 1;
end