% % 函数用于确定图像最亮点所在的列, 参数为(输入图像, 模板尺寸)
function column_max = Find_I_MAX(Image, kernal_size)
% 转换为灰度图
Image_gray = rgb2gray(Image);
% 初始化模板
kernal = zeros(kernal_size, kernal_size);
% 采用均值模板
for i = 1 : kernal_size
    for j = 1 : kernal_size
        kernal(i, j) = 1 / (kernal_size * kernal_size);
    end
end
% 卷积实现局部平滑滤波, 消除单个像素点的亮度的影响, 使用边缘填充
Image_conv = conv2(single(Image_gray), single(kernal), 'same');
% 检索图像最亮点所在的列
[~, column_max] = find(max(max(Image_conv)) == Image_conv);