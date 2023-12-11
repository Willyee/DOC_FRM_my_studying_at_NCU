function [T, im] = imeq(file_name, step)
%% setting
close all;
step = double(step);
im_original = imread(file_name);
L = 256;

%% Saving the number of each intensity
num_of_intensity = zeros(L,1);
for i = 1:L     
    num_of_intensity(i) = sum(im_original(:)==i-1);
end

%% Compute the transformation function
p_of_intensity = num_of_intensity./numel(im_original);
cum_of_p = 0;
T = zeros(L,1); 

for i = 1:L
    cum_of_p = cum_of_p + p_of_intensity(i);
    T(i) = round((L/step)*cum_of_p)*step;
end

%% Transform image
im = zeros(size(im_original));
for x = 1:size(im_original,1)
    for y = 1:size(im_original,2)
        im(x,y)=T(im_original(x,y)+1);
    end
end
im = uint8(im);

%% Ploting
subplot(2, 3, 1), imshow(im_original);
subplot(2, 3, 4), histogram(im_original,0:257);

subplot(2, 3, 2), imshow(im);
subplot(2, 3, 5), histogram(im,0:257);

subplot(2, 3, 6),plot(0: L - 1, T);