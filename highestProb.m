function [probs,group] = highestProb(test,PROBSS,PROBST,PROBSV,X,Y)
X = round(X/100)*100; Y = round(Y/100)*100; test  = round(test/100)*100;
test
x = find(X(1,:)==test(1));
x = round(mean(x));
y = find(Y(:,1)==test(2));
y = round(mean(y));

probs = [PROBSS(x,y),PROBST(x,y),PROBSV(x,y)];
[prob group] = max(probs);



