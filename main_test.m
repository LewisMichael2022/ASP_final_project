%% RLS testing
%%
clear;
load("project_data2024.mat");
% 1. Static Channel Case (ans_static_1)
% Params

tr_seq = trainseq_static_1;
tr_seq_noise_all = data_static_1(1:1000);
data_noise = data_static_1(1001:end);
num_blocks = 1;

L_range = [6,12]; 
L_delta=1;
lambda_range = [0.9,0.99];
alpha_delta=0.01;
num_epochs=10;
best_BER=1;
best_SER=1;
ans_static_1=[];
best_L=L_range(1);
best_lambda=lambda_range(1);
disp('RLS static 1');
for L=L_range(1):L_delta:L_range(2)
    for lambda=lambda_range(1):alpha_delta:lambda_range(2)
        [tmp_static_1,SER,BER] = data_reused_RLS(tr_seq, tr_seq_noise_all, data_noise, num_blocks, L, lambda,num_epochs);
        if BER<best_BER
            ans_static_1=tmp_static_1;
            best_BER=BER;
            best_SER=SER;
            best_L=L;
            best_lambda=lambda;
        end
    end
end
disp(['L:',num2str(best_L)]);
disp(['lambda:',num2str(best_lambda)]);
disp(['符號錯誤率 (SER): ', num2str(best_SER)]);
disp(['符號錯誤率 (BER): ', num2str(best_BER)]);
return;


% 1. Static Channel Case (ans_static_2)
% Params
%{
tr_seq = trainseq_static_2;
tr_seq_noise_all = data_static_2(1:1000);
data_noise = data_static_2(1001:end);
num_blocks = 1;
L_range = [6,12]; 
L_delta=1;
lambda_range = [0.9,0.99];
alpha_delta=0.01;
num_epochs=10;
best_BER=1;
best_SER=1;
ans_static_2=[];
best_L=L_range(1);
best_lambda=lambda_range(1);
disp('RLS static 2');
for L=L_range(1):L_delta:L_range(2)
    for lambda=lambda_range(1):alpha_delta:lambda_range(2)
        [tmp_static_2,SER,BER] = data_reused_RLS(tr_seq, tr_seq_noise_all, data_noise, num_blocks, L, lambda,num_epochs);
        if BER<best_BER
            ans_static_2=tmp_static_2;
            best_BER=BER;
            best_SER=SER;
            best_L=L;
            best_lambda=lambda;
        end
    end
end
disp(['L:',num2str(best_L)]);
disp(['lambda:',num2str(best_lambda)]);
disp(['符號錯誤率 (SER): ', num2str(best_SER)]);
disp(['符號錯誤率 (BER): ', num2str(best_BER)]);
return;
save('ans_static.mat', 'ans_static_1', 'ans_static_2');
%}

%%
clear;
load("project_data2024.mat");
% 2. Quasi-Static Channel Case (ans_qstatic_1)
% Params
%{
tr_seq = trainseq_qstatic_1;
block_size = 1200;
num_blocks = length(data_qstatic_1) / block_size;
reshaped_data = reshape(data_qstatic_1.', block_size, num_blocks).';
tr_seq_noise_all = reshaped_data(:, 1:200);  % (200,200)
data_noise_all = reshaped_data(:, 201:end);  % (200,1000)
L_range = [6,12]; 
L_delta=1;
lambda_range = [0.9,0.99];
alpha_delta=0.01;
num_epochs=10;
best_BER=1;
best_SER=1;
ans_qstatic_1=[];
best_L=L_range(1);
best_lambda=lambda_range(1);
disp('RLS qstatic 1');
for L=L_range(1):L_delta:L_range(2)
    for lambda=lambda_range(1):alpha_delta:lambda_range(2)
        [tmp_qstatic_1,SER,BER] = data_reused_RLS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, lambda,num_epochs);
        if BER<best_BER
            ans_qstatic_1=tmp_qstatic_1;
            best_BER=BER;
            best_SER=SER;
            best_L=L;
            best_lambda=lambda;
        end
    end
end
disp(['L:',num2str(best_L)]);
disp(['lambda:',num2str(best_lambda)]);
disp(['符號錯誤率 (SER): ', num2str(best_SER)]);
disp(['符號錯誤率 (BER): ', num2str(best_BER)]);
return;

%}

% 2. Quasi-Static Channel Case (ans_qstatic_2)
% Params
%{
tr_seq = trainseq_qstatic_2;
block_size = 1200;
num_blocks = length(data_qstatic_2) / block_size;
reshaped_data = reshape(data_qstatic_2.', block_size, num_blocks).';
tr_seq_noise_all = reshaped_data(:, 1:200);  % (200,200)
data_noise_all = reshaped_data(:, 201:end);  % (200,1000)

L_range = [6,12]; 
L_delta=1;
lambda_range = [0.9,0.99];
alpha_delta=0.01;
num_epochs=10;
best_BER=1;
best_SER=1;
ans_qstatic_2=[];
best_L=L_range(1);
best_lambda=lambda_range(1);
disp('RLS qstatic 2');
for L=L_range(1):L_delta:L_range(2)
    for lambda=lambda_range(1):alpha_delta:lambda_range(2)
        [tmp_qstatic_2,SER,BER] = data_reused_RLS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, lambda,num_epochs);
        if BER<best_BER
            ans_qstatic_2=tmp_qstatic_2;
            best_BER=BER;
            best_SER=SER;
            best_L=L;
            best_lambda=lambda;
        end
    end
end
disp(['L:',num2str(best_L)]);
disp(['lambda:',num2str(best_lambda)]);
disp(['符號錯誤率 (SER): ', num2str(best_SER)]);
disp(['符號錯誤率 (BER): ', num2str(best_BER)]);
return;
save('ans_qstatic.mat', 'ans_qstatic_1', 'ans_qstatic_2');
%}

%%
clear;
load("project_data2024.mat");
% 3. Time-Varying Channel Case (ans_varying_1)
% Params
%{
tr_seq = trainseq_varying_1;
block_size = 450;
num_blocks = length(data_varying_1) / block_size;
reshaped_data = reshape(data_varying_1.', block_size, num_blocks).';
tr_seq_noise_all = reshaped_data(:, 1:50);  % (500,50)
data_noise_all = reshaped_data(:, 51:end);  % (500,400)
L_range = [6,12]; 
L_delta=1;
lambda_range = [0.9,0.99];
alpha_delta=0.01;
num_epochs=10;
best_BER=1;
best_SER=1;
ans_varying_1=[];
best_L=L_range(1);
best_lambda=lambda_range(1);
disp('RLS varying 1');
for L=L_range(1):L_delta:L_range(2)
    for lambda=lambda_range(1):alpha_delta:lambda_range(2)
        [tmp_varying_1,SER,BER] = data_reused_RLS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, lambda,num_epochs);
        if BER<best_BER
            ans_varying_1=tmp_varying_1;
            best_BER=BER;
            best_SER=SER;
            best_L=L;
            best_lambda=lambda;
            %disp(['best lambda:',num2str(lambda)]);
        end
    end
end
disp(['L:',num2str(best_L)]);
disp(['lambda:',num2str(best_lambda)]);
disp(['符號錯誤率 (SER): ', num2str(best_SER)]);
disp(['符號錯誤率 (BER): ', num2str(best_BER)]);
disp('');
return;
%}
% 3. Time-Varying Channel Case (ans_varying_2)
% Params
%{
tr_seq = trainseq_varying_2;
block_size = 450;
num_blocks = length(data_varying_2) / block_size;
reshaped_data = reshape(data_varying_2.', block_size, num_blocks).';
tr_seq_noise_all = reshaped_data(:, 1:50);  % (500,50)
data_noise_all = reshaped_data(:, 51:end);  % (500,450)

L_range = [6,12]; 
L_delta=1;
lambda_range = [0.9,0.99];
alpha_delta=0.01;
num_epochs=10;
best_BER=1;
best_SER=1;
ans_varying_2=[];
best_L=L_range(1);
best_lambda=lambda_range(1);
disp('RLS varying 2');
for L=L_range(1):L_delta:L_range(2)
    for lambda=lambda_range(1):alpha_delta:lambda_range(2)
        [tmp_varying_2,SER,BER] = data_reused_RLS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, lambda,num_epochs);
        if BER<best_BER
            ans_varying_2=tmp_varying_2;
            best_BER=BER;
            best_SER=SER;
            best_L=L;
            best_lambda=lambda;
        end
    end
end
disp(['L:',num2str(best_L)]);
disp(['lambda:',num2str(best_lambda)]);
disp(['符號錯誤率 (SER): ', num2str(best_SER)]);
disp(['符號錯誤率 (BER): ', num2str(best_BER)]);
save('ans_varying.mat', 'ans_varying_1', 'ans_varying_2');
return;
%}

%% NLMS testing
%%
clear;
load("project_data2024.mat");
% 1. Static Channel Case (ans_static_1)

% Params
%{
tr_seq = trainseq_static_1;
tr_seq_noise_all = data_static_1(1:1000);
data_noise = data_static_1(1001:end);
num_blocks = 1;
best_BER=1;
best_SER=1;
ans_static_1=[];
L_range = [6,12]; 
L_delta=1;
alpha_range = [0.06,0.12];
alpha_delta=0.01;
num_epochs=10;
best_L=L_range(1);
best_alpha=alpha_range(1);
disp('NLMS static 1');
for L=L_range(1):L_delta:L_range(2)
    for alpha=alpha_range(1):alpha_delta:alpha_range(2)
        [tmp_static_1,SER,BER] = data_reused_NLMS(tr_seq, tr_seq_noise_all, data_noise, num_blocks, L, alpha,num_epochs);
        if BER<best_BER
            ans_static_1=tmp_static_1;
            best_BER=BER;
            best_SER=SER;
            best_L=L;
            best_alpha=alpha;
        end
    end
end
disp(['L:',num2str(best_L)]);
disp(['alpha:',num2str(best_alpha)]);
disp(['符號錯誤率 (SER): ', num2str(best_SER)]);
disp(['符號錯誤率 (BER): ', num2str(best_BER)]);
return;
%}

% 1. Static Channel Case (ans_static_2)
% Params
%{
tr_seq = trainseq_static_2;
tr_seq_noise_all = data_static_2(1:1000);
data_noise = data_static_2(1001:end);
num_blocks = 1;
L_range = [6,12]; 
L_delta=1;
alpha_range = [0.06,0.12];
alpha_delta=0.01;
num_epochs=10;
best_BER=1;
best_SER=1;
ans_static_2 = [];
best_L=L_range(1);
best_alpha=alpha_range(1);
disp('NLMS static 2');
for L=L_range(1):L_delta:L_range(2)
    for alpha=alpha_range(1):alpha_delta:alpha_range(2)
        [tmp_static_2,SER,BER] = data_reused_NLMS(tr_seq, tr_seq_noise_all, data_noise, num_blocks, L, alpha,num_epochs);
        if BER<best_BER
            ans_static_2=tmp_static_2;
            best_BER=BER;
            best_SER=SER;
            best_L=L;
            best_alpha=alpha;
        end
    end
end
disp(['L:',num2str(best_L)]);
disp(['alpha:',num2str(best_alpha)]);
disp(['符號錯誤率 (SER): ', num2str(best_SER)]);
disp(['符號錯誤率 (BER): ', num2str(best_BER)]);
return;
%}


%%
clear;
load("project_data2024.mat");
% 2. Quasi-Static Channel Case (ans_qstatic_1)
% Params
%{
tr_seq = trainseq_qstatic_1;
block_size = 1200;
num_blocks = length(data_qstatic_1) / block_size;
reshaped_data = reshape(data_qstatic_1.', block_size, num_blocks).';
tr_seq_noise_all = reshaped_data(:, 1:200);  % (200,200)
data_noise_all = reshaped_data(:, 201:end);  % (200,1000)
L_range = [6,12]; 
L_delta=1;
alpha_range = [0.06,0.12];
alpha_delta=0.01;
num_epochs=10;
best_BER=1;
best_SER=1;
ans_qstatic_1=[];
best_L=L_range(1);
best_alpha=alpha_range(1);
disp('NLMS Qstatic 1');
for L=L_range(1):L_delta:L_range(2)
    for alpha=alpha_range(1):alpha_delta:alpha_range(2)
        [tmp_qstatic_1,SER,BER] = data_reused_NLMS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, alpha,num_epochs);
        if BER<best_BER
            ans_qstatic_1=tmp_qstatic_1;
            best_BER=BER;
            best_SER=SER;
            best_L=L;
            best_alpha=alpha;
        end
    end
end
disp(['L:',num2str(best_L)]);
disp(['alpha:',num2str(best_alpha)]);
disp(['符號錯誤率 (SER): ', num2str(best_SER)]);
disp(['符號錯誤率 (BER): ', num2str(best_BER)]);
return;
%}

% 2. Quasi-Static Channel Case (ans_qstatic_2)
% Params
%{
tr_seq = trainseq_qstatic_2;
block_size = 1200;
num_blocks = length(data_qstatic_2) / block_size;
reshaped_data = reshape(data_qstatic_2.', block_size, num_blocks).';
tr_seq_noise_all = reshaped_data(:, 1:200);  % (200,200)
data_noise_all = reshaped_data(:, 201:end);  % (200,1000)

L_range = [6,12]; 
L_delta=1;
alpha_range = [0.06,0.12];
alpha_delta=0.01;
num_epochs=10;
best_BER=1;
best_SER=1;
ans_qstatic_2=[];
best_L=L_range(1);
best_alpha=alpha_range(1);
disp('NLMS Qstatic 2');
for L=L_range(1):L_delta:L_range(2)
    for alpha=alpha_range(1):alpha_delta:alpha_range(2)
        [tmp_qstatic_2,SER,BER] = data_reused_NLMS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, alpha,num_epochs);
        if BER<best_BER
            ans_qstatic_2=tmp_qstatic_2;
            best_BER=BER;
            best_SER=SER;
            best_L=L;
            best_alpha=alpha;
        end
    end
end
disp(['L:',num2str(best_L)]);
disp(['alpha:',num2str(best_alpha)]);
disp(['符號錯誤率 (SER): ', num2str(best_SER)]);
disp(['符號錯誤率 (BER): ', num2str(best_BER)]);
%save('ans_qstatic.mat', 'ans_qstatic_1', 'ans_qstatic_2');
return;
%}

%%
clear;
load("project_data2024.mat");
% 3. Time-Varying Channel Case (ans_varying_1)
% Params
%{
tr_seq = trainseq_varying_1;
block_size = 450;
num_blocks = length(data_varying_1) / block_size;
reshaped_data = reshape(data_varying_1.', block_size, num_blocks).';
tr_seq_noise_all = reshaped_data(:, 1:50);  % (500,50)
data_noise_all = reshaped_data(:, 51:end);  % (500,400)
L_range = [6,12]; 
L_delta=1;
alpha_range = [0.06,0.12];
alpha_delta=0.01;
num_epochs=10;
best_BER=1; 
best_SER=1;
ans_varying_1=[];
best_L=L_range(1);
best_alpha=alpha_range(1);
disp('NLMS varying 1');
for L=L_range(1):L_delta:L_range(2)
    for alpha=alpha_range(1):alpha_delta:alpha_range(2)
        [tmp_varying_1,SER,BER] = data_reused_NLMS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, alpha,num_epochs);
        if BER<best_BER
            ans_varying_1=tmp_varying_1;
            best_BER=BER;
            best_SER=SER;
            best_L=L;
            best_alpha=alpha;
        end
    end
end
disp(['L:',num2str(best_L)]);
disp(['alpha:',num2str(best_alpha)]);
disp(['符號錯誤率 (SER): ', num2str(best_SER)]);
disp(['符號錯誤率 (BER): ', num2str(best_BER)]);
return;
%}


% 3. Time-Varying Channel Case (ans_varying_2)
% Params
tr_seq = trainseq_varying_2;
block_size = 450;
num_blocks = length(data_varying_2) / block_size;
reshaped_data = reshape(data_varying_2.', block_size, num_blocks).';
tr_seq_noise_all = reshaped_data(:, 1:50);  % (500,50)
data_noise_all = reshaped_data(:, 51:end);  % (500,450)
L_range = [6,12]; 
L_delta=1;
alpha_range = [0.06,0.12];
alpha_delta=0.01;
num_epochs=10;
best_BER=1;
best_SER=1;
ans_varying_2=[];
best_L=L_range(1);
best_alpha=alpha_range(1);
disp('NLMS varying 2');
for L=L_range(1):L_delta:L_range(2)
    for alpha=alpha_range(1):alpha_delta:alpha_range(2)
        [tmp_varying_2,SER,BER] = data_reused_NLMS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, alpha,num_epochs);
        if BER<best_BER
            ans_varying_2=tmp_varying_2;
            best_BER=BER;
            best_SER=SER;
            best_L=L;
            best_alpha=alpha;
        end
    end
end
disp(['L:',num2str(best_L)]);
disp(['alpha:',num2str(best_alpha)]);
disp(['符號錯誤率 (SER): ', num2str(best_SER)]);
disp(['符號錯誤率 (BER): ', num2str(best_BER)]);
%save('ans_varying.mat', 'ans_varying_1', 'ans_varying_2');