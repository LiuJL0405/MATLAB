clear all
c=xlsread('shuju.xls');

f=1000*c(:,1);
dl=c(:,2);

s=pi*(12.5*1e-3)^2;
L=50;

yl=f/s;
yb=dl/L;

plot(yl,yb,'b-')
hold on
xlabel('应力/pa');
ylabel('应变');
grid on;

yl0=yl(200:500,1);
yb0=yb(200:500,1);
p=polyfit(yl0,yb0,1);

x=-1e+7:4e+7;
y=polyval(p,x);
plot(x,y,'k-')
hold on
grid on;

p
nh_ml=1/p(1,1)
pt_ml=(yl(500,1)-yl(200,1))/(yb(500,1)-yb(200,1))
