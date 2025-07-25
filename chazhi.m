clear all

x0=0:2:15;
y0=sin(x0);%原始数据

xc=0:0.1:15;%插值点

yc1=interp1(x0,y0,xc,'nearest');%最近邻插值曲线
yc2=interp1(x0,y0,xc,'linear');%线性插值曲线
yc3=interp1(x0,y0,xc,'spline');%分段三次样条插值曲线
yc4=interp1(x0,y0,xc,'pchip');%分段三次保形插值曲线

subplot(2,2,1);
plot(x0,y0,'b-');%散点图
hold on
x1=0:0.1:15;
y1=sin(x1);
plot(x1,y1,'k-');%真实曲线
hold on
plot(xc,yc1,'r-');%最近邻插值曲线
title('最近邻插值曲线');
grid on

subplot(2,2,2);
plot(x0,y0,'b-');%散点图
hold on
x1=0:0.1:15;
y1=sin(x1);
plot(x1,y1,'k-');%真实曲线
hold on
plot(xc,yc2,'r-');%线性插值曲线
title('线性插值曲线');
grid on

subplot(2,2,3);
plot(x0,y0,'b-');%散点图
hold on
x1=0:0.1:15;
y1=sin(x1);
plot(x1,y1,'k-');%真实曲线
hold on
plot(xc,yc3,'r-');%分段三次样条插值曲线
title('分段三次样条插值曲线');
grid on

subplot(2,2,4);
plot(x0,y0,'b-');%散点图
hold on
x1=0:0.1:15;
y1=sin(x1);
plot(x1,y1,'k-');%真实曲线
hold on
plot(xc,yc4,'r-');%分段三次保形插值曲线
title('分段三次保形插值曲线');
grid on