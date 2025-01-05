function [undersampled_image, sampling_mask] = PartialFourierMethod(image)
    % get image size
    [nx, ny] = size(image);

    % convert to k-space
    k_space = fft2c(image);

    % create mask for upper half of k-space
    mask = zeros(nx, ny);
    mask(1:ceil(nx/2), :) = 1;

    % calculate sampling percentage
    sampling_rate = sum(mask(:)) / numel(mask);

    % show the sampling pattern
    figure;
    imshow(mask, []);
    title(sprintf('partial fourier mask (%.2f%% sampling)', sampling_rate*100));

    % apply mask to k-space
    undersampled_k_space = k_space .* mask;

    % use symmetry to fill in bottom half
    for x = ceil(nx/2)+1:nx
        for y = 1:ny
            % find matching point in top half
            sym_x = nx - x + 1;
            sym_y = ny - y + 1;

            % check if point exists and copy it
            if sym_x >= 1 && sym_x <= nx && sym_y >= 1 && sym_y <= ny
                undersampled_k_space(x, y) = conj(undersampled_k_space(sym_x, sym_y));
            end
        end
    end

    % convert back to image space
    undersampled_image = abs(ifft2c(undersampled_k_space));

    % save mask for later use
    sampling_mask = mask;
end