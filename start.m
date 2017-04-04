function start1()
close all
[f,mag] = imread('a1.gif');  %read in image
% % imshow(f,mag);
z = fft2(double(f));   % do fourier transform
q = fftshift(z);       % puts u=0,v=0 in the centre 
Magq = abs(q);         % magnitude spectrum
Phaseq=angle(q);       % phase spectrum
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usually for viewing purposes:
figure
imagesc(log(abs(q)+1)); 
colorbar;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
w = ifft2(ifftshift(q)); % do inverse fourier transform
% % imagesc(w);