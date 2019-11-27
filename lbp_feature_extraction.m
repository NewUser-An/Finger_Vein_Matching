% % �������ھֲ�������ģʽLBP������ȡ, ����Ϊ������ͼ��, ���ֿ�ĳߴ磩
function Image_lbp_feature = lbp_feature_extraction(Image, block_size)
% ת��Ϊ�Ҷ�ͼ
Image_gray = rgb2gray(Image);
[height, width] = size(Image_gray);
Image_lbp = zeros(height - 2, width - 2);
% ����[3, 3]�������ص�LBPֵ
for i = 2 : height - 1
    for j = 2 : width - 1
        neighbor = [Image_gray(i - 1, j - 1), Image_gray(i - 1, j), Image_gray(i - 1, j + 1), Image_gray(i, j + 1), Image_gray(i + 1, j + 1), Image_gray(i + 1, j), Image_gray(i + 1, j - 1), Image_gray(i, j - 1)] >= Image_gray(i, j);
        for k = 1 : 8
            Image_lbp(i - 1, j - 1) = Image_lbp(i - 1, j - 1) + neighbor(1, k) * bitshift(1, 8 - k); 
        end
    end
end
Image_lbp = uint8(Image_lbp);
% block_hist�������ÿ�����ֱ��ͼ
[height, width] = size(Image_lbp);
block_hist = cell(1);
num = 1;
% ��ʼ�����ֿ�ĳߴ�����
height_start = 1;
height_end = height_start + block_size - 1;
width_start = 1;
width_end = width_start + block_size - 1;
for i = 1 : ceil(height / block_size)
    for j = 1 : ceil(width / block_size)
        % ������ֱ��ͼ��������block_hist��
        block_hist{1, num} = imhist(Image_lbp(height_start : height_end, width_start : width_end));
        % ֱ��ͼ��һ��
        block_hist{1, num} = block_hist{1, num} / ((height_end - height_start + 1) * (width_end - width_start + 1));
        num = num + 1;
        % ����width���������ֵ
        width_start = width_end + 1;
        width_end = width_start + block_size - 1;
        if(width_end > width)
            width_end = width;
        end
    end
    % ��ʼ��width���������ֵ
    width_start = 1;
    width_end = width_start + block_size - 1;
    % ����height���������ֵ
    height_start = height_end + 1;
    height_end = height_start + block_size - 1;
    if(height_end > height)
        height_end = height;
    end
end
% �������п��ֱ��ͼ
[~, block_num] = size(block_hist);
for count = 1 : block_num
    Image_lbp_feature((count - 1) * 256 + 1 : count * 256, 1) = block_hist{1, count};
end
% % ����ֱ��ͼ
% figure;
% [gray_level, ~] = size(Image_lbp_feature);
% stem(1 : gray_level, Image_lbp_feature, 'Marker', 'none', 'LineWidth', 3, 'color', 'b');