function count = getFeature1(FILE)
addpath(genpath(strcat(pwd,'/trainGIF')));
addpath(genpath(strcat(pwd,'/AB')));
% addpath(genpath(strcat(pwd,'/testData/Test2')));
if ischar(FILE) == 1
    F = imread(FILE);  %read in image
else
    F = FILE;
end
% do fourier transform N.B. output of the fourier transform are complex
Z = fft2(double(F));   
% shift u=0,v=0 in the centre, **centre at 200, 320**
Q = fftshift(Z);
maxQ = max(max(Q));
%  subplot(2,1,1); 

scale2=[(linspace(0,400,400))]'; 
scale1=[(linspace(0,640,640))]';

%2d resolution matrix
[X Y] = meshgrid(scale1,scale2);

% imagesc(log(abs(Q)+1)); colorbar ;
% figure; surf(X,Y,log(abs(Q)+1))

if ischar(FILE) == 0
%      figure(1);subplot(2,2,2); imagesc(log(abs(Q)+1)); title('fourier space'); colorbar;
end
lower = 60; upper = 80;
center = [0 0];    %u=0,v=0
theta1 = lower*(pi/180); theta2 = upper*(pi/180);
% Q = sectorFilter2(Q,center,theta1,theta2,400);
r1a = 10; r1b = 8/5*r1a;
r2a = 12; r2b = 8/5*r2a;
[a,rQ] = ringFilter(Q,center,r1a,r1b,r2a,r2b);

a = abs(a).^2; m =mean(a);
abQ = (abs(rQ)).^2;
mag = sum(sum(abQ));
v = var(a);
b = abs(m - a); count = 0;
for i = 1:length(a)
    for j = 12:-1:4
        if b(i) < m/j
            count = count + (1);
        end
    end
end

xtraQ = boxFilter(Q,[-140 100],20,20);
abxtraQ = (abs(xtraQ)).^2;
mag = sum(sum(abxtraQ));
% count=count*(mag/20);

% mag = var(a);
% mag = mag/maxQ;
%  imagesc(log(abs(xtraQ)+1));colorbar;
if ischar(FILE) == 0
%     figure(1);subplot(2,2,3); imagesc(log(abs(Q)+1)); title('after filter 1'); colorbar;
end
% figure
%  subplot(2,1,2);
% imagesc(log(abs(rQ)+1));colorbar;

% imagesc(log(abs(Q)+1)); 
% axis equal
% ylim([0,400]);xlim([0,640])
% colorbar
