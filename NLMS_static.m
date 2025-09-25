% Load data
load("project_data2024.mat");
d = trainseq_static_1;     % Desired Signal
x = data_static_1(1:1000); % Noisy Signal
N = length(x);             % length of training data

% LMS parameter
L = 9; 
alpha = 0.01;
epochs = 10;
f_weights = zeros(L, 1);
x_buffer = zeros(L, 1);
y = zeros(1, N);
e = zeros(epochs, N);

% LMS algorithm
for i = 1: epochs
    for n = 1:N
        % x_buffer and f_weights should have same size
        x_buffer = [x(n); x_buffer(1:end-1)];
        y(n) = f_weights' * x_buffer;
        error = d(n) - y(n);
        % NLMS
        alpha_prime = alpha / (x_buffer' * x_buffer + eps);
        % 使用 LMS 更新權重
        f_weights = f_weights + alpha_prime * error' * x_buffer;
        e(i,n) = error * error';
    end
end
% Mean square error
MSE = mean(e,2);

%% Visualization of Constellation Map 
visualization(y, d, MSE);

%% Demodulation and Computation of SER and BER
[SER, BER] = calculate_ser_ber(y, d);
