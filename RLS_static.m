% Load data
load("project_data2024.mat");
d = trainseq_static_2;     % Desired Signal
x = data_static_2(1:1000); % Noisy Signal
N = length(x);             % length of training data

% RLS parameter
L = 12; 
lambda = 0.99;
delta = 1e3;
epochs = 20;
f_weights = zeros(L, 1);
R_inverse = delta * eye(L);
x_buffer = zeros(L, 1);
y = zeros(1, N);
e = zeros(epochs, N);

% RLS algorithm
for i = 1: epochs
    for n = 1:N
        % x_buffer and f_weights should have same size
        x_buffer = [x(n); x_buffer(1:end-1)];
        y(n) = f_weights' * x_buffer;
        error = d(n) - y(n);
        alpha = 1 / (lambda + x_buffer' * R_inverse * x_buffer);
        f_weights = f_weights + alpha * error' * R_inverse * x_buffer;
        R_inverse = (R_inverse - alpha * R_inverse * x_buffer * (x_buffer') * R_inverse) / lambda;
        e(i,n) = error * error';
    end
end
% Mean square error
MSE = mean(e,2);

%% Visualization of Constellation Map 
visualization(y, d, MSE);

%% Demodulation and Computation of SER and BER
[SER, BER] = calculate_ser_ber(y, d);
disp(['符號錯誤率 (SER): ', num2str(SER)]);
disp(['符號錯誤率 (BER): ', num2str(BER)]);
