clear all

xita=0:0.01:2*pi;

a=1;
b=1.2;

n=1.333;%红光折射率

x0=a*cos(xita);
y0=b*sin(xita);

plot(x0,y0,'LineWidth',2,"Color",[0,0,1]);%画椭圆
hold on;

plot(cos(xita),sin(xita),'LineWidth',0.1,"Color",[0,0,0]);%画辅助圆
hold on;

plot(0,0,'ko');%画辅助圆心
hold on;


m=100;
delta=0.01;%一个小量

x=zeros(1,m);
y=zeros(1,m);

t=linspace(pi/2+delta,4*pi/5-delta,m);

j=45;

k_f=a/b*tan(t(j));%入射点法线斜率

x1=linspace(-0.6,-0.1,20);
y1=k_f*(x1-a*cos(t(j)))+b*sin(t(j));
plot(x1,y1,'k.');%法线k_f
hold on;

x2=linspace(a*cos(t(j))-1,a*cos(t(j)),100);
y2=b*sin(t(j))*(x2./x2);
plot(x2,y2,'LineWidth',1,"Color",[1,0,0]);%入射光线
hold on;

alpha=-atan(k_f);%入射角大小

beta=asin(sin(alpha)/n);%折射角大小

k_1=tan(beta-alpha);%内部第一次反射的入射光斜率

F=@(t0) b*sin(t0)-b*sin(t(j))-k_1*(a*cos(t0)-a*cos(t(j)));
t0=[-0.5*pi,0.5*pi];

t_1=fzero(F,t0);%解出球内入射点的参数t_1

x3=linspace(a*cos(t(j)),a*cos(t_1),100);
y3=k_1*(x3-a*cos(t(j)))+b*sin(t(j));
plot(x3,y3,'LineWidth',1,"Color",[1,0,0]);%k_1光线
hold on;

k_f_1=a/b*tan(t_1);%球内入射点法线斜率

x4=linspace(a*cos(t_1)-0.5,a*cos(t_1)+0.5,20);
y4=k_f_1*(x4-a*cos(t_1))+b*sin(t_1);
plot(x4,y4,'k.');% 法线k_f_1
hold on;

alpha_1=atan(k_f_1)-atan(k_1);%球内入射角

k_2=tan(alpha_1+atan(k_f_1));%内部第一次反射的反射光斜率

F1=@(t1) b*sin(t1)-b*sin(t_1)-k_2*(a*cos(t1)-a*cos(t_1));
t1=[-pi,0];

t_2=fzero(F1,t1);%解出出射点的参数t_2

k_f_2=a/b*tan(t_2);%出射点法线斜率

x5=linspace(a*cos(t_2),a*cos(t_1),100);
y5=k_2*(x5-a*cos(t_2))+b*sin(t_2);
plot(x5,y5,'LineWidth',1,"Color",[1,0,0]);%出射点入射光线k_2
hold on;

x6=linspace(a*cos(t_2)-0.2,a*cos(t_2)+0.2,20);
y6=k_f_2*(x6-a*cos(t_2))+b*sin(t_2);
plot(x6,y6,'k.');%法线k_f_2
hold on;

%出射点的入射角
if k_f_2>=0
    alpha_2=atan(k_f_2)-atan(k_2);
else
    alpha_2=atan(k_f_2)-atan(k_2)+pi;
end

Ref=asin(n*sin(alpha_2));%出射点的折射角

%观测角大小
if k_f_2>=0
    guancejiao=-Ref+abs(atan(k_f_2));
else
    guancejiao=pi-Ref+atan(k_f_2);
end

x7=linspace(a*cos(t_2)-0.5,a*cos(t_2),100);
y7=tan(guancejiao)*(x7-a*cos(t_2))+b*sin(t_2);
plot(x7,y7,'LineWidth',1,"Color",[1,0,0]);%出射光线
hold on;

axis equal;

grid on;

