function [a,Q1] = ringFilter(Q,center,r1b,r1a,r2b,r2a)
% ring filer applied to matrix Q
% r1 is distance to inside of ring from center
% r2 is distance to outside of ring from center

dim = size(Q);
center = (dim/2) + center;
Q1 = zeros(dim);
a = [];
for i = 1:dim(1)
    for j = 1:dim(2)
        u = i - center(1); v = j - center(2);
        if u >= -r2b && u <= r2b ...
                && ((v <= -sqrt(r1a^2-(u^2 * r1a^2)/r1b^2) && v >= -sqrt(r2a^2-(u^2 * r2a^2)/r2b^2)) ...
                || (v >= sqrt(r1a^2-(u^2 * r1a^2)/r1b^2) && v <= sqrt(r2a^2-(u^2 * r2a^2)/r2b^2)))
            Q1(i,j) = Q(i,j);
            a = [a Q(i,j)];
        end
    end
end