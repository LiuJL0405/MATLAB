clear

q=3.20e-19;%(C)
m=6.64e-27;%(kg)

E=[0,0,0];

dt=3e-11;%(s)
n=1000000;

R0=5.7;
a=1.6;

vth=sqrt(2*(3.5e6*1.6e-19)/m);
v=[0.48*vth,-0.36*vth,-0.8*vth]; %(m/s)，一种香蕉轨道
%v=[sqrt(1)/sqrt(9)*vth,sqrt(8)/sqrt(9)*vth,0*vth]; %(m/s)，一种通行粒子轨道
x=[6.7,1,0]; %(m)

B1=zeros(n,3);
v1=zeros(n,3);
x1=zeros(n,3);

for i=1:n

v_m=v+(q*E/m)*dt/2;

s=2*dt/(1+dt^2);

%计算磁场
R=sqrt(x(1,1).^2+x(1,2).^2);
r=sqrt((R-R0).^2+x(1,3).^2);

B0=5;
qq=5*r./R;
%qq=0.45;
Bt=B0*R0./R;
Bp=-r.*Bt./(qq.*R);

Bx=-Bt.*x(1,2)./R-Bp.*(x(1,3)./r).*(x(1,1)./R);
By=Bt.*x(1,1)./R-Bp.*(x(1,3)./r).*(x(1,2)./R);
Bz=Bp.*(R-R0)./r;

B=[Bx,By,Bz];
B1(i,:)=B;

v_p0 =v_m+cross(v_m,q*B/m*dt/2);
v_p=v_m+cross(v_p0,q*B/m*s/2);

v=v_p+(q*E/m)*dt/2;
v1(i,:)=v;

x=x+v*dt;
x1(i,:)=x;

end

B1(n,1)=-Bt.*x(1,2)./R-Bp.*(x(1,3)./r).*(x(1,1)./R);
B1(n,2)=Bt.*x(1,1)./R-Bp.*(x(1,3)./r).*(x(1,2)./R);
B1(n,3)=Bp.*(R-R0)./r;

plot3(x1(:,1),x1(:,2),x1(:,3),'b.');
hold on;
plot3(x1(1,1),x1(1,2),x1(1,3),'ro');%起始点
hold on;
plot3(x1(n,1),x1(n,2),x1(n,3),'k*');
hold on;

[u,v]=meshgrid(0:2*pi/50:2*pi,0:2*pi/50:2*pi);
    X=(R0+a.*cos(u)).*cos(v);
    Y=(R0+a.*cos(u)).*sin(v);
    Z=a.*sin(u);
    mesh(X,Y,Z);
    axis equal;
    hidden off;
    colormap([0 1 1]);

xlabel('X');
ylabel('Y');
zlabel('Z');

axis equal;
grid on;


figure (2)%画香蕉

plot(sqrt(x1(:,1).^2+x1(:,2).^2),x1(:,3),'b-');
hold on;

u=0:2*0.01*pi:2*pi;
    XX=R0+a.*cos(u);
    YY=a.*sin(u);
    plot(XX,YY,'k-');
    hold on;
    plot(R0,0,'ko');
    axis equal;

xlabel('R');
ylabel('Z');

axis equal;
grid on;

figure (3)

N=1:1:n;
t=dt*N;
v0=sqrt(v1(:,1).^2+v1(:,2).^2+v1(:,3).^2);
x0=sqrt(x1(:,1).^2+x1(:,2).^2+x1(:,3).^2);

subplot(2,3,1)
plot(t,v0,'r-');
xlabel('$ t $', 'Interpreter', 'latex');
ylabel('$ v $', 'Interpreter', 'latex');
grid on;

subplot(2,3,2)

vpar=zeros(n,1);
for i=1:n

    vpar(i,1)=dot(v1(i,:),B1(i,:))/sqrt(B1(i,1).^2+B1(i,2).^2+B1(i,3).^2);
end

plot(t,vpar,'r-');
xlabel('$ t $', 'Interpreter', 'latex');
ylabel('$ v_\parallel $', 'Interpreter', 'latex');
grid on;

subplot(2,3,3)

vperp=sqrt(v0.^2-vpar.^2);
plot(t,vperp,'r-');
xlabel('$ t $', 'Interpreter', 'latex');
ylabel('$ v_\perp $', 'Interpreter', 'latex');
grid on;

subplot(2,3,4)
plot(t,x0,'b-');
xlabel('$ t $', 'Interpreter', 'latex');
ylabel('$ r $', 'Interpreter', 'latex');
grid on;

subplot(2,3,5)
xr=sqrt(x1(:,1).^2+x1(:,2).^2);
plot(t,xr,'b-');
xlabel('$ t $', 'Interpreter', 'latex');
ylabel('$ R $', 'Interpreter', 'latex');
grid on;

subplot(2,3,6)
xz=x1(:,3);
plot(t,xz,'b-');
xlabel('$ t $', 'Interpreter', 'latex');
ylabel('$ Z $', 'Interpreter', 'latex');
grid on;

figure(4)

% B=sqrt(B1(:,1).^2+B1(:,2).^2+B1(:,3).^2);

T=2*pi*m/(q*B0);
n1=floor(max(t)/(0.6*T));
NN=floor(n/n1);

tt=zeros(NN,1);
vparm=zeros(NN,1);
vperpm=zeros(NN,1);
x0m=zeros(NN,1);
xrm=zeros(NN,1);
xzm=zeros(NN,1);

for i=1:NN

    tt(i)=t(floor(n1/2)+(i-1)*n1);
    vparm(i)=mean(vpar(1+(i-1)*n1:n1*i,1));
    vperpm(i)=mean(vperp(1+(i-1)*n1:n1*i,1));
    x0m(i)=mean(x0(1+(i-1)*n1:n1*i,1));
    xrm(i)=mean(xr(1+(i-1)*n1:n1*i,1));
    xzm(i)=mean(xz(1+(i-1)*n1:n1*i,1));
end

subplot(2,3,1)
v0m=sqrt(vparm.^2+vperpm.^2);
plot(tt,v0m,'r-');
hold on;
plot(t,v0,'b-');
xlabel('$ t $', 'Interpreter', 'latex');
ylabel('$ \langle v \rangle $', 'Interpreter', 'latex');
grid on;

subplot(2,3,2)

plot(tt,vparm,'r-');
xlabel('$ t $', 'Interpreter', 'latex');
ylabel('$ \langle v_\parallel \rangle $', 'Interpreter', 'latex');
grid on;

subplot(2,3,3)

plot(tt,vperpm,'r-');
xlabel('$ t $', 'Interpreter', 'latex');
ylabel('$ \langle v_\perp \rangle $', 'Interpreter', 'latex');
grid on;

subplot(2,3,4)
plot(tt,x0m,'b-');
hold on;
% plot(tt,sqrt(xrm.^2+xzm.^2),'r-');
xlabel('$ t $', 'Interpreter', 'latex');
ylabel('$ \langle r \rangle $', 'Interpreter', 'latex');
grid on;

subplot(2,3,5)
plot(tt,xrm,'b-');
xlabel('$ t $', 'Interpreter', 'latex');
ylabel('$ \langle R \rangle $', 'Interpreter', 'latex');
grid on;

subplot(2,3,6)

plot(tt,xzm,'b-');
xlabel('$ t $', 'Interpreter', 'latex');
ylabel('$ \langle Z \rangle $', 'Interpreter', 'latex');
grid on;

% % 生成示例数据（50,000×1 的列向量）
% data = vpar;  
% 
% % 转换为表格（列名默认是 'Var1'，可自定义）
% data_table = table(data, 'VariableNames', {'Values'});  
% 
% % 存储到 Excel
% writetable(data_table, 'vpar.xlsx'); 