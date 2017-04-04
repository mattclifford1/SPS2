function start2(FILE,letter)
tic
% close all
figure
F = imread(FILE);  %read in image
% print image on scaled plot
subplot(2,2,1); imagesc(F); title('original'); colorbar;

% fourier transform -------------------------------------------------------

% do fourier transform N.B. output of the fourier transform are complex
Z = fft2(double(F));   
% shift u=0,v=0 in the centre, **centre at 200, 320**
Q = fftshift(Z);       

%from argan diagram
magQ = abs(Q);         % magnitude spectrum
phaseQ=angle(Q);       % phase spectrum

% show fourier space
subplot(2,2,2); imagesc(log(abs(Q)+1)); title('fourier space'); colorbar;

% filter ------------------------------------------------------------------
if letter == 't'
    center = [0 0];    %u=0,v=0
    I = 20; J =640;     %width/height of box
    I2 = 400; J2 =20;     %width/height of box
    Q1 = boxFilter(Q,center,I,J);
    Q2 = boxFilter(Q,center,I2,J2);
    Q = combineFilter2(Q1,Q2);
    filter = 3;
    if filter == 3
        I3 = 35; J3 =70;     %width/height of box
        Q = antiBoxFilter(Q,center,I3,J3);
    end
end
if letter == 'v'
    center = [0 0];    %u=0,v=0
    theta1 = 65*(pi/180); theta2 = 80*(pi/180);
    theta1_2 = -80*(pi/180); theta2_2 = -65*(pi/180);
    Q1 = sectorFilter(Q,center,theta1,theta2,1000);
    Q2 = sectorFilter(Q,center,theta1_2,theta2_2,1000);
    filter = 3;
    if filter == 2
        Q = combineFilter2(Q1,Q2);
    end
    if filter == 3
        I = 35; J =60;     %width/height of box
        Q3 = boxFilter(Q,center,I,J);
        Q = combineFilter3(Q1,Q2,Q3);
    end
end
if letter == 's'
    center = [0 0];    %u=0,v=0
    Q = ringFilter(Q,center,50,80);
end
    
% inverse fourier ---------------------------------------------------------

% show fourier space after filter
subplot(2,2,3); imagesc(log(abs(Q)+1)); title('after filter'); colorbar;

% work out magnitude and phase to do inverse transform
magQ = abs(Q);         % magnitude spectrum
phaseQ=angle(Q);       % phase spectrum

% w = ifft2(ifftshift(Q)); % do inverse fourier transform -  this doesnt
% work when you apply filters, why????

% put magnitude and phase back together - (re^itheta)
XXX = magQ.*exp(i*phaseQ);
% do inverse fourier transform
intrans = ifft2(ifftshift(XXX));
% show image after filter - have to use magnitude, why????
subplot(2,2,4); imagesc(abs(intrans)); title('inverse fourier'); colorbar;
% subplot(2,2,4); imagesc(abs(w)./angle(w)); title('inverse fourier');
toc