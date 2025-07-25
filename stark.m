clear all
F = 1; 
rho_eff = 0.5;
dz=0.05;
R=1/dz^2;
n=200;
 
V_eff=zeros(1,n);
a=zeros(1,n);
 
for j = 1:n
   integrand = @(q) besselj(0,q*rho_eff^4*F).*exp(-rho_eff^2*q.^2/4 - q*abs(j*dz));
   V_eff(j) = 2*integral(integrand,0,Inf); 
   a(j)=2*R+V_eff(j);
end
 
A=zeros(200,200);
 
for j=1:n
    A(j,j)=a(j);
    if j==200
        break;
    end
    A(j,j+1)=R;
    A(j+1,j)=-R;
end

m=abs(eig(A));
mm=m;

E=zeros(1,9);

for k=1:9
    E(1,k)=min(m);
    for s=1:200
        if m(s,1)==E(1,k)
            m(s,1)=Inf;
        end
    end
end

E

[M,N]=eig(A);

fai=zeros(200,9);
 
z=linspace(0,1,200);

for kkk=1:9
    for k=1:200
        if mm(k,1)==E(1,kkk);
            fai(:,kkk)=abs(M(:,k)).^2;
            break;
        end
    end
end

    subplot(3,3,1)
   plot(z,fai(:,1))
   
   subplot(3,3,2)
   plot(z,fai(:,2))
   
   subplot(3,3,3)
 plot(z,fai(:,3))
   
   subplot(3,3,4)
plot(z,fai(:,4))
   
   subplot(3,3,5)
  plot(z,fai(:,5))
   
   subplot(3,3,6)
plot(z,fai(:,6))
   
   subplot(3,3,7)
plot(z,fai(:,7))
   
   subplot(3,3,8)
plot(z,fai(:,8))
   
   subplot(3,3,9)
  plot(z,fai(:,9))