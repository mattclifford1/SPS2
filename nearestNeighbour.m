function nearestNeighbour(feature1,feature2,testImage)
close all
train = [feature1,feature2];
S = [feature1(1:10),feature2(1:10)];
T = [feature1(11:20),feature2(11:20)];
V = [feature1(21:30),feature2(21:30)];

addpath(genpath('/Users/mattclifford/Documents/SPS/CourseWork2/characters/testData'))
% testImage = prepImage(testImage);
% test = [getFeature1(testImage),getFeature2(testImage)];
% dists = pdist2(train,test);
% [dist,ind] = min(dists);
% if ind > 0 && ind < 11
%     fprintf('letter is an S\n')
% %     title('letter is an S')
% elseif ind > 10 && ind < 21
%     fprintf('letter is a T\n')
% %     title('letter is a T')
% else
%     fprintf('letter is a V\n')
% %     title('letter is a V')
% end

myFolder = '/Users/mattclifford/Documents/SPS/CourseWork2/characters/testData';
filePattern = fullfile(myFolder, '*.png');
pngFiles = dir(filePattern)
test = [];
for i = 1:length(pngFiles)
    fprintf('\n%d: \n',i)
    baseFileName = pngFiles(i).name;
    fullFileName = fullfile(myFolder, baseFileName);
    testImage = prepImage(fullFileName);
    test = [test; getFeature1(testImage),getFeature2(testImage)]; 
end

figure
scatter(feature1(1:10),feature2(1:10))
hold on
scatter(feature1(11:20),feature2(11:20))
scatter(feature1(21:30),feature2(21:30))
xlabel('Feature 1'); ylabel('Feature 2');
test
plot(test([1:4],1),test([1:4],2),'x','LineWidth',2)
plot(test([5:9],1),test([5:9],2),'x','LineWidth',2)
plot(test([10:end],1),test([10:end],2),'x','LineWidth',2)
legend('S','T','V','testS','testT','testV')


