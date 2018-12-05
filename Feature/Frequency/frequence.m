% clear all;
% close all;
% clc;

% x = load('D:\matlab\bin\workspace\postgraduate\sigdatabase\testdata3.txt');
y = load('arduino.mat');
x = y.Data;
fs = 9600;
N = length(x);
n = 0:N-1;
t = n/fs;
y = fft(x,N);
mag = abs(y);
f = (0:N-1)*fs/N;

plot(f(1:N/2),mag(1:N/2)*2/N);
xlabel('ÆµÂÊ/Hz');
ylabel('Õñ·ù');
xlim([0 200]);
ylim([0 20]);
