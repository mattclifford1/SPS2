function nearestNeighbour(feature1,feature2)
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
dot = 5; do1 = 20
figure
plot(A(:,1),A(:,2),'.','color',[.5 .8 1],'MarkerSize',dot);
hold on
plot(B(:,1),B(:,2),'.','color',[.8 .5 1],'MarkerSize',dot);
plot(C(:,1),C(:,2),'.','color',[1 .8 .5],'MarkerSize',dot);
plot(feature1(1:10),feature2(1:10),'.','MarkerSize',do1)
hold on
plot(feature1(11:20),feature2(11:20),'.','MarkerSize',do1)
plot(feature1(21:30),feature2(21:30),'.','MarkerSize',do1)
% % TEST DATA ---------------------------------------------------------------
% global max1; global max2;
% myFolder = strcat(pwd,'/testData/Test2');
% 
% fileGeneralS = fullfile(myFolder, 'S*.png');
% pngFilesS = dir(fileGeneralS);
% testS = []; 
% for i = 1:length(pngFilesS)
%     fprintf('\nS%d: ',i)
%     baseFileNameS = pngFilesS(i).name;
%     fullFileNameS = fullfile(myFolder, baseFileNameS);
%     testImage = prepImage(fullFileNameS);
%     testS = [testS; (getFeature1(testImage)/max1),(getFeature2(testImage)/max2)]; 
%     dists = pdist2(train,testS(i,:));
%     [dist,ind] = min(dists);
%     if ind > 0 && ind < 11
%         fprintf('Pass')
%         passS = passS + 1;
%     else
%         fprintf('Fail')
%         fail = [fail; testS(i,:)];
%     end
% end
% 
% fileGeneralT = fullfile(myFolder, 'T*.png');
% pngFilesT = dir(fileGeneralT);
% testT = [];
% for i = 1:length(pngFilesT)
%     fprintf('\nT%d: ',i)
%     baseFileNameT = pngFilesT(i).name;
%     fullFileNameT = fullfile(myFolder, baseFileNameT);
%     testImage = prepImage(fullFileNameT);
%     testT = [testT; (getFeature1(testImage)/max1),(getFeature2(testImage)/max2)];
%     dists = pdist2(train,testT(i,:));
%     [dist,ind] = min(dists);
%     if ind > 10 && ind < 21
%         fprintf('Pass')
%         passT = passT + 1;
%     else
%         fprintf('Fail')
%         fail = [fail; testT(i,:)];
%     end
% end
% 
% fileGeneralV = fullfile(myFolder, 'V*.png');
% pngFilesV = dir(fileGeneralV);
% testV = [];
% for i = 1:length(pngFilesV)
%     fprintf('\nV%d: ',i)
%     baseFileNameV = pngFilesV(i).name;
%     fullFileNameV = fullfile(myFolder, baseFileNameV);
%     testImage = prepImage(fullFileNameV);
%     testV = [testV; (getFeature1(testImage)/max1),(getFeature2(testImage)/max2)];
%     dists = pdist2(train,testV(i,:));
%     [dist,ind] = min(dists);
%     if ind > 20 && ind < 31
%         fprintf('Pass')
%         passV = passV + 1;
%     else
%         fprintf('Fail')
%         fail = [fail; testV(i,:)];
%     end
% end
% totalS = length(testS); totalT = length(testT); totalV = length(testV);
% 
% fprintf('\nS pass rate: %d out of %d\n',passS,totalS)
% fprintf('\nT pass rate: %d out of %d\n',passT,totalT)
% fprintf('\nV pass rate: %d out of %d\n',passV,totalV)
% %PLOTTING -----------------------------------------------------------------
% figure
% plot(feature1(1:10),feature2(1:10),'.','MarkerSize',10)
% hold on
% plot(feature1(11:20),feature2(11:20),'.','MarkerSize',10)
% plot(feature1(21:30),feature2(21:30),'.','MarkerSize',10)
% xlabel('Feature 1'); ylabel('Feature 2');
% plot(testS(:,1),testS(:,2),'x','LineWidth',2)
% plot(testT(:,1),testT(:,2),'x','LineWidth',2)
% plot(testV(:,1),testV(:,2),'x','LineWidth',2)
% plot(fail(:,1),fail(:,2),'o','MarkerSize',20)
% legend('S','T','V','testS','testT','testV','failed')




