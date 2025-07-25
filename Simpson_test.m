clear all

% 示例1：计算 sin(x) 在 [0, pi] 的积分（精确值应为 2）
f = @(x) sin(x);
a = 0;
b = pi;
tol = 1e-8;
[result, err] = adaptive_simpson(f, a, b, tol);
fprintf('积分结果: %.10f, 实际误差: %.2e\n', result, err);

% 示例2：计算 exp(-x^2) 在 [0, 1] 的积分（高斯函数）
f = @(x) exp(-x.^2);
[result, err] = adaptive_simpson(f, 0, 1, 1e-6);
fprintf('高斯积分结果: %.10f, 实际误差: %.2e\n', result, err);

% 示例3：与MATLAB内置积分函数对比
matlab_result = integral(f, 0, 1, 'AbsTol', 1e-12);
fprintf('MATLAB内置积分结果: %.10f\n', matlab_result);