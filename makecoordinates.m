
clear
close all
clc

[ img_discrete ] = extractpixels('starryplace2.png');

figure;
imshow(img_discrete);
img_siz = size(img_discrete);

img_final = make_numbered_image(img_discrete, false(img_siz(1:2)), [11 21], false);


%% show
figure;
imshow(img_final);
imwrite(img_final, 'starryplace-numbered.png');

%% save
