clear all

q=1.6e-19;%(C)
m=9.11e-31;%(kg)
m1=1.67e-27;%(kg)

E=[0,0,0];%(V/m)
%B=[0,0,3e-1];%(T)

dt=1e-12;%(s)
nn=200;
np=3.7e5;


vp=[0,-0.9e1,0]; %(m/s)
xp=[0,0,0]; %(m)
vn=[0,-0.9e1,0]; %(m/s)
xn=[0,0,0]; %(m)

xp1=zeros(np, 3);
xn1=zeros(nn, 3);

for i=1:np
   
    v_mp=vp+(q*E/m1)*dt/2;
  
s=2*dt/(1+dt^2);

v_p0p=v_mp+cross(v_mp,(q*[0,0,7e-1+2e6*xp(1,2)]/m1)*dt/2);
v_pp=v_mp+cross(v_p0p,(q*[0,0,7e-1+2e6*xp(1,2)]/m1)*s/2);

vp=v_pp+(q*E/m1)*dt/2;

xp=xp+vp*dt;

xp1(i,:)=xp;

end

for j=1:nn
   
      v_mn=vn+(-q*E/m)*dt/2;

s=2*dt/(1+dt^2);

v_p0n=v_mn+cross(v_mn,(-q*[0,0,7e-1+3e9*xn(1,2)]/m)*dt/2);
v_pn=v_mn+cross(v_p0n,(-q*[0,0,7e-1+3e9*xn(1,2)]/m)*s/2);

vn=v_pn+(-q*E/m)*dt/2;

xn=xn+vn*dt;

xn1(j,:)=xn;

end

subplot(2,1,1);
 plot(xp1(:,1),xp1(:,2),'r-');
 hold on;
  plot(xp1(1,1),xp1(1,2),'ro');
 hold on;

xlabel('X(m)');
ylabel('Y(m)');

axis equal;
grid on;

 subplot(2,1,2);
  plot(xn1(:,1),xn1(:,2),'b-');
 hold on;
 plot(xn1(1,1),xn1(1,2),'bo');
 hold on;

xlabel('X(m)');
ylabel('Y(m)');

axis equal;
grid on;