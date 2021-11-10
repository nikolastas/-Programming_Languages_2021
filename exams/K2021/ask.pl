unique([]).
unique([Item | Rest]) :-
member(Item, Rest), fail.

unique([X | Rest]) :-
not(member(X,Rest)),
unique(Rest).