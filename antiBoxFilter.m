function Q = antiBoxFilter(Q,center,I,J)
% box filer applied to matrix Q
% center is the co ordinates of the center of the box
% I and J are the length and width of the box

dim = size(Q);
center = (dim/2) + center;
minI = center(1) - I; maxI = center(1) + I;
minJ = center(2) - J; maxJ = center(2) + J;
for i = 1:dim(1)
    for j = 1:dim(2)
        if i >= minI && i <= maxI && j >= minJ && j <= maxJ
            Q(i,j) = 0;
        end
    end
end
