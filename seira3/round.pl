:-dynamic bag/1.
assert_seen(L) :-
    
    term_hash(L, Hash),
    assertz(bag(Hash)).

seen(L) :-
    
    term_hash(L, Hash),
    bag(Hash).

read_input(File, M, N, K) :-
    open(File, read, Stream),
    read_line(Stream, [M, N]),
    read_line(Stream, K).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

replace(I, L, E, K) :-
    nth0(I, L, _, R),
    nth0(I, K, E, R).

listOfZeros([0],1).
listOfZeros([0|T],M):-
                   NewM is M-1, 
                   once(listOfZeros(T,NewM)).

vehicles_to_cities([H], C, NewC) :- nth0(H, C, Element),
                                    NewElement is Element + 1,
                                    replace(H, C, NewElement, NewC). 

vehicles_to_cities([H| T], C, FinalC) :- nth0(H, C, Element),
                                       NewElement is Element + 1,
                                       replace(H, C, NewElement, NewC),
                                       vehicles_to_cities(T, NewC, FinalC).
/* moves */

move(List, Pr, AfterList, NewIndex, N) :- nth0(Index, List, Element), 
                                    
                                    Element =:= 1,
                                    Pr =\= Index,
                                    NewElement is Element - 1, 
                                    replace(Index, List, NewElement, NewList),
                                    NewIndex is (Index+1) mod N,
                                    nth0(NewIndex, NewList, AfterElement),
                                    NewAfterElement is AfterElement + 1,
                                    replace(NewIndex, NewList, NewAfterElement, AfterList).

move(List, _, AfterList, NewIndex, N) :- nth0(Index, List, Element), 
                                    
                                     Element > 1,
                                     
                                     NewElement is Element - 1, 
                                     replace(Index, List, NewElement, NewList),
                                     NewIndex is (Index+1) mod N,
                                     nth0(NewIndex, NewList, AfterElement),
                                     NewAfterElement is AfterElement + 1,
                                     replace(NewIndex, NewList, NewAfterElement, AfterList).





/*
move(K, Pr, NewList, Index, N) :- NNew is N - 1,
                        nth0(Index, K, NNew),
                        Index =\= Pr,
                        replace(Index, K, 0, NewList).
*/

append( [], X, X).                                   
append( [X,C,L | Y], Z, [X,C,L | W]) :- append( Y, Z, W).

final([H| _], H, Count, Count).
final([_|T], V,Count, FCount) :- NewCount is Count + 1,
                         final(T, V, NewCount,FCount).



steps(N, [K,Pr,Index| Tail],V, Count) :-                      
                                     ( seen(K) -> steps(N, Tail,V, Count)
                                        ; assert_seen(K),
                                        ( final(K,V,0,Count )-> final(K,V,0,Count ), writeln("done")
                                           ;  writeln(K),  move(K, Pr, NewList, Index, N),append([K,Pr,Index| Tail],[NewList,Index,_],Newsteps),steps(N,Newsteps,V,Count)
                                        )
                                     ).
                                    
                                      
/*                                        
[1, 1, 1,2,0]  N=1 and X=3 , N*(1/2)*x*(x-1)=
[0, 1, 1]
[0, 0, 1]
[0, 0, 0]

[0, 0, 0]
[1, 0, 0]
[1, 1, 0]
[0, 1, 0]
[0, 0, 0]
*/
solve(K, N, M, Moves, V, C) :- 
                                length(Moves, Count),
                                
                                steps(N,[K,-1,_|Moves], V,C),
                                M is Count.
                            

round(File,M,C):-
    read_input(File,N,V,K),
    writeln("done reading"),
    listOfZeros(L,N),
    writeln("done zering"),
    vehicles_to_cities(K, L, NL),
    writeln("done cities"),
    once(solve(NL,N,M, _, V,C)).        