function im = sharpen_by_frequency_laplacian(file_name, c)
%% setting
close all;

im = imread(file_name);
im = double(im);

im = im / max(abs(im(:)));

fft_im = fft2(im);

fft_im_laplacian = zeros(size(im));

for i = 1:size(im,1)
    for j = 1:size(im,2)
        fft_im_laplacian(i,j) = (1-4*c*(pi^2)*(((i-1)/(size(im,1)))^2 +((j-1)/(size(im,2)))^2))*...
                                fft_im(i,j);
    end
end
lf = ifft2(fft_im_laplacian);

im = real(lf);

