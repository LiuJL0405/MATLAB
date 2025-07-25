clear all

 a=input('a=');%积分下限
 b=input('b=');%积分上限
 
 x=(b-a)*rand(1,100000)+a;
 y=@(x) sin(x);%被积函数
 
 fax=max(y(x));
 fin=min(y(x));
 
 m=0;
 N=100000;
 n=0;
 while n<N
     xi=a+(b-a)*rand;
     yi=fin+(fax-fin)*rand;
     y1=y(xi);
     if y1>yi
         m=m+1;
     end
     n=n+1;
 end
 
 j=m*(fax-fin)*(b-a)/n+fin*(b-a);
 
 disp(j)