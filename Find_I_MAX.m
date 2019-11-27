% % ��������ȷ��ͼ�����������ڵ���, ����Ϊ(����ͼ��, ģ��ߴ�)
function column_max = Find_I_MAX(Image, kernal_size)
% ת��Ϊ�Ҷ�ͼ
Image_gray = rgb2gray(Image);
% ��ʼ��ģ��
kernal = zeros(kernal_size, kernal_size);
% ���þ�ֵģ��
for i = 1 : kernal_size
    for j = 1 : kernal_size
        kernal(i, j) = 1 / (kernal_size * kernal_size);
    end
end
% ���ʵ�־ֲ�ƽ���˲�, �����������ص�����ȵ�Ӱ��, ʹ�ñ�Ե���
Image_conv = conv2(single(Image_gray), single(kernal), 'same');
% ����ͼ�����������ڵ���
[~, column_max] = find(max(max(Image_conv)) == Image_conv);