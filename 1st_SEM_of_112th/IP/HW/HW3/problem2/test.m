file_name = "blurry-moon.tif";
c = -1;

im = sharpen_by_frequency_laplacian(file_name,c);

imshow(im)
