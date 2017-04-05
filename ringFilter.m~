function Q = ringFilter(Q,center,r1,r2)
% ring filer applied to matrix Q
% r1 is distance to inside of ring from center
% r2 is distance to outside of ring from center

dim = size(Q);
center = (dim/2) + center;
for i = 1:dim(1)
    for j = 1:dim(2)
        u = i - center(1); v = j - center(2);
        if u >= -r2 && u <= r2 ...
                && (v <= -sqrt(r1^2 - u^2) && v >= -sqrt(r2^2 - u^2)) ...
                || (v >= sqrt(r1^2 - u^2) && v <= sqrt(r2^2 - u^2))
            Q(i,j) = Q(i,j);
        else
            Q(i,j) = 0;
        end
    end
end