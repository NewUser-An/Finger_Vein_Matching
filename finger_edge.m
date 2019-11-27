% % ��������ȷ��ͼ����ָ�ı�Ե, ����Ϊ(����ͼ��, �������ִ�, ��������ֵ), ��������ִ�ȡƽ��, ������������ֵ��ֹͣ��ǰ����
function [edge_left_start_avg, edge_left_end_avg, edge_right_start_avg, edge_right_end_avg] = finger_edge(Image, count, thresh)
[height, ~, ~] = size(Image);
% ת��Ϊ�Ҷ�ͼ
Image_gray = rgb2gray(Image);
% ������˹�˲�ģ��, ��СΪ5x5, ��׼��Ϊ1
gauss = fspecial('gaussian', [5, 5], 1);
% ��˹�˲���ʹ��'replicate'����Ե
Image_gauss = imfilter(Image_gray, gauss, 'replicate');
% figure
% imshow(Image_gauss)
% ʹ��sobel���ӽ��б�Ե���
Image_edge = edge(Image_gauss,'sobel');
% figure
% imshow(Image_edge)
% ȷ��ͼ�������ָ���ϱ�Ե, ��ͼ���м�λ�ÿ�ʼ����ֱ���ҵ���Ե
column = 1;
edge_left_start = zeros(1, count);
for i = 1 : count
    edge_left_start(i) = round(height / 2);
    while Image_edge(edge_left_start(i), column) == 0
        edge_left_start(i) = edge_left_start(i) - 1;
        % ������ֵ��ֹͣ��ǰ����
        if round(height / 2) - edge_left_start(i) == thresh
            column = column + 1;
            edge_left_start(i) = round(height / 2);
        end
    end
    column = column + 1;
end
% ��μ���ȡƽ��
edge_left_start_avg = round(sum(edge_left_start) / count);
% ȷ��ͼ�������ָ���±�Ե
column = 1;
edge_left_end = zeros(1, count);
for i = 1 : count
    edge_left_end(i) = round(height / 2);
    while Image_edge(edge_left_end(i), column) == 0
        edge_left_end(i) = edge_left_end(i) + 1;
        if edge_left_end(i) - round(height / 2) == thresh
            column = column + 1;
            edge_left_end(i) = round(height / 2);
        end
    end
    column = column + 1;
end
edge_left_end_avg = round(sum(edge_left_end) / count);
% ȷ��ͼ���Ҳ���ָ���ϱ�Ե
column = 480;
edge_right_start = zeros(1, count);
for i = 1 : count
    edge_right_start(i) = round(height / 2);
    while Image_edge(edge_right_start(i), column) == 0
        edge_right_start(i) = edge_right_start(i) - 1;
        if round(height / 2) - edge_right_start(i) == thresh
            column = column - 1;
            edge_right_start(i) = round(height / 2);
        end
    end
    column = column - 1;
end
edge_right_start_avg = round(sum(edge_right_start) / count);
% ȷ��ͼ���Ҳ���ָ���±�Ե
column = 480;
edge_right_end = zeros(1, count);
for i = 1 : count
    edge_right_end(i) = round(height / 2);
    while Image_edge(edge_right_end(i), column) == 0
        edge_right_end(i) = edge_right_end(i) + 1;
        if edge_right_end(i) - round(height / 2) == thresh
            column = column - 1;
            edge_right_end(i) = round(height / 2);
        end
    end
    column = column - 1;
end
edge_right_end_avg = round(sum(edge_right_end) / count);