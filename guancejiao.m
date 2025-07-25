clear all

n=[1.333,1.336,1.338,1.342,1.344,1.349,1.354];

colors=[1,0,0;
    1,0.5,0;
    1,1,0;
    0,1,0;
    0,1,1;
    0,0.5,1;
    0,0,1;];

figure(1)

x=linspace(0,pi/2,100);
y=zeros(1,7);

for i=1:7

y=-2*x+4*asin(sin(x)./n(1,i));%虹的曲线
%y=pi+2*x-6*asin(sin(x)./n(1,i));%霓的曲线

plot(x,y,"Color",[colors(i,:)]);
hold on;

end

xlabel('Incident Angle (rad)');
ylabel('Observation Angle of Rainbow (rad)');
%ylabel('Observation Angle of Secondary Rainbow (rad)');


figure(2)%部分放大

xx=linspace(0.8,1.2,100);%虹
%xx=linspace(1,1.5,100);%霓
yy=zeros(1,7);

for i=1:7

yy=-2*xx+4*asin(sin(xx)./n(1,i));%虹的曲线
%yy=pi+2*xx-6*asin(sin(xx)./n(1,i));%霓的曲线

plot(xx,yy,'LineWidth',2,"Color",[colors(i,:)]);
hold on;

end

xlabel('Incident Angle (rad)');
ylabel('Observation Angle of Rainbow (rad)');
%ylabel('Observation Angle of Secondary Rainbow (rad)');

