clear all

 f=inline('u*x*(1-x)');
   
for u=3:0.01:4
    x0=0.12;
    
    for i=1:300
     x0=f(u,x0);
     
    if i>100
     plot(u,x0,'k.','linewidth',1);          
     hold on;
    end
    
    end
    
end

hold off
