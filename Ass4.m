x=audioread("fivewo.wav");
fs=length(x);
fc=240;
f_l=90;
f_h=5760;
n_bands=1;
i=1;
while(n_bands<=16)
	x_f=bands(x,f_l,f_h,n_bands, fs, fc);
	subplot(5,1,i)
	plot(x_f)
	n_bands=n_bands*2;
	i=i+1;
end
function [x_f] = bandgen(x,f_l, f_h, fs,fc)
h1f=butter(10, [f_l f_h]/(fs/2));
b1=conv(x,h1f);
b1=b1(1:fs);
b1_h=hilbert(b1);
noise=wgn(fs, 1,1);
noise_1=conv(noise, h1f);
noise_1=noise(1:fs);
lpf=butter(10, fc/(fs/2));
x_f0=conv(b1_h, lpf);
x_f0=x_f0(1:fs);
x_f=abs(x_f0.*noise_1);
end
function [x_f]= bands(x,f_l, f_h, n_bands,fs,fc)
r=(f_h/f_l)^(1/n_bands);
f_l_new=f_l; f_h_new=f_l*r;
x_f=zeros(fs,1);
while (f_h_new<=f_h)
	x_f=x_f+bandgen(x,f_l_new, f_h_new,fs,fc);
	f_l_new=f_h_new;
	f_h_new=f_h_new*r;
end
end
