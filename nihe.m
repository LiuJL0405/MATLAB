clear all
x0=0:2:15;
y0=sin(x0);%样本点

plot(x0,y0,'b-');%样本散点图
hold on

p=polyfit(x0,y0,3);%3次拟合
x=0:0.1:15;
y=polyval(p,x);
plot(x,y,'k-');%拟合曲线
hold on
y1=sin(x);
plot(x,y1,'r-');%真实曲线

axis equal;
grid on;
