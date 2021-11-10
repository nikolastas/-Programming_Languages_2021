natural_number(0).
natural_number(s(X)) :- natural_number(X).

gcd(X,Y, G):-