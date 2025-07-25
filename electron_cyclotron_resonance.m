clear all

w=0.5;
R0=0.1;
a=3;

t=linspace(0,a*2*pi/w,500);

X=R0*max(t);

n=length(t);
m=moviein(n);

for i=1:n
    
    R(i)=R0*t(i);

    x(i)=R(i)*cos(w*t(i));
    y(i)=R(i)*sin(w*t(i));


    plot(x(i),y(i),'r.');
    hold on;
    plot(X,-X);
    hold on;
    plot(-X,-X);
    hold on;
    
    axis([-X,X -X,X]);

    axis equal;
    grid on;
    
    m(:,i)=getframe;

end

movie(m,1,length(t)/2) %m帧播放1次，每秒length(t)/2帧

