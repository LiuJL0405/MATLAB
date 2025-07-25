clear all

n=[1.333,1.336,1.338,1.342,1.344,1.349,1.354];

colors=[1,0,0;
    1,0.5,0;
    1,1,0;
    0,1,0;
    0,1,1;
    0,0.5,1;
    0,0,1;];

subplot(1,2,1);

x1=linspace(0,pi/2,100);
y1=zeros(1,7);

for i=1:7

y1=-2*x1+4*asin(sin(x1)./n(1,i));%虹的曲线

plot(x1,y1,"Color",[colors(i,:)]);
hold on;

end

title('(a)');
xlabel('Incident Angle (rad)');
ylabel('Observation Angle of Rainbow (rad)');


subplot(1,2,2);

x3=linspace(0,pi/2,100);

for i=1:7

y3=pi+2*x3-6*asin(sin(x3)./n(1,i));%霓的曲线

plot(x3,y3,"Color",[colors(i,:)]);
hold on;

end

title('(b)');
xlabel('Incident Angle (rad)');
ylabel('Observation Angle of Secondary Rainbow (rad)');

