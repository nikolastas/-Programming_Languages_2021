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

vehicles_to_cities([H], C, NewC) :- nth0(H, C, Element),
                                    NewElement is Element + 1,
                                    replace(H, C, NewElement, NewC). 

vehicles_to_cities([H| T], C, FinalC) :- nth0(H, C, Element),
                                       NewElement is Element + 1,
                                       replace(H, C, NewElement, NewC),
                                       vehicles_to_cities(T, NewC, FinalC).

move(K, Pr, NewList, Index, N) :- nth0(Index, K, Element),
                        Index =\= Pr,
                        NewElement is (Element + 1) mod N,
                        replace(Index, K, NewElement, NewList).

/*
move(K, Pr, NewList, Index, N) :- NNew is N - 1,
                        nth0(Index, K, NNew),
                        Index =\= Pr,
                        replace(Index, K, 0, NewList).
*/


final([_]).
final([H, S| T]) :- H =:= S,
                    final([S|T]).

steps(K, _, _, K, []) :- final(K).

steps(K, Pr, N, FK, [Index| Moves]) :- move(K, Pr, NewList, Index, N),
                                      /*write("Previous "),
                                      writeln(Pr),
                                      writeln(K),
                                      writeln(NewList),*/
                                      steps(NewList, Index, N, FK, Moves).
/*                                        
[1, 1, 1]
[0, 1, 1]
[0, 0, 1]
[0, 0, 0]

[0, 0, 0]
[1, 0, 0]
[1, 1, 0]
[0, 1, 0]
[0, 0, 0]
*/
solve(K, N, Count, H, Moves) :- 
                                length(Moves, Count),
                                writeln(Count),
                                steps(K,-1,N, [H| _], Moves).
                            

round(File,M,C):-
    read_input(File,N,_,K),
    once(solve(K,N,M,C, Moves)),
    writeln(Moves).