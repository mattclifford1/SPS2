function rescaledG = prepImage(testImage)

addpath(genpath(strcat(pwd,'/testData/Test2')));

I = imread(testImage);

G = rgb2gray(I);
rescaledG = imresize(G,[400 640]);
% BW = imbinarize(G);
dim = size(rescaledG);
for i = 1:dim(1)
    for j = 1:dim(2)
        if rescaledG(i,j) > 240
            rescaledG(i,j) = 1;
        else
            rescaledG(i,j) = 0;
        end
    end
end
% figure(1);subplot(2,2,1); imagesc(rescaledG);
