%% RLS testing
%%
% 
%clear;
%load("project_data2024.mat");
% % 1. Static Channel Case (ans_static_1)
% % Params
% tr_seq = trainseq_static_1;
% tr_seq_noise_all = data_static_1(1:1000);
% data_noise = data_static_1(1001:end);
% num_blocks = 1;
% num_epochs=10;
% L=12;%12;
% lambda=0.99;
% disp('RLS static 1');
% [ans_static_1,ans_y,SER,BER] = data_reused_RLS(tr_seq, tr_seq_noise_all, data_noise, num_blocks, L, lambda,num_epochs);
% disp(['符號錯誤率 (SER): ', num2str(SER)]);
% disp(['位元錯誤率 (BER): ', num2str(BER)]);
% scatterplot(ans_y);
% title('RLS static 1的星座圖');
% axis([-2 2 -2 2]);
% 
% % 1. Static Channel Case (ans_static_2)
% % Params
% tr_seq = trainseq_static_2;
% tr_seq_noise_all = data_static_2(1:1000);
% data_noise = data_static_2(1001:end);
% num_blocks = 1;
% num_epochs=10;
% L=12;
% lambda=0.99;
% disp('RLS static 2');
% [ans_static_2,ans_y,SER,BER] = data_reused_RLS(tr_seq, tr_seq_noise_all, data_noise, num_blocks, L, lambda,num_epochs);
% disp(['符號錯誤率 (SER): ', num2str(SER)]);
% disp(['位元錯誤率 (BER): ', num2str(BER)]);
% save('ans_static.mat', 'ans_static_1', 'ans_static_2');
% scatterplot(ans_y);
% title('RLS static 2的星座圖');
% axis([-2 2 -2 2]);
% 
% %%
% clear;
% load("project_data2024.mat");
% % 2. Quasi-Static Channel Case (ans_qstatic_1)
% % Params
% tr_seq = trainseq_qstatic_1;
% block_size = 1200;
% num_blocks = length(data_qstatic_1) / block_size;
% reshaped_data = reshape(data_qstatic_1.', block_size, num_blocks).';
% tr_seq_noise_all = reshaped_data(:, 1:200);  % (200,200)
% data_noise_all = reshaped_data(:, 201:end);  % (200,1000)
% num_epochs=10;
% L=12;
% lambda=0.99;
% disp('RLS qstatic 1');
% [ans_qstatic_1,ans_y,SER,BER] = data_reused_RLS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, lambda,num_epochs);
% disp(['符號錯誤率 (SER): ', num2str(SER)]);
% disp(['位元錯誤率 (BER): ', num2str(BER)]);
% scatterplot(ans_y);
% title('RLS qstatic 1的星座圖');
% axis([-2 2 -2 2]);
% % 
% % % 2. Quasi-Static Channel Case (ans_qstatic_2)
% % % Params
% tr_seq = trainseq_qstatic_2;
% block_size = 1200;
% num_blocks = length(data_qstatic_2) / block_size;
% reshaped_data = reshape(data_qstatic_2.', block_size, num_blocks).';
% tr_seq_noise_all = reshaped_data(:, 1:200);  % (200,200)
% data_noise_all = reshaped_data(:, 201:end);  % (200,1000)
% num_epochs=10;
% L=6;
% lambda=0.99;
% disp('RLS qstatic 2');
% [ans_qstatic_2,ans_y,SER,BER] = data_reused_RLS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, lambda,num_epochs);
% disp(['符號錯誤率 (SER): ', num2str(SER)]);
% disp(['位元錯誤率 (BER): ', num2str(BER)]);
% save('ans_qstatic.mat', 'ans_qstatic_1', 'ans_qstatic_2');
% scatterplot(ans_y);
% title('RLS qstatic 2的星座圖');
% axis([-2 2 -2 2]);
% 
%%
clear;
load("project_data2024.mat");
% 3. Time-Varying Channel Case (ans_varying_1)
% Params
tr_seq = trainseq_varying_1;
block_size = 450;
num_blocks = length(data_varying_1) / block_size;
reshaped_data = reshape(data_varying_1.', block_size, num_blocks).';
tr_seq_noise_all = reshaped_data(:, 1:50);  % (500,50)
data_noise_all = reshaped_data(:, 51:end);  % (500,400)
num_epochs=10;
L=9;
lambda=0.99;
disp('RLS varying 1');
[ans_varying_1,ans_y,SER,BER] = data_reused_RLS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, lambda,num_epochs);
disp(['符號錯誤率 (SER): ', num2str(SER)]);
disp(['位元錯誤率 (BER): ', num2str(BER)]);
scatterplot(ans_y);
title('RLS varying 1的星座圖');
axis([-2 2 -2 2]);

% 3. Time-Varying Channel Case (ans_varying_2)
% Params
tr_seq = trainseq_varying_2;
block_size = 450;
num_blocks = length(data_varying_2) / block_size;
reshaped_data = reshape(data_varying_2.', block_size, num_blocks).';
tr_seq_noise_all = reshaped_data(:, 1:50);  % (500,50)
data_noise_all = reshaped_data(:, 51:end);  % (500,450)

num_epochs=10;
L=12;
lambda=0.99;
disp('RLS varying 2');
[ans_varying_2,ans_y,SER,BER] = data_reused_RLS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, lambda,num_epochs);
disp(['符號錯誤率 (SER): ', num2str(SER)]);
disp(['位元錯誤率 (BER): ', num2str(BER)]);
save('DR_ans_varying.mat', 'ans_varying_1', 'ans_varying_2');
scatterplot(ans_y);
title('RLS varying 2的星座圖');
axis([-2 2 -2 2]);

%% NLMS testing
%%
% clear;
% load("project_data2024.mat");
% % 1. Static Channel Case (ans_static_1)
% 
% % Params
% tr_seq = trainseq_static_1;
% tr_seq_noise_all = data_static_1(1:1000);
% data_noise = data_static_1(1001:end);
% num_blocks = 1;
% L=12;
% alpha=0.1;
% num_epochs=10;
% disp('NLMS static 1');
% [ans_static_1,ans_y,MSE,SER,BER] = data_reused_NLMS(tr_seq, tr_seq_noise_all, data_noise, num_blocks, L, alpha,num_epochs);
% disp(['符號錯誤率 (SER): ', num2str(SER)]);
% disp(['符號錯誤率 (BER): ', num2str(BER)]);
% 
% scatterplot(ans_y);
% title('NLMS static 1的星座圖');
% axis([-2 2 -2 2]);
% figure
% 
% 
% 
% % 1. Static Channel Case (ans_static_2)
% % Params
% tr_seq = trainseq_static_2;
% tr_seq_noise_all = data_static_2(1:1000);
% data_noise = data_static_2(1001:end);
% num_blocks = 1;
% L=12;
% alpha=0.06;
% num_epochs=10;
% disp('NLMS static 2');
% [ans_static_2,ans_y,MSE,SER,BER] = data_reused_NLMS(tr_seq, tr_seq_noise_all, data_noise, num_blocks, L, alpha,num_epochs);
% disp(['符號錯誤率 (SER): ', num2str(SER)]);
% disp(['符號錯誤率 (BER): ', num2str(BER)]);
% 
% scatterplot(ans_y);
% title('NLMS static 2的星座圖');
% axis([-2 2 -2 2]);
% figure


%%
clear;
load("project_data2024.mat");
% 2. Quasi-Static Channel Case (ans_qstatic_1)
% % Params
tr_seq = trainseq_qstatic_1;
block_size = 1200;
num_blocks = length(data_qstatic_1) / block_size;
reshaped_data = reshape(data_qstatic_1.', block_size, num_blocks).';
tr_seq_noise_all = reshaped_data(:, 1:200);  % (200,200)
data_noise_all = reshaped_data(:, 201:end);  % (200,1000)
L=11;
alpha=0.07;
num_epochs=10;
disp('NLMS qstatic 1');
[ans_qstatic_1,ans_y,MSE,SER,BER] = data_reused_NLMS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, alpha,num_epochs);
disp(['符號錯誤率 (SER): ', num2str(SER)]);
disp(['符號錯誤率 (BER): ', num2str(BER)]);

scatterplot(ans_y);
title('NLMS qstatic 1的星座圖');
axis([-2 2 -2 2]);


% % 2. Quasi-Static Channel Case (ans_qstatic_2)
% % Params
tr_seq = trainseq_qstatic_2;
block_size = 1200;
num_blocks = length(data_qstatic_2) / block_size;
reshaped_data = reshape(data_qstatic_2.', block_size, num_blocks).';
tr_seq_noise_all = reshaped_data(:, 1:200);  % (200,200)
data_noise_all = reshaped_data(:, 201:end);  % (200,1000)
L=12;
alpha=0.06;
num_epochs=10;
disp('NLMS qstatic 2');
[ans_qstatic_2,ans_y,MSE,SER,BER] = data_reused_NLMS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, alpha,num_epochs);
disp(['符號錯誤率 (SER): ', num2str(SER)]);
disp(['符號錯誤率 (BER): ', num2str(BER)]);
save('DR_ans_qstatic.mat', 'ans_qstatic_1', 'ans_qstatic_2');
scatterplot(ans_y);
title('NLMS qstatic 2的星座圖');
axis([-2 2 -2 2]);


%%
% clear;
% load("project_data2024.mat");
% % 3. Time-Varying Channel Case (ans_varying_1)
% % Params
% tr_seq = trainseq_varying_1;
% block_size = 450;
% num_blocks = length(data_varying_1) / block_size;
% reshaped_data = reshape(data_varying_1.', block_size, num_blocks).';
% tr_seq_noise_all = reshaped_data(:, 1:50);  % (500,50)
% data_noise_all = reshaped_data(:, 51:end);  % (500,400)
% L=12;
% alpha=0.12;
% num_epochs=10;
% disp('NLMS varying 1');
% [ans_varying_1,ans_y,MSE,SER,BER] = data_reused_NLMS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, alpha,num_epochs);
% disp(['符號錯誤率 (SER): ', num2str(SER)]);
% disp(['符號錯誤率 (BER): ', num2str(BER)]);
% scatterplot(ans_y);
% title('NLMS varying 1的星座圖');
% axis([-2 2 -2 2]);
% 
% 
% % 3. Time-Varying Channel Case (ans_varying_2)
% % Params
% tr_seq = trainseq_varying_2;
% block_size = 450;
% num_blocks = length(data_varying_2) / block_size;
% reshaped_data = reshape(data_varying_2.', block_size, num_blocks).';
% tr_seq_noise_all = reshaped_data(:, 1:50);  % (500,50)
% data_noise_all = reshaped_data(:, 51:end);  % (500,450)
% L=12;
% alpha=0.09;
% num_epochs=10;
% disp('NLMS varying 2');
% [ans_varying_2,ans_y,MSE,SER,BER] = data_reused_NLMS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, alpha,num_epochs);
% disp(['符號錯誤率 (SER): ', num2str(SER)]);
% disp(['符號錯誤率 (BER): ', num2str(BER)]);
% scatterplot(ans_y);
% title('NLMS varying 2的星座圖');
% axis([-2 2 -2 2]);
% save('ans_varying.mat', 'ans_varying_1', 'ans_varying_2');