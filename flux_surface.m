clear

[u,v]=meshgrid(0:2*pi/75:2*pi,0:1.5*pi/75:1.5*pi);

a=1;
R0=5;
delta=0.25;
kappa=1.6;

R = R0 +a.*cos(u + delta*sin(u));

X=R.*cos(v);
Y=R.*sin(v);
Z = kappa *a* sin(u);

mesh(X,Y,Z);
axis equal;
hidden off;
colormap([0 0 1]);

xlabel('X');
ylabel('Y');
zlabel('Z');

grid on;
axis equal;


