close all; clear; clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% rgb image processing sample 710 %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load the rgb image (243x205x3)
image = imread('y710.jpg'); 

% get image dimensions
[height, width, ~] = size(image);

% calculate padding for square image
pad_size = (height - width) / 2;

% make the image square using padding
if pad_size > 0
    padded_image = padarray(image, [0, floor(pad_size), 0], 'replicate', 'pre');
    padded_image = padarray(padded_image, [0, ceil(pad_size), 0], 'replicate', 'post');
else
    disp('image is already square in width');
end

% resize to 243x243
resized_image = imresize(padded_image, [243, 243]);

% extract first channel and show original
im1 = double(resized_image(:,:,1));
figure;
imshow(im1, []);

% apply undersampling methods
random1 = RandomUndersampler(im1);
[pfourier1, pfourier_mask] = PartialFourierMethod(im1);
[vardens_pfourier1, vardens_pfourier_mask] = VarDensityandPartialFourier(im1);
[rec1, vardens_mask] = VariableDensityUndersampler(im1);
[radial1, sampling_mask] = RadialUndersampler(im1);
[center_weighted, center_mask] = CenterWeighted(im1);
uniform1 = UniformUndersampler(im1);
[cartesian1, cartesian_mask] = CartesianUndersampler(im1);

subplot(3,3,1);
imshow(im1, []);
title('Normal Image');

subplot(3,3,2);
imshow(random1, []);
title('Random Undersampled (50% sampling)');

subplot(3,3,3);
imshow(rec1, []);
sampling_rate = sum(vardens_mask(:))/numel(vardens_mask);
title(sprintf('Variable Density Undersampled (%.2f%% sampling)', sampling_rate*100));

subplot(3,3,4);
imshow(pfourier1, []);
sampling_rate = sum(pfourier_mask(:))/numel(pfourier_mask);
title(sprintf('Partial Fourier Undersampled (%.2f%% sampling)', sampling_rate*100));

subplot(3,3,5);
imshow(vardens_pfourier1, []);
sampling_rate = sum(vardens_pfourier_mask(:))/numel(vardens_pfourier_mask);
title(sprintf('Partial Fourier and Variable Density (%.2f%% sampling)', sampling_rate*100));

subplot(3,3,6);
imshow(center_weighted, []);
sampling_rate = sum(center_mask(:))/numel(center_mask);
title(sprintf('Center Weighted Undersampled (%.2f%% sampling)', sampling_rate*100));

subplot(3,3,7);
imshow(radial1, []);
sampling_rate = sum(sampling_mask(:))/numel(sampling_mask);
title(sprintf('Radial Undersampled (%.2f%% sampling)', sampling_rate*100));

subplot(3,3,8);
imshow(uniform1, []);
title('Uniform Undersampled (50% sampling)');

subplot(3,3,9);
imshow(cartesian1, []);
sampling_rate = sum(cartesian_mask(:))/numel(cartesian_mask);
title(sprintf('Cartesian Undersampled (%.2f%% sampling)', sampling_rate*100));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% rgb image processing sample 143 %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load the rgb image (243x205x3)
image = imread('y143.jpg'); 

% get image dimensions
[height, width, ~] = size(image);

% calculate padding for square image
pad_size = (height - width) / 2;

% make the image square using padding
if pad_size > 0
    padded_image = padarray(image, [0, floor(pad_size), 0], 'replicate', 'pre');
    padded_image = padarray(padded_image, [0, ceil(pad_size), 0], 'replicate', 'post');
else
    disp('image is already square in width');
end

% resize to 243x243
resized_image = imresize(padded_image, [243, 243]);

% extract first channel and show original
im1 = double(resized_image(:,:,1));
figure;
imshow(im1, []);

% apply undersampling methods
random1 = RandomUndersampler(im1);
[pfourier1, pfourier_mask] = PartialFourierMethod(im1);
[vardens_pfourier1, vardens_pfourier_mask] = VarDensityandPartialFourier(im1);
[rec1, vardens_mask] = VariableDensityUndersampler(im1);
[radial1, sampling_mask] = RadialUndersampler(im1);
[center_weighted, center_mask] = CenterWeighted(im1);
uniform1 = UniformUndersampler(im1);
[cartesian1, cartesian_mask] = CartesianUndersampler(im1);

subplot(3,3,1);
imshow(im1, []);
title('Normal Image');

subplot(3,3,2);
imshow(random1, []);
title('Random Undersampled (50% sampling)');

subplot(3,3,3);
imshow(rec1, []);
sampling_rate = sum(vardens_mask(:))/numel(vardens_mask);
title(sprintf('Variable Density Undersampled (%.2f%% sampling)', sampling_rate*100));

subplot(3,3,4);
imshow(pfourier1, []);
sampling_rate = sum(pfourier_mask(:))/numel(pfourier_mask);
title(sprintf('Partial Fourier Undersampled (%.2f%% sampling)', sampling_rate*100));

subplot(3,3,5);
imshow(vardens_pfourier1, []);
sampling_rate = sum(vardens_pfourier_mask(:))/numel(vardens_pfourier_mask);
title(sprintf('Partial Fourier and Variable Density (%.2f%% sampling)', sampling_rate*100));

subplot(3,3,6);
imshow(center_weighted, []);
sampling_rate = sum(center_mask(:))/numel(center_mask);
title(sprintf('Center Weighted Undersampled (%.2f%% sampling)', sampling_rate*100));

subplot(3,3,7);
imshow(radial1, []);
sampling_rate = sum(sampling_mask(:))/numel(sampling_mask);
title(sprintf('Radial Undersampled (%.2f%% sampling)', sampling_rate*100));

subplot(3,3,8);
imshow(uniform1, []);
title('Uniform Undersampled (50% sampling)');

subplot(3,3,9);
imshow(cartesian1, []);
sampling_rate = sum(cartesian_mask(:))/numel(cartesian_mask);
title(sprintf('Cartesian Undersampled (%.2f%% sampling)', sampling_rate*100));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% t2 weighted image processing %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;

% read raw data
filename = 't2_icbm_normal_3mm_pn0_rf0.raws';
fileID = fopen(filename, 'r');
raw_data = fread(fileID, [181, 217*181], 'int16'); 
fclose(fileID);

imageInfo = imageInfo(filename);

% reshape volume
volume = reshape(raw_data, [181, 217, 60]);

% extract and process middle slice
axial_slice = rot90(volume(:,:,31), 1);
[h, w] = size(axial_slice);
if h > w
    axial_padded = padarray(axial_slice, [0 floor((h-w)/2)], 'replicate', 'both');
else
    axial_padded = padarray(axial_slice, [floor((w-h)/2) 0], 'replicate', 'both');
end

% apply undersampling methods
im1 = axial_padded;
random1 = RandomUndersampler(im1);
[pfourier1, pfourier_mask] = PartialFourierMethod(im1);
[vardens_pfourier1, vardens_pfourier_mask] = VarDensityandPartialFourier(im1);
[rec1, vardens_mask] = VariableDensityUndersampler(im1);
[radial1, sampling_mask] = RadialUndersampler(im1);
[center_weighted, center_mask] = CenterWeighted(im1);
uniform1 = UniformUndersampler(im1);
[cartesian1, cartesian_mask] = CartesianUndersampler(im1);

% show results
subplot(3,3,1);
imshow(im1, []);
title('Normal Image');

subplot(3,3,2);
imshow(random1, []);
title('Random Undersampled (50% sampling)');

subplot(3,3,3);
imshow(rec1, []);
sampling_rate = sum(vardens_mask(:))/numel(vardens_mask);
title(sprintf('Variable Density Undersampled (%.2f%% sampling)', sampling_rate*100));

subplot(3,3,4);
imshow(pfourier1, []);
sampling_rate = sum(pfourier_mask(:))/numel(pfourier_mask);
title(sprintf('Partial Fourier Undersampled (%.2f%% sampling)', sampling_rate*100));

subplot(3,3,5);
imshow(vardens_pfourier1, []);
sampling_rate = sum(vardens_pfourier_mask(:))/numel(vardens_pfourier_mask);
title(sprintf('Partial Fourier and Variable Density (%.2f%% sampling)', sampling_rate*100));

subplot(3,3,6);
imshow(center_weighted, []);
sampling_rate = sum(center_mask(:))/numel(center_mask);
title(sprintf('Center Weighted Undersampled (%.2f%% sampling)', sampling_rate*100));

subplot(3,3,7);
imshow(radial1, []);
sampling_rate = sum(sampling_mask(:))/numel(sampling_mask);
title(sprintf('Radial Undersampled (%.2f%% sampling)', sampling_rate*100));

subplot(3,3,8);
imshow(uniform1, []);
title('Uniform Undersampled (50% sampling)');

subplot(3,3,9);
imshow(cartesian1, []);
sampling_rate = sum(cartesian_mask(:))/numel(cartesian_mask);
title(sprintf('Cartesian Undersampled (%.2f%% sampling)', sampling_rate*100));