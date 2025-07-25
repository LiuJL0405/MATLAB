clear

q=1.6e-19;%(C)
m=9.11e-31;%(kg)

E=[0,0,0];%(V/m)
%B=[0,0,3e-1];%(T)

dt=1e-12;%(s)
n=1000;


v=[0,20,0]; %(m/s)
x=[1e-9,0,0]; %(m)

x1=zeros(n,3);
v1=zeros(n,3);


for i=1:n

v_m=v+(q*E/m)*dt/2;

s=2*dt/(1+dt^2);

v_p0 =v_m+cross(v_m,(0.4*q*[-x(1,2)/sqrt(x(1,1)^2+x(1,2)^2),x(1,1)/sqrt(x(1,1)^2+x(1,2)^2),0]/m)*dt/2);
v_p=v_m+cross(v_p0,(0.4*q*[-x(1,2)/sqrt(x(1,1)^2+x(1,2)^2),x(1,1)/sqrt(x(1,1)^2+x(1,2)^2),0]/m)*s/2);

v=v_p+(q*E/m)*dt/2;

x=x+v*dt;

x1(i,:)=x;
v1(i,:)=v;

end


plot3(x1(:,1),x1(:,2),x1(:,3),'b-');
hold on;
plot3(x1(1,1),x1(1,2),x1(1,3),'ro');
hold on;
plot3(x1(n,1),x1(n,2),x1(n,3),'r*');
hold on;


xlabel('X(m)');
ylabel('Y(m)');
zlabel('Z(m)');

axis equal;
grid on;

