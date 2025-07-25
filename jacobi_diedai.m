clear all

D=[-8,0,0;0,-5,0;0,0,-4];
A=[-8,1,1;1,-5,1;1,1,-4];
b=[1;16;7];
I=eye(3);

M=I-inv(D)*A;
g=inv(D)*b;

x=zeros(3,100);
x(:,1)=[0;0;0];

for i=2:100
    x(:,i)=M*x(:,i-1)+g;
   
    m=min(abs(x(:,i)-x(:,i-1)));
    if m<=1.0e-2
        break;
    end
end

x(:,1:i)
