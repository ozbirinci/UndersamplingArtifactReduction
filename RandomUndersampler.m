function [undersampled_image] = RandomUndersampler(image1)
    % convert to k-space
    k_space = fft2c(image1);
    
    % create random sampling pattern (50% sampling rate)
    undersampling_mask = rand(size(k_space)) > 0.5;
    
    % apply mask to k-space
    undersampled_k_space = k_space .* undersampling_mask;
    
    % show the sampling pattern
    figure;
    imshow(undersampling_mask, []);
    title('random sampling mask');
    
    % convert back to image space
    undersampled_image = abs(ifft2c(undersampled_k_space));
end