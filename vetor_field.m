clear all


x0=linspace(-0.5,0.5,10);
y0=linspace(-0.5,0.5,10);
z0=linspace(-0.4,0.4,3);

[x,y,z]=meshgrid(x0,y0,z0);

Bx=-y.*(x.^2+y.^2).^(-1/2);
By=x.*(x.^2+y.^2).^(-1/2);
Bz=0*z;

%Bx=0.25*(1+x.^2-y.^2-z.^2);
%By=-x.*y;
%Bz=-x.*z;


quiver3(x,y,z,Bx,By,Bz);

%y00=linspace(-0.05,0.05,3);
%z00=linspace(-0.05,0.05,3);

y00=linspace(0.1,0.1,1);
z00=linspace(-0.4,0.4,3);

[startX,startY,startZ]=meshgrid(0,y00,z00);
verts=stream3(x,y,z,Bx,By,Bz,startX,startY,startZ);
streamline(verts);


xlabel('X');
ylabel('Y');
zlabel('Z');

axis equal;

%view(0,90);
