clear all;
close all;
clc;
[x,fs] = audioread('fivewo.wav');
t=[];
for i=1:size(x)
    t(i)=i;
end
N=16;
r = 64^(1/N);
subplot(N+3,1,1);
plot(t,x);
n = 1024;
k=fft(x,n);
k = fftshift(k);
f=linspace(-fs/2,fs/2,n);
subplot(N+3,1,2);
plot(f,abs(k));
sum = 0;
for i = 1:N
    sig = filterBank(x,90*(r^(i-1))+1, 90*(r^i), fs);
    [c,d]=butter(2,240/fs,"low");
    sig=filter(c,d,abs(sig));
    subplot(N+3,1,i+2);
    plot(t,sig);
    product=white(sig,90*(r^(i-1)),90*(r^i),fs);
    sum=sum+product;
end
%sum=sum*100;
subplot(N+3,1,N+3);
plot(t,sum);
sound(100,fs);
audiowrite('output.wav', sum, fs);
function [product] = white(sig, fc1, fc2,fs)
wn=1*wgn(156250,1,1);
wn=filterBank(wn,fc1,fc2,fs);
wn=real(wn);

product=wn.*sig;
end
function[y] = filterBank(x, fc1, fc2, fs)
order = 3;
wc = [fc1 fc2]/(fs/2);
[b,a]=butter(order, wc, "bandpass"); % Bandpass digital filter design
y = filter(b,a,x);
y = hilbert(y);
end
