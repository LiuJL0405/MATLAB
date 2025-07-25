clear all
G = 1;
m1=1; 
m2=1; 
 
r10 = [0, 0.2]; 
r20 = [0.2, 0]; 

v10 = [-0.1, -0.1]; 
v20 = [0.4, 0.4];

Y0=[r10,v10,r20,v20]; %初值

fun = @(t, Y) [Y(3:4); -G*m2*(Y(1:2)-Y(5:6))/norm( Y(1:2)-Y(5:6))^3;
               Y(7:8); -G*m1*(Y(5:6)-Y(1:2))/norm( Y(5:6)-Y(1:2))^3];

options = odeset('RelTol',1e-8,'AbsTol',1e-10);%绝对误差和相对误差

[t, Y] = ode15s(fun, [0 2], Y0,options); %刚性方程，所以用ode15s求解
%ode15s（函数，积分时长，初值，精度）

hold on;
plot(Y(1, 1), Y(1, 2), 'ro');
plot(Y(1, 5), Y(1, 6), 'bo');%三个初始位置


plot(Y(:, 1), Y(:, 2), 'r-', 'DisplayName', 'm_1');
plot(Y(:, 5), Y(:, 6),  'b-', 'DisplayName', 'm_2');%三个动起来后的轨迹
xlabel('X');
ylabel('Y');
%legend('show');

axis equal;
grid on;

