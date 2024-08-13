clc
clear all

Fourier_1(20e3, 256)
saveas(gcf,'Ass1c.png')
function [lmao] = Fourier_1(fs, N)
    T = 1/fs;
    t= (0:N - 1)*T;
    fw = 1e3;
    x = 0.5 * (sign(sin(2 * pi * fw * t)) + 1)
    subplot(211)
    plot(t,x)
    hold on 
    xlabel('Time(s)', 'Interpreter','latex')
    ylabel( 'Amplitude', 'Interpreter','latex')
    ylim([0, 2])
    tstring = sprintf('Original signal sampled at $F_s$=%d',fs)
    title(tstring, 'Interpreter','latex')
    hold off 
    y=fft(x);
    subplot(212);
    plot(fs/N*(-N/2:N/2-1), abs(fftshift(y)), "LineWidth",1)
    hold on 
    xlabel('Frequency (kHz)', 'Interpreter','latex')
    ylabel( 'Power', 'Interpreter','latex')
    tstring = sprintf('DFT at $F_s$=%d, N=%d points',fs, N)
    title(tstring, 'Interpreter','latex')
    hold off 
    lmao = 1;
end


