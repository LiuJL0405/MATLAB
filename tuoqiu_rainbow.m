clear all

xita=0:0.01:2*pi;

a=1;
e=input('离心率e=');%0到0.55
b=1/(sqrt(1-e*e));%最多到1.1974

n=[1.333,1.336,1.338,1.342,1.344,1.349,1.354];%折射率

colors=[1,0,0;
    1,0.5,0;
    1,1,0;
    0,1,0;
    0,1,1;
    0,0.5,1;
    0,0,1;];

x0=a*cos(xita);
y0=b*sin(xita);

%plot(x0,y0,'k-');

m=100;
delta=0.01;%一个小量

x=zeros(length(n),m);
y=zeros(length(n),m);

t=linspace(0.59*pi,0.8*pi-delta,m);

for i=1:length(n)

for j=1:m

k_f=a/b*tan(t(j));%入射点法线斜率

alpha=-atan(k_f);%入射角大小

beta=asin(sin(alpha)/n(i));%折射角大小

k_1=tan(beta-alpha);%内部第一次反射的入射光斜率

F=@(t0) b*sin(t0)-b*sin(t(j))-k_1*(a*cos(t0)-a*cos(t(j)));
t0=[-0.5*pi,0.5*pi];

t_1=fzero(F,t0);%解出球内入射点的参数t_1

k_f_1=a/b*tan(t_1);%球内入射点法线斜率

alpha_1=atan(k_f_1)-atan(k_1);%球内入射角

k_2=tan(alpha_1+atan(k_f_1));%内部第一次反射的反射光斜率

F1=@(t1) b*sin(t1)-b*sin(t_1)-k_2*(a*cos(t1)-a*cos(t_1));
t1=[-pi,0];

t_2=fzero(F1,t1);%解出出射点的参数t_2

k_f_2=a/b*tan(t_2);%出射点法线斜率

%出射点的入射角
if k_f_2>=0
    alpha_2=atan(k_f_2)-atan(k_2);
else
    alpha_2=atan(k_f_2)-atan(k_2)+pi;
end

Ref=asin(n(i)*sin(alpha_2));%出射点的折射角

%观测角大小
if k_f_2>=0
    guancejiao=-Ref+abs(atan(k_f_2));
else
    guancejiao=pi-Ref+atan(k_f_2);
end

x(i,m-j+1)=alpha;
y(i,m-j+1)=guancejiao;

end

plot(x(i,:),y(i,:),'LineWidth',1.5,"Color",[colors(i,:)]);
hold on;

end

xlabel('Incident Angle (rad)');
ylabel('Observation Angle of Rainbow (rad)');


axis equal;

%输出观测角的结果,数组y每行的最大值
gcj=zeros(1,length(n));

for k=1:length(n)

    gcj(k)=max(y(k,:));

end

hudu=gcj%输出观测角的弧度值

jiaodu=(gcj/pi)*180%角度值

(jiaodu-floor(jiaodu))*60%分度

