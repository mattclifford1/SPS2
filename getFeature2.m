function mag = getFeature2(FILE)
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

center = [0 0];    %u=0,v=0
I = 20; J =640;     %width/height of box
%I2 = 400; J2 =20;     %width/height of box
% Q1 = boxFilter(Q,center,I,J);
% Q2 = boxFilter(Q,center,I2,J2);
theta1 = -10*(pi/180); theta2 = 10*(pi/180);
% theta1_2 = -upper*(pi/180); theta2_2 = -lower*(pi/180);
Q = sectorFilter3(Q,center,theta1,theta2,1000);
% fprintf('filter1 done\n')
% Q2 = boxFilter(Q,center,I,J);
% fprintf('filter2 done\n')
% Q2 = (sectorFilter(Q,center,-pi/2,-85*(pi/180),1000) + sectorFilter(Q,center,85*(pi/180),pi/2,1000));
% Q = max(Q1,Q2);
% Q = combineFilter2(Q1,Q2);
I = 50; J =70;     %width/height of box
% Q = antiBoxFilter(Q,center,I,J);
% % Q = ringFilter(Q,center,50,1000);
Q = holeFilter(Q,center,40);
% fprintf('filter3 done\n')
abQ = (abs(Q)).^2;
mag = sum(sum(abQ));
mag = mag/maxQ;
imagesc(log(abs(Q)+1));
if ischar(FILE) == 0
    figure(1);subplot(2,2,4); imagesc(log(abs(Q)+1)); title('after filter 1'); colorbar;
end