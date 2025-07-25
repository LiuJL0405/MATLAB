clear all

x=linspace(0,2e-2,100);
t=linspace(0,6,100);

A=2;
T=3;
lambda=5e-3;

m=moviein(100);

for i=1:100
    y1=A*cos(2*pi*(x/lambda-t(i)/T));
    y2=A*cos(2*pi*(x/lambda+t(i)/T));
    y=y1+y2;
    plot(x,y,'k-',x,y1,'b-',x,y2,'r-');
    axis([0,2e-2 -10,10]);
    grid on;
    
    m(:,i)=getframe;
end
movie(m,5,20) %m帧放5次每秒20帧
