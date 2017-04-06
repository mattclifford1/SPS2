%addpath(genpath('/Users/mattclifford/Documents/SPS/CourseWork2/characters/trainGIF'))
addpath(genpath('/home/fe15/jc15311/linux/Documents/MATLAB/CW2/SPS2/trainGIF'));
F = imread('T1.GIF');
Z = fft2(double(F));   
% shift u=0,v=0 in the centre, **centre at 200, 320**
Q = fftshift(Z);
center = [0 0];
r1 = 50; r2 = 300;
% tic
% [P,out] = PowerRing(r1,r2,Q);
% toc
% tic 
% Q = ringFilter(Q,center,r1,r2);
% toc
theta1 = pi/4; theta2 = 3*pi/2; r= 1000;
tic

dim = size(Q);
center = round(dim/2);
vert = linspace(-center(1),center(1),dim(1));
horiz = linspace(-center(2),center(2),dim(2));
[u v] = meshgrid(horiz,vert);
angle = atan(v./u);
angle(angle<theta1) = 0;
angle(angle>theta2) = 0;

for i = 1:dim(1)
    for j = 1:dim(2)
        if angle(i,j) == 0
            Q(i,j) = 0;
        end
    end
end
% imagesc(log(abs(Q)+1));

toc
subplot(2,1,1); imagesc(log(abs(Q)+1));
Q = fftshift(Z);
tic
center = [0 0];
Q = sectorFilter(Q,center,theta1,theta2,r);
toc


subplot(2,1,2); imagesc(log(abs(Q)+1));