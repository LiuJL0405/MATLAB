clear all

%q=1.6e-19;%(C)
%m=9.11e-31;%(kg)
q=1;
m=1;

E=[0,0,0];%(V/m)
%B=[0,0,3e-1];%(T)

dt=5e-2;%(s)
n=1000;


v=[0,0,0.1]; %(m/s)
x=[-0.5,-0.04,0]; %(m)

x1=zeros(n,3);


for i=1:n

v_m=v+(q*E/m)*dt/2;

s=2*dt/(1+dt^2);

v_p0 =v_m+cross(v_m,(q*[1+x(1,1)^2-x(1,2)^2-x(1,3)^2,-x(1,1).*x(1,2),-x(1,1).*x(1,3)]/m)*dt/2);
v_p=v_m+cross(v_p0,(q*[1+x(1,1)^2-x(1,2)^2-x(1,3)^2,-x(1,1).*x(1,2),-x(1,1).*x(1,3)]/m)*s/2);

v=v_p+(q*E/m)*dt/2;

x=x+v*dt;

x1(i,:)=x;

end


plot3(x1(:,1),x1(:,2),x1(:,3),'b-');
hold on;
plot3(x1(1,1),x1(1,2),x1(1,3),'ro');
hold on;
plot3(x1(n,1),x1(n,2),x1(n,3),'r*');
hold on;

xlabel('X');
ylabel('Y');
zlabel('Z');

axis equal;
grid on;

