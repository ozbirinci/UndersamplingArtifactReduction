function [undersampled_image, sampling_mask] = RadialUndersampler(image)
    % convert to k-space
    k_space = fft2c(image);
    [nx, ny] = size(k_space);

    % calculate spoke parameters for ~50% sampling
    radius = min(nx, ny)/2;
    num_spokes = round(0.17 * (nx*ny)/(2*radius));
    angles = linspace(0, 180, num_spokes);

    % set up radial sampling pattern
    [kx, ky] = meshgrid(-nx/2:nx/2-1, -ny/2:ny/2-1);
    mask = zeros(nx, ny);

    % convert coordinates to angles
    theta = atan2d(ky, kx);
    theta(theta < 0) = theta(theta < 0) + 180;

    % create the spoke pattern
    for angle = angles
        tolerance = 1.3;
        mask(abs(theta - angle) < tolerance) = 1;
    end

    % calculate how much we're sampling
    sampling_rate = sum(mask(:))/numel(mask);

    % show the sampling pattern
    figure;
    imshow(mask, []);
    title(sprintf('radial mask (sampling rate: %.2f%%)', sampling_rate*100));

    % apply mask and reconstruct
    undersampled_k_space = k_space .* mask;
    undersampled_image = abs(ifft2c(undersampled_k_space));
    sampling_mask = mask;
end