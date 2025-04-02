%created by Saurabh Kamble
% Edge Detection using Canny, Prewitt, and Sobel - Without Built-in Functions

% Read the input image
img = imread('https://c0.wallpaperflare.com/preview/372/509/315/people-india-indian-man-thumbnail.jpg');  % Replace 'input_image.jpg' with your image path

% Convert the image to grayscale if it is RGB
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Convert to double for processing     
img = double(img);

% Apply Gaussian smoothing manually (optional for edge detection)
% Creating a simple 3x3 Gaussian Kernel for smoothing
G = fspecial('gaussian', [3, 3], 1);
smoothed_img = conv2(img, G, 'same');

% Sobel Edge Detection (Manual Implementation)
% Sobel kernels for horizontal and vertical edges
sobel_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];

% Convolution with Sobel kernels
gradient_x_sobel = conv2(smoothed_img, sobel_x, 'same');
gradient_y_sobel = conv2(smoothed_img, sobel_y, 'same');

% Edge magnitude and direction for Sobel
sobel_magnitude = sqrt(gradient_x_sobel.^2 + gradient_y_sobel.^2);
sobel_edges = sobel_magnitude > 100;  % Threshold to detect edges

% Prewitt Edge Detection (Manual Implementation)
% Prewitt kernels for horizontal and vertical edges
prewitt_x = [-1 0 1; -1 0 1; -1 0 1];
prewitt_y = [-1 -1 -1; 0 0 0; 1 1 1];

% Convolution with Prewitt kernels
gradient_x_prewitt = conv2(smoothed_img, prewitt_x, 'same');
gradient_y_prewitt = conv2(smoothed_img, prewitt_y, 'same');

% Edge magnitude and direction for Prewitt
prewitt_magnitude = sqrt(gradient_x_prewitt.^2 + gradient_y_prewitt.^2);
prewitt_edges = prewitt_magnitude > 100;  % Threshold to detect edges

% Canny Edge Detection (Manual Steps)
% Step 1: Gaussian smoothing (done above)

% Step 2: Gradient calculation (using Sobel for simplicity)
gradient_x_canny = conv2(smoothed_img, sobel_x, 'same');
gradient_y_canny = conv2(smoothed_img, sobel_y, 'same');
gradient_magnitude_canny = sqrt(gradient_x_canny.^2 + gradient_y_canny.^2);

% Step 3: Non-maximum suppression (thinning)
% Compute direction (angle) of the gradient
gradient_direction = atan2(gradient_y_canny, gradient_x_canny);
gradient_direction = mod(gradient_direction, pi);  % Make direction non-negative

% Initialize the edge image (same size as input)
non_max_suppressed = zeros(size(img));

% For each pixel, perform non-maximum suppression
for i = 2:size(smoothed_img, 1)-1
    for j = 2:size(smoothed_img, 2)-1
        angle = gradient_direction(i, j);
        if (angle >= 0 && angle < pi/8) || (angle >= 7*pi/8 && angle < pi)
            % Horizontal edge (0 degrees)
            neighbors = [gradient_magnitude_canny(i, j-1), gradient_magnitude_canny(i, j+1)];
        elseif (angle >= pi/8 && angle < 3*pi/8)
            % Diagonal edge (45 degrees)
            neighbors = [gradient_magnitude_canny(i-1, j-1), gradient_magnitude_canny(i+1, j+1)];
        elseif (angle >= 3*pi/8 && angle < 5*pi/8)
            % Vertical edge (90 degrees)
            neighbors = [gradient_magnitude_canny(i-1, j), gradient_magnitude_canny(i+1, j)];
        elseif (angle >= 5*pi/8 && angle < 7*pi/8)
            % Diagonal edge (135 degrees)
            neighbors = [gradient_magnitude_canny(i-1, j+1), gradient_magnitude_canny(i+1, j-1)];
        end
        
        % Non-maximum suppression: keep the pixel if it's a local maximum
        if gradient_magnitude_canny(i, j) >= max(neighbors)
            non_max_suppressed(i, j) = gradient_magnitude_canny(i, j);
        end
    end
end

% Step 4: Hysteresis (thresholding to track edges)
high_threshold = 100;  % Define thresholds for edge detection
low_threshold = 50;

% Create the final edge image based on hysteresis
final_edges = zeros(size(img));
for i = 1:size(non_max_suppressed, 1)
    for j = 1:size(non_max_suppressed, 2)
        if non_max_suppressed(i, j) >= high_threshold
            final_edges(i, j) = 1;
        elseif non_max_suppressed(i, j) >= low_threshold
            % Check if it's connected to a strong edge pixel
            if any(final_edges(i-1:i+1, j-1:j+1) == 1)
                final_edges(i, j) = 1;
            end
        end
    end
end

% Display the results
figure;
subplot(2, 2, 1);
imshow(img, []);
title('Original Image');

subplot(2, 2, 2);
imshow(sobel_edges, []);
title('Sobel Edge Detection');

subplot(2, 2, 3);
imshow(prewitt_edges, []);
title('Prewitt Edge Detection');

subplot(2, 2, 4);
imshow(final_edges, []);
title('Canny Edge Detection');
