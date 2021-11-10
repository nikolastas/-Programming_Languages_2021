tree(n(13,5,17)).
tree(n(n(0,1,2),n(3,n(4,5,6),7),n(8,9,10))).
tree(n(n(0,1,2),n(13,17,42),4)).
max(X,Y,Y):-
X<Y.
max(X,Y,X):-
X>=Y.

max(X,Y,Z,M2):-
max(X,Y,M1),
max(Y,Z,M2),
M2 > M1.

max(X,Y,Z,M1):-
max(X,Y,M1),
max(Y,Z,M2),
M1 >= M2.

maxOfTree(n(T1,T2,T3),M,FinalM):-
(integer(T1)-> (M<T1 -> NewM1 is T1
            ; NewM1 is M)
;maxOfTree(T1,M,NewM1)),
(integer(T2)  -> (NewM1< T2 -> NewM2 is T2
            ; NewM2 is M)
;maxOfTree(T2,M,NewM2)),
(integer(T3) -> (NewM2<T3 -> NewM3 is T3
            ; NewM3 is M)
;maxOfTree(T3,M,NewM3)
),max(NewM3,NewM2,NewM1,FinalM).

changeTree(n(T1,T2,T3),M,MaxTree):-
(integer(T1)-> NewT1 is M
;changeTree(T1,M,NewT1)),
(integer(T2)  -> NewT2 is M 
;changeTree(T2,M,NewT2)),
(integer(T3) -> NewT3 is M
;changeTree(T3,M,NewT3)),
MaxTree = n(NewT1,NewT2,NewT3).

maximize(MaxTree):-
tree(T),
maxOfTree(T,-999,M),
print(M),
changeTree(T,M,MaxTree).
