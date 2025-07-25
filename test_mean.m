clear all

n=50000;

w=10;
w1=500;
t=linspace(0,4*pi/w,n);

f=cos(w*t)+0.1*cos(w1*t);

% n1=floor(w1/w);
n1=floor((2*pi/w)/(0.1*2*pi/w1));
N=floor(n/n1);

ff=zeros(1,N);
tt=zeros(1,N);

for i=1:N

    ff(i)=mean(f(1+(i-1)*n1:n1*i));
    tt(i)=t(floor(n1/2)+(i-1)*n1);

end

subplot(2,1,1)
plot(t,f,'b');
hold on;
plot(tt,ff,'r*');
%axis equal;
grid on;

subplot(2,1,2)
plot(tt,cos(w*tt),'b');
hold on;
plot(tt,ff,'ro');
%axis equal;
grid on;