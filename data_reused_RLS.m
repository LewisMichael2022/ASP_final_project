function [ans_bitstream,ans_y,SER,BER] = data_reused_RLS(tr_seq, tr_seq_noise_all, data_noise_all, num_blocks, L, lambda,num_epochs)
    data_len = size(data_noise_all, 2);
    ans_bitstream = zeros(1, data_len * 2 * num_blocks);
    SER_all = zeros(1, num_blocks);
    BER_all = zeros(1, num_blocks);
    ans_y=[];
    for i = 1:num_blocks
        [f_weights, SER, BER] = data_reused_RLS_training_mode(tr_seq, tr_seq_noise_all(i, :), L, lambda,num_epochs);
        SER_all(i) = SER;
        BER_all(i) = BER;
        [y,z] = RLS_desicion_mode(data_noise_all(i, :), f_weights);
        ans_y=[ans_y,y];
        ans_bitstream((i-1)*data_len*2 + 1 : i*data_len*2) = reshape(z', 1, [])';
    end
    SER=mean(SER_all);
    BER=mean(BER_all);
end


function [f_weights, SER, BER] = data_reused_RLS_training_mode(d, x, L, lambda,num_epochs)
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
    e = zeros(1, N);
    delta= 1e3;
    R_inverse = delta * eye(L);
    % data reused NLMS training mode
    %pre_error_performance=0;
    %pre_f_weights=zeros(L, 1);
    %pre_y=zeros(1,N);
    for epoch=1:num_epochs
        for n = 1:N
            x_buffer = [x(n); x_buffer(1:end-1)];
            y(n) = f_weights' * x_buffer;
            error = d(n) - y(n);
            alpha = 1 / (lambda + x_buffer' * R_inverse * x_buffer);
            f_weights = f_weights + alpha * error' * R_inverse * x_buffer;
            R_inverse = (R_inverse - alpha * R_inverse * x_buffer * (x_buffer') * R_inverse) / lambda;
            e(n) = error * error';
        end
        
    end
    [SER, BER] = calculate_ser_ber(y, d);
end

function [y,z] = RLS_desicion_mode(x, f_weights)
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
