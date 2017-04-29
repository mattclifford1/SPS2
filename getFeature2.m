function mag = getFeature2(FILE)
addpath(genpath(strcat(pwd,'/trainGIF')));
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
% imagesc(log(abs(Q)+1))

center = [0 0];    %u=0,v=0
theta1 = -6*(pi/180); theta2 = 6*(pi/180);
Q = sectorFilter3(Q,center,theta1,theta2,400,53);

abQ = (abs(Q)).^2;
mag = sum(sum(abQ));

% mag = mag/maxQ;
% imagesc(log(abs(Q)+1)); 
% axis equal
% ylim([0,400]);xlim([0,640])
% colorbar

if ischar(FILE) == 0
%     figure(1);subplot(2,2,4); imagesc(log(abs(Q)+1)); title('after filter 1'); colorbar;
end
