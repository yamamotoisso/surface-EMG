function [y] = Singalplot(x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
y = load(x);
plot(y,'linewidth',2);
% grid on;
set(gca,'FontSize',20,'FontWeight','bold','Fontname','Times New Roman');
set(gca,'linewidth',1);
xlabel('{\fontname{STSong}采样点}');
ylabel('{\fontname{STSong}幅值}');
box off;
end

