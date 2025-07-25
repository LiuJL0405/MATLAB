clear all


subplot(2,2,3);

t=linspace(0,2.5*pi,5000);

x=cos(t);
y=sin(t);

plot(x,y,'LineWidth',1.2,'color',[0,0,1]);
hold on;
plot(0,0,'k.');
hold on;

xlabel('x');
ylabel('z');

grid on;
axis equal;
axis([-2.3,2.3 -2.3,2.3]);


subplot(2,2,4);

t=linspace(0,2.5*pi,5000);

x=cos(t);
y=1.5*sin(t);

plot(x,y,'LineWidth',1.2,'color',[0,0,1]);
hold on;
plot(0,0,'k.');
hold on;

xlabel('x');
ylabel('z');

grid on;
axis equal;
axis([-2.3,2.3 -2.3,2.3]);

subplot(2,2,1);

f1 = @(x,y,z) x.*x+y.*y+z.*z-1;%圆球函数表达式

[x,y,z] = meshgrid(-1:0.05:1,-1:0.05:1,-2:0.05:2);%画图范围

v = f1(x,y,z);
h = patch(isosurface(x,y,z,v,0));

isonormals(x,y,z,v,h)              
set(h,'FaceColor',[0,1,1],'EdgeColor','none');

xlabel('x');
ylabel('y');
zlabel('z');

%alpha(1)   
view(-37.5,30);

axis equal; 
%axis off; 

grid on;

camlight; %打光
lighting gouraud

axis([-1.5,1.5 -1.5,1.5 -1.5,1.5]);


subplot(2,2,2);

f2 = @(x,y,z) x.*x+y.*y+z.*z/2-1;%椭球函数表达式

[x,y,z] = meshgrid(-1:0.05:1,-1:0.05:1,-2:0.05:2);%画图范围

v = f2(x,y,z);
h = patch(isosurface(x,y,z,v,0));

isonormals(x,y,z,v,h)              
set(h,'FaceColor',[0,1,1],'EdgeColor','none');

xlabel('x');
ylabel('y');
zlabel('z');

%alpha(1)   
view(-37.5,30);
axis equal; 
%axis off; 

grid on;

camlight; %打光
lighting gouraud

axis([-1.5,1.5 -1.5,1.5 -1.5,1.5]);


