clear

x=linspace(-2,2,20);
y=linspace(-2,2,20);
z=linspace(-1,1,20);

[X,Y,Z]=meshgrid(x,y,z);

R0=1.7;
E0=1;

R=sqrt(X.*X+Y.*Y);
r=sqrt((R-R0).^2+Z.*Z);
c_phi=X./sqrt(X.*X+Y.*Y);
s_phi=Y./sqrt(X.*X+Y.*Y);


E_R=E0*(R-R0)./r;
E_phi=0;
E_Z=E0*Z./r;

Ex=E_R.*c_phi-E_phi.*s_phi;
Ey=E_R.*s_phi+E_phi.*c_phi;
Ez=E_Z;

quiver3(X,Y,Z,Ex,Ey,Ez);

y00=linspace(1.5,1.9,2);
z00=linspace(-0.2,0.2,2);

[startX,startY,startZ]=meshgrid(0,y00,z00);
verts=stream3(X,Y,Z,Ex,Ey,Ez,startX,startY,startZ);
streamline(verts);

xlabel('X');
ylabel('Y');
zlabel('Z');

axis equal;
