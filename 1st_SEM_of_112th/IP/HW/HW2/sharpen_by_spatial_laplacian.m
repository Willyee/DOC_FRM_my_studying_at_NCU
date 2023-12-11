function im = sharpen_by_spatial_laplacian(file_name, c)
%% setting
close all;

im = imread(file_name);
im = double(im);

im = im / max(abs(im(:)));

%% Laplacian convolution
la = zeros(size(im));

for i = 2:size(im,1)-1
    for j = 2:size(im,2)-1
        under_filter = im(i-1:i+1,j-1:j+1);
        la(i,j) = sum(under_filter(:)) - 9*im(i,j);
    end
end

%% plot Laplacian with c
im = im + c * la;

im = double(im);


