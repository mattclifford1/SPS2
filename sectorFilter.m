function Q = sectorFilter(Q,center,theta1,theta2,r)
% sector filer applied to matrix Q
% theta1 is starting angle of filter
% theta2 is ending anlge of filter
% theta1 and theta2 range from -pi to pi
% r is the distance to end of filter from center

dim = size(Q);
center = (dim/2) + center;
for i = 1:dim(1)
    for j = 1:dim(2)
        u = i - center(1); v = j - center(2);
        if ~(atan(v/u) >= theta1 && atan(v/u) <= theta2 && u^2 + v^2 <= r^2)
            Q(i,j) = 0;
        end
    end
end
