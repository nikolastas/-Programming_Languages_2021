

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

sum_of_moves(N, [], _, FinalM, N, FinalM) .

sum_of_moves(N, [H| T], C, M, I, Help):- /*No of Cities, List, City, Moves*/

  CurrentSum is H * ((C - I) mod N),
  NewI is I + 1,
  NewM is CurrentSum + M,
  sum_of_moves(N, T, C, NewM, NewI,  Help).



legal_state(_,[],_,N,N,_).
legal_state(C, [0| T], Sum, I, N, MaxDist):- 
    NewI is I + 1,
    legal_state(C, T, Sum, NewI, N, MaxDist).

legal_state(C, [_| T], Sum, I, N, MaxDist):- 
    Dist is (C - I) mod N,
    Dist < MaxDist,
    NewI is I + 1  ,
    legal_state(C, T, Sum, NewI, N, MaxDist).
    

legal_state(C, [1| T], Sum, I, N, MaxDist):-

    Dist is (C - I) mod N,
    Check is Sum - Dist + 1,
    Dist =< Check,
    
    Dist > MaxDist,
    NewI is I + 1,
    legal_state(C, T, Sum, NewI, N, Dist).


legal_state(C, [H| T], Sum, I, N, MaxDist):- 
    H > 1,
    Dist is (C - I) mod N,
    Dist > MaxDist,
    NewI is I + 1,
    legal_state(C, T, Sum, NewI, N, Dist).
    

possible_solutions(N, _, N, Max, Max, C, C).

possible_solutions(N, L, C, CurrMax, Max, CurrentC, FinalC):-
    sum_of_moves(N, L, C, 0, 0, Help),
    ( Help < CurrMax, once(legal_state(C, L, Help, 0, N, -1)) -> NewC is C + 1, possible_solutions(N, L, NewC, Help, Max, C, FinalC)
      ;NewC is C+1, possible_solutions(N, L, NewC, CurrMax, Max, CurrentC, FinalC)
    ).


    
    
 



/*
move(K, Pr, NewList, Index, N) :- NNew is N - 1,
                        nth0(Index, K, NNew),
                        Index =\= Pr,
                        replace(Index, K, 0, NewList).
*/


                                      
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

                            

round(File,M,C):-
    read_input(File,N,_,K),
    listOfZeros(L,N),
    vehicles_to_cities(K, L, NL),
    once(possible_solutions(N, NL, 0, 999999999, M, -1, C)).        