clear all

N=100000;
a=0.529;
r1=2.5*rand(1,N);
Dr=4/a^3*r1.^2.*exp(-2/a*r1);
m=max(Dr);
r2=m*rand(1,N);
r=r1(find(r2<Dr));
n=length(r);
Q=2*pi*rand(1,n);

[X,Y]=pol2cart(Q,r);
plot(X,Y,'k.','marker','.','markersize',1)
hold on
axis equal
r=0:0.01:5;
Dr=4/a^3*r.^2.*exp(-2/a*r);
%plot(r,Dr)
