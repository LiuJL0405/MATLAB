clear all

n=75;
a=linspace(6,7,n);

xita=0:0.01:3*pi;

x=zeros(n,length(xita));
y=zeros(n,length(xita));

colors=zeros(n,3);
hsvc=zeros(256,3);

hsvc=hsv;
colors=[hsvc(21:60,:);hsvc(106:140,:)];

for i=1:n

    x(i,:)=a(i)*cos(xita);
    y(i,:)=a(i)*sin(xita);

    plot(x(i,:),y(i,:),'LineWidth',3,'color',[colors(n+1-i,:)]);
hold on

end

plot(0,0,'ko');
hold on

axis equal;

