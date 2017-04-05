tic
myFolder = '/Users/mattclifford/Documents/SPS/CourseWork2/characters/trainGIF';

filePattern = fullfile(myFolder, '*.GIF');
gifFiles = dir(filePattern);
feature1 = zeros(length(gifFiles),1);
feature2 = zeros(length(gifFiles),1);
feature3 = zeros(length(gifFiles),1);
for i = 1:length(gifFiles)
  baseFileName = gifFiles(i).name;
  fullFileName = fullfile(myFolder, baseFileName);
  feature1(i) = getFeature1(fullFileName);
  feature2(i) = getFeature2(fullFileName);
%   feature3(i) = getFeature3(fullFileName);
end
hold off
feature = 2;
if feature == 2
    scatter(feature1(1:10),feature2(1:10))
    hold on
    scatter(feature1(11:20),feature2(11:20))
    scatter(feature1(21:30),feature2(21:30))
    xlabel('Feature 1'); ylabel('Feature 2');
end
if feature == 3
    scatter3(feature1(1:10),feature2(1:10),feature3(1:10))
    hold on
    scatter3(feature1(11:20),feature2(11:20),feature3(11:20))
    scatter3(feature1(21:30),feature2(21:30),feature3(21:30))
    xlabel('Feature 1'); ylabel('Feature 2'); zlabel('Feature 3')
end
legend('S','T','V')
toc