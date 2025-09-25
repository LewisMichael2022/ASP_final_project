function visualization(y, d, MSE)
    % Visualization traing progress
    %
    % input：
    %   y - Equalized Signal
    %   d - Desired Signal
    %   MSE - Loss during training
    %
    % output：
    %   None

    scatterplot(d');
    title('Rx 等化前的星座圖');
    axis([-3 3 -3 3]);
    
    scatterplot(y);
    title('Rx 等化後的星座圖');
    axis([-3 3 -3 3]);
    
    % Plot MSE during training
    %{
    figure
    plot(10*log10(MSE))
    legend('MSE','Location','Best');
    grid minor
    xlabel('iterations');
    ylabel('Mean squared error (dB)');
    title('Loss');
    %}
end