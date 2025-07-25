clear all

x0=linspace(-pi,pi,200);

n=-1:1;
N=length(n);

subplot(211)
for i=1:N

    x=x0-2*pi*n(i);
    fb1=cos(5*x).*exp(-x.^2);
    plot(x/pi,fb1,'r-','LineWidth',1);
    hold on;
    
    fb2=sin(5*x).*exp(-x.^2);
    plot(x/pi,fb2,'b--','LineWidth',1);
    hold on;
end
 
grid on
xlabel('Ballooning Angle \theta_b/\pi');
ylabel('\phi');
title('(a)');

subplot(212)

fp1=0;
fp2=0;

for i=1:N

    x=x0-2*pi*n(i);
    fp1=fp1+cos(5*x).*exp(-x.^2);
    fp2=fp2+sin(5*x).*exp(-x.^2);

end

plot(x0/pi,fp1,'r-','LineWidth',1);
hold on;
plot(x0/pi,fp2,'b--','LineWidth',1);
hold on;
% plot(x0/pi,cos(5*x0).*exp(-x0.^2),'ro');
% grid on
% plot(x0/pi,sin(5*x0).*exp(-x0.^2),'bo');
grid on

xlabel('Poloidal Angle \theta_p/\pi');
ylabel('\phi');
title('(b)');