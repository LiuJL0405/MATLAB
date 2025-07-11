% Hua-sheng XIE, huashengxie@gmail.com, FSC-ZJU, 2016-04-29 17:30
% matrix to solve local kinetic ITG dispersion relation
% lambda*[g_ij(v_par,v_perp),phi]=M_ij*[g_ij(v_par,v_perp),phi]
% Benchmark with Kim1994PoP Fig.5
% 16-05-10 09:21 Fix bug of F0
% 16-10-17 13:02 rewrite for entropy mode
% 17-01-13 10:51 tau\neq1.0, bug on phi=sum(gi+ge) should be sum(gi+ge/tau),
% 11:36 fixed, test tau=2.0 agree with IVP & DR
close all;clear;%clc;

data =[0.1,     0.1277+2.8258i;
       0.2,     0.2487+2.8211i;
       0.5,     0.6369+2.6664i;
       1.0,     1.3108+2.2697i;
       1.5,     2.1182+1.9633i;
       2.0,     3.1047+1.9143i];
id=4;
ky=data(id,1); % k_perp
wr=real(data(id,2)); wi=imag(data(id,2));

runtime=cputime;

tau=1.0;
epsn=0.2;
kapn=1/epsn; % R/L_n
kapt=0.1*kapn; % R/L_T
eta=kapt/kapn;

kz=0.0; % k_z*R
mi=1836.0; % mi/me

wdi=ky; % *v_ti/R
wde=-wdi*tau;
ki=ky;
ke=-ky*sqrt(tau/mi);
kzi=kz;
kze=kz*sqrt(tau*mi);
Gamma0i=besseli(0,ki^2,1);
Gamma0e=besseli(0,ke^2,1);
G0coef=1.0/((1.0-Gamma0i)+(1.0-Gamma0e)/tau)/sqrt(2.0*pi);

nvx=1*64/1; nvy=1*64/1;
vxmax=5.0; vxmin=-vxmax; vymax=5.0; vymin=0.0;
% vxmax=6.0; vxmin=-vxmax; vymax=6.0; vymin=0.0;
% vxmax=10.0; vxmin=-vxmax; vymax=10.0; vymin=0.0;

dvx=(vxmax-vxmin)/nvx; dvy=(vymax-vymin)/nvy;

Vx=vxmin:dvx:vxmax; Vy=vymin:dvy:vymax; 
[vx,vy]=meshgrid(Vx,Vy); % vx and vy grids

wDiv=wdi*(vx.^2+vy.^2/2);
wTiv=wdi*(kapn+(0.5*(vx.^2+vy.^2)-1.5)*kapt);
wDev=wde*(vx.^2+vy.^2/2);
wTev=wde*(kapn+(0.5*(vx.^2+vy.^2)-1.5)*kapt);

F0=exp(-0.5*(vx.^2+vy.^2)); % initial distribution

%获取速度空间网格尺寸，初始化稀疏矩阵的索引和值数组
[Nx,Ny]=size(vx);
Nda=Nx*Ny;
Nd=2*Nx*Ny+1; II=[]; JJ=[]; SS=[];
cout=0;

%构造稀疏矩阵
% [离子部分       0       耦合列 ]
% [  0       电子部分     耦合列 ]
% [耦合行     耦合行         0   ]
for jx=1:Nx
    for jy=1:Ny
        
        % for ion
        ind=(jx-1)*Ny+jy; 
        
        cout=cout+1;
        II(cout)=ind; JJ(cout)=ind;
        SS(cout)=(kzi*vx(jx,jy)+wDiv(jx,jy));
        
        cout=cout+1;
        II(cout)=ind; JJ(cout)=Nd;
        SS(cout)=((kzi*vx(jx,jy)+wDiv(jx,jy)-wTiv(jx,jy))*(...
            besselj(0,ki*vy(jx,jy)))^2*F0(jx,jy));
        
        cout=cout+1;
        II(cout)=Nd; JJ(cout)=ind;
        SS(cout)=G0coef*(kzi*vx(jx,jy)+wDiv(jx,jy))*vy(jx,jy)*dvx*dvy;
        
        % for electron
        ind=ind+Nda; 
        
        cout=cout+1;
        II(cout)=ind; JJ(cout)=ind;
        SS(cout)=(kze*vx(jx,jy)+wDev(jx,jy));
        
        cout=cout+1;
        II(cout)=ind; JJ(cout)=Nd;
        SS(cout)=((kze*vx(jx,jy)+wDev(jx,jy)-wTev(jx,jy))*(...
            besselj(0,ke*vy(jx,jy)))^2*F0(jx,jy));
        
        cout=cout+1;
        II(cout)=Nd; JJ(cout)=ind;
        SS(cout)=G0coef/tau*(kze*vx(jx,jy)+wDev(jx,jy))*vy(jx,jy)*dvx*dvy; % 17-01-13 11:29 fixed bug on tau
        
    end
end

cout=cout+1;
II(cout)=Nd; JJ(cout)=Nd;
SS(cout)=G0coef*sum(sum(((kzi*vx+wDiv-wTiv).*(...
        besselj(0,ki.*vy)).^2+(kze*vx+wDev-wTev).*(...
        besselj(0,ke.*vy)).^2/tau).*F0.*vy))*dvx*dvy; % 17-01-13 10:52 fixed bug on tau
%上面是在添加矩阵的最后一个元素

%构建稀疏矩阵M
M=sparse(II,JJ,SS,Nd,Nd);
% wg=1.2 + 2.3i; % k=0.9
wg=wr+1i*wi;%使用初始猜测wg求解特征值问题

%根据问题规模选择使用eig小规模或eigs大规模
if (nvx*nvy<1000)
    d=eig(full(M));
else
    d=eigs(M,1,wg);
end
% d=eigs(M,1,'li');
runtime=cputime-runtime;%记录用时

[di,ind]=sort(imag(d),'descend');%对特征值按虚部降序排序
d=d(ind);
% d(1:5) % find(imag(d)>0)

[V,D]=eigs(M,1,d(1));
% d = eigs(A)                % 返回矩阵 A 的 6 个最大模特征值
% d = eigs(A,k)              % 返回 k 个最大模特征值
% d = eigs(A,k,sigma)        % 返回最接近 sigma 的 k 个特征值
% [V,D] = eigs(A,...)        % 同时返回特征向量 V 和特征值对角矩阵 D
% [V,D,flag] = eigs(A,...)   % flag 指示计算是否收敛
w=D(1,1);
X=V(:,1);%提取最主要的特征值和特征向量
% 不稳定模（Im(ω)>0）：少数几个，对应物理不稳定性。
% 衰减模（Im(ω)<0）：大量存在，对应朗道阻尼等耗散过程。
% 纯实模（Im(ω)=0）：如连续谱模式。
% 排序后选择d(1)，本质是筛选最不稳定的主导模式。

% 从特征向量中提取离子和电子的分布函数，分布函数扰动δf(v∥,v⊥)本质是二维速度空间的函数，需转换为矩阵形式才能绘制等高线图
gi = reshape(V(1:Nda), Ny, Nx);  % 提取离子扰动并重构为Ny×Nx矩阵
ge = reshape(V((Nda+1):(Nd-1)), Ny, Nx);  % 提取电子扰动
gi = gi.'; ge = ge.';  % 转置矩阵，MATLAB的reshape按列优先顺序填充数据，因此需要后续转置

%绘图
close all;
h = figure('Unit','Normalized','position',...
    [0.01 0.10 0.9 0.6],'DefaultAxesFontSize',15);
% h = figure(...)
% 创建一个新的图形窗口，并返回其句柄（handle）赋值给变量h
% 这个句柄可以用于后续对该图形窗口的操作和控制
% 'Unit','Normalized'
% 设置图形窗口的位置和大小的单位为"归一化"单位
% 归一化单位意味着所有尺寸和位置值都在0到1之间，相对于屏幕尺寸 
% [0,0]表示屏幕左下角，[1,1]表示屏幕右上角
% 'position',[0.01 0.13 0.6 0.65]
% 设置图形窗口的位置和大小
% 参数格式为[left, bottom, width, height] 
% 具体解释：
% 0.01：窗口左边缘距离屏幕左边缘1%的屏幕宽度 
% 0.13：窗口下边缘距离屏幕底部13%的屏幕高度 
% 0.6：窗口宽度为屏幕宽度的60% 
% 0.65：窗口高度为屏幕高度的65%
% 'DefaultAxesFontSize',15
% 设置图形中所有坐标轴的默认字体大小为15磅
% 这将影响坐标轴标签、刻度标签等的字体大小

subplot(231);
plot(real(d),imag(d),'x',real(w),imag(w),'rs','Linewidth',2);
xlabel('\omega_r'); ylabel('\omega_i');
title(['(a) k_{||}=',num2str(kz),', k_\perp=',num2str(ky),...
    ', \epsilon_n=',num2str(epsn),', \eta=',num2str(eta),...
    ', \tau=',num2str(tau)]);%num2str函数将数值转换为字符串

subplot(232);
% pcolor(vx,vy,real(ge)); shading interp; %log(abs(real(g)))
contourf(vx,vy,real(ge),30,'LineStyle','none'); colorbar;
axis equal;
xlabel('v_{||}'); ylabel('v_\perp'); 
title(['(b) Re g_e, \omega=',num2str(w,4)]);
xlabel(['\omega^T=',num2str(wr+1i*wi,4)]);

subplot(233);
% pcolor(vx,vy,real(g)); shading interp; %log(abs(real(g)))
contourf(vx,vy,real(gi),30,'LineStyle','none'); colorbar;
axis equal;
xlabel(['v_{||}, runtime=',num2str(runtime),'s']); ylabel('v_\perp'); 
title(['(c) Re g_i, nvx=',num2str(nvx),', nvy=',num2str(nvy)]);
subplot(235);
% pcolor(vx,vy,imag(g)); shading interp;
contourf(vx,vy,imag(ge),30,'LineStyle','none'); colorbar;
axis equal;
xlabel('v_{||}'); ylabel('v_\perp'); 
title(['(d) Im g_e, vxmax=',num2str(vxmax),', vymax=',num2str(vymax)]);
subplot(236);
% pcolor(vx,vy,imag(g)); shading interp;
contourf(vx,vy,imag(gi),30,'LineStyle','none'); colorbar;
axis equal;
xlabel('v_{||}'); ylabel('v_\perp'); 
title(['(e) Im g_i, vxmax=',num2str(vxmax),', vymax=',num2str(vymax)]);

%下面的用不上
% str=['entropy_matrix_kz=',num2str(kz),',ky=',num2str(ky),...
%     ',epsn=',num2str(epsn),',eta=',num2str(eta),...
%     ',tau=',num2str(tau),',vxmax=',num2str(vxmax),...
%     ',vymax=',num2str(vymax),',nvx=',num2str(nvx),...
%     ',nvy=',num2str(nvy)];
% 
% set(gcf,'PaperUnits','inches','PaperPosition',[0 0 8 6.0]);
% %print(gcf,'-dpng',[str,'.png'],'-r100');
% print(gcf,'-dpdf',[str,'.pdf'],'-r100');
