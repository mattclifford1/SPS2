function magQ = getFeature1(FILE)
addpath(genpath('/Users/mattclifford/Documents/SPS/CourseWork2/characters/trainGIF'))
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

if ischar(FILE) == 0
    figure(1);subplot(2,2,2); imagesc(log(abs(Q)+1)); title('fourier space'); colorbar;
end
lower = 60; upper = 85;
center = [0 0];    %u=0,v=0
theta1 = lower*(pi/180); theta2 = upper*(pi/180);
theta1_2 = -upper*(pi/180); theta2_2 = -lower*(pi/180);
% Q1 = sectorFilter(Q,center,theta1,theta2,1000);
% Q2 = sectorFilter(Q,center,theta1_2,theta2_2,1000);
Q = sectorFilter2(Q,center,theta1,theta2,80);
% Q = max(Q1,Q2);
I = 35; J =70;     %width/height of box
% Q = antiBoxFilter(Q,center,I,J);
abQ = (abs(Q)).^2;
mag = sum(sum(abQ));
magQ = mag/maxQ;
imagesc(log(abs(Q)+1));colorbar;
if ischar(FILE) == 0
    figure(1);subplot(2,2,3); imagesc(log(abs(Q)+1)); title('after filter 1'); colorbar;
end
