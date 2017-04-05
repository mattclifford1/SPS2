function mag = getFeature3(FILE)
addpath(genpath('/Users/mattclifford/Documents/SPS/CourseWork2/characters/trainGIF'))
F = imread(FILE);  %read in image
% do fourier transform N.B. output of the fourier transform are complex
Z = fft2(double(F));   
% shift u=0,v=0 in the centre, **centre at 200, 320**
Q = fftshift(Z);
maxQ = max(max(Q));

center = [0 0];    %u=0,v=0
Q = ringFilter(Q,center,50,80);
abQ = (abs(Q)).^2;
mag = sum(sum(abQ));
mag = mag/maxQ;