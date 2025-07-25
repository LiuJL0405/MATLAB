clear all

R0=6.2;
a=2;

r=linspace(0,a,7);
theta=linspace(0,2*pi,100);

kappa = 1.6 + 0.4*(r/a).^2;     % 拉长比
delta =0.3*(r/a).^1.5;         % 三角率
Delta=-0.85*r+5.27*log(1+r/6.2);
q=0.7+3*(r/a).^2;

subplot(2,2,1);
for i=1:7

R = R0 +Delta(i)+r(i).*cos(theta );
    Z = r(i) * sin(theta);
    
    plot(R, Z,'b-') ;

    axis equal;
    hold on;

    plot(R0, 0,'k*') ;

    grid on;

end
    xlabel('R/m');
    ylabel('Z/m');
title('Circular cross-section');

subplot(2,2,2);
for i=1:7

R = R0 +Delta(i)+r(i).*cos(theta + delta(i)*sin(theta));
    Z = kappa(i) * r(i) * sin(theta);
    
    plot(R, Z,'b-') ;

  axis equal;
    hold on;

    plot(R0, 0,'k*') ;

    grid on;

end
    xlabel('R/m');
    ylabel('Z/m');
title('D-shaped cross-section')


subplot(2,2,3);
plot(r/a, q,'r*-') ;
    hold on;

    grid on;
    xlabel('\rho');
    ylabel('q');
    title('Safety factor');


subplot(2,2,4);

plot(r/a, Delta,'ro-') ;

    hold on;

    grid on;

    xlabel('\rho');
    ylabel('\Delta/m');
    title('Shafranov shift');

