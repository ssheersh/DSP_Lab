clc
clear all


N=512; %Number of points
k=(N-1)/2;
f_c=1/12;
w_c=2*pi*f_c;% angular frequency between -\pi to \pi 
w_i= pi/10;% inside the passband
w_o=pi/3;% outside the pass_banned

W_r=zeros(N,1);
W_t=zeros(N,1);
W_hn=zeros(N,1);
W_hm=zeros(N,1);
W_b=zeros(N,1);
Y=zeros(N,1);


for i=1:1:N-1
   W_r(i)=Rect(i,N);
   W_t(i)=Triangular(i,N);
   W_hn(i)=Hanning(i,N);
   W_hm(i)=Hamming(i,N);
   W_b(i)=Blackman(i,N);
   Y(i)=h_d(i, N, w_c);
end


h_r=W_r.*Y;
h_t=W_t.*Y;
h_hn=W_hn.*Y;
h_hm=W_hm.*Y;
h_b=W_b.*Y;
x=linspace(-pi,pi,1024);

%freqz(h_r,1,x);
%freqz(h_t,1,x);
%freqz(h_hn,1,x);
freqz(h_hm,1,x);
%freqz(h_b,1,x);


function w = Rect(n, N) % Rectangular window
    if n<N
        w=1;
    else
        w=0;
    end
end
function w = Triangular(n, N) % Triangular window
    if n<N
        w = 1 - 2 * (n - (N - 1) / 2) / (N - 1);
    else
        w=0;
    end
end
function w = Hanning(n, N) % Hanning window
    if n < N
        w = 0.5 - 0.5 * cos(2 * pi * n / (N - 1));
    else 
        w = 0;
    end
end
function w = Hamming(n, N) %Hamming window
    if n < N
        w = 0.54 - 0.46 * cos(2 * pi * n / (N - 1));
    else 
        w = 0;
    end
end
function w = Blackman(n, N) % Blackmann window
    if n < N
        w = 0.42 - 0.5*cos(2*pi*n/(N-1))+0.08*cos(4*pi*n/(N-1))
    else
        w=0
    end
end

function y= h_d(n,N,w_c) % Time domain of the ideal LPF
    k=(N-1)/2;
    if n==k
        y= 0
    else
        y=(sin(w_c*(n-k)))/(pi*(n-k));
    end
end