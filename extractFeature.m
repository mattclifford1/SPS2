tic

myFolder = strcat(pwd,'/trainGIF');

% myFolder = '/Users/mattclifford/Documents/SPS/CourseWork2/characters/trainGIF';
% myFolder = '/home/fe15/jc15311/linux/Documents/MATLAB/CW2/SPS2/trainGIF';
timeElapsed = 0;
filePattern = fullfile(myFolder, '*.GIF');
gifFiles = dir(filePattern);
feature1 = zeros(length(gifFiles),1);
feature2 = zeros(length(gifFiles),1);
feature3 = zeros(length(gifFiles),1);
for i = 1:length(gifFiles)
  fprintf('\n%d: \n',i)
  baseFileName = gifFiles(i).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf('doing feature 1: ')
  tic
  feature1(i) = getFeature1(fullFileName);
  toc
  timeElapsed = toc + timeElapsed;
  fprintf('doing feature 2: ')
  tic
  feature2(i) = getFeature2(fullFileName);
  toc
  timeElapsed = toc + timeElapsed;
%   feature3(i) = getFeature3(fullFileName);
end
global max1; global max2; 
max1 = max(feature1); max2 = max(feature2);
feature1 = feature1/max1;
feature2 = feature2/max2;

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
% Class1 = [feature1(1:10),feature2(1:10)];
% Class2 = [feature1(11:20),feature2(11:20)];
% Class3 = [feature1(21:30),feature2(21:30)];
% Mean1 = mean(Class1)
% Sum1 = sum(abs( [(Class1(:,1)-Mean1(1)),(Class1(:,2)-Mean1(2))]) )
% Sum1R = round(Sum1)

legend('S','T','V')
toc
timeElapsed
