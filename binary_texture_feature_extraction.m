% % 函数用于二值纹理特征提取, 参数为（输入图像, 二值化阈值）
function Image_binary_texture_feature = binary_texture_feature_extraction(Image, thresh)
[~, ~, channel] = size(Image);
Image = single(Image);
for c = 1 : channel
    % 进行gabor滤波
    Image_gabor(:, :, c) = imfilter(Image(:, :, c), gabor_fn(1, 90, 20, 0, 1.5), 'replicate', 'conv');
    % 将灰度映射到[0, 255]范围
    MAX = max(max(Image_gabor(:, :, c)));
    MIN = min(min(Image_gabor(:, :, c)));
    Image_gabor(:, :, c) = (Image_gabor(:, :, c) - MIN) / (MAX - MIN) * 255;
end
Image_gabor = uint8(Image_gabor);
% figure
% imshow(Image_gabor)
% 进行图像二值化, 提取二值纹理特征
Image_binary_texture_feature = im2bw(Image_gabor, thresh);
% figure
% imshow(Image_binary_texture_feature)