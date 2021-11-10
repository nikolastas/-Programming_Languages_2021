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


:- dynamic seen/2.

/*queue*/
empty( q([],[]) ).
enque( X , q(F,B) , q(F, [X|B] ) ).
deque( q( []     , Bs ) , F , q(Fs,[]) ) :- reverse( Bs, [F|Fs] ).
deque( q( [F|Fs] , Bs ) , F , q(Fs,Bs) ).


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
move(Q, S, QNew, SNew,'Q'):-deque(Q,Bs,QNew),
                                push(Bs, S,SNew).

move(Q, S, QNew, SNew, 'S') :- pop(SH, S, SNew),
                               enque(SH, Q, QNew).

assert_seen((Q,S)) :-   
                                atomics_to_string(Q,Q1),
                                atomics_to_string(S,S1),
                                term_hash((Q1,S1), Hash),
                                assertz(seen(Hash, (Q1,S1))).
                            
visit((Q,S)) :-
                               atomics_to_string(Q,Q1),
                                atomics_to_string(S,S1),
                                term_hash((Q1,S1), Hash),
                                seen(Hash, (Q1,S1)).


visited(Q, S):-
                       not(visit((Q,S))),
                       write("this was not in seen :"), write(Q),writeln(S),
                        assert_seen((Q,S)).
                                                        
/*visited(Q,S,[Start|End],All_of_visited,Final_visited):-
                                Start \= (Q,S),       
                                visited(Q,S,End,All_of_visited,Final_visited). */

                        
formque(q([],L),L).
formque(q(QL, []), QL).
formque(q([X|T], QR),[X|R]) :- formque(q(T, QR),R). 



finalstate(q([], []) ,[]).
finalstate(q([], QR), []) :- reverse(QR, NQR), finalstate(q(NQR,[]), []).  
finalstate(q([_], []), []).
/*finalstate(q([QL], [QR]), []) :- QL =< QR.*/
finalstate(q([QH], QR), []) :- reverse(QR, NQR), finalstate(q([QH| NQR], []), []).
/*finalstate(q([QH, QSec], QR), []) :- QH =< QSec, reverse(QR, NQR), finalstate(q([QSec| NQR], []), []). */
finalstate(q([QH, QSec| QT], QR), []) :- QH =< QSec, finalstate(q([QSec | QT], QR), []).




steps(Q, S,[Move| Moves]) :- 
    formque(Q, FQ),
    write("this is a step"),write(Q),write(S),writeln(""),
    visited(FQ, S),
    writeln("i successeded the visit"),
    move(Q, S, QNew, SNew,Move),
    stepsodd(QNew, SNew,Moves).

stepsodd(Q,[S],'S' ):- enque(S, Q, QNew),
                       finalstate(QNew, []).
stepsodd(Q, S,[Move| Moves]) :- 
    formque(Q, FQ),
    write("this is a stepodd :"),write(Q),write(S),writeln(""),
    visited(FQ, S),
    writeln("i successeded the visit"),
    move(Q, S, QNew, SNew,Move),
    writeln("i successeded the move :"),write(Move),
    steps(QNew, SNew,Moves).


                        

                                            
                                            


solve(Moves, Q) :-
            (length(Moves, _)),
            deque(Q, Bs, QNew),
            
            stepsodd(QNew, [Bs], Moves).

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