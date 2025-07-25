clear all

tspan=[0,100];
vec0=[0.25,0];
[t,vs]=ode45('xiangtu_hanshu',tspan,vec0);

x=vs(:,1);
v=vs(:,2);

subplot(2,2,1);
plot(t,x,'b-');
xlabel('t');
ylabel('x');
title('振动x-t曲线');
grid on;

subplot(2,2,2);
plot(t,v,'b-');
xlabel('t');
ylabel('v');
title('振动v-t曲线');
grid on;

subplot(2,2,3);
plot(v,x,'b-');
xlabel('v');
ylabel('x');
title('相图');

axis equal;
grid on;

subplot(2,2,4);
plot(x,v,'b-');
xlabel('x');
ylabel('v');
title('相图(1)');

axis equal;
grid on;

