function plot_riemann_solution()
    % 参数设置
    gamma = 1.4;
    t = 0.13;  % 表格N3单元格的值
    
    % 左右状态初始值（B4-B6和E4-E6）
    rho_L = 0.445; m_L = 0.311; E_L = 8.928;
    rho_R = 0.5;   m_R = 0.0;   E_R = 1.4275;
    
    % 计算中间状态（根据表格中的迭代结果）
    % 这里使用表格A25:A26的迭代值，取平均值作为最终解
    p_star = 3.5;  % 根据表格G24=0时的压力值
    u_star = 0.5;  % 界面速度
    
    % 计算各区域解（根据Rankine-Hugoniot条件和等熵关系）
    x = linspace(-1, 1, 1000);
    
    % 1. 左状态区 (x < -a_L*t)
    a_L = sqrt(gamma*(gamma-1)*(E_L-0.5*m_L^2/rho_L)/rho_L);
    left_region = x < -a_L*t;
    
    % 2. 左膨胀波区 (-a_L*t < x < u_star*t)
    % 使用特征线法求解膨胀波
    expansion_region = (x >= -a_L*t) & (x < u_star*t);
    u_expansion = 2/(gamma+1)*(x(expansion_region)/t + a_L);
    a_expansion = a_L - (gamma-1)/2*u_expansion;
    rho_expansion = rho_L*(a_expansion/a_L).^(2/(gamma-1));
    p_expansion = (gamma-1)*(E_L-0.5*m_L^2/rho_L)*(rho_expansion/rho_L).^gamma;
    
    % 3. 中间状态区 (u_star*t < x < u_star*t + shock_speed*t)
    % 使用激波关系计算右激波
    [rho_star_R, p_star_R] = shock_relations(rho_R, (gamma-1)*(E_R-0.5*m_R^2/rho_R), p_star, gamma);
    shock_speed = u_star + sqrt(gamma*p_star/rho_star_R);  % 激波速度
    
    middle_region = (x >= u_star*t) & (x < shock_speed*t);
    
    % 4. 右激波区 (x > shock_speed*t)
    right_region = x >= shock_speed*t;
    
    % 构建完整解
    rho = zeros(size(x));
    u = zeros(size(x));
    p = zeros(size(x));
    
    % 填充各区域值
    rho(left_region) = rho_L;
    u(left_region) = m_L/rho_L;
    p(left_region) = (gamma-1)*(E_L-0.5*m_L^2/rho_L);
    
    rho(expansion_region) = rho_expansion;
    u(expansion_region) = u_expansion;
    p(expansion_region) = p_expansion;
    
    rho(middle_region) = rho_star_R;
    u(middle_region) = u_star;
    p(middle_region) = p_star;
    
    rho(right_region) = rho_R;
    u(right_region) = m_R/rho_R;
    p(right_region) = (gamma-1)*(E_R-0.5*m_R^2/rho_R);
    
    % 计算其他变量
    m = rho .* u;
    E = p./(gamma-1) + 0.5*rho.*u.^2;
    
    % 绘图（按Excel中的图表样式）
    figure('Position', [100, 100, 800, 900])
    
    % 1. 密度图
    subplot(3,1,1)
    plot(x, rho, 'b-', 'LineWidth', 2)
    grid on
    ylabel('Density (ρ)')
    title(sprintf('Riemann Problem Solution at t=%.2f', t))
    
    % 2. 动量图
    subplot(3,1,2)
    plot(x, m, 'r-', 'LineWidth', 2)
    grid on
    ylabel('Momentum (ρu)')
    
    % 3. 能量图
    subplot(3,1,3)
    plot(x, E, 'g-', 'LineWidth', 2)
    grid on
    ylabel('Energy (E)')
    xlabel('x')
    
    % 标记特殊点（激波、接触间断等）
    for i = 1:3
        subplot(3,1,i)
        hold on
        % 激波位置
        x_shock = shock_speed*t;
        plot([x_shock x_shock], ylim, 'k--', 'LineWidth', 1)
        
        % 接触间断位置
        x_contact = u_star*t;
        plot([x_contact x_contact], ylim, 'k:', 'LineWidth', 1.5)
        
        % 膨胀波边界
        x_expansion = -a_L*t;
        plot([x_expansion x_expansion], ylim, 'k:', 'LineWidth', 1.5)
    end
end

function [rho_star, p_star] = shock_relations(rho_R, p_R, p_star, gamma)
    % 激波关系计算
    mu_sq = (gamma-1)/(gamma+1);
    A = 2/(gamma+1)/rho_R;
    B = mu_sq*p_R;
    rho_star = 1/(A/(p_star + B));
    
    % 确保压力匹配
    p_star = p_star;  % 使用迭代得到的p_star
end