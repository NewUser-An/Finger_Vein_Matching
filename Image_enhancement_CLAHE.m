% % ����ʹ�����ƶԱȶ�����Ӧֱ��ͼ���⻯CLAHE����ͼ����ǿ, ����Ϊ(����ͼ��, �Աȶ���������)
function Image_clahe = Image_enhancement_CLAHE(Image, ClipLimit)
[~, ~, channel] = size(Image);
% ת��Ϊhsvͼ��
Image_hsv = rgb2hsv(Image);
% ʹ�����ƶԱȶ�����Ӧֱ��ͼ���⻯CLAHE
Image_hsv(:, :, 3) = adapthisteq(Image_hsv(:, :, 3), 'ClipLimit', ClipLimit);
% ת��Ϊrgbͼ��
Image_clahe = hsv2rgb(Image_hsv);
% ���Ҷ�ӳ�䵽[0, 255]��Χ
for c = 1 : channel
    MAX = max(max(Image_clahe(:, :, c)));
    MIN = min(min(Image_clahe(:, :, c)));
    Image_clahe(:, :, c) = (Image_clahe(:, :, c) - MIN) / (MAX - MIN) * 255;
end
Image_clahe = uint8(Image_clahe);