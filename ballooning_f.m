clear all

m=20;
a=0.05;

theta=linspace(0,2*pi,800);
r=1+a*cos(m*theta);

subplot(1,2,1)

x=r.*cos(theta);
y=r.*sin(theta);

plot(x,y);
yline(0);
xline(0);
axis equal;
grid off

subplot(1,2,2)

r2=1;

for n=20:30
    
    r2=r2+a*cos(n*theta);

end

x2=r2.*cos(theta);
y2=r2.*sin(theta);

plot(x2,y2);
yline(0);
xline(0);
axis equal;
grid off