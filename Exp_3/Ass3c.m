L=100;
n=5000;
B=7*10^-3;
T=1:n;
w_c_l=[ 697, 770, 852, 941];
w_c_h=[1209, 1336, 1477, 1633];
y_l=[zeros(n,1), zeros(n,1), zeros(n,1), zeros(n,1)];
y_h=[zeros(n,1), zeros(n,1), zeros(n,1), zeros(n,1)];
MP = ['1', '2', '3', 'A'; '4', '5', '6', 'B'; '7', '8', '9', 'C'; '*' , '0','#', 'D'];
W=linspace(-pi,pi,300);
x_f=zeros(n,1);
A=linspace(0,10,20);
sigma=linspace(0.1, 10,10);
matrix=zeros(length(A),length(sigma));
for j=1:length(w_c_h)
    for i=1:n
        y_h(i,j)=h(1,w_c_h(j),i,L);
    end
    y_h(i)=y_h(i)/max(y_h(i));
end
for j=1:length(w_c_l)
    for i=1:n
        y_l(i,j)=h(1,w_c_l(j),i,L);
    end
    y_l(i)=y_l(i)/max(y_l(i));
end
for i=1:4
    for j=1:4
        for I_A=1:length(A)
            for I_S=1:length(sigma)
                x_f=sin(w_c_l(i)*T)+sin(w_c_h(j)*T)+A(I_A)*(sin(w_c_l(i)*T)+sin(w_c_h(j)*T)).^2+normrnd(0,sigma(I_S));
                j_a=xfreq(x_f,w_c_l,y_l,n);
                j_b=yfreq(x_f,w_c_h,y_h,n);
                if(j_a==i & j_b==j)
                    matrix(I_A,I_S)=matrix(I_A,I_S)+1;
                end
            end
        end
    end
end
disp("Result")
heatmap(matrix./16)
xlabel("a, where the coefficient of quadratic non-linear term varies from -a to +a");
ylabel("sigma, where sigma^2 is the variance of random noise")

function [y] = h(B,w_c, n, L)
if n<L
    y = B*cos(w_c*n);
else
    y=0;
end
end

function [Y] = pl(y)
Y=abs(fftshift(fft(y)));
plot(1:length,Y)
hold on
tstring = sprintf('Convolution with filter at');
title(tstring, 'Interpreter','latex')
hold off
end
function [T] = stop(t)
T=randi([t+200, t+300]);
end
function [j_a]= xfreq(s,w_c_l, y_l,n)
mx_a=0;
for j=1:length(w_c_l)
    r=conv(s, y_l(1:n,j));
    r(isnan(r))=0;
    R=abs(fftshift(fft(r)));
    R(isnan(R))=0;
    if max(R)>mx_a
        mx_a=max(R); j_a=j;
    end
end
end
function [j_b]=yfreq(s,w_c_h,y_h,n)
mx_b=0;
for j=1:length(w_c_h)
    r=conv(s, y_h(1:n,j));
    r(isnan(r))=0;
    R=abs(fftshift(fft(r)));
    R(isnan(R))=0;
    if max(R)>mx_b
        mx_b=max(R); j_b=j;
    end
end
end
