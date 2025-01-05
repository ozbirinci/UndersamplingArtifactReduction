image = imread('y110.jpg');
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
lambda = 0.005; % Regularization parameter
num_iters = 300; % Maximum number of iterations
sampling_ratio = 0.4; % Fraction of k-space samples

% Generate sampling mask
mask = rand(size(k_space)) < sampling_ratio;
undersampled_k_space = k_space .* mask;
undersampled_image = abs(ifft2c(undersampled_k_space)); % Reconstruct

% Initial guess (zero-filled reconstruction)
x = abs(ifft2c(undersampled_k_space));

% Define wavelet transform and its inverse
wavelet_name = 'db1'; % Daubechies wavelet
decomposition_level = 2; % Number of levels for wavelet decomposition

% Iterative reconstruction
for iter = 1:num_iters
    % Step 1: Data fidelity
    x_kspace = fft2c(x);
    x_kspace(mask == 1) = undersampled_k_space(mask == 1);
    x = abs(ifft2c(x_kspace));

    % Step 2: Wavelet sparsity regularization
    [c, s] = wavedec2(x, decomposition_level, wavelet_name); % Wavelet decomposition
    c = sign(c) .* max(abs(c) - lambda, 0); % Soft thresholding
    x = waverec2(c, s, wavelet_name); % Reconstruct from thresholded coefficients

    % Display progress
    if mod(iter, 10) == 0
        disp(['Iteration ', num2str(iter), ' completed']);
    end
end

% Display final reconstructed image
subplot(1,2,1); imshow(undersampled_image, []); title('Randomly Undersampled Image');
subplot(1,2,2); imshow(x, []); title('Reconstructed Image using Wavelet Regularization');
