R0=1.85;
mcrossection(R0);
%--------------------subfunction mcrossection------------------------------
function mcrossection(R0)
%--------------------------------------------------------------------------
%inside wall
pr=([1.238,1.238,1.271,1.399,1.547,1.718])-R0;
pz=([0,0.916,1.0447,1.197,1.254,1.244]);
%outside wall
ppr=([1.2,1.2,1.271,1.399,1.561,1.742])-R0;
ppz=([0,0.973,1.14,1.263,1.316,1.320]);

Qr=([2.730,2.84])-R0;
% Qz=([0,0])*unit;

%limter location
nr=([1.369,1.369,1.428,1.328,1.366,1.594,1.761,1.822,2.279,2.65])-R0;
nz=([0,0.46,0.745,1.016,0.978,1.103,1.168,0.926,0.488,0.488]);
%--------------------------------------------------------------------------
% figure
% set(gcf,'position',[358,30,614,669])
hold on
line(ppr,ppz,'linestyle','-','color','k','LineWidth',3)

line(ppr,-ppz,'linestyle','-','color','k','LineWidth',3)

line(pr,pz,'linestyle','-','color','k','LineWidth',3)

line(pr,-pz,'linestyle','-','color','k','LineWidth',3)

line(nr,nz,'linestyle','-','color','b','LineWidth',2)

line(nr,-nz,'linestyle','-','color','b','LineWidth',2)

%--------------------------------------------------------------------------
ap=Qr(1)-pr(end);
bp=pz(end);
app=Qr(2)-ppr(end);
bpp=ppz(end);
theta=linspace(pi/2,0,50);
pR=pr(end)+ap*sin(theta);
pZ=bp*cos(theta);
%--------------------------------------------------------------------------
line(pR,pZ,'linestyle','-','color','k','LineWidth',3)

line(pR,-pZ,'linestyle','-','color','k','LineWidth',3)

ppR=ppr(end)+app*sin(theta);
ppZ=bpp*cos(theta);
line(ppR,ppZ,'linestyle','-','color','k','LineWidth',3)

line(ppR,-ppZ,'linestyle','-','color','k','LineWidth',3)

line(0,-max(ppz):0.01:max(ppz),'linestyle','-','color','r','LineWidth',1)
%--------------------------------------------------------------------------

xlabel('Radial Location  /m','fontsize',14,'fontname','times new roman')
ylabel('Vertical Location  /m','fontsize',14,'fontname','times new roman')

axis([min(ppr)-0.05,max(pR)+0.05 min(-ppz)-0.1,max(ppz)+0.1])

axis equal
p1=min(-ppz);
p0=0;
text(p0,p1,['\leftarrow','Magnetic Axis'],'FontSize',12)
end