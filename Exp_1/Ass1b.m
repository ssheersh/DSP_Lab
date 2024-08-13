subplot(311);
Fourier_1(12e3, 64);
subplot(312);
Fourier_1(12e3, 128);
subplot(313)
Fourier_1(12e3, 256);

% subplot(334);
% Fourier_1(5e3, 64);
% subplot(335);
% Fourier_1(5e3, 128);
% subplot(336);
% Fourier_1(5e3, 256);
% 
% subplot(337);
% Fourier_1(4e3, 64);
% subplot(338);
% Fourier_1(4e3, 128);
% subplot(339)
% Fourier_1(4e3, 256);

saveas(gcf,'Ass1a.png')

function [lmao] = Fourier_1(fs, N)
    T = 1/fs;
    t= (0:N-1)*T;
    x = 10*cos(2*pi*1e3*t) + 6*cos(2*pi*2e3*t) + 2*cos(2*pi*4e3*t);
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

