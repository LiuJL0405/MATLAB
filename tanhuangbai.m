clear all

g= 10;
w2=5;
r00=5;%m=1,k=5,弹簧原长=5
 
r0 = 5; 
a=input('摆角/°：');
xita0 =3*pi/2-pi*(a/180); 
 
vr0 = 0; 
vxita0 =0;

Y0=[r0,vr0,xita0,vxita0]; %初值

fun = @(t, Y) [Y(2); -g*sin(Y(3))-w2*(Y(1)-r00)+Y(1).*Y(4).*Y(4);
    Y(4);(-g*cos(Y(3))-2*Y(2).*Y(4))./Y(1)];


options = odeset('RelTol',1e-8,'AbsTol',1e-10);%绝对误差和相对误差
tspan=[0,200];

[t, Y] = ode15s(fun, tspan, Y0,options);

x0=Y0(1,1).*cos(Y0(1,3));
y0=Y0(1,1).*sin(Y0(1,3));

plot(x0, y0, 'ko');
hold on;
plot(0, 0, 'ko');
hold on;

x=Y(:,1).*cos(Y(:,3));
y=Y(:,1).*sin(Y(:,3));
plot(x, y, 'r-');
axis([-8,8 -10,0]);
xlabel('x');
ylabel('y');

axis equal;
grid on;
