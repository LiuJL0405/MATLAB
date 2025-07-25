clear all

a=0.35;%圆环半径
the=0:pi/20:2*pi;
y=-1:0.04:1;
z=-1:0.04:1;
[Y,Z,T]=meshgrid(y,z,the);%三维网格数据

r=sqrt((a*cos(T)).^2+(Y-a*sin(T)).^2+Z.*Z);
r3=r.^3;

dby=a*Z.*sin(T)./r3;
by=pi/40*trapz(dby,3);%磁场y分量

dbz=a*(a-Y.*sin(T))./r3;
bz=pi/40*trapz(dbz,3);%磁场z分量

figure(1)%第一个图
[bSY,bSZ]=meshgrid([0:0.05:0.2],0);%二维网格
h1=streamline(Y(:,:,1),Z(:,:,1),by,bz,bSY,bSZ,[0.1,1000]);%第一象限图

h2=copyobj(h1,gca);
rotate(h2,[1,0,0],180,[0,0,0]);%绕X轴转得到第一，第四象限

h3=copyobj(allchild(gca),gca);
rotate(h3,[0,1,0],180,[0,0,0]);%绕Y轴转到第二，第三象限
title('二维图','fontsize',12);%加标题并控制字号

axis equal;
grid on;

xlabel('X');
ylabel('Y');

%再画三维图
for kk=1:4
    [bSY,bSZ]=meshgrid(0.2+kk*0.02,0);
    streamline(Y(:,:,1),Z(:,:,1),by,bz,bSY,bSZ,[0.02/(kk+1),4500]);
    streamline(-Y(:,:,1),Z(:,:,1),-by,bz,-bSY,bSZ,[0.02/(kk+1),4500]);
end

[X,Y,Z]=meshgrid(-1:0.04:1);
r2=X.*X+Y.*Y+Z.*Z;

for k=1:81
    phi=pi/40*(k-1);
    costh=cos(phi);
    sinth=sin(phi);
    R3=(r2+a^2-2*a*(X*costh+Y*sinth)).^(3/2);
    Bx0(:,:,:,k)=a*Z*costh./R3;
    By0(:,:,:,k)=a*Z*sinth./R3;
    Bz0(:,:,:,k)=a*(a-X*costh-Y*sinth)./R3;
end

Bx=pi/40*trapz(Bx0,4);
By=pi/40*trapz(By0,4);
Bz=pi/40*trapz(Bz0,4);

figure(2)%第二张图
v=[-0.2,-0.1,0,0.1,0.2];
[Vx,Vy,Vz]=meshgrid(v,v,0);%三维网格
plot3(Vx(:),Vy(:),Vz(:),'o','color',[0,1,1])%磁场穿过天青色小圈
streamline(X,Y,Z,Bx,By,Bz,Vx,Vy,Vz,[0.01,2000]);%磁感线
hold on;
axis([-1,1,-1,1,-1,1]);
grid on;%加网格
xlabel('X');
ylabel('Y');
zlabel('Z');
title('三维图','fontsize',12);%加标题并控制字号

t=0:pi/200:2*pi;
plot(a*exp(i*t),'k-');%画出黑色圆环

h4=copyobj(allchild(gca),gca);
rotate(h4,[1,0,0],180,[0,0,0]);%绕X轴转得到下半部分图
