clear all

a=1;
e=input('离心率e=');%0到0.55
b=1/(sqrt(1-e*e));%最多到1.1974

n=1.333;%红光折射率

m=500;
delta=0.01;%一个小量

x=zeros(1,m);
y=zeros(1,m);

t=linspace(1.33*pi,1.5*pi-delta,m);%根据输出结果实时修改

for j=1:m

k_f=a/b*tan(t(j));%入射点法线斜率

alpha=atan(k_f);%入射角大小

beta=asin(sin(alpha)/n);%折射角大小

k_1=tan(-beta+alpha);%内部第一次反射的入射光斜率

F=@(t0) b*sin(t0)-b*sin(t(j))-k_1*(a*cos(t0)-a*cos(t(j)));
t0=[-0.5*pi,0.5*pi];

t_1=fzero(F,t0);%解出球内入射点的参数t_1

k_f_1=a/b*tan(t_1);%球内第一次入射点法线斜率

alpha_1=-atan(k_f_1)+atan(k_1);%球内第一次入射角

k_2=tan(-alpha_1+atan(k_f_1));%内部第一次反射的反射光斜率

F1=@(t1) b*sin(t1)-b*sin(t_1)-k_2*(a*cos(t1)-a*cos(t_1));
t10=[0,pi];

t_2=fzero(F1,t10);%解出球内第二次入射点的参数t_2

k_f_2=a/b*tan(t_2);%第二次反射射点法线斜率

%球内第二次反射的入射角
alpha_2=atan(k_2)-atan(k_f_2);

k_3=tan(-alpha_2+atan(k_f_2));%内部第二次反射的反射光斜率

F2=@(t2) b*sin(t2)-b*sin(t_2)-k_3*(a*cos(t2)-a*cos(t_2));

t20=[t_2+0.01,1.5*pi];

t_3=fzero(F2,t20);%解出出射点的参数t_3

k_f_3=a/b*tan(t_3);%出射点法线斜率

%出射点的入射角
alpha_3=atan(k_3)-atan(k_f_3);

Ref=asin(n*sin(alpha_3));%出射点的折射角

guancejiao=Ref+atan(k_f_3);

x(1,m-j+1)=alpha;
y(1,m-j+1)=guancejiao;

end

plot(x,y,'r.');

axis equal;
grid on;

min(y)%输出观测角的结果

