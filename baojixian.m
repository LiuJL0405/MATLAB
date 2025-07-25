clear all

o1=1;
o2=3.5;
r1=1.2;
r2=1.5;

plot(o1,0,'r*');
hold on
plot(o2,0,'b*');
hold on

xita=0:0.1:pi;
x1=o1+r1*cos(xita);
y1=r1*sin(xita);
plot(x1,y1,'r-');
hold on
x2=o2+r2*cos(xita);
y2=r2*sin(xita);
plot(x2,y2,'b-');
hold on

a=atan((r2-r1)/(o2-o1));

xp=o1-r1*sin(a);
yp=r1*cos(a);
xq=o2-r2*sin(a);
yq=r2*cos(a);

xn=[xp,xq];
yn=[yp,yq];

p=polyfit(xn,yn,1);
x=-1:0.1:6;
y=polyval(p,x);
plot(x,y,'k-');

axis equal;
grid on;
