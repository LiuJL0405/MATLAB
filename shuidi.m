clear all

t=linspace(0,pi,200);

x=sqrt(6)*sin(2*t);
y=5-exp(2)*sin(t);

plot(x,y,'LineWidth',1.5,'color',[0,0.5,1]);
hold on;

axis equal;
axis off;