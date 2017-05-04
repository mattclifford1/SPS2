clear all
myFolder = strcat(pwd,'/trainGIF');
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
end
global max1; global max2; 
max1 = max(feature1)/100; max2 = max(feature2)/100;
feature1 = feature1/max1;
feature2 = feature2/max2;

hold off
dot = 20; do1 = 5;
plot(feature1(1:10),feature2(1:10),'o','color',[0 0.5 0.5],'MarkerSize',do1)
hold on
plot(feature1(11:20),feature2(11:20),'x','color',[0.5 0 0.5],'MarkerSize',do1)
plot(feature1(21:30),feature2(21:30),'d','color',[0.5 0.5 0],'MarkerSize',do1)
xlabel('Feature 1'); ylabel('Feature 2');

legend('S','T','V')
timeElapsed
