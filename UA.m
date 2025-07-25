clear all

x1=[301,305,290,280,360,325,282,330,276];%只需要改这里

x=[575,382,356,292,355,291,268,321,321,261,218,325,316,333];
m=length(x)+length(x1);

n=14;
t=2:2:2*n;

t1=2*n+3:3:2*n+3*(m-n);

t0=[t,t1];
x0=[x,x1];

tc=2:0.1:2*n+3*(m-n);
yc=interp1(t0,x0,tc,'pchip');%分段三次保形插值曲线

plot(t0,x0,'bo')%原始数据
hold on
plot(tc,yc,'b-')%分段三次保形插值曲线
hold on

tt=linspace(2,2*n+3*(m-n),m);

xmax=linspace(420,420,m);
plot(tt,xmax,'r--')
hold on
xmin=linspace(179,179,m);
plot(tt,xmin,'r--')
hold on
xm=linspace(300,300,m);
plot(tt,xm,'g--')
grid on;
xlabel('t (d)');
ylabel('UA (umol/L)');
