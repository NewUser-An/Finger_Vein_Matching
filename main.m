clear;clc;
% ��ʼ���洢�ṹ
Image_feature = cell(4, 10);
count = 0;
% ��ȡͼ������
for i = 81 : 84
    count = count + 1;
    for j = 1 : 10
        filename = sprintf('./Image/5%d-%d.bmp', i, j);%��ȡ/Image/5�ַ�-�ַ� �����ݸ�ʽ��תΪ�ַ���
        Image = imread(filename);
        Image_feature{count, j} = Feature_extraction(Image);
    end
end

% ��ȡ����ƥ�����
count = 0;
for i = 1 : 4
    for j = 1 : 9
        for k = j + 1 : 10
            count = count + 1;
            score_within(1, count) = roundn(Feature_match(Image_feature{i, j}, Image_feature{i, k}), -2);
        end
    end
end

% ��ȡ���ƥ�����
count = 0;
for i = 1 : 3
    for j = i + 1 : 4
        for m = 1 : 10
            for n = 1 : 10
                count = count + 1;
                score_between(1, count) = roundn(Feature_match(Image_feature{i, m}, Image_feature{j, n}), -2);
            end
        end
    end
end

% ����ֱ��ͼ
x_axis = 0 : 0.01 : 1;
figure;
counts_within = hist(score_within, x_axis);
counts_between = hist(score_between, x_axis);
% ���Ӹ�ֱ��ͼ���е��������ͼ
plot(x_axis, counts_within, 'g', x_axis, counts_between, 'r');
xlabel('ƥ�����ر���');
ylabel('ƥ�����ر���ͳ��');