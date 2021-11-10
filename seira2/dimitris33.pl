read_input(File, N, Q) :-
    open(File, read, Stream),
    read_line(Stream,  [N]),
    read_line(Stream, Q).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

list2queue([], Q, Q). 
list2queue([H| T], Q, QFinal) :- enque(H, Q, QNew), list2queue(T, QNew, QFinal).

tuple2list((Q, S), [Q, S]).
list2term(L, T):- format(atom(T), '~w~w', L).
/*queue*/
empty( q([],[]) ).
enque( X , q(F,B) , q(F, [X|B] ) ).
deque( q( []     , Bs ) , F , q(Fs,[]) ) :- reverse( Bs, [F|Fs] ).
deque( q( [F|Fs] , Bs ) , F , q(Fs,Bs) ).


/* stack */

emptyS([]).
pop(E, [E|Es],Es).
push(E, Es, [E|Es]).

/*format(atom(A), '~w~w', [q([1, 2, 3], [4, 5]), [3, 4]]).*/

/* new */
/*
move(Q, [], QNew, [Bs],'Q'):- deque(Q,Bs,QNew).
                              

move(Q, S, QNew, SNew, 'S') :- empty(Q),
                               pop(SH, S, SNew),
                               enque(SH, Q, QNew).
*/
move(Q, S, QNew, SNew, 'Q'):-
    deque(Q,Bs,QNew),
    push(Bs, S,SNew).

move(Q, S, QNew, SNew, 'S') :- pop(SH, S, SNew),
                               enque(SH, Q, QNew).

visited(Q, S, D, NewD) :- list2term([Q, S], State),
                          not(get_dict(State, D, 1)),
                          put_dict([State : 1], D, NewD).
                          


                        
                        

formque(q(QL, []), q(QL, [])).
formque(q([], QR), q(NQR, [])) :- reverse(QR, NQR).
formque(q(QL, QR), q(Q, [])) :- reverse(QR, NQR), append(QL, NQR, Q). 




finalstate(q([], []) ,[]).
finalstate(q([], QR), []) :- reverse(QR, NQR), finalstate(q(NQR,[]), []).  
finalstate(q([_], []), []).
/*finalstate(q([QL], [QR]), []) :- QL =< QR.*/
finalstate(q([QH], QR), []) :- reverse(QR, NQR), finalstate(q([QH| NQR], []), []).
/*finalstate(q([QH, QSec], QR), []) :- QH =< QSec, reverse(QR, NQR), finalstate(q([QSec| NQR], []), []). */
finalstate(q([QH, QSec| QT], QR), []) :- QH =< QSec, finalstate(q([QSec | QT], QR), []).

stepsodd(Q,[S], _, _, ['S'], _):- enque(S, Q, QNew),
                               finalstate(QNew, []).


stepsodd(Q, S, QFinal, SFinal,[Move| Moves], Vis) :- formque(Q, FQ),
                                                     visited(FQ, S, Vis, NewVis),
                                                     move(FQ, S, QNew, SNew,Move),
                                                     steps(QNew, SNew, QFinal, SFinal,Moves, NewVis).


                        
steps(Q, S, QFinal, SFinal,[Move| Moves], Vis) :- formque(Q, FQ),
                                                  visited(FQ, S, Vis, NewVis),
                                                  move(FQ, S, QNew, SNew,Move),
                                                  stepsodd(QNew, SNew, QFinal, SFinal,Moves, NewVis).
                                            
                                            


solve(Moves, Q) :-
            (length(Moves, _)),
            deque(Q, Bs, QNew),
            list2term([Q, []], Init),
            dict_create(D, point, [Init:1]),
            stepsodd(QNew, [Bs], _, _, Moves, D).

            /*writeln(QFinal).*/


qssort(File, 'empty'):-
    read_input(File,_,L),
    list2queue(L, q([], []), Q),
    once(finalstate(Q, [])).

qssort(File,String3):-
    read_input(File,_,L),
    list2queue(L, q([], []), Q),
    not(finalstate(Q, [])),
    once(solve(Moves, Q)),
    atomics_to_string(Moves, String),
    string_concat('Q', String, String3).