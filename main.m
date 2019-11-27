clear;clc;
% 初始化存储结构
Image_feature = cell(4, 10);
count = 0;
% 提取图像特征
for i = 81 : 84
    count = count + 1;
    for j = 1 : 10
        filename = sprintf('./Image/5%d-%d.bmp', i, j);%获取/Image/5字符-字符 将数据格式化转为字符串
        Image = imread(filename);
        Image_feature{count, j} = Feature_extraction(Image);
    end
end

% 获取类内匹配分数
count = 0;
for i = 1 : 4
    for j = 1 : 9
        for k = j + 1 : 10
            count = count + 1;
            score_within(1, count) = roundn(Feature_match(Image_feature{i, j}, Image_feature{i, k}), -2);
        end
    end
end

% 获取类间匹配分数
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

% 绘制直方图
x_axis = 0 : 0.01 : 1;
figure;
counts_within = hist(score_within, x_axis);
counts_between = hist(score_between, x_axis);
% 连接各直方图的中点绘制曲线图
plot(x_axis, counts_within, 'g', x_axis, counts_between, 'r');
xlabel('匹配像素比例');
ylabel('匹配像素比例统计');