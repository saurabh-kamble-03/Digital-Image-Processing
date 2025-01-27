% created by saurabh kamble
% Bit Plane Slicing with Individual Bit Plane Display

% Read and save the image (download from the web if needed)
img_url = 'https://www.bkacontent.com/wp-content/uploads/2016/06/Depositphotos_31146757_l-2015.jpg';
websave('input_image.jpg', img_url);
img = imread('input_image.jpg');

% Convert to grayscale if not already
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Display 8 bit planes
figure;
for bit = 1:8
    % Extract the specific bit plane
    bit_plane = bitget(img, bit);
    
    % Display the bit plane
    subplot(2, 4, bit);
    imshow(logical(bit_plane)); % Convert to logical for binary display
    title(['Bit Plane ' num2str(bit)]);
end

% Remove the least significant bit (LSB) and create a new image
output_img = bitand(img, uint8(254)); % Clears bit 1

% Display original image and processed image
figure;
subplot(1, 2, 1);
imshow(img);
title('Original Image');

subplot(1, 2, 2);
imshow(output_img);
title('Image with LSB Removed');
