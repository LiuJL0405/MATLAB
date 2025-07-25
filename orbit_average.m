clear all

w=5;
t0=linspace(0,4*pi/w,200);
% x0=linspace(-3,3,200);
v0=linspace(-3,3,500);

[t,v]=meshgrid(t0,v0);


subplot(2,2,1);
f=exp(sin(w*t+0.5*pi)).*cos(5*v).*exp(-v.*v);
mesh(t,v,f);
xlabel('$ t $', 'Interpreter', 'latex');
ylabel('$ v $', 'Interpreter', 'latex');
zlabel('$\phi$', 'Interpreter', 'latex');
axis equal; 
grid on;
title('$\phi(t,v)$', 'Interpreter', 'latex');

subplot(2,2,2);
contourf(v,t,f,30,'LineStyle','none'); colorbar;
xlabel('$ v $', 'Interpreter', 'latex');
ylabel('$ t $', 'Interpreter', 'latex');
axis equal; 
title('$\phi$ distribution in $(t,v)$ area', 'Interpreter', 'latex');

subplot(2,2,3);

colors=[1,0,0;
    1,0.5,0;
    0,1,0;
    0,1,1;
    0,0,1;];

line=3;
tt=linspace(0,pi/w,line);
for i=1:line
    ft=exp(sin(w*tt(i)+0.5*pi)).*cos(5*v0).*exp(-v0.*v0);
    plot(v0,ft,'color',[colors(i,:)]);
    hold on;
end

xlabel('$ v $', 'Interpreter', 'latex');
ylabel('$ \phi $', 'Interpreter', 'latex');
axis equal; 
grid on;
title('$\phi(v)$ in different $t$', 'Interpreter', 'latex');



subplot(2,2,4);
tol=1e-10;
fbar = zeros(size(v0)); % 初始化存储积分结果的数组

% 对每个v值计算积分
for i = 1:length(v0)
    current_v = v0(i);
    integrand = @(t) exp(sin(w*t+0.5*pi)) * cos(5*current_v) * exp(-current_v^2);
    fbar(i) = (1/max(t0)) * integral(integrand, 0, max(t0), 'AbsTol', tol, 'RelTol', tol);
end

plot(v,fbar,'ro');
xlabel('$ v $', 'Interpreter', 'latex');
ylabel('$ \phi $', 'Interpreter', 'latex');
grid on;
title('$\langle \phi(v) \rangle _{\mathrm{orbit}}$', 'Interpreter', 'latex');
