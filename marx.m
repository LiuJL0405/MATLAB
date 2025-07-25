clear all

t=0:0.01:6*pi;

x1=t;
y1=0*t;
z1=sin(t);

x2=cos(t);
y2=sin(t);
z2=t;

x=x1+x2;
y=y1+y2;
z=z1+z2;

plot3(x1,y1,z1);
hold on
plot3(x2,y2,z2);
hold on
plot3(x,y,z);
hold on

grid on;
axis equal;

