function nearestNeighbour(feature1,feature2)
close all
train = [feature1,feature2];
trainS = [feature1(1:10),feature2(1:10)];
trainT = [feature1(11:20),feature2(11:20)];
trainV = [feature1(21:30),feature2(21:30)];

addpath(genpath(strcat(pwd,'/testData')));
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

failS = 0; failT = 0; failV = 0;
% TEST DATA ---------------------------------------------------------------
global max1; global max2;
myFolder = strcat(pwd,'/testData/Test2');

fileGeneralS = fullfile(myFolder, 'S*.png');
pngFilesS = dir(fileGeneralS);
testS = []; 
for i = 1:length(pngFilesS)
    fprintf('\nS%d: ',i)
    baseFileNameS = pngFilesS(i).name;
    fullFileNameS = fullfile(myFolder, baseFileNameS);
    testImage = prepImage(fullFileNameS);
    testS = [testS; (getFeature1(testImage)/max1),(getFeature2(testImage)/max2)]; 
    dists = pdist2(train,testS(i,:));
    [dist,ind] = min(dists);
    if ind > 0 && ind < 11
        fprintf('Pass')
    else
        fprintf('Fail')
        failS = failS + 1;
    end
end

fileGeneralT = fullfile(myFolder, 'T*.png');
pngFilesT = dir(fileGeneralT);
testT = [];
for i = 1:length(pngFilesT)
    fprintf('\nT%d: ',i)
    baseFileNameT = pngFilesT(i).name;
    fullFileNameT = fullfile(myFolder, baseFileNameT);
    testImage = prepImage(fullFileNameT);
    testT = [testT; (getFeature1(testImage)/max1),(getFeature2(testImage)/max2)];
    dists = pdist2(train,testT(i,:));
    [dist,ind] = min(dists);
    if ind > 10 && ind < 21
        fprintf('Pass')
    else
        fprintf('Fail')
        failT = failT + 1;
    end
end

fileGeneralV = fullfile(myFolder, 'V*.png');
pngFilesV = dir(fileGeneralV);
testV = [];
for i = 1:length(pngFilesV)
    fprintf('\nV%d: ',i)
    baseFileNameV = pngFilesV(i).name;
    fullFileNameV = fullfile(myFolder, baseFileNameV);
    testImage = prepImage(fullFileNameV);
    testV = [testV; (getFeature1(testImage)/max1),(getFeature2(testImage)/max2)];
    dists = pdist2(train,testV(i,:));
    [dist,ind] = min(dists);
    if ind > 20 && ind < 31
        fprintf('Pass')
    else
        fprintf('Fail')
        failV = failV + 1;
    end
end
totalS = length(testS); totalT = length(testT); totalV = length(testV);

fprintf('\nS fail rate: %d out of %d\n',failS,totalS)
fprintf('\nT fail rate: %d out of %d\n',failT,totalT)
fprintf('\nV fail rate: %d out of %d\n',failV,totalV)
%PLOTTING -----------------------------------------------------------------
figure
plot(feature1(1:10),feature2(1:10),'.','MarkerSize',10)
hold on
plot(feature1(11:20),feature2(11:20),'.','MarkerSize',10)
plot(feature1(21:30),feature2(21:30),'.','MarkerSize',10)
xlabel('Feature 1'); ylabel('Feature 2');
plot(testS(:,1),testS(:,2),'x','LineWidth',2)
plot(testT(:,1),testT(:,2),'x','LineWidth',2)
plot(testV(:,1),testV(:,2),'x','LineWidth',2)
legend('S','T','V','testS','testT','testV')




