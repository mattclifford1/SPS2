% function mle(feature1,feature2)
close all
addpath(genpath(strcat(pwd,'/testData')));

train = [feature1,feature2];
classS = [feature1(1:10),feature2(1:10)];
classT = [feature1(11:20),feature2(11:20)];
classV = [feature1(21:30),feature2(21:30)];

%find mean and covarance of each class
muS = mean(classS); muT = mean(classT); muV = mean(classV);
covS = cov(classS); covT = cov(classT); covV = cov(classV);

C = [muS; muT; muV];

%calculating 3d normal distribution using means and variances
%found, meshgrid used to get good/even plotting resolution
error = 0.5;
res=1000;
scale1=[(linspace((min(feature1)),(max(feature1)+error),res))]'; 
scale2=[(linspace((min(feature2)),(max(feature2)+error),res))]';

%2d resolution matrix
[X Y] = meshgrid(scale1,scale2);

%calculating the probability across the area given
probsS = mvnpdf([X(:) Y(:)],muS,covS);
probsT = mvnpdf([X(:),Y(:)],muT,covT);
probsV = mvnpdf([X(:),Y(:)],muV,covV);

%Changing back to matrix
PROBSS = reshape(probsS,res,res);
PROBST = reshape(probsT,res,res);
PROBSV = reshape(probsV,res,res);

%For 95% of density 
densityS = (exp(-6/2))/(2*pi*sqrt(det(covS)));
densityT = (exp(-6/2))/(2*pi*sqrt(det(covT)));
densityV = (exp(-6/2))/(2*pi*sqrt(det(covV)));

%pair wise ratio boundaries - when the probabilites are the same, the ratio
%will equal 1 - go on to plot the contour of hieght 1 to show where the
%probabilites are the same, as a class decicsion cannot be made
bound1 = PROBSS./PROBST;
bound2 = PROBST./PROBSV;
bound3 = PROBSS./PROBSV;

%gets rid of unessary parts of the boundary by seeing if the probabilty of
%the distribution that isn't taken into account in the pair wise ratio has
%a higher probabilty, and if so making it not plot that bit of the
%boundary
for i = 1:length(bound1)
    for j = 1:length(bound1)
        if PROBSS(i,j) < PROBSV(i,j) && PROBST(i,j) < PROBSV(i,j)
            bound1(i,j) = 0;
        end
        if PROBST(i,j) < PROBSS(i,j) && PROBSV(i,j) < PROBSS(i,j)
            bound2(i,j) = 0;
        end
        if PROBSS(i,j) < PROBST(i,j) && PROBSV(i,j) < PROBST(i,j)
            bound3(i,j) = 0;
        end
    end
end

% TEST DATA ---------------------------------------------------------------
global max1; global max2;
myFolder = strcat(pwd,'/testData/Test2');

fileGeneralS = fullfile(myFolder, 'S*.png');
pngFilesS = dir(fileGeneralS);
testS = []; 
for i = 1:length(pngFilesS)
    fprintf('\n%d: \n',i)
    baseFileNameS = pngFilesS(i).name;
    fullFileNameS = fullfile(myFolder, baseFileNameS);
    testImage = prepImage(fullFileNameS);
    testS = [testS; (getFeature1(testImage)/max1),(getFeature2(testImage)/max2)]; 
    [probsS,groupS(i)] = highestProb(testS(i,:),PROBSS,PROBST,PROBSV,X,Y);
end

fileGeneralT = fullfile(myFolder, 'T*.png');
pngFilesT = dir(fileGeneralT);
testT = [];
for i = 1:length(pngFilesT)
    fprintf('\n%d: \n',i)
    baseFileNameT = pngFilesT(i).name;
    fullFileNameT = fullfile(myFolder, baseFileNameT);
    testImage = prepImage(fullFileNameT);
    testT = [testT; (getFeature1(testImage)/max1),(getFeature2(testImage)/max2)];
    [probsT,groupT(i)] = highestProb(testT(i,:),PROBSS,PROBST,PROBSV,X,Y);
end

fileGeneralV = fullfile(myFolder, 'V*.png');
pngFilesV = dir(fileGeneralV);
testV = [];
for i = 1:length(pngFilesV)
    fprintf('\n%d: \n',i)
    baseFileNameV = pngFilesV(i).name;
    fullFileNameV = fullfile(myFolder, baseFileNameV);
    testImage = prepImage(fullFileNameV);
    testV = [testV; (getFeature1(testImage)/max1),(getFeature2(testImage)/max2)];
    [probsV,groupV(i)] = highestProb(testV(i,:),PROBSS,PROBST,PROBSV,X,Y);
end

%PLOTTING -----------------------------------------------------------------
hold off
sise=13;
graphtype = 2;
%mle likelihood, 2d contour of class, with mle decision boundaries
if graphtype == 2
    plot(classS(:,1),classS(:,2),'k.','MarkerSize',sise);
    hold on
    plot(classT(:,1),classT(:,2),'r.','MarkerSize',sise);
    plot(classV(:,1),classV(:,2),'b.','MarkerSize',sise);
    plot(C(:,1),C(:,2),'kx','MarkerSize',10,'LineWidth',2)
    scatter(testS(:,1),testS(:,2),'k*');
    scatter(testT(:,1),testT(:,2),'r*');
    scatter(testV(:,1),testV(:,2),'b*');  
    legend('S','T','V','Means','s','t','v')
    contour(scale1,scale2,PROBSS,[densityS densityS],'color','g')
    contour(X,Y,PROBST,[densityT densityT],'color','g')
    contour(X,Y,PROBSV,[densityV densityV],'color','g')
    contour(X,Y,bound1,[1 1],'color','k')
    contour(X,Y,bound2,[1 1],'color','k')
    contour(X,Y,bound3,[1 1],'color','k')
    %imagesc(BOUND)
    xlabel('Feature 1');ylabel('Feature 2');
end
%mle likelihood, 3d contour of class, with mle decision boundaries
if graphtype == 3
    surf(X,Y,PROBSS)
    hold 
    surf(X,Y,PROBST)
    surf(X,Y,PROBSV)
    shading flat;
    maxProb = max(max([PROBSS;PROBST;PROBSV]));
    zlim([0 maxProb])
    contour3(X,Y,PROBSS,[densityS densityS],'k')
    contour3(X,Y,PROBST,[densityT densityT],'r')
    contour3(X,Y,PROBSV,[densityV densityV],'b')
    
    contour(X,Y,bound1,[1 1],'g')
    contour3(X,Y,bound1*maxProb,[maxProb maxProb],'g')
    contour(X,Y,bound2,[1 1],'g')
    contour3(X,Y,bound2*maxProb,[maxProb maxProb],'g')
    contour(X,Y,bound3,[1 1],'g')
    contour3(X,Y,bound3*maxProb,[maxProb maxProb],'g')
    xlabel('Feature 1');ylabel('Feature 2');
end
