% Load the image
original_image = imread('images/camera.png');
% normalize image (rescale values between [0, 1]
original_image = im2double(original_image);

% parameters
sigma_n = 0.0025; % overall noise variance
window_size = 7; % filter window size

% adding Gaussian noise
noisy_image = imnoise(original_image, 'gaussian', 0, sigma_n);

% apply adaptive local noise reduction - our implementation
estimated_image = reduce_noise(noisy_image, sigma_n, window_size);
% apply adaptive local noise reduction - our wiener2
estimated_image_wiener = wiener2(noisy_image,[window_size window_size], sigma_n);

% Display original, noisy, and estimated images
subplot(1, 4, 1), imshow(original_image), title('Original Image');
subplot(1, 4, 2), imshow(noisy_image), title('Noisy Image');
subplot(1, 4, 3), imshow(estimated_image), title('Estimated Image');
subplot(1, 4, 4), imshow(estimated_image_wiener), title('Estimated Image - Wiener2');
