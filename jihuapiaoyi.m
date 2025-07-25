clear all

q=1.6e-19;%(C)
m=9.11e-31;%(kg)

B=[0,0,3e-1]; %(T)

dt=1e-12;%(s)
nn=500;

E=zeros(nn,3);

for i=1:nn

E(i,1)=0.6*sin(i*dt*2*pi/(nn*dt));%(V/m)

end

vn=[0.8e1,0,0]; %(m/s)
xn=[0,0,0]; %(m)

xn1=zeros(nn, 3);


for j=1:nn
   
      v_mn=vn+(q*E(j,:)/m)*dt/2;

s=2*dt/(1+dt^2);

v_p0n=v_mn+cross(v_mn,(q*B/m)*dt/2);
v_pn=v_mn+cross(v_p0n,(q*B/m)*s/2);

vn=v_pn+(q*E(j,:)/m)*dt/2;

xn=xn+vn*dt;

xn1(j,:)=xn;

if j>nn/2
plot(xn1(j,1),xn1(j,2),'b.');
 hold on;
end

 if j<=nn/2
plot(xn1(j,1),xn1(j,2),'r.');
 hold on;
 end

end


   plot(xn1(1,1),xn1(1,2),'bo');
 hold on;

xlabel('X(m)');
ylabel('Y(m)');

axis equal;
grid on;

