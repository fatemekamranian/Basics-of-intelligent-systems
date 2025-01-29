function PlotResult(target, output, name)
    
    error = target - output;
    
    RMSE = sqrt(mean(error(:).^2));
    
    error_mean = mean(error(:));
    
    error_std = std(error(:));

    subplot(2,2,[1,2]);
    plot(target, 'ks-');
    hold on; 
    plot(output, 'ro-');
    legend('Target', 'Output');
    title(name);

    subplot(2,2,3);
    plot(error);
    legend('Error');
    title(['RMSE = ' num2str(RMSE)]);

    subplot(2,2,4);
    histfit(error);
    title(['Error: mean = ' num2str(error_mean) ', std = ' num2str(error_std)]);
end