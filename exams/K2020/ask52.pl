tree(n(n(0,1,0),1,0)).
tree(n(n(0,1,0),n(n(0,1,1),1,0),n(1,1,1))).

/*
counto(n(T1, T2, T3),Z,FZ):-
(D == 1 -> NZ is Z+1
; NZ is Z
),
member(Elem,L),
print(Elem),
countz(Elem,NZ,FZ),
FZ is NZ.
*/

countz(n(T1,T2,T3),Z,FZ3):-
    (T1 = 0 -> FZ1 = [T1|Z]
    ;T1 = 1 -> FZ1 = Z
    ; countz(T1, Z, FZ1)
    ),
    (T2 = 0 -> FZ2 = [T2| FZ1]
    ;T2 = 1 -> FZ2 = FZ1
    ; countz(T2, FZ1, FZ2)),
    (T3 = 0 -> FZ3 = [T3| FZ2]
    ;T3 = 1 -> FZ3 = FZ2
    ; countz(T3, FZ2, FZ3)).

counto(n(T1,T2,T3),Z,FZ3):-
    (T1 = 1 -> FZ1 = [T1|Z]
    ;T1 = 0 -> FZ1 = Z
    ; counto(T1, Z, FZ1)),
    (T2 = 1 -> FZ2 = [T2|FZ1] 
    ;T2 = 0 -> FZ2 = FZ1
    ; counto(T2, FZ1, FZ2)),
    (T3 = 1 -> FZ3 = [T3|FZ2]
    ;T3 = 0 -> FZ3 = FZ2
    ; counto(T3, FZ2, FZ3)).

odd_parity(n(T1, T2, T3), Parity) :-
    Sum is T1 + T2 + T3,
    Parity is Sum mod 2.


termatiko(n(T1,T2,T3)):-
(T1 is 1 ; T1 is 0),
(T2 is 1 ; T2 is 0),
(T3 is 1 ; T3 is 0).

count_odd_parity(1, 0).
count_odd_parity(0, 0).
count_odd_parity(n(T1, T2, T3), Count):-
    (termatiko(n(T1, T2, T3)) -> odd_parity(n(T1, T2, T3), Parity), Count is Parity
    ;count_odd_parity(T1, Count1),
    count_odd_parity(T2, Count2),
    count_odd_parity(T3, Count3),
    Count is Count1 + Count2 + Count3
).



triadiko(Z,O,Count):- tree(Tree),
countz(Tree,[],Z), 
counto(Tree,[],O), count_odd_parity(Tree,Count).

help(X):-
tree(T),
count_odd_parity(T,X).