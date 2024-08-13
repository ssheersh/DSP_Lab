clc
clear all
N=64;
Fs1=12e3; Fs2=24e3;
T1=1/Fs1; T2=2/Fs2;
t=linspace(0,100*T1,N);
t2=linspace(0,100*T1,2*N);
x=0.5*sin(2*pi*6e3*t)+3*cos(2*pi*5.9e3*t)+1.5*sin(2*pi*4e3*t)+2.5*cos(2*pi*2e3*t);
x2=0.5*sin(2*pi*6e3*t2)+3*cos(2*pi*5.9e3*t2)+1.5*sin(2*pi*4e3*t2)+2.5*cos(2*pi*2e3*t2);
x1=upsample(x,2);
%  subplot(311);
%  plot(t,x);
%  hold on
%  xlabel('Time', 'Interpreter','latex')
%  ylabel( 'Amplitude', 'Interpreter','latex')
%  tstring = sprintf('Original signal sampled at $F_s$=%d',Fs1)
%  title(tstring, 'Interpreter','latex')
%  hold off
% subplot(312);
% plot(t2,x2);
% hold on
% xlabel('Time', 'Interpreter','latex')
% ylabel( 'Amplitude', 'Interpreter','latex')
% tstring = sprintf('Original signal sampled at $F_s$=%d',Fs2)
% title(tstring, 'Interpreter','latex')
% hold off
 t1=(0:2*N-1)*T1;
f_c=6e3
f_cn=f_c/Fs1
[b , a]=butter(8,f_cn,"low")
x_f=filter(b,a,x1)
%subplot(313)
% plot(t2,x_f)
% hold on
% xlabel('Time', 'Interpreter','latex')
% ylabel( 'Amplitude', 'Interpreter','latex')
% tstring = sprintf('Upsampled signal filtered through Butterwoth filter with cutoff $F_H$=%d',f_c)
% title(tstring, 'Interpreter','latex')
% hold off
subplot(311);
Fourier_1(x,12e3,64)
subplot(312);
Fourier_1(x1,24e3,128)
subplot(313)
Fourier_1(x_f,12e3,128)
%saveas(gcf, 'Ass1db.png')

function [lmao] = Fourier_1(x,fs, N)
    y=fft(x);
    stem(fs/N*(-N/2:N/2-1), abs(fftshift(y)), "LineWidth",1)
    hold on 
    xlabel('Frequency (kHz)', 'Interpreter','latex')
    ylabel( 'Power', 'Interpreter','latex')
    tstring = sprintf('DFT at $F_s$=%d, N=%d points',fs, N)
    title(tstring, 'Interpreter','latex')
    hold off 
    lmao = 1;
end
