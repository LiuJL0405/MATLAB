function [result, tol_achieved] = adaptive_simpson(f, a, b, tol, max_depth)
    % 自适应辛普森积分法
    % 输入：
    %   f: 被积函数（函数句柄）
    %   a, b: 积分区间 [a, b]
    %   tol: 目标误差容限（默认 1e-6）
    %   max_depth: 最大递归深度（默认 20）
    % 输出：
    %   result: 积分结果
    %   tol_achieved: 实际达到的误差
    
    % 设置默认参数
    if nargin < 4, tol = 1e-6; end
    if nargin < 5, max_depth = 20; end
    
    % 调用递归函数
    [result, tol_achieved] = recursive_simpson(f, a, b, tol, max_depth, 0);
end

function [S, err] = recursive_simpson(f, a, b, tol, max_depth, depth)
    % 递归计算子区间积分
    h = b - a;
    c = (a + b) / 2;
    
    % 计算三个点的函数值
    fa = f(a);
    fc = f(c);
    fb = f(b);
    
    % 普通辛普森公式
    S1 = h * (fa + 4*fc + fb) / 6;
    
    % 复合辛普森公式（分成两半）
    d = (a + c) / 2;
    e = (c + b) / 2;
    fd = f(d);
    fe = f(e);
    S2 = h * (fa + 4*fd + 2*fc + 4*fe + fb) / 12;
    
    % 误差估计（基于 Richardson 外推）
    err = abs(S2 - S1) / 15;
    
    % 递归终止条件
    if err <= tol || depth >= max_depth
        S = S2 + (S2 - S1)/15; % 更高阶的修正
    else
        % 递归分割区间
        [S_left, err_left] = recursive_simpson(f, a, c, tol/2, max_depth, depth+1);
        [S_right, err_right] = recursive_simpson(f, c, b, tol/2, max_depth, depth+1);
        S = S_left + S_right;
        err = err_left + err_right;
    end
end