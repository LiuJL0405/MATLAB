clear all

ym=1.25;

y=linspace(-ym,ym,10001);

d=2;
z=1000;
lambda=0.8e-3;

L1=sqrt((y-1).^2+z^2);
L2=sqrt((y+1).^2+z^2);

phi=2*pi*(L2-L1)/lambda;

n=100;
p=linspace(0.2,0.9,n);

for i=1:n
I=(1./(1+4*p(i)/(1-p(i))^2*sin(0.5*phi).^2));

subplot(2,1,1);

ymax=max(I);
plot(y,I,'LineWidth',1,"Color",[0,0,1]);
axis([-1.25,1.25,0,ymax]);

subplot(2,1,2);

B=I*255/1.5;
image(B);
colormap(gray(255));
axis off;

pause(0.1);

end
