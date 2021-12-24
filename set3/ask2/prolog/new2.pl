:- dynamic seen/2.
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

%source: http://kti.ms.mff.cuni.cz/~bartak/prolog/sorting.html%
merge_sort([],[]).     % empty list is already sorted
merge_sort([X],[X]).   % single element list is already sorted
merge_sort(List,Sorted):-
    List=[_,_|_],divide(List,L1,L2),     % list with at least two elements is divided into two parts
	merge_sort(L1,Sorted1),merge_sort(L2,Sorted2),  % then each part is sorted
	merge(Sorted1,Sorted2,Sorted).                  % and sorted parts are merged
merge([],L,L).
merge(L,[],L):-L\=[].
merge([X|T1],[Y|T2],[X|T]):-X=<Y,merge(T1,[Y|T2],T).
merge([X|T1],[Y|T2],[Y|T]):-X>Y,merge([X|T1],T2,T).

divide(L,E,O):-odd(L,E,O).
   
odd([],[],[]).
odd([H|T],E,[H|O]):-even(T,E,O).
   
even([],[],[]).
even([H|T],[H|E],O):-odd(T,E,O).


add_to_end_of_list(List-Tail, Element, List-Tail2) :- % add_to_end_of_list([1,2,3|T]-T,4,L-[]).%
    Tail = [Element| Tail2].
dappend(List1-Tail1, Tail1-Tail2, List1-Tail2). %dappend([1,2,3|T]-T,[4,5,6|T2]-T2,R-[]). %


addzeros(0, L, L).

addzeros(Counter, Zeros, L):-
    add_to_end_of_list(L,0,NL),
    NCounter is Counter - 1,
    addzeros(NCounter, Zeros, NL).

vehicles_to_cities([],L,FinalL,PrevH,Counter, N):-
    NewN is N - 1,
    (PrevH < NewN -> Zeros is NewN - PrevH , addzeros(Zeros, NewL, T-T), dappend([Counter|T2]-T2,NewL,NewCounter)
    ; NewCounter = [Counter|T2]-T2
    ),
    dappend(L,NewCounter,FinalL-[]).

vehicles_to_cities([H| T], L, FinalL, PrevH, Counter, N):-
    NewH is PrevH + 1,
    H > NewH,
    add_to_end_of_list(L,Counter,NewL),
    vehicles_to_cities([H| T], NewL, FinalL, NewH, 0, N).

vehicles_to_cities([H| T], L, FinalL, PrevH, Counter, N) :-
    NewH is PrevH + 1,
    H == NewH,
    add_to_end_of_list(L,Counter,NewL),
    vehicles_to_cities(T, NewL, FinalL, H, 1, N).                          

vehicles_to_cities([H| T], L, FinalC, H, Counter, N) :-
    NewCounter is Counter+1,
    vehicles_to_cities(T,L,FinalC,H,NewCounter, N).
    
rotleft([E|T], R) :-
   append(T,[E],R).

rotright(L, R) :-
   rotleft(R, L).

rotNtime(L,0,L).
rotNtime(L,N,Final):- 
NewN is N-1 , 
rotright(L,NewL),
rotNtime(NewL,NewN,Final).

rotateandstore(L,N,R):-
rotateandstore(L,N,0,R).

rotateandstore([],_,_,_).
rotateandstore([H|T],N,I,RotateNumber):-
Place is (I - RotateNumber - 1) mod N,
assertz(seen(Place,H)),
NewI is I+1,
rotateandstore(T,N,NewI,RotateNumber).
/* moves */

sum_of_moves(N, [], _, FinalM, N, FinalM) .

sum_of_moves(N, [H| T], C, M, I, Help):- /*No of Cities, List, City, Moves*/

  CurrentSum is H * ((C - I) mod N),
  NewI is I + 1,
  NewM is CurrentSum + M,
  sum_of_moves(N, T, C, NewM, NewI,  Help).

new_sum(PrevSum, N, V, T, Sum):- /* Previous Sum, Index, No of Cities, Vehicles , Table[C], result*/
  Sum is PrevSum + V - N * T.


legal_state(_,I,I).
legal_state(Sum, I, N):-

    seen(I, 0),
    NewI is (I + 1) ,
    legal_state(Sum, NewI, N).
    

legal_state(Sum, I, N):-

    seen(I, 1),
    Dist is N - 1 - I, 
    Check is Sum - Dist + 1,
    Dist =< Check.


legal_state(_, I, _):- 

    seen(I,H),
    H > 1.
    

possible_solutions(N, _, N, Max, Max, C, C, _, _). 

possible_solutions(N, L, C, CurrMax, Max, CurrentC, FinalC, PrevSum, V):-
    nth0(C, L, T),
    new_sum(PrevSum, N, V, T, Sum),
    ( Sum < CurrMax, rotateandstore(L,N,C),once(legal_state(Sum,0, N)) -> NewC is C + 1, retractall(seen(_,_)),  possible_solutions(N, L, NewC, Sum, Max, C, FinalC, Sum, V)
      ;NewC is C+1, possible_solutions(N, L, NewC, CurrMax, Max, CurrentC, FinalC, Sum, V)
    ).

round(File,M,C):-
    read_input(File,N, V, K),
    merge_sort(K, NK),
    once(vehicles_to_cities(NK, T-T, NL, 0, 0, N)),
    sum_of_moves(N, NL, 0, 0, 0, Help),
    (rotateandstore(NL,N,0), once(legal_state(Help,0, N)) -> retractall(seen(_,_)), once(possible_solutions(N, NL, 1, Help, M, 0, C, Help, V))
    ;once(possible_solutions(N, NL, 1, 99999999, M, _, C, Help, V))
    ). 

           