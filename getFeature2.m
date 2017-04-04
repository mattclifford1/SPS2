function mag = getFeature2(FILE)
addpath(genpath('/Users/mattclifford/Documents/SPS/CourseWork2/characters/trainGIF'))
F = imread(FILE);  %read in image
% do fourier transform N.B. output of the fourier transform are complex
Z = fft2(double(F));   
% shift u=0,v=0 in the centre, **centre at 200, 320**
Q = fftshift(Z);
maxQ = max(max(Q));

center = [0 0];    %u=0,v=0
I = 20; J =640;     %width/height of box
I2 = 400; J2 =20;     %width/height of box
Q1 = boxFilter(Q,center,I,J);
Q2 = boxFilter(Q,center,I2,J2);
Q = max(Q1,Q2);
% Q = combineFilter2(Q1,Q2);
I = 35; J =70;     %width/height of box
Q = antiBoxFilter(Q,center,I,J);
abQ = (abs(Q)).^2;
mag = sum(sum(abQ));
mag = mag/maxQ;