clear all

g= 10;
w2=1;%m=1,k=1
 
x0 = 0; 
y0 =0; 
 
vx0 =input('vx0=');
vy0 =input('vy0=');
a=input('a=');

Y0=[x0,vx0,y0,vy0]; %初值

fun = @(t, Y) [Y(2); -w2*Y(2).*(Y(2).^2+Y(4).^2).^(a/2-1/2);
    Y(4);-g-w2*Y(4).*(Y(2).^2+Y(4).^2).^(a/2-1/2)];


options = odeset('RelTol',1e-8,'AbsTol',1e-10);%绝对误差和相对误差
tspan=[0,500];

[t, Y] = ode45(fun, tspan,Y0,options);

plot(x0, y0, 'ko');
hold on;

n=length(t);

for i=1:n
    
    if Y(i,3)<0
        break;
    end
    
    x(i)=Y(i,1);
    y(i)=Y(i,3);
    
    xz(i)=vx0*t(i);
    yz(i)=vy0*t(i)-1/2*g*t(i).^2;
end

plot(x, y, 'r-');
hold on
plot(xz,yz,'-','color',[0,1,1]);
xlabel('x');
ylabel('y');
grid on;
