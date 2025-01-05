function [undersampled_image] = UniformUndersampler(image)
    % get image dimensions
    [nx, ny] = size(image);

    % convert to k-space
    k_space = fft2c(image);

    % set uniform sampling rate (take every other point)
    sampling_factor = 2;

    % create uniform sampling pattern
    mask = zeros(nx, ny);
    mask(1:sampling_factor:end, 1:sampling_factor:end) = 1;

    % show the sampling pattern
    figure;
    imshow(mask, []);
    title('uniform sampling mask');

    % apply mask and reconstruct
    undersampled_k_space = k_space .* mask;
    undersampled_image = abs(ifft2c(undersampled_k_space));
end