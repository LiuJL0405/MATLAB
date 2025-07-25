clear

[X,Y]=meshgrid(-1:0.001:1);
[Q,R]=cart2pol(X,Y);

R(find(R>1))=NaN;

for m=0:8

    subplot(3,3,m+1);
    pcolor(X,Y,exp(-50*(R-0.5).^2).*cos(m*Q));
    title(['m=',num2str(m)]);
    shading interp;
    axis equal;

end