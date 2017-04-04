function Q = combineFilter2(Q1,Q2)

dim = size(Q1);
Q = zeros(dim);
for i = 1:dim(1)
    for j = 1:dim(2)
        if Q1(i,j) ~= 0 
            Q(i,j) = Q1(i,j);
        end
        if Q2(i,j) ~= 0
            Q(i,j) = Q2(i,j);
        end
    end
end