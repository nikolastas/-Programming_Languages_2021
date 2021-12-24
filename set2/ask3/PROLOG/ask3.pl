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

/*queue*/
empty( q([],[]) ).
enque( X , q(F,B) , q(F, [X|B] ) ).
deque( q( []     , Bs ) , F , q(Fs,[]) ) :- reverse( Bs, [F|Fs] ).
deque( q( [F|Fs] , Bs ) , F , q(Fs,Bs) ).

queh(q([], []), -1).
queh(q([QH|_],_),QH).
queh(q([],QR),QH):- reverse(QR,NQR),queh(q(NQR,[]), QH).
/* stack */

emptyS([]).
pop(E, [E|Es],Es).
push(E, Es, [E|Es]).



/* new */
/*
move(Q, [], QNew, [Bs],'Q'):- deque(Q,Bs,QNew).
                              

move(Q, S, QNew, SNew, 'S') :- empty(Q),
                               pop(SH, S, SNew),
                               enque(SH, Q, QNew).
*/
move(Q, S, QNew, SNew, 'Q',OldCount,NewCount):-
    deque(Q,Bs,QNew),
    push(Bs, S,SNew),
    NewCount is OldCount+1.

move(Q, S, QNew, SNew, 'S',Oldcount,Oldcount) :- pop(SH, S, SNew),
                               enque(SH, Q, QNew),
                               once(queh(Q, QH)),
                               \+SH = QH.





finalstate(q([], []) ,[]).
finalstate(q([], QR), []) :- reverse(QR, NQR), finalstate(q(NQR,[]), []).  
finalstate(q([_], []), []).
/*finalstate(q([QL], [QR]), []) :- QL =< QR.*/
finalstate(q([QH], QR), []) :- reverse(QR, NQR), finalstate(q([QH| NQR], []), []).
/*finalstate(q([QH, QSec], QR), []) :- QH =< QSec, reverse(QR, NQR), finalstate(q([QSec| NQR], []), []). */
finalstate(q([QH, QSec| QT], QR), []) :- QH =< QSec, finalstate(q([QSec | QT], QR), []).

stepsodd(Q,[S], _, _, ['S'],Qcount,HL):-        Qcount = HL,
                                                enque(S, Q, QNew),
                                                finalstate(QNew, []).


stepsodd(Q, S, QFinal, SFinal,[Move| Moves], Qcount, HL) :- 
                                                Qcount =< HL,
                                                move(Q, S, QNew, SNew,Move,Qcount,NewCount),
                                                steps(QNew, SNew, QFinal, SFinal,Moves,NewCount,HL).


                        
steps(Q, S, QFinal, SFinal,[Move| Moves],Qcount,HL) :- Qcount =< HL,
                                             move(Q, S, QNew, SNew,Move, Qcount, NewCount),
                                             stepsodd(QNew, SNew, QFinal, SFinal,Moves,NewCount,HL).
                                            
                                            


solve(Moves, Q) :-
            (length(Moves, L)),
            1 is L mod 2,
            HL is (L + 1)/2, 
            
            deque(Q, Bs, QNew),
            stepsodd(QNew, [Bs], _, _, Moves,1,HL).

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