function start1(FILE)
tic
close all
figure
F = imread(FILE);  %read in image
% print image on scaled plot
subplot(2,2,1); imagesc(F); title('original');
% do fourier transform N.B. output of the fourier transform are complex
Z = fft2(double(F));   
% shift u=0,v=0 in the centre, **centre at 200, 320**
Q = fftshift(Z);       

%from argan diagram
magQ = abs(Q);         % magnitude spectrum
phaseQ=angle(Q);       % phase spectrum

% show fourier space
subplot(2,2,2); imagesc(log(abs(Q)+1)); title('fourier space');

% filter ------------------------------------------------------------------
center = [0 0];    %centre of box
I = 50; J =70;     %width/height of box
theta1 = 0; theta2 = pi/4;
Q1 = boxFilter(Q,center,I,J);
Q2 = sectorFilter(Q,center,theta1,theta2);
Q = combineFilter2(Q1,Q2);
%--------------------------------------------------------------------------
% show fourier space after filter
subplot(2,2,3); imagesc(log(abs(Q)+1)); title('after filter');

% work out magnitude and phase to do inverse transform
magQ = abs(Q);         % magnitude spectrum
phaseQ=angle(Q);       % phase spectrum

% w = ifft2(ifftshift(Q)); % do inverse fourier transform -  this doesnt
% work when you apply filters, why????

% put magnitude and phase back together - have to do it this was instead if
% you use a filter, why????
XXX = magQ.*exp(i*phaseQ);
% do inverse fourier transform
intrans = ifft2(ifftshift(XXX));
% show image after filter - have to use magnitude, why????
subplot(2,2,4); imagesc(abs(intrans)); title('inverse fourier');
% subplot(2,2,4); imagesc(abs(w)./angle(w)); title('inverse fourier');
toc