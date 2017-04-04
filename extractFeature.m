tic
myFolder = '/Users/mattclifford/Documents/SPS/CourseWork2/characters/trainGIF';

filePattern = fullfile(myFolder, '*.GIF');
gifFiles = dir(filePattern);
feature1 = zeros(length(gifFiles),1);
feature2 = zeros(length(gifFiles),1);
for i = 1:length(gifFiles)
  baseFileName = gifFiles(i).name;
  fullFileName = fullfile(myFolder, baseFileName);
  feature1(i) = getFeature1(fullFileName);
  feature2(i) = getFeature2(fullFileName);
end
scatter(feature1(1:10),feature2(1:10))
hold on
scatter(feature1(11:20),feature2(11:20))
scatter(feature1(21:30),feature2(21:30))
xlabel('Feature 1'); ylabel('Feature 2'); 
toc