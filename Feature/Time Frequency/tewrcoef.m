clc;
clear all;

load tesignal.mat;

[c,l] = wavedec(yl,3,'db3');
a3 = wrcoef('a',c,l,'db3',3);

figure(1);
subplot(211);
plot(yl);
title('raw signal');
subplot(212);
plot(a3);
title('wrcoef refactor');

wpt = wpdec(yl,3,'db2','shannon');
rex = wprec(wpt);
figure(2);
subplot(211);
plot(yl);
title('raw signal');
subplot(212);
plot(rex);
title('wprec refactor');

t = wpdec(yl,3,'db1','shannon');
rcfs = wprcoef(t,[2,1]);
figure(3);
subplot(211);
plot(yl);
title('raw signal');
subplot(212);
plot(rcfs);
title('wprcoef refactor');
