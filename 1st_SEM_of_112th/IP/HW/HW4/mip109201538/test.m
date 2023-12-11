clear; close all; clc;

file_name = 'iris-RGB.tif';
im = imread(file_name);
im = double(im);

sizes = size(im);
H = sizes(1);       % image heigh
W = sizes(2);       % image width

for k = [3 5]
    for gamma = [0 0.2 0.5]

        num_trial = 2;

        % 創建5 x (H * W)的矩陣im_vec，每一行代表一個像素。
        % 第一列代表R，第二列代表G，第三列代表B，第四列為gamma*x，第五列為gamma*y
        im_vec = zeros(5, H * W);
        idx = 1;
        for h = 1: H
            for w = 1: W
                rgb = im(h, w, :);

                im_vec(:, idx) = [rgb(:); h * gamma; w * gamma];
                idx = idx + 1;
            end
        end

        [indicies, centers, err] = my_kmeans(double(im_vec), k, num_trial);

        segmented_im = zeros(size(im));

        % 寫入segmented_im，維度為H x W x 3，和im一樣。
        % 對每個像素而言，從indicies中查出它屬於哪個群
        % 然後把那個群的平均值中對應到RGB的三個維度寫進segmented_im中
        idx = 1;
        for h = 1: H
            for w = 1: W
                center = centers(:, indicies(idx));
                center = center(1: end - 2, :);
                segmented_im(h, w, :) = center;
                idx = idx + 1;
            end
        end

        figure("Name",sprintf("k = %d, gamma = %.2f",k,gamma));
        subplot(1, 2, 1);
        imshow(im / 255, []);
        subplot(1, 2, 2);
        imshow(segmented_im / 255, [0, 1]);
        fprintf("k = %d, gamma = %.2f\nerr = %.2g\n",k,gamma,err)
        centers
    end
end
