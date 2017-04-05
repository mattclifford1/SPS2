function rescaledG = prepImage(testImage)

addpath(genpath('/Users/mattclifford/Documents/SPS/CourseWork2/characters/testData'))

I = imread(testImage);
G = rgb2gray(I);
rescaledG = imresize(G,[640 400]);
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
figure(1);subplot(2,2,1); imagesc(rescaledG);
