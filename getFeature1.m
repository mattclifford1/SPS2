function mag = getFeature1(FILE)
addpath(genpath('/Users/mattclifford/Documents/SPS/CourseWork2/characters/trainGIF'))
addpath(genpath('/Users/mattclifford/Documents/SPS/CourseWork2/characters/testData'))
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
% imagesc(log(abs(Q)+1));figure

if ischar(FILE) == 0
    figure(1);subplot(2,2,2); imagesc(log(abs(Q)+1)); title('fourier space'); colorbar;
end
lower = 60; upper = 80;
center = [0 0];    %u=0,v=0
theta1 = lower*(pi/180); theta2 = upper*(pi/180);
Q = sectorFilter2(Q,center,theta1,theta2,400);

abQ = (abs(Q)).^2;
mag = sum(sum(abQ));

mag = mag/maxQ;
% imagesc(log(abs(Q)+1));colorbar;
if ischar(FILE) == 0
    figure(1);subplot(2,2,3); imagesc(log(abs(Q)+1)); title('after filter 1'); colorbar;
end
% figure
% imagesc(log(abs(Q)+1));colorbar
