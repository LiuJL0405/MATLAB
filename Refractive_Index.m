clear all

x=linspace(400,700,7);

y=[1.0003	1.3330	1.5170;
1.0003	1.3360	1.5200;
1.0003	1.3380	1.5250;
1.0003	1.3420	1.5280;
1.0003	1.3440	1.5320;
1.0004	1.3490	1.5360;
1.0004	1.3540	1.5440];


plot(x,y(:,1),'kv-');
hold on;

plot(x,y(:,2),'ro-');
hold on;

plot(x,y(:,3),'b^-');
hold on;


axis([350,750 0.9,1.9]);

xlabel('Wavelength (nm)');
ylabel('Refractive Index');

