function [reconstructed_image, undersampling_mask] = VariableDensityUndersampler(image1)
    % convert to k-space
    k_space = fft2c(image1);

    % get image dimensions
    nx = size(image1,1);
    ny = size(image1,2);

    % create coordinate grid for k-space
    [x, y] = meshgrid(-nx/2:nx/2-1, -ny/2:ny/2-1);

    % calculate distance from center for each point
    distance_from_center = sqrt(x.^2 + y.^2);
    max_distance = max(distance_from_center(:));

    % create probability map (higher chance to sample near center)
    sampling_probability = exp(-distance_from_center / (max_distance / 4));

    % generate random sampling pattern based on probability
    vardens_undersampling_mask = rand(nx, ny) < sampling_probability;

    % calculate actual sampling percentage
    sampling_rate = sum(vardens_undersampling_mask(:)) / numel(vardens_undersampling_mask);

    % show the sampling pattern
    figure;
    imshow(vardens_undersampling_mask, []);
    title(sprintf('variable density mask (%.2f%% sampling)', sampling_rate*100));

    % apply mask to k-space
    vardens_sampled_k_space = k_space .* vardens_undersampling_mask;

    % convert back to image space
    reconstructed_image = abs(ifft2c(vardens_sampled_k_space));

    % save mask for later use
    undersampling_mask = vardens_undersampling_mask;
end