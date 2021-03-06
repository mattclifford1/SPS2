function Q = sectorFilter4(Q,center,theta1,theta2,r,r2)
% sector filer applied to matrix Q
% theta1 is starting angle of filter
% theta2 is ending anlge of filter
% theta1 and theta2 range from -pi to pi
% r is the distance to end of filter from center

dim = size(Q);
center = (dim/2) + center;
r1 = 0;
for i = 1:dim(1)
    for j = 1:dim(2)
        u = i - center(1); v = j - center(2);
         if ~( u<= r2 && u>=-r2 && (u >= -r2 && u <= r2 && (v <= -sqrt(r1^2 - u^2) && v >= -sqrt(r2^2 - u^2)) ...
                || (v >= sqrt(r1^2 - u^2) && v <= sqrt(r2^2 - u^2))) ) ... 
            && ( (atan(v/u) >= theta1 && atan(v/u) <= theta2 && u^2 + v^2 <= r^2) ...
            || (atan(v/u) >= (theta1+pi/2) && atan(v/u) <= (theta2+pi/2) && u^2 + v^2 <= r^2) ...
            || (atan(v/u) >= (theta1-pi/2) && atan(v/u) <= (theta2-pi/2) && u^2 + v^2 <= r^2) )
            Q(i,j) = 0;
        end
    end
end
% imagesc(log(abs(Q1)+1));