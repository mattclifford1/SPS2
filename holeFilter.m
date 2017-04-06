function Q = holeFilter(Q,center,r)
% hole filter applied to matrix Q
% r is distance to outside of circle

dim = size(Q);
center = (dim/2) + center;
r1 = 0;
for i = 1:dim(1)
    for j = 1:dim(2)
        u = i - center(1); v = j - center(2);
        if u >= -r && u <= r && (v <= -sqrt(r1^2 - u^2) && v >= -sqrt(r^2 - u^2)) ...
                || (v >= sqrt(r1^2 - u^2) && v <= sqrt(r^2 - u^2))
            Q(i,j) = 0;
        end
    end
end