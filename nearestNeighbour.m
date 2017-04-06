function nearestNeighbour(feature1,feature2,testImage)
close all
train = [feature1,feature2];
S = [feature1(1:10),feature2(1:10)];
T = [feature1(11:20),feature2(11:20)];
V = [feature1(21:30),feature2(21:30)];

addpath(genpath('/Users/mattclifford/Documents/SPS/CourseWork2/characters/testData'))
testImage = prepImage(testImage);
test = [getFeature1(testImage),getFeature2(testImage)];
dists = pdist2(train,test);
[dist,ind] = min(dists);
if ind > 0 && ind < 11
    fprintf('letter is an S\n')
    title('letter is an S')
elseif ind > 10 && ind < 21
    fprintf('letter is a T\n')
    title('letter is a T')
else
    fprintf('letter is a V\n')
    title('letter is a V')
end


