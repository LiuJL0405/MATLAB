clear all

ym=1.25;

y=linspace(-ym,ym,1001);

d=2;
z=1000;
lambda=0.8e-3;

L1=sqrt((y-1).^2+z^2);
L2=sqrt((y+1).^2+z^2);

phi=2*pi*(L2-L1)/lambda;

I=4*(cos(phi/2)).^2;

subplot(2,1,1);

plot(y,I,'LineWidth',1,"Color",[0,0,1]);
axis([-1.25,1.25 ,0,4]);

subplot(2,1,2);

B=I*255/4.5;
image(B);
colormap(gray(255));
