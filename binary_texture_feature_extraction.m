% % �������ڶ�ֵ����������ȡ, ����Ϊ������ͼ��, ��ֵ����ֵ��
function Image_binary_texture_feature = binary_texture_feature_extraction(Image, thresh)
[~, ~, channel] = size(Image);
Image = single(Image);
for c = 1 : channel
    % ����gabor�˲�
    Image_gabor(:, :, c) = imfilter(Image(:, :, c), gabor_fn(1, 90, 20, 0, 1.5), 'replicate', 'conv');
    % ���Ҷ�ӳ�䵽[0, 255]��Χ
    MAX = max(max(Image_gabor(:, :, c)));
    MIN = min(min(Image_gabor(:, :, c)));
    Image_gabor(:, :, c) = (Image_gabor(:, :, c) - MIN) / (MAX - MIN) * 255;
end
Image_gabor = uint8(Image_gabor);
% figure
% imshow(Image_gabor)
% ����ͼ���ֵ��, ��ȡ��ֵ��������
Image_binary_texture_feature = im2bw(Image_gabor, thresh);
% figure
% imshow(Image_binary_texture_feature)