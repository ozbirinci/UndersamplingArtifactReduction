function [undersampled_image, sampling_mask] = VarDensityandPartialFourier(image)
    % convert to k-space
    k_space = fft2c(image);
    [nx, ny] = size(image);

    % set up coordinate grid for variable density sampling
    [x, y] = meshgrid(-nx/2:nx/2-1, -ny/2:ny/2-1);
    
    % calculate distance from center for each point
    distance_from_center = sqrt(x.^2 + y.^2);
    max_distance = max(distance_from_center(:));
    
    % create probability map (higher chance to sample near center)
    sampling_probability = exp(-distance_from_center / (max_distance / 4));
    
    % create random sampling pattern
    vardens_undersampling_mask = rand(nx, ny) < sampling_probability;
    
    % create mask for upper half of k-space
    partial_fourier_mask = zeros(nx, ny);
    partial_fourier_mask(1:ceil(nx/2), :) = 1;
    
    % combine both sampling patterns
    total_mask = vardens_undersampling_mask .* partial_fourier_mask;
    
    % calculate actual sampling percentage
    sampling_rate = sum(total_mask(:)) / numel(total_mask);
    
    % show the combined sampling pattern
    figure;
    imshow(total_mask, []);
    title(sprintf('variable density + partial fourier mask (%.2f%% sampling)', sampling_rate*100));
    
    % apply mask to k-space
    undersampled_k_space = k_space .* total_mask;
    
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
    sampling_mask = total_mask;
end