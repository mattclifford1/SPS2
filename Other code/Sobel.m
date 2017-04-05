function Sobel(FILE)
% Sobel edge detection
A = imread(FILE);
fx = [-1 0 1; -2 0 2; -1 0 1];
fy = [1 2 1; 0 0 0; -1 -2 -1];
gx = conv2(double(A),double(fx))/8;
gy = conv2(double(A),double(fy))/8;
mag = sqrt((gx).^2+(gy).^2);
ang = atan(gy./gx);
figure; imagesc(mag); axis off; %colormap gray 
figure; imagesc(ang); axis off; colormap gray