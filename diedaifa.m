clear all

x0=1.5;
x(1)=x0;

for n=2:100
    x(n)=(x(n-1)+1)^(1/3);%迭代方程
    a=abs(x(n)-x(n-1));
    
    if a<=1.0e-8 %精度控制
        break;
    end
end
x
plot(x,'o-')
