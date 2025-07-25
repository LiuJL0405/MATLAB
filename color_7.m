clear all

tList=linspace(0,2.*pi,300);
rList=linspace(1,2,100);
[theta,R]=meshgrid(tList,rList);

% 角度及半径转换为坐标
X=cos(theta).*R;
Y=sin(theta).*R;
Z=zeros(size(X));

% 构造hsv网格并转换为rgb网格
hsvMesh=cat(3,theta./2./pi,R,ones(size(R)));
rgbMesh=hsv2rgb(hsvMesh);

% surf绘图
surf(X,Y,Z,'EdgeColor','none','CData',rgbMesh)
axis equal;
axis off;
view(0,90);
