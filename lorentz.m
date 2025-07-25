function F = lorentz( t,vec )
x=vec(1);
y=vec(2);
z=vec(3);
 
sigma=10;
b=8/3;
r=24.74;%参数

F=[sigma*(y-x);
    r*x-y-x*z;
    x*y-b*z];%Lorentz方程
end