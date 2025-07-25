clear

x0=linspace(-7,7,50);
y0=linspace(-7,7,50);
z0=linspace(-2,2,25);

[x,y,z]=meshgrid(x0,y0,z0);

B0=5;
R0=5;
a=1;

R=sqrt(x.^2+y.^2);
r=sqrt((R-R0).^2+z.^2);

%q=5*r./R;
q=3;
Bt=B0*R0./R;
Bp=-r.*Bt./(q.*R);

Bx=-Bt.*y./R-Bp.*(z./r).*(x./R);
By=Bt.*x./R-Bp.*(z./r).*(y./R);
Bz=Bp.*(R-R0)./r;

quiver3(x,y,z,Bx,By,Bz);

X=[R0,R0];
Y=[0,0];
Z=[a,-a];
[startX,startY,startZ]=meshgrid(X,Y,Z);
verts=stream3(x,y,z,Bx,By,Bz,startX,startY,startZ);
h=streamline(verts);
%h.Color=[0 0 1];

hold on

[u,v]=meshgrid(0:0.05*pi:2*pi,0:2*pi/50:1.5*pi);
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

grid on;
axis equal;
