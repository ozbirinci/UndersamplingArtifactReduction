close all; clear; clc;

image = imread('y268.jpg');
% Get the size of the image
[height, width, ~] = size(image);

% Calculate the padding needed to make the image square
pad_size = (height - width) / 2;

% Add padding to both sides of the width dimension
if pad_size > 0
    % Add padding to make it square
    padded_image = padarray(image, [0, floor(pad_size), 0], 'replicate', 'pre');
    padded_image = padarray(padded_image, [0, ceil(pad_size), 0], 'replicate', 'post');
else
    disp('Image is already square in width');
end

% Resize the square image to 243x243
resized_image = imresize(padded_image, [243, 243]);

im1 = double(resized_image(:,:,1));
k_space = fft2c(im1);

% Parameters
lambda = 0.01; % Regularization parameter
num_iters = 700; % Maximum number of iterations
sampling_ratio = 0.4; % Fraction of k-space samples

% Generate sampling mask
mask = rand(size(k_space)) < sampling_ratio;
undersampled_k_space = k_space .* mask;
undersampled_image = abs(ifft2c(undersampled_k_space)); % Reconstruct

% Initial guess (zero-filled reconstruction)
x = abs(ifft2c(undersampled_k_space));

% Total Variation Regularization using Split Bregman
for iter = 1:num_iters
    % Step 1: Data fidelity (update x to fit undersampled k-space)
    x_kspace = fft2c(x);
    x_kspace(mask == 1) = undersampled_k_space(mask == 1);
    x = abs(ifft2c(x_kspace));

    % Step 2: Total Variation Minimization
    [dx, dy] = gradient(x); % Compute gradients
    grad_magnitude = sqrt(dx.^2 + dy.^2);
    dx = dx ./ (grad_magnitude + eps); % Normalize gradients
    dy = dy ./ (grad_magnitude + eps); % Normalize gradients
    x = x - lambda * divergence(dx, dy); % TV update step

    % Display progress
    if mod(iter, 10) == 0
        disp(['Iteration ', num2str(iter), ' completed']);
    end
end

% Display final reconstructed image
subplot(1,2,1); imshow(undersampled_image, []); title('Randomly Undersampled Image');
subplot(1,2,2); imshow(x, []); title('Reconstructed Image using Total Variation Regularization');