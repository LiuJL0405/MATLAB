clc;
clear;
close all;

%% 参数设置
R0 = 3.0;       % 托卡马克主半径 [m]
a = 1.0;        % 等离子体小半径 [m]
mu0 = 4e-7*pi;  % 真空磁导率
Nr = 100;       % 径向网格数
Ntheta = 100;   % 极向角网格数
max_iter = 100; % 最大迭代次数
tolerance = 1e-4; % 收敛容差

% 径向网格 (r从0到a)
r = linspace(0, a, Nr);
dr = r(2) - r(1);

% 定义κ(r)和δ(r)的函数（示例：抛物线分布）
kappa = @(r) 1.6 + 0.4*(r/a).^2;     % 拉长比随半径增加
delta = @(r) 0.3*(r/a);              % 三角率随半径线性增加

% 初始化流函数ψ（假设初始猜测为抛物线分布）
psi_max = 1.0;  % 显式定义 psi_max
psi = psi_max*(1 - (r/a).^2);  % 初始猜测

% 压力分布 p(ψ) 和 F(ψ)=R*Bφ(ψ)/u0（假设为抛物线分布）
p0 = 1e4;       % 中心压力 [Pa]
F0 = 0.5;       % 环向磁场参数
p_func = @(psi) p0*(1 - (psi/psi_max).^2);
F_func = @(psi) F0*sqrt(1 - (psi/psi_max).^2)/mu0;

%% 迭代求解Grad-Shafranov方程（Picard迭代）
for iter = 1:max_iter
    psi_old = psi;
    
    % 构造差分方程矩阵（一维径向简化）
    A = zeros(Nr, Nr);
    R = R0 + r;  % 近似环向坐标
    
    for i = 2:Nr-1
        % 径向二阶导数项 (Δ*ψ)
        A(i, i-1) = 1/dr^2 - 1/(2*dr*r(i));
        A(i, i)   = -2/dr^2;
        A(i, i+1) = 1/dr^2 + 1/(2*dr*r(i));
        
        % 右端项：-μ0*R²*dp/dψ - F*dF/dψ
        dp_dpsi = -2*p0/psi_max^2 * psi(i);
        dF_dpsi = -F0^2/psi_max^2 * psi(i);
        rhs = -mu0*R(i)^2*dp_dpsi - mu0^2*F_func(psi(i))*dF_dpsi;
        
        A(i, i) = A(i, i) - rhs/(psi(i) + eps);  % 避免除以零
    end
    
    % 边界条件
    % 1. 中心 r=0: dψ/dr=0 (对称性)
    A(1, 1) = -3/(2*dr);
    A(1, 2) = 4/(2*dr);
    A(1, 3) = -1/(2*dr);
    
    % 2. 边界 r=a: ψ=0
    A(Nr, Nr) = 1;
    
    % 求解线性方程组
    psi = A \ zeros(Nr, 1);
    
    % 收敛判断
    if max(abs(psi - psi_old)) < tolerance
        break;
    end
end

%% 计算Shafranov位移Δ(r)
% Δ(r) = (1/R0) * ∫[0到r] (β_p(r') + μ0*p(r')/Bθ²(r')) * r' dr'
B_theta = F_func(psi)./R0;  % 极向磁场Bθ ≈ F(ψ)/R0
beta_p = 2*mu0*p_func(psi)./(B_theta.^2);
integrand = -(beta_p + mu0*p_func(psi)./(B_theta.^2)) .* r';
Delta = cumtrapz(r, integrand)/R0;

% 确保Δ(a)=0（通过归一化修正）
Delta = Delta - Delta(end);

%% 绘制D形磁面（代码同之前，确保变量已正确定义）
theta = linspace(0, 2*pi, Ntheta);
r_mag_surfaces = linspace(0, a, 10); % 选择10个磁面

figure (1);
hold on;
for i = 1:length(r_mag_surfaces)
    r_i = r_mag_surfaces(i);
    [~, idx] = min(abs(r - r_i));
    
    % 当前半径的κ和δ
    kappa_i = kappa(r_i);
    delta_i = delta(r_i);
    
    % 磁面坐标（考虑Δ(r)、κ(r)、δ(r)）
    R = R0 +( Delta(idx)) + r_i*cos(theta + delta_i*sin(theta));
    Z = kappa_i * r_i * sin(theta);
    
    plot(R, Z, 'LineWidth', 1.5, ...
        'DisplayName', sprintf('r=%.2f,  κ=%.2f, δ=%.2f', r_i, kappa_i, delta_i));
end

hold on;
 % 磁面坐标（考虑Δ(r)、κ(r)、δ(r)）
    R = R0 + a*cos(theta + 0.3*sin(theta));
    Z = 2 * a * sin(theta);
    
    plot(R, Z, 'k.')

% 图形美化
axis equal;
xlabel('R [m]');
ylabel('Z [m]');
%title('Equilibrim magnetic surface (include κ(r) and δ(r))');
title('Equilibrim magnetic surface');
legend('Location', 'northeastoutside');
grid on;
plot(R0, 0, 'ro', 'MarkerSize', 3, 'MarkerFaceColor', 'r');
%text(R0+0.1, 0.1, 'Magnetic axis', 'Color', 'r');

figure (2);
hold on;

    plot(r, Delta, 'r.');

% 图形美化
%axis equal;
xlabel('r [m]');
ylabel('\Delta [m]');
title('Shafranov shift profile');
grid on;

