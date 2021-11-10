p(89).
p(7).
p(42).

foo2(X,Y):-
p(X),
!,
p(Y),
X>=Y.
n(X):-p(X),!.

foo3(X,Y):-
n(X),
n(Y),
X>=Y.

foo(X,Y):-
p(X),
p(Y),
X>=Y.