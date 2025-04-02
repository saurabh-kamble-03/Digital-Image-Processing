%created by Saurabh Kamble
% Edge Detection using Sobel, Prewitt, and Canny

% Read the input image
img = imread('https://c0.wallpaperflare.com/preview/372/509/315/people-india-indian-man-thumbnail.jpg');  % Replace 'input_image.jpg' with your image path

% Convert the image to grayscale if it is RGB
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Apply Gaussian smoothing to reduce noise
smoothed_img = imgaussfilt(img, 2);  % You can adjust the standard deviation for the Gaussian filter

% Sobel Edge Detection
sobel_edges = edge(smoothed_img, 'Sobel');

% Prewitt Edge Detection
prewitt_edges = edge(smoothed_img, 'Prewitt');

% Canny Edge Detection
canny_edges = edge(smoothed_img, 'Canny');

% Display the results
figure;
subplot(2, 2, 1);
imshow(img);
title('Original Image');

subplot(2, 2, 2);
imshow(sobel_edges);
title('Sobel Edge Detection');

subplot(2, 2, 3);
imshow(prewitt_edges);
title('Prewitt Edge Detection');

subplot(2, 2, 4);
imshow(canny_edges);
title('Canny Edge Detection');
