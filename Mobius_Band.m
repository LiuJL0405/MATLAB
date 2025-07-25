clear all

U=linspace(-1,1,40);
V=linspace(0,2*pi,40);
[u,v]=meshgrid(U,V);
x=(3+u.*cos(v/2)).*cos(v);
y=(3+u.*cos(v/2)).*sin(v);
z=u.*sin(v/2);
mesh(x,y,z);
axis([-4 4 -4 4 -4 4]);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Mobius Band');