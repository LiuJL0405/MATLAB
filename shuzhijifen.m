clear all

F = 1; 
rho_eff = 0.5;
z_values=-0.5:0.01:0.5;
 
V_eff=zeros(1,length(z_values));
 
for j = 1:length(z_values)
   integrand = @(q) besselj(0,q*rho_eff^4*F).*exp(-rho_eff^2*q.^2/4 - q*abs(z_values(1,j)));
   V_eff(j) = 2*integral(integrand,0,Inf); 
end

plot(z_values,V_eff,'-','color',[0,1,1],'linewidth',2)
xlabel('z');
ylabel('V_{eff}');
title('V_{eff}-z曲线');

axis equal;
grid on;
