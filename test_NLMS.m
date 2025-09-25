% 載入資料
load("project_data2024.mat");
d = trainseq_varying_2; % 訓練序列僅為一段固定長度
x = data_varying_2;

%資料的格式
num_blocks = 500;          % 區塊數量
train_length = 50;         % 每個區塊的訓練序列長度
data_length = 400;         % 每個區塊的數據序列長度

% training的參數
epoch_num = 4;            % 訓練的 epoch 次數
L = 9;                     % 等化器長度 (可調整)

% Training Method的參數
mu = 0.01;                 % LMS 步進大小

%用於暫存的容器
buffer = zeros(L, 1);   % 等化器輸入緩衝區
original_x_train=[]; %紀錄data資料中的train資料
weights = zeros(L, 1); % 初始權重
train_y=[]; %紀錄train資料的y輸出
ans_y=zeros(1,num_blocks*data_length); %紀錄data資料的data的y輸出
ans_varying_1 = zeros(1,2*num_blocks*data_length);   % 儲存data資料的data的gray code
training_SER = zeros(epoch_num, 1); % train資料的 SER
training_BER = zeros(epoch_num, 1); % train資料的 BER

% 用於暫存容器的指標
ans_ptrH=1;%紀錄data資料的data的y輸出的gray code的指標
ans_ptrL=2;
ans_y_ptr=1;%紀錄data資料的data的y輸出的指標

% 逐塊處理
for block_i = 1:num_blocks
    % 獲取該區塊的接收信號
    block = x((block_i - 1) * (train_length + data_length) + 1: block_i * (train_length + data_length)); % 當前區塊的接收信號
    block_train = block(1:train_length);        % 區塊內訓練序列
    block_data = block(train_length + 1:end);  % 區塊內數據序列
    block_train_y = zeros(train_length, 1); % 區塊內訓練模式恢復的數據 
    
    original_x_train=[original_x_train;block_train'];
    % 訓練模式
    buffer_tmp=buffer(1:L); %複製進入這個block之前的buffer的狀態
    for epoch=1:epoch_num
        buffer=buffer_tmp(1:L);
        for n = 1:train_length
            % 更新等化器輸入緩衝區
            buffer = [block_train(n); buffer(1:end-1)];
            % 計算等化器輸出
            block_train_y(n) = weights' * buffer;
            % 計算誤差
            error = d(n) - block_train_y(n);
            % NLMS 更新
            mu_prime = mu / (buffer' * buffer + eps);
            weights = weights + mu_prime * error' * buffer;
        end
            % 訓練序列的 SER 和 BER 計算
        M = 4; % QPSK 調制階數
        ideal_symbols=zeros(1,train_length); %= pskdemod(d, M, pi/4, "gray");          % 理想訓練序列
        received_symbols=zeros(1,train_length); %= pskdemod(block_train_y, M, pi/4, "gray"); % 恢復的訓練序列
        for n=1:train_length
            [z,ideal_symbols(n),bitH,bitL]=demod(d(n));
            [z,received_symbols(n),bitH,bitL]=demod(block_train_y(n));
        end
        symbol_errors = sum(received_symbols ~= ideal_symbols); % 符號錯誤數
        %disp(length(symbol_errors));
        training_SER(epoch) = training_SER(epoch) + symbol_errors/train_length;

        % 訓練序列位元錯誤計算
        ideal_bits = de2bi(ideal_symbols, log2(M)); % 理想序列的位元表示
        received_bits = de2bi(received_symbols, log2(M));
        bit_errors = sum(sum(received_bits ~= ideal_bits));
        training_BER(epoch) = training_BER(epoch) + bit_errors/ (train_length * log2(M));   
    end
    train_y=[train_y;block_train_y];
    
    
    
    % 決策導向模式
    block_data_y = zeros(data_length, 1); % 恢復數據
    for n = 1:data_length
        % 更新等化器輸入緩衝區
        buffer = [block_data(n); buffer(1:end-1)];
        % 計算等化器輸出
        block_data_y(n) = weights' * buffer;
        y=block_data_y(n);
        %decision device
        [z,symbol,bitH,bitL]=demod(y);
        % 儲存恢復數據
        ans_varying_1(ans_ptrH)=bitH;
        ans_varying_1(ans_ptrL)=bitL;
        ans_y(ans_y_ptr)=y;
        ans_ptrH=ans_ptrH+1;
        ans_ptrL=ans_ptrL+1;
        ans_y_ptr=ans_y_ptr+1;
        
        % 計算誤差
        error = z-block_data_y(n);
        % NLMS 更新
        mu_prime = mu / (buffer' * buffer + eps);
        weights = weights + mu_prime * error' * buffer;
    end
end

scatterplot(original_x_train');
title('Rx 等化前的星座圖');
axis([-3 3 -3 3]);

scatterplot(train_y);
title('Rx 等化後的星座圖(train)');
axis([-3 3 -3 3]);

scatterplot(ans_y);
title('Rx 等化後的星座圖(data)');
axis([-3 3 -3 3]);
% 儲存結果
save('ans_varying.mat', 'ans_varying_1');

% 訓練序列性能結果輸出
disp(['平均符號錯誤率 (SER) (訓練): ', num2str(mean(training_SER)/num_blocks)]);
disp(['平均位元錯誤率 (BER) (訓練): ', num2str(mean(training_BER)/num_blocks)]);
