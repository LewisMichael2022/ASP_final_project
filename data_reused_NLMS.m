function [ans_bitstream,ans_y,MSE,SER,BER] = data_reused_NLMS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, alpha,num_epochs)
    data_len = size(data_noise_all, 2);
    ans_bitstream = zeros(1, data_len * 2 * num_blocks);
    SER_all = zeros(1, num_blocks);
    BER_all = zeros(1, num_blocks);
    ans_y=[];
    MSE=zeros(1,num_epochs*length(tr_seq));
    for i = 1:num_blocks
        [f_weights,e,SER, BER] = data_reused_NLMS_training_mode(tr_seq, tr_seq_noise_all(i, :), L, alpha,num_epochs);
        SER_all(i) = SER;
        BER_all(i) = BER;
        [y,z] = NLMS_desicion_mode(data_noise_all(i, :), f_weights);
        ans_y=[ans_y,y];
        ans_bitstream((i-1)*data_len*2 + 1 : i*data_len*2) = reshape(z', 1, []);
        for j=1:num_epochs*length(tr_seq)
            MSE(j)=MSE(j)+e(j);
        end
    end
    for j=1:num_epochs*length(tr_seq)
        MSE(j)=MSE(j)/num_blocks;
    end
    SER=mean(SER_all);
    BER=mean(BER_all);
    %disp(['符號錯誤率 (SER): ', num2str(mean(SER_all))])
    %disp(['符號錯誤率 (BER): ', num2str(mean(BER_all))])
    %disp(' ')

end


function [f_weights,e,SER, BER] = data_reused_NLMS_training_mode(d, x, L, alpha,num_epochs)
    % RLS training mode
    % Input:
    %   d: Desired signal
    %   x: Noisy signal
    %   L: Filter length
    %   lambda: Forgetting factor
    % Output:
    %   f_weights: filter coefficients
    
    % init param
    ver_ratio=0;
    N = length(d)*(1-ver_ratio);
    f_weights = zeros(L, 1);
    x_buffer = zeros(L, 1);
    y = zeros(1, N);
    d=d(1:N);
    e = zeros(1, num_epochs*N);
    % data reused NLMS training mode
    %pre_f_weights=zeros(L, 1);
    %pre_y=zeros(1,N);
    for epoch=1:num_epochs
        for n = 1:N
            x_buffer = [x(n); x_buffer(1:end-1)];
            y(n) = f_weights' * x_buffer;
            error = d(n) - y(n);
            alpha_prime = alpha / (x_buffer' * x_buffer + eps);
            f_weights = f_weights + alpha_prime * error' * x_buffer;
            e((epoch-1)*N+n) = error * error';
        end
    end
    [SER, BER] = calculate_ser_ber(y, d);
end

function [y,z] = NLMS_desicion_mode(x, f_weights)
    % RLS desicion_mode
    % Input:
    %   x: Noisy signal
    % Output:
    %   z: Recovered signal (bits)
    
    % init param
    L = length(f_weights);
    N = length(x);
    x_buffer = zeros(L, 1);
    y = zeros(1, N);
    % RLS desicion_mode
    for n = 1:N
        x_buffer = [x(n); x_buffer(1:end-1)];
        y(n) = f_weights' * x_buffer;
    end
    z = de2bi(pskdemod(y, 4, pi/4, "gray"), log2(4));
end
