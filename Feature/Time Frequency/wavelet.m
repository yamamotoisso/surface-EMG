clc;
clear all;

load tesignal.mat;
 
figure(1);

% subplot(6,1,1);
% plot(yl);
% % title('Low');
% ylabel('Signal');
% axis tight;
% box off;
% set(gca,'FontSize',20,'Fontname','Times New Roman');
[C,L] = wavedec(yl,5,'bior3.7');
for i =1:5
    a = wrcoef('d',C,L,'bior3.7',6-i);
    subplot(5,1,i);
    plot(a,'b','LineWidth',2);
    axis tight;
    ylabel(['a',num2str(6-i)]);
    box off;
    set(gca,'FontSize',20,'Fontname','Times New Roman');
end


figure(2);

% subplot(6,1,1);
% plot(yl);
% % title('High');
% ylabel('Signal');
% axis tight;
% box off;
% set(gca,'FontSize',20,'Fontname','Times New Roman');
% [C,L] = wavedec(yl,5,'db3');
for i =1:5
    d = wrcoef('d',C,L,'bior3.7',6-i);
    subplot(5,1,i);
    plot(d,'r','LineWidth',2);
    axis tight;
    ylabel(['d',num2str(6-i)]);
    box off;
    set(gca,'FontSize',20,'Fontname','Times New Roman');
end
