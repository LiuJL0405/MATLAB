function X=Gauss(A,b)
%求线性方程组的高斯消去法，其中
%A 为方程组的系数矩阵
% b为方程组的右端项
% x 为方程组的解
[n,m]=size(A);
x=zeros(n,1);
for k=1:n-1
    for i=k+1:n
        if A(k,k)==0
        return
        end
    lik=A(i,k)/A(k,k);
for j=k+1:n
        A(i,j)=A(i,j)- lik *A(k,j);
end
    b(i)=b(i)- lik *b(k);
   end
end
for k=n:-1:1 %回代求解
    for j=k+1:n
        b(k)=b(k)-A(k, j)*x(j);
    end
    x(k)=b(k)/A(k,k);
end
X=x;