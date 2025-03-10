% Watermarking using Bit Plane Slicing
% Created by Srinivas vatsav
clc; clear; close all;

% Load Original Image
img = imread('https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630');
if size(img,3) == 3
    img = rgb2gray(img);
end

% Load Watermark Image (Must be smaller than original)
watermark = imread('https://cdn3.pixelcut.app/7/20/uncrop_hero_bdf08a8ca6.jpg');
if size(watermark,3) == 3
    watermark = rgb2gray(watermark);
end
watermark = imresize(watermark, size(img)); % Resize to match original image

% Convert images to binary representation
img_bin = dec2bin(img, 8);
watermark_bin = dec2bin(watermark, 8);

% Embed watermark into the least significant bit (LSB)
img_bin(:,8) = watermark_bin(:,1); % Replace LSB of original image with MSB of watermark
img_watermarked = uint8(bin2dec(img_bin));

% Save and Display Watermarked Image
imwrite(img_watermarked, 'watermarked_image.png');
figure;
subplot(1,3,1); imshow(img); title('Original Image');
subplot(1,3,2); imshow(img_watermarked); title('Watermarked Image');
subplot(1,3,3); imshow(watermark, []); title('Watermark');

% -------------------- Watermark Extraction --------------------

% Extract watermark from LSB of watermarked image
img_watermarked_bin = dec2bin(img_watermarked, 8);
extracted_watermark_bin = img_watermarked_bin(:,8); % Extract LSB as watermark
extracted_watermark = uint8(bin2dec(extracted_watermark_bin));
extracted_watermark = reshape(extracted_watermark, size(img));

% Save and Display Extracted Watermark
imwrite(extracted_watermark, 'extracted_watermark.png');
figure;
subplot(1,2,1); imshow(img_watermarked); title('Watermarked Image');
subplot(1,2,2); imshow(extracted_watermark, []); title('Extracted Watermark');