% % 函数使用限制对比度自适应直方图均衡化CLAHE用于图像增强, 参数为(输入图像, 对比度限制因子)
function Image_clahe = Image_enhancement_CLAHE(Image, ClipLimit)
[~, ~, channel] = size(Image);
% 转化为hsv图像
Image_hsv = rgb2hsv(Image);
% 使用限制对比度自适应直方图均衡化CLAHE
Image_hsv(:, :, 3) = adapthisteq(Image_hsv(:, :, 3), 'ClipLimit', ClipLimit);
% 转化为rgb图像
Image_clahe = hsv2rgb(Image_hsv);
% 将灰度映射到[0, 255]范围
for c = 1 : channel
    MAX = max(max(Image_clahe(:, :, c)));
    MIN = min(min(Image_clahe(:, :, c)));
    Image_clahe(:, :, c) = (Image_clahe(:, :, c) - MIN) / (MAX - MIN) * 255;
end
Image_clahe = uint8(Image_clahe);