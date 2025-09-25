function [SER, BER] = calculate_ser_ber(y, d)
    % Compute SER and BER
    %
    % input：
    %   y - Equalized Signal
    %   d - Desired Signal
    % 
    % output：
    %   SER
    %   BER

    % QPSK demodulation
    M = 4;
    received_symbols = pskdemod(y, M, pi/4, "gray");
    ideal_symbols = pskdemod(d, M, pi/4, "gray");
    
    % Compute SER
    symbol_errors = sum(received_symbols ~= ideal_symbols);
    N = length(ideal_symbols);
    SER = symbol_errors / N;
    %disp(length(SER))
    %disp(['符號錯誤率 (SER): ', num2str(SER)]);

    % Compute BER
    received_bits = de2bi(received_symbols, log2(M));
    ideal_bits = de2bi(ideal_symbols, log2(M));
    bit_errors = sum(sum(received_bits ~= ideal_bits));
    BER = bit_errors / (N * log2(M));
    %disp(['位元錯誤率 (BER): ', num2str(BER)]);
end