L=100;
n=1000;
B=7*10^-3;
T=1:n;
w_c_l=[ 697, 770, 852, 941];
w_c_h=[1209, 1336, 1477, 1633];
y_l=[zeros(n,1), zeros(n,1), zeros(n,1), zeros(n,1)];
y_h=[zeros(n,1), zeros(n,1), zeros(n,1), zeros(n,1)];
MP = ['1', '2', '3', 'A'; '4', '5', '6', 'B'; '7', '8', '9', 'C'; '*' , '0','#', 'D'];


x_c=sin(w_c_l(2)*t)+sin(w_c_h(3)*t);
W=linspace(-pi,pi,300);
x_f=zeros(n,1);
t=1;
c_arr="";
while (t<n)
    st = stop(t);
    st = min(st,n);
    j_a=randi(4);
    j_b=randi(4)
    f1=w_c_l(j_a);
    f2=w_c_h(j_b);
    for i=t:st
        x_f(i)=sin(f1*i)+sin(f2*i);
    end
    c_arr=append(c_arr,MP(j_a,j_b));
    t=min(st,n);
    for i=t:min(t+20,n)
        x_f(i)=0;
    end
    t=t+20;
end
disp(c_arr)
plot(T,x_f)

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
 
C_arr="";
S=1;C=0;
for i=1:n
    if(x_f(i)~=0)
        C=0;
    else 
        C=C+1;
        if(C==20 | i==n)
            s=x_f(S:i-20);
            j_a=xfreq(s,w_c_l,y_l,n);
            j_b=yfreq(s,w_c_h,y_h,n);
            C_arr=append(C_arr,MP(j_a, j_b));
            S=i+1;
        end
    end
end
disp(C_arr)



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