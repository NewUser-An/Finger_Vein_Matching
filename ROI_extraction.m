% % 函数用于提取图像的ROI区域, 参数为(输入图像, ROI区域尺寸)
function Image_ROI = ROI_extraction(Image, ROI_size)
[height, width, ~] = size(Image);
% 确定图像手指的边缘
[edge_left_start_avg, edge_left_end_avg, edge_right_start_avg, edge_right_end_avg] = finger_edge(Image, 50, 200);
% 确定左侧手指中点
midpoint_left = round((edge_left_end_avg - edge_left_start_avg) / 2) + edge_left_start_avg;
% 确定右侧手指中点
midpoint_right = round((edge_right_end_avg - edge_right_start_avg) / 2) + edge_right_start_avg;
% 计算旋转角度并旋转原图像校正, 裁剪两侧黑边
rotate_angle = atan((midpoint_left - midpoint_right) / width) / pi * 180;
Image_rotate = imrotate(Image, -rotate_angle, 'crop');
Image_rotate = Image_rotate(:, round(height / 2 * abs(tan(rotate_angle / 180 * pi))) + 1 : width - round(height / 2 * abs(tan(rotate_angle / 180 * pi))), :);
% figure
% imshow(Image_rotate)
% 重新确定旋转后图像手指的边缘和两侧中点
[edge_left_start_avg, edge_left_end_avg, edge_right_start_avg, edge_right_end_avg] = finger_edge(Image_rotate, 100, 200);
midpoint_left = round((edge_left_end_avg - edge_left_start_avg) / 2) + edge_left_start_avg;
midpoint_right = round((edge_right_end_avg - edge_right_start_avg) / 2) + edge_right_start_avg;
% 计算截取区域的宽度和中点
if (edge_left_end_avg - edge_left_start_avg) < (edge_right_end_avg - edge_right_start_avg)
    finger_height = (edge_left_end_avg - edge_left_start_avg);
    midpoint = midpoint_left;
else
    finger_height = (edge_right_end_avg - edge_right_start_avg);
    midpoint = midpoint_right;
end
% 截取手指区域上下边界
Image_finger_height = Image_rotate(midpoint - round(finger_height / 2) + 10 : midpoint + round(finger_height / 2) - 10, :, :);
% figure
% imshow(Image_finger_height)
% 找出图像最亮的部分, 以此为限截取手指区域左右边界
Image_finger_width = Image_finger_height(:, 1 : Find_I_MAX(Image_finger_height, 71), :);
% 截取ROI区域
[height, width, ~] = size(Image_finger_width);
Image_ROI = Image_finger_width(round(height / 2) - round(ROI_size(1) / 2) + 1 : round(height / 2) + round(ROI_size(1) / 2), round(width / 2) - round(ROI_size(2) / 2) + 1 : round(width / 2) + round(ROI_size(2) / 2), :);