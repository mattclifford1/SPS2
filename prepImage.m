function rescaledG = prepImage(testImage)
% convert RGB image into black and white image.

I = imread(testImage);
G = rgb2gray(I);
rescaledG = imresize(G,[400 640]);
dim = size(rescaledG);
for i = 1:dim(1)  %convert to binary
    for j = 1:dim(2)
        if rescaledG(i,j) > 240
            rescaledG(i,j) = 1;
        else
            rescaledG(i,j) = 0;
        end
    end
end
