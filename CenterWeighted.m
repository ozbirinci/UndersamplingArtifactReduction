function [undersampled_image, sampling_mask] = CenterWeighted(image)
    % get image size
    [nx, ny] = size(image);

    % convert to k-space (frequency domain)
    k_space = fft2c(image);

    % create empty mask
    mask = zeros(nx, ny);

    % calculate center region boundaries (middle 50% of k-space)
    center_start_x = round(nx/4);
    center_end_x = round(3*nx/4);
    center_start_y = round(ny/4);
    center_end_y = round(3*ny/4);

    % fill in center region of mask
    mask(center_start_x:center_end_x, center_start_y:center_end_y) = 1;

    % calculate how much of k-space we're actually sampling
    sampling_rate = sum(mask(:)) / numel(mask);

    % show the sampling pattern
    figure;
    imshow(mask, []);
    title(sprintf('center weighted mask (%.2f%% sampling)', sampling_rate*100));

    % apply mask to k-space data
    undersampled_k_space = k_space .* mask;

    % convert back to image space
    undersampled_image = abs(ifft2c(undersampled_k_space));

    % save mask for later use
    sampling_mask = mask;
end