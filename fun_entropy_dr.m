% Hua-sheng XIE, huashengxie@gmail.com, FSC-PKU, 2016-10-10 11:57
% Adaptive Simpson quadrature formula to calculate the 2D integral
% for entropy mode.
% 16-10-16 16:14 with kpara
% 16-10-18 23:24 fixed a bug for kpara \neq 0
% 25-7-11 9:19 for the approximation of adiabatic electrons
function fdr=fun_entropy_dr(w,k,wd,kapn,kapt,kz,tol,xmax,ymax)

% nargin是MATLAB内置变量，表示函数输入参数的实际个数
if (nargin<9)
    ymax=1e1;
end
if (nargin<8)
    xmax=1e1;
end
if (nargin<7) % control the accuracy
    tol=1e-10;
end
if (nargin<6)
    kz=0.0;
end

nw=length(w); fdr=0.*w;

% for jw=1:nw
% 	f=@(x,y) besselj(0,k*abs(y)).^2.*(w(jw)-wd*(kapn+...
% 		kapt*((x.^2+y.^2)/2-3/2))).*abs(y)./(w(jw)-kz*x-wd*(x.^2+...
% 		y.^2/2)).*exp(-(x.^2+y.^2)/2);
% 
%     if(kz==0)
%         xmin=-0.0;  ymin=0; 
%         %dblquad是二重积分函数，现已被integral2取代
%         fdr(jw)=1.0-2.0/sqrt(2*pi)*dblquad(f,xmin,xmax,ymin,ymax,tol);
%             else % 16-10-18 23:24
%         xmin=-xmax;  ymin=0; 
%         fdr(jw)=1.0-1.0/sqrt(2*pi)*dblquad(f,xmin,xmax,ymin,ymax,tol);
%     end
% end

for jw=1:nw
    f = @(x,y) besselj(0,k*abs(y)).^2.*(w(jw)-wd*(kapn+...
        kapt*((x.^2+y.^2)/2-3/2))).*abs(y)./(w(jw)-kz*x-wd*(x.^2+...
        y.^2/2)).*exp(-(x.^2+y.^2)/2);

    if(kz==0)
        xmin=0;  ymin=0; 
        fdr(jw)=1.0-2.0/sqrt(2*pi)*integral2(f,xmin,xmax,ymin,ymax,'AbsTol',tol,'RelTol',tol);
    else
        xmin=-xmax;  ymin=0; 
        fdr(jw)=1.0-1.0/sqrt(2*pi)*integral2(f,xmin,xmax,ymin,ymax,'AbsTol',tol,'RelTol',tol);
    end
end


