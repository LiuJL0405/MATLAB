clear all

a=1.5;
b=1;
c=1;

t=linspace(-0.5*pi,1.5*pi,200);

x=c*cos(t);
y=-0.5*((a+b)-(a-b)*sin(t)).*sin(t);

plot(x,y,'LineWidth',1.5,'color',[0,0.5,1]);
hold on;

plot(0,0,'ko');

axis equal;
grid on;