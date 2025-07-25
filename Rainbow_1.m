clear all

n=7;

%angle1=[0.7344,0.7268,0.7218,0.7119,0.7069,0.6947,0.6828];%虹
%a=10*sin(angle1);

%angle1=[0.7867,0.7797,0.7751,0.7659,0.7614,0.7503,0.7392];%e=0.25的椭球虹
%a=10*sin(angle1);

angle1=[0.8349,0.8285,0.8243,0.8160,0.8119,0.8016,0.7916];%e=0.35的椭球虹
a=10*sin(angle1);

%angle1=[0.9318,0.9268,0.9234,0.9168,0.9136,0.9054,0.8974];%e=0.5的椭球虹
%a=10*sin(angle1);



%angle2=[0.8882,0.9019,0.9109,0.9289,0.9378,0.9599,0.9817];%霓
%b=10*sin(angle2);

%angle2=[0.8878,0.9026,0.9125,0.9320,0.9416,0.9655,0.9891];%e=0.25的椭球霓
%b=10*sin(angle2);

angle2=[ 0.8914,0.9082,0.9193,0.9413,0.9521,0.9790,1.0054];%e=0.35的椭球霓
b=10*sin(angle2);

%angle2=[0.9160,0.9430,0.9609,0.9965,1.0141,1.0571,1.0986];%e=0.5的椭球霓
%b=10*sin(angle2);

xita=0:0.01:3*pi;%环形

x1=zeros(n,length(xita));
y1=zeros(n,length(xita));%虹

x2=zeros(n,length(xita));
y2=zeros(n,length(xita));%霓

colors=[1,0,0;
    1,0.5,0;
    1,1,0;
    0,1,0;
    0,1,1;
    0,0.5,1;
    0,0,1;];

for i=1:n

 
    x1(i,:)=a(n+1-i)*cos(xita);
    y1(i,:)=a(n+1-i)*sin(xita);

    x2(i,:)=b(i)*cos(xita);
    y2(i,:)=b(i)*sin(xita);

    plot(x1(i,:),y1(i,:),'LineWidth',1.5,'color',[colors(8-i,:)]);%虹
    hold on

    plot(x2(i,:),y2(i,:),'LineWidth',0.5,'color',[colors(i,:)]);%霓
    hold on

end

plot(0,0,'ko');
hold on

axis equal;

