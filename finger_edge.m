% % 函数用于确定图像手指的边缘, 参数为(输入图像, 检索的轮次, 检索的阈值), 检索多个轮次取平均, 超过检索的阈值则停止当前检索
function [edge_left_start_avg, edge_left_end_avg, edge_right_start_avg, edge_right_end_avg] = finger_edge(Image, count, thresh)
[height, ~, ~] = size(Image);
% 转换为灰度图
Image_gray = rgb2gray(Image);
% 产生高斯滤波模板, 大小为5x5, 标准差为1
gauss = fspecial('gaussian', [5, 5], 1);
% 高斯滤波，使用'replicate'填充边缘
Image_gauss = imfilter(Image_gray, gauss, 'replicate');
% figure
% imshow(Image_gauss)
% 使用sobel算子进行边缘检测
Image_edge = edge(Image_gauss,'sobel');
% figure
% imshow(Image_edge)
% 确定图像左侧手指的上边缘, 从图像中间位置开始检索直至找到边缘
column = 1;
edge_left_start = zeros(1, count);
for i = 1 : count
    edge_left_start(i) = round(height / 2);
    while Image_edge(edge_left_start(i), column) == 0
        edge_left_start(i) = edge_left_start(i) - 1;
        % 超过阈值则停止当前检索
        if round(height / 2) - edge_left_start(i) == thresh
            column = column + 1;
            edge_left_start(i) = round(height / 2);
        end
    end
    column = column + 1;
end
% 多次检索取平均
edge_left_start_avg = round(sum(edge_left_start) / count);
% 确定图像左侧手指的下边缘
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
% 确定图像右侧手指的上边缘
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
% 确定图像右侧手指的下边缘
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