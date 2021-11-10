p(X):- member(X,[2,3,5]).
q(Y):- member(Y,[17,24,42,51,71]).
r(X,Y):- p(X),!,q(Y), mod(Y,X)=:=0.

