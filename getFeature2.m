function mag = getFeature2(FILE)
if ischar(FILE) == 1
    F = imread(FILE);  %read in image
else
    F = FILE;
end
% do fourier transform N.B. output of the fourier transform are complex
Z = fft2(double(F));   
% shift u=0,v=0 in the centre
Q = fftshift(Z);

center = [0 0];    %u=0,v=0
theta1 = -6*(pi/180); theta2 = 6*(pi/180);
Q = sectorFilter3(Q,center,theta1,theta2,400,53);

abQ = (abs(Q)).^2;
mag = sum(sum(abQ));
