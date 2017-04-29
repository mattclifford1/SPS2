function ABnearestNeighbour(feature1,feature2)
close all
train = [feature1,feature2];
trainS = [feature1(1:10),feature2(1:10)];
trainT = [feature1(11:20),feature2(11:20)];
trainV = [feature1(21:30),feature2(21:30)];

% addpath(genpath(strcat(pwd,'/testData')));

passS = 0; passT = 0; passV = 0;
fail = [];

A = []; B = []; C = [];
for i = [0:100]
    for j = [0:100]
        dists = pdist2(train,[i,j]);
        [dist,ind] = min(dists);
        if ind > 0 && ind < 11
            A = [A;[i,j]];
        end
        if ind > 10 && ind < 21
            B = [B;[i,j]];
        end
        if ind > 20 && ind < 31
            C = [C;[i,j]];
        end
    end
end

% % TEST DATA ---------------------------------------------------------------
global max1; global max2;
myFolder = strcat(pwd,'/AB');

fileGeneralS = fullfile(myFolder, '*.GIF');
pngFilesS = dir(fileGeneralS);
testAB = []; 
for i = 1:length(pngFilesS)
    baseFileNameS = pngFilesS(i).name;
    fullFileNameS = fullfile(myFolder, baseFileNameS);
    testImage = prepImage(fullFileNameS);
    testAB = [testAB; (getFeature1(testImage)/max1),(getFeature2(testImage)/max2)]; 
    dists = pdist2(train,testAB(i,:));
    [dist,ind] = min(dists);
    if ind > 0 && ind < 11
        fprintf('Pass')
        passS = passS + 1;
    else
        fprintf('Fail')
        fail = [fail; testAB(i,:)];
    end
end

%PLOTTING -----------------------------------------------------------------
figure
plot(feature1(1:10),feature2(1:10),'.','MarkerSize',10)
hold on
plot(feature1(11:20),feature2(11:20),'.','MarkerSize',10)
plot(feature1(21:30),feature2(21:30),'.','MarkerSize',10)
xlabel('Feature 1'); ylabel('Feature 2');
% plot(testS(:,1),testS(:,2),'x','LineWidth',2)
% plot(testT(:,1),testT(:,2),'x','LineWidth',2)
% plot(testV(:,1),testV(:,2),'x','LineWidth',2)
% plot(fail(:,1),fail(:,2),'o','MarkerSize',20)
% legend('S','T','V','testS','testT','testV','failed')
dot = 20; do1 = 5;
% figure
plot(A(:,1),A(:,2),'.','color',[.8 1 1],'MarkerSize',dot);
hold on
plot(B(:,1),B(:,2),'.','color',[1 .8 1],'MarkerSize',dot);
plot(C(:,1),C(:,2),'.','color',[1 1 .8],'MarkerSize',dot);
plot(feature1(1:10),feature2(1:10),'o','color',[0 0.5 0.5],'MarkerSize',do1)
plot(feature1(11:20),feature2(11:20),'x','color',[0.5 0 0.5],'MarkerSize',do1)
plot(feature1(21:30),feature2(21:30),'d','color',[0.5 0.5 0],'MarkerSize',do1)





