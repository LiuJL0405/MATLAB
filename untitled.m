clear all

% 参数设置
Fs = 10000;            % 采样频率 (Hz)
T = 1/Fs;             % 采样间隔 (s)
L = 100000;            % 信号长度
t = (0:L-1)*T;        % 时间向量 (s)
x = 2*pi*1*t;         % 基频 1 Hz (时间轴转换为角度)

% 生成信号（可根据需要修改）
% 示例1：基频1Hz + 谐波（原问题）
y = 0;
for i = 1:150
    y = y + cos(0.1*i*x); % 基频1Hz，谐波至150Hz
end

% 示例2：自定义信号
% y = cos(10*t) + 0.5*cos(30*t); % 10Hz + 30Hz信号

% 傅里叶变换
Y = fft(y);
P2 = abs(Y/L);                % 双边频谱幅值
P1 = P2(1:L/2+1);             % 单边频谱
P1(2:end-1) = 2*P1(2:end-1);  % 幅值修正
f = Fs*(0:(L/2))/L;           % 频率向量 (Hz)

% 自动检测有效频率范围
threshold = 0.0001 * max(P1);    % 幅值阈值为最大值的0.01%
valid_freqs = f(P1 > threshold); % 显著频率成分
f_min = max(0.001, floor(min(valid_freqs))); % 最小频率（至少0.001Hz）
f_max = ceil(max(valid_freqs)); % 最大频率（向上取整）


% 图1：信号时间图
subplot(2,1,1);
plot(t, y, 'b-', 'LineWidth', 1);
xlabel('时间 (s)');
ylabel('幅值');
title('信号时域图');
grid on;

% 图2：自适应频谱图
subplot(2,1,2);
plot(f, P1, 'bo', 'LineWidth', 1);
xlim([f_min, f_max]); % 动态调整频率范围
xlabel('频率 (Hz)');
ylabel('幅值 |Y(f)|');
title(sprintf('频谱分析 (%.1f Hz 到 %.0f Hz)', f_min, f_max));
grid on;
