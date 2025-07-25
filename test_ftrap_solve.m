% Hua-sheng XIE, huashengxie@gmail.com, FSC-PKU, 2016-10-10 12:06
% Solve the local kinetic entropy mode dispersion relation
% Adaptive Simpson quadrature to calculate the 2D integral
% Rewrite from the 2016-04-27 18:20 version
% 16-10-11 09:52 change the output normalization, with R/vti not L_n/vti
% 16-10-11 14:20 this version fixed the possible bug at small k, by add
% the tolerace to 1e-6 to 1e-10 in fsolve()
% 16-10-14 16:03 compare z-pinch and dipole
% 16-10-16 16:14 with kpara

close all; clear; clc;
runtime=cputime;%记录当前 CPU 时间，用于后续计算代码运行时间

tol=1e-9;%积分容差
xmax=1.0e1; ymax=1.0e1; %  control the 2d integral accuracy 

tau=1.0;
epsn=0.2;
kapn=1/epsn; % R/L_n
kapt=0.1*kapn; % R/L_T
eta=kapt/kapn;

kz=0;
mi=1836.0; % mi/me

% kk=4.0:-0.2:0.2; x0=0.01+0.03i;
kk = 0.1:0.1:4.0;  % 波数范围 (kρ_i)，一般情况
x0 = 0.01 + 0.03i; % 初始猜测值（复数，含实部和虚部）
nk = length(kk);    % 波数点数

ftrapv=[0.01,0.3,0.7,0.95,1];%最多6个
% ftrapv=linspace(0,1,7);
% wdorbv=[-2,-1,0,1,2];
ln=length(ftrapv);
wk = zeros(ln,nk);
bm=0*kk;
wko = zeros(ln,nk);        % 预分配结果存储数组

%% 没有k||，测试ftrap
for fw=1:ln
    ftrap=ftrapv(fw);
    % wdorb=wdorbv(3);
    x0 = 0.01 + 0.03i;

    for jk = 1:nk

        k = kk(jk);
        wdi = k;          % 离子特征频率 (k*v_ti/R)
        wde = -wdi*tau;   % 电子特征频率
        ki = k;
        ke = -k*sqrt(tau/mi);  % 电子波数缩放
        kzi = kz;
        kze = kz*sqrt(tau*mi); % 电子平行波数缩放


        % 定义色散关系函数，一般情况
        % fdr = @(w) fun_entropy_dr(w,ki,wdi,kapn,kapt,kzi,tol,xmax,ymax) + ...
        %       (1/tau)*fun_entropy_dr(w,ke,wde,kapn,kapt,kze,tol,xmax,ymax)+...
        %       (1/tau)*test_dr(w,wde,kapn,kapt,tol,xmax,ymax,ftrap);
        fdr = @(w) fun_entropy_dr(w,ki,wdi,kapn,kapt,kzi,tol,xmax,ymax) + ...
            (1/tau)*(1-test_ftrap_dr(w,wde,kapn,kapt,tol,xmax,ymax,ftrap));

        % 调用 fsolve 求解
        % fun：函数句柄，定义方程组F(x)=0。
        % x0：初始猜测值（关键！影响收敛性和结果）。
        % options：优化选项（如算法选择、容忍度、显示输出等）
        options = optimset('Display','off');
        x = fsolve(fdr, x0, options);
        x0 = x;           % 更新初始猜测值
        wk(fw,jk) = x;       % 存储结果

    end
end

% %% 有k||，测试ftrap
% for fw=1:ln
%     ftrap=ftrapv(fw);
%     % wdorb=wdorbv(3);
%     x0 = 0.01 + 0.03i;
% 
%     for jk = 1:nk
% 
%         k = kk(jk);
%         wdi = k;          % 离子特征频率 (k*v_ti/R)
%         wde = -wdi*tau;   % 电子特征频率
%         ki = k;
%         ke = -k*sqrt(tau/mi);  % 电子波数缩放
%         % kzi = kz;
%         kzi = 0.9*ki;
%         kze = kz*sqrt(tau*mi); % 电子平行波数缩放
% 
% 
%         % 定义色散关系函数，一般情况
%         % fdr = @(w) fun_entropy_dr(w,ki,wdi,kapn,kapt,kzi,tol,xmax,ymax) + ...
%         %       (1/tau)*fun_entropy_dr(w,ke,wde,kapn,kapt,kze,tol,xmax,ymax)+...
%         %       (1/tau)*test_dr(w,wde,kapn,kapt,tol,xmax,ymax,ftrap);
%         fdr = @(w) fun_entropy_dr(w,ki,wdi,kapn,kapt,kzi,tol,xmax,ymax) + ...
%             (1/tau)*(1-test_ftrap_dr(w,wde,kapn,kapt,tol,xmax,ymax,ftrap));
% 
%         % 调用 fsolve 求解
%         % fun：函数句柄，定义方程组F(x)=0。
%         % x0：初始猜测值（关键！影响收敛性和结果）。
%         % options：优化选项（如算法选择、容忍度、显示输出等）
%         options = optimset('Display','off');
%         x = fsolve(fdr, x0, options);
%         x0 = x;           % 更新初始猜测值
%         wko(fw,jk) = x;       % 存储结果
% 
%     end
% end

%% 没有k||，谢的基准
x0 = 0.01 + 0.03i;
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
    options = optimset('Display','off');
    x = fsolve(fdr, x0, options);
    x0 = x;           % 更新初始猜测值
    bm(jk) = x;       % 存储结果
end

%%
% %过滤无效解
% ind = find(imag(wk) < 1e-4 | abs(real(wk)) > 10e0);
% wk(ind) = NaN + 1i*NaN;
% indo = find(imag(wko) < 1e-4 | abs(real(wko)) > 10e0);
% wk(indo) = NaN + 1i*NaN;

close all;

figure('unit','normalized','position',[0.2 0.2 0.6 0.4],...
       'DefaultAxesFontSize',15);

% 生成标题字符串
str = ['epsn=', num2str(epsn), ',eta=', num2str(eta), ...
       ',tau=', num2str(tau), ',k_z=', num2str(kz), ',nk=', num2str(nk)];
str2 = [',xmax=', num2str(xmax), ',ymax=', num2str(ymax), ',tol=', num2str(tol)];

colors=[1,0,0;
    1,0.5,0;
    0,1,0;
    0,1,1;
    0,0,1;];

bmr=[0.1277,0.2486, 0.3757, 0.5054,0.6369,0.7691,0.9019,1.0357,1.1715,1.3108,...
    1.4553,1.6067,1.7668,1.9370,2.1182,2.3098,2.5092,2.7118,2.9118,3.1047];

bmi=[2.8255,2.8210,2.7882,2.7346,2.6664,2.5893,2.5080,2.4262,2.3462,2.2696,2.1973,...
    2.1297,2.0674,2.0114,1.9633,1.9259,1.9020,1.8931,1.8985,1.9143];

% 绘制实部（频率）
subplot(121);
plot(kk,real(bm),'ko-','Linewidth', 2);
hold on
for fk=1:ln
    plot(kk, real(wk(fk,:)), 'o--', 'Linewidth', 1,'color',[colors(fk,:)]);
    hold on
    % plot(kk, real(wko(fk,:)), '*--', 'Linewidth', 1,'color',[colors(fk,:)]);
    % hold on
end
grid on
xlabel(['k\rho_i', str2]); ylabel('\omega_r R/v_{ti}');
xlim([0, max(kk)]);
title(['test f_{trap}', ',runtime=', num2str(runtime,4), 's']);

% 绘制虚部（增长/阻尼率）
subplot(122);
plot(kk,imag(bm),'ko-','Linewidth', 2);
hold on
for fk=1:ln
    plot(kk, imag(wk(fk,:)), 'o--', 'Linewidth', 1,'color',[colors(fk,:)]);
    hold on
    % plot(kk, imag(wko(fk,:)), '*--', 'Linewidth', 1,'color',[colors(fk,:)]);
    % hold on
end
grid on
xlim([0, max(kk)]);
xlabel('k\rho_i'); ylabel('\omega_i R/v_{ti}');
title(str);

dat = [kk.', wk.'];  % 最终数据
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 8 3.0]);

%print(gcf,'-dpng',['entropy_dr_',str,str2,'.png'],'-r100');
%print(gcf,'-dpdf',['entropy_dr_',str,str2,'.pdf'],'-r100');


