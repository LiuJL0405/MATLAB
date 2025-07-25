clear all

x0=0.6;
u=[2,3.2,3.45,3.6];
x=zeros(4,30);
x(:,1)=[x0,x0,x0,x0];

for i=1:4
  for n=2:30
     x(i,n)=u(1,i)*x(i,n-1)*(1-x(i,n-1));
  end
end

subplot(2,2,1);
plot(x(1,:),'o-')
title('\mu=2');
grid on;

subplot(2,2,2);
plot(x(2,:),'o-')
title('\mu=3.2');
grid on;

subplot(2,2,3);
plot(x(3,:),'o-')
title('\mu=3.45');
grid on;

subplot(2,2,4);
plot(x(4,:),'o-')
title('\mu=3.6');
grid on;