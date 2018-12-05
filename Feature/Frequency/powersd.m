function [ ppx ] = powersd( data,fs )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

nfft = length(data);
xc = xcorr(data,'unbiased');
xk = fft(xc,nfft);
pxx = abs(xk);
index = 0:round(nfft/2-1);
k = index*fs/nfft;
ppx = 10*log(pxx(index+1));
% n = 0:1/fs:1;
% L = length(data);
% xc = xcorr(data,'unbiased');
% xk = fft(xc,L);
% pxx = abs(xk);
% ppx = 10*log(pxx);
end

