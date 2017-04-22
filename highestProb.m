function [probs,group] = highestProb(test,PROBSS,PROBST,PROBSV,X,Y)
deci = 100;
% X = round(X*deci)/deci; Y = round(Y*deci)/deci; test  = round(test*deci)/deci;
x = find(X(1,:)>test(1));
% x = round(mean(x));
x = x(1);
y = find(Y(:,1)>test(2));
% y = round(mean(y));
y = y(1);

probs = [PROBSS(y,x),PROBST(y,x),PROBSV(y,x)];
[prob, group] = max(probs);



