% Hua-sheng XIE, huashengxie@gmail.com, FSC-PKU, 2016-10-10 12:06
% Solve the local kinetic entropy mode dispersion relation
% Adaptive Simpson quadrature to calculate the 2D integral
% Rewrite from the 2016-04-27 18:20 version
% 16-10-11 09:52 change the output normalization, with R/vti not L_n/vti
% 16-10-11 14:20 this version fixed the possible bug at small k, by add
% the tolerace to 1e-6 to 1e-10 in fsolve()
% 16-10-14 16:03 compare z-pinch and dipole
% 16-10-16 16:14 with kpara
% 25-7-11 9:19 add the approximation of adiabatic electrons

close all; clear; clc;
runtime=cputime;%记录当前 CPU 时间，用于后续计算代码运行时间

tol=1e-6;%积分容差
xmax=1.0e1; ymax=1.0e1; %  control the 2d integral accuracy 

tau=1.0;
epsn=0.2;
kapn=1/epsn; % R/L_n
kapt=0.1*kapn; % R/L_T
eta=kapt/kapn;

kz=0.0;
mi=1836.0; % mi/me

% kk=4.0:-0.2:0.2; x0=0.01+0.03i;
kk = 0.1:0.1:2.0;  % 波数范围 (kρ_i)，一般情况
% kk = 0.01:0.01:0.1;  % 波数范围 (kρ_i)，绝热电子近似
x0 = 0.01 + 0.03i; % 初始猜测值（复数，含实部和虚部）
wk = 0.*kk;        % 预分配结果存储数组
nk = length(kk);    % 波数点数

for jk = 1:nk
    k = kk(jk);
    wdi = k;          % 离子特征频率 (k*v_ti/R)
    wde = -wdi*tau;   % 电子特征频率
    ki = k;
    ke = -k*sqrt(tau/mi);  % 电子波数缩放
    kzi = kz;
    kze = kz*sqrt(tau*mi); % 电子平行波数缩放
    
    % 定义色散关系函数，一般情况
    fdr = @(w) fun_entropy_dr(w,ki,wdi,kapn,kapt,kzi,tol,xmax,ymax) + ...
              (1/tau)*fun_entropy_dr(w,ke,wde,kapn,kapt,kze,tol,xmax,ymax);

    % 定义色散关系函数,绝热电子，暂时解决不了
    % fdr = @(w) fun_entropy_dr(w,ki,wdi,kapn,kapt,kzi,tol,xmax,ymax) + (1/tau);

    % 调用 fsolve 求解
    % fun：函数句柄，定义方程组F(x)=0。 
    % x0：初始猜测值（关键！影响收敛性和结果）。
    % options：优化选项（如算法选择、容忍度、显示输出等）
    options = optimset('Display','off');
    x = fsolve(fdr, x0, options);
    x0 = x;           % 更新初始猜测值
    wk(jk) = x;       % 存储结果
end
runtime = cputime - runtime;  % 计算总运行时间
dat0 = [kk.', wk.'];         % 合并波数和频率结果
dat=dat0(1:2:end,:);

%过滤无效解
ind = find(imag(wk) < 1e-4 | abs(real(wk)) > 10e0);
wk(ind) = NaN + 1i*NaN;

close all;

figure('unit','normalized','position',[0.01 0.1 0.6 0.7],...
       'DefaultAxesFontSize',15);

% 生成标题字符串
str = ['epsn=', num2str(epsn), ',eta=', num2str(eta), ...
       ',tau=', num2str(tau), ',k_z=', num2str(kz), ',nk=', num2str(nk)];
str2 = [',xmax=', num2str(xmax), ',ymax=', num2str(ymax), ',tol=', num2str(tol)];

% 绘制实部（频率）
subplot(221);
plot(kk, real(wk), 'ro--', 'Linewidth', 2);
xlabel(['k\rho_i', str2]); ylabel('\omega_r R/v_{ti}');
xlim([0, max(kk)]);
title(['entropy mode', ',runtime=', num2str(runtime,4), 's']);

% 绘制虚部（增长/阻尼率）
subplot(222);
plot(kk, imag(wk), 'bo--', 'Linewidth', 2);
xlim([0, max(kk)]);
xlabel('k\rho_i'); ylabel('\omega_i R/v_{ti}');
title(str);

% 绘制实部（频率）
subplot(223);
plot(kk, real(wk), 'ro--', 'Linewidth', 2);
xlabel(['k\rho_i', str2]); ylabel('\omega_r R/v_{ti}');
xlim([0, max(kk)]);
title(['entropy mode', ',runtime=', num2str(runtime,4), 's']);

% 绘制gama/kyps
subplot(224);
plot(kk, imag(wk)./kk, 'bo--', 'Linewidth', 2);
xlim([0, max(kk)]);
xlabel('k\rho_i'); ylabel('\omega_i/k\rho_i');
title(str);

dat = [kk.', wk.'];  % 最终数据
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 8 3.0]);

%print(gcf,'-dpng',['entropy_dr_',str,str2,'.png'],'-r100');
%print(gcf,'-dpdf',['entropy_dr_',str,str2,'.pdf'],'-r100');


