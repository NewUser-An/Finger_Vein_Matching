% % ����������ȡͼ���ROI����, ����Ϊ(����ͼ��, ROI����ߴ�)
function Image_ROI = ROI_extraction(Image, ROI_size)
[height, width, ~] = size(Image);
% ȷ��ͼ����ָ�ı�Ե
[edge_left_start_avg, edge_left_end_avg, edge_right_start_avg, edge_right_end_avg] = finger_edge(Image, 50, 200);
% ȷ�������ָ�е�
midpoint_left = round((edge_left_end_avg - edge_left_start_avg) / 2) + edge_left_start_avg;
% ȷ���Ҳ���ָ�е�
midpoint_right = round((edge_right_end_avg - edge_right_start_avg) / 2) + edge_right_start_avg;
% ������ת�ǶȲ���תԭͼ��У��, �ü�����ڱ�
rotate_angle = atan((midpoint_left - midpoint_right) / width) / pi * 180;
Image_rotate = imrotate(Image, -rotate_angle, 'crop');
Image_rotate = Image_rotate(:, round(height / 2 * abs(tan(rotate_angle / 180 * pi))) + 1 : width - round(height / 2 * abs(tan(rotate_angle / 180 * pi))), :);
% figure
% imshow(Image_rotate)
% ����ȷ����ת��ͼ����ָ�ı�Ե�������е�
[edge_left_start_avg, edge_left_end_avg, edge_right_start_avg, edge_right_end_avg] = finger_edge(Image_rotate, 100, 200);
midpoint_left = round((edge_left_end_avg - edge_left_start_avg) / 2) + edge_left_start_avg;
midpoint_right = round((edge_right_end_avg - edge_right_start_avg) / 2) + edge_right_start_avg;
% �����ȡ����Ŀ�Ⱥ��е�
if (edge_left_end_avg - edge_left_start_avg) < (edge_right_end_avg - edge_right_start_avg)
    finger_height = (edge_left_end_avg - edge_left_start_avg);
    midpoint = midpoint_left;
else
    finger_height = (edge_right_end_avg - edge_right_start_avg);
    midpoint = midpoint_right;
end
% ��ȡ��ָ�������±߽�
Image_finger_height = Image_rotate(midpoint - round(finger_height / 2) + 10 : midpoint + round(finger_height / 2) - 10, :, :);
% figure
% imshow(Image_finger_height)
% �ҳ�ͼ�������Ĳ���, �Դ�Ϊ�޽�ȡ��ָ�������ұ߽�
Image_finger_width = Image_finger_height(:, 1 : Find_I_MAX(Image_finger_height, 71), :);
% ��ȡROI����
[height, width, ~] = size(Image_finger_width);
Image_ROI = Image_finger_width(round(height / 2) - round(ROI_size(1) / 2) + 1 : round(height / 2) + round(ROI_size(1) / 2), round(width / 2) - round(ROI_size(2) / 2) + 1 : round(width / 2) + round(ROI_size(2) / 2), :);