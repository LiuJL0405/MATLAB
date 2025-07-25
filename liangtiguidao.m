clear all
 
figure(1)%总能量大于零：双曲线轨道

xita1=0:0.001:0.6*pi;
r1=1./(1+2*cos(xita1));
x1=r1.*cos(xita1);
y1=r1.*sin(xita1);
plot(x1,y1,'-','color',[0,1,1]);
xlabel('X');
ylabel('Y');
grid on;
h1=copyobj(allchild(gca),gca);
rotate(h1,[1,0,0],180,[0,0,0]);%绕x轴转
hold on
plot(0,0,'ko');
title('双曲线轨道');

axis equal;
grid on;

figure(2)%总能量等于零：抛物线轨道

xita2=0:0.001:0.7*pi;
r2=10./(1+cos(xita2));
x2=r2.*cos(xita2);
y2=r2.*sin(xita2);
plot(x2,y2,'-','color',[0,1,1]);
xlabel('X');
ylabel('Y');
grid on;
h2=copyobj(allchild(gca),gca);
rotate(h2,[1,0,0],180,[0,0,0]);%绕x轴转
hold on
plot(0,0,'ko');
title('抛物线轨道');

axis equal;
grid on;

figure(3)%总能量小于零：椭圆轨道

xita3=0:0.001:2*pi;
r3=1./(1+0.7*cos(xita3));
x3=r3.*cos(xita3);
y3=r3.*sin(xita3);
plot(x3,y3,'-','color',[0,1,1]);
xlabel('X');
ylabel('Y');
grid on;
hold on
plot(0,0,'ko');
title('椭圆轨道');

axis equal;
grid on;
