function F = xiangtu_hanshu( t,vec )
y(1)=vec(1);
y(2)=vec(2);
 
w=2;
u=-0.5;
x0=1;
w0=1;
V=0;

F=[y(2);
    u*(x0^2-y(1)^2)*y(2)-w0^2*y(1)-V*cos(w*t)];%范德瓦尔方程
end