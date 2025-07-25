clear all

x=-16:0.1:16;
y=zeros(25,321);

for i=0:3

y(i+1,:)=besselj(i,x);

subplot(2,2,i+1);

plot(x,y(i+1,:),'color',[0,1,1]);
hold on;

xlabel('x');
ylabel('y');

grid on;

end