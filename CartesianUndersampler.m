function [undersampled_image, sampling_mask] = CartesianUndersampler(image)
    % convert to k-space
    k_space = fft2c(image);
    [nx, ny] = size(image);

    % set sampling parameters
    center_fraction = 0.25;    % fully sample the middle 25%
    outer_fraction = 0.05;     % sample 5% of the outer regions

    % create empty mask
    mask = zeros(nx, ny);

    % define central region
    center_start = round((1 - center_fraction) * ny / 2);
    center_end = round((1 + center_fraction) * ny / 2);

    % sample all columns in the center
    mask(:, center_start:center_end) = 1;

    % calculate how often to sample in outer regions
    outer_sampling_factor = round(1 / outer_fraction);

    % sample left side columns
    for col = 1:center_start-1
        if mod(col, outer_sampling_factor) == 0
            mask(:, col) = 1;
        end
    end

    % sample right side columns
    for col = center_end+1:ny
        if mod(col, outer_sampling_factor) == 0
            mask(:, col) = 1;
        end
    end

    % calculate actual sampling percentage
    sampling_rate = sum(mask(:)) / numel(mask);

    % show the sampling pattern
    figure;
    imshow(mask, []);
    title(sprintf('cartesian sampling mask (%.2f%% sampling)', sampling_rate*100));

    % apply mask to k-space
    undersampled_k_space = k_space .* mask;

    % convert back to image space
    undersampled_image = abs(ifft2c(undersampled_k_space));

    % save mask for later use
    sampling_mask = mask;
end