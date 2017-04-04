function mag = getFeature1(FILE)
addpath(genpath('/Users/mattclifford/Documents/SPS/CourseWork2/characters/trainGIF'))
F = imread(FILE);  %read in image
% do fourier transform N.B. output of the fourier transform are complex
Z = fft2(double(F));   
% shift u=0,v=0 in the centre, **centre at 200, 320**
Q = fftshift(Z);

center = [0 0];    %u=0,v=0
theta1 = 65*(pi/180); theta2 = 80*(pi/180);
theta1_2 = -80*(pi/180); theta2_2 = -65*(pi/180);
Q1 = sectorFilter(Q,center,theta1,theta2,1000);
Q2 = sectorFilter(Q,center,theta1_2,theta2_2,1000);
Q = combineFilter2(Q1,Q2);
I = 35; J =70;     %width/height of box
Q = antiBoxFilter(Q,center,I,J);
abQ = (abs(Q)).^2;
mag = sum(sum(abQ));

