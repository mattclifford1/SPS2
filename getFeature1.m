function count = getFeature1(FILE)

if ischar(FILE) == 1
    F = imread(FILE);  %read in image
else
    F = FILE;
end
% do fourier transform N.B. output of the fourier transform are complex
Z = fft2(double(F));   
% shift u=0,v=0 in the centre, **centre at 200, 320**
Q = fftshift(Z);

center = [0 0];    %u=0,v=0
r1a = 10; r1b = 8/5*r1a;
r2a = 12; r2b = 8/5*r2a;
[a,rQ] = ringFilter(Q,center,r1a,r1b,r2a,r2b);

a = abs(a).^2; m =mean(a);
b = abs(m - a); %difference
count = 0;
for i = 1:length(a)   %find how far everything is from mean
    for j = 12:-1:4   %more count for close to mean
        if b(i) < m/j
            count = count + (1);
        end
    end
end