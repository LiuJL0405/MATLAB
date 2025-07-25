clear all

dt=3e-11;%(s)
n=500000;
N=1:1:n;
t=dt*N;

f0=readtable('xr.xlsx');
f=f0.Values;

B0=5;
q=3.20e-19;%(C)
m=6.64e-27;%(kg)

T=2*pi*m/(q*B0);
% n1=floor(w1/w);
n1=floor(max(t)/(0.6*T));
NN=floor(n/n1);

ff=zeros(NN,1);
tt=zeros(NN,1);

for i=1:NN

    ff(i)=mean(f(1+(i-1)*n1:n1*i,1));
    tt(i)=t(floor(n1/2)+(i-1)*n1);

end
a=ff;
subplot(311)
plot(t,f,'b');
hold on;
plot(tt,ff,'r*-');
%axis equal;
grid on;

