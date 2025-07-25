clear all

kapa=linspace(0.01,0.99,100);
n=length(kapa);

% s=linspace(-3,3,n);
% alpha=linspace(0.3,3,n);
tol=1e-10;
K = zeros(1,n); % 初始化存储积分结果的数组
E = zeros(1,n);
for i = 1:n
    current_kapa = kapa(i).^2;
    integrandK = @(theta) 1./sqrt(1-current_kapa.*(sin(theta)).^2);
    integrandE = @(theta) sqrt(1-current_kapa.*(sin(theta)).^2);

    K(i) = integral(integrandK, 0, pi/2, 'AbsTol', tol, 'RelTol', tol);
    E(i) = integral(integrandE, 0, pi/2, 'AbsTol', tol, 'RelTol', tol);
end

G0=2*E./K-1;
Gs=4*(E./K+kapa.^2-1);
Ga=4/3*((1-2*kapa.^2).*E./K+kapa.^2-1);

w=1;
s=-0.25;
alpha=2.5;
omega0=w*(G0+s*Gs+alpha*Ga);
plot(kapa,omega0,'r-');
hold on

s=-0.25;
alpha=0.3;
omega0=w*(G0+s*Gs+alpha*Ga);
plot(kapa,omega0,'b-');
hold on

s=0.25;
alpha=0.3;
omega0=w*(G0+s*Gs+alpha*Ga);
plot(kapa,omega0,'g-');

grid on;