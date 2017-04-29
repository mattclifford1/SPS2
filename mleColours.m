% function mle(feature1,feature2)
close all
% addpath(genpath(strcat(pwd,'/testData')));

train = [feature1,feature2];
classS = [feature1(1:10),feature2(1:10)];
classT = [feature1(11:20),feature2(11:20)];
classV = [feature1(21:30),feature2(21:30)];

%find mean and covarance of each class
muS = mean(classS); muT = mean(classT); muV = mean(classV);
covS = cov(classS); covT = cov(classT); covV = cov(classV);

Cen = [muS; muT; muV];

%calculating 3d normal distribution using means and variances
%found, meshgrid used to get good/even plotting resolution
error = 25;
res=1000;
scale1=[(linspace((min(feature1)),(max(feature1)+error),res))]'; 
scale2=[(linspace((min(feature2)),(max(feature2)+error),res))]';
scale1=[linspace(0,101,res)]'; 
scale2=[linspace(0,101,res)]';
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


passS = 0; passT = 0; passV = 0;
fail = [];
A = []; B = []; C = [];
for i = [0:100]
    for j = [0:100]
        [probsT,group] = highestProb([i,j],PROBSS,PROBST,PROBSV,X,Y);
        if group == 1
            A = [A;[i,j]];
        end
        if group == 2
            B = [B;[i,j]];
        end
        if group == 3
            C = [C;[i,j]];
        end
    end
end

%PLOTTING -----------------------------------------------------------------
hold off
sise=13;
graphtype = 2;
%mle likelihood, 2d contour of class, with mle decision boundaries
if graphtype == 2
    
    dot = 20; do1 = 5;
%     plot(classS(:,1),classS(:,2),'k.','MarkerSize',sise);
%     hold on
%     plot(classT(:,1),classT(:,2),'r.','MarkerSize',sise);
%     plot(classV(:,1),classV(:,2),'b.','MarkerSize',sise);
    plot(feature1(1:10),feature2(1:10),'o','color',[0 0.5 0.5],'MarkerSize',do1)
    hold on
    plot(feature1(11:20),feature2(11:20),'x','color',[0.5 0 0.5],'MarkerSize',do1)
    plot(feature1(21:30),feature2(21:30),'d','color',[0.5 0.5 0],'MarkerSize',do1)
    plot(Cen(:,1),Cen(:,2),'kx','MarkerSize',10,'LineWidth',2)
    %     if isempty(testS) == 0
    %         scatter(testS(:,1),testS(:,2),'k*');
    %     end
    %     if isempty(testT) == 0
    %         scatter(testT(:,1),testT(:,2),'r*');
%     end
%     if isempty(testV) == 0
%         scatter(testV(:,1),testV(:,2),'b*');
%     end
%     if isempty(fail) == 0
%         plot(fail(:,1),fail(:,2),'o','MarkerSize',20)
%     end
    legend('S','T','V','Means')
%     legend('S','T','V','Means','s','t','v','fail')
    plot(A(:,1),A(:,2),'.','color',[.8 1 1],'MarkerSize',dot);
    hold on
    plot(B(:,1),B(:,2),'.','color',[1 .8 1],'MarkerSize',dot);
    plot(C(:,1),C(:,2),'.','color',[1 1 .8],'MarkerSize',dot);
    contour(scale1,scale2,PROBSS,[densityS densityS],'color','g')
    contour(X,Y,PROBST,[densityT densityT],'color','g')
    contour(X,Y,PROBSV,[densityV densityV],'color','g')
    contour(X,Y,bound1,[1 1],'color','k')
    contour(X,Y,bound2,[1 1],'color','k')
    contour(X,Y,bound3,[1 1],'color','k')
    plot(feature1(1:10),feature2(1:10),'o','color',[0 0.5 0.5],'MarkerSize',do1)
    hold on
    plot(feature1(11:20),feature2(11:20),'x','color',[0.5 0 0.5],'MarkerSize',do1)
    plot(feature1(21:30),feature2(21:30),'d','color',[0.5 0.5 0],'MarkerSize',do1)
    plot(Cen(:,1),Cen(:,2),'kx','MarkerSize',10,'LineWidth',2)

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
