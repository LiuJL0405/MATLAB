clear all
tspan=[0,100];
vec0=[1e-5,0,0];%设定求解的时间范围和初值

[t,v]=ode45('lorentz',tspan,vec0);

x=v(:,1);
y=v(:,2);
z=v(:,3);

plot3(x,y,z,'b-');
xlabel('x');
ylabel('y');
zlabel('z');
hold on
plot3(vec0(1),vec0(2),vec0(3),'*r')

grid on;

