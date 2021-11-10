:- dynamic seen/2. 
 
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


addAndSquare((Q, S)):-
                       not(visit((Q,S))),
                       write("this was not in seen :"), write(Q),writeln(S),
                        assert_seen((Q,S)). 


empty( q([],[]) ).
enque( X , q(F,B) , q(F, [X|B] ) ).
deque( q( []     , Bs ) , F , q(Fs,[]) ) :- reverse( Bs, [F|Fs] ).
deque( q( [F|Fs] , Bs ) , F , q(Fs,Bs) ).


/* stack */

emptyS([]).
pop(E, [E|Es],Es).
push(E, Es, [E|Es]).

move(Q, S, QNew, SNew, 'Q'):-
    deque(Q,Bs,QNew),
    push(Bs, S,SNew).


move(Q, S, QNew, SNew, 'S') :- pop(SH, S, SNew),
                               enque(SH, Q, QNew).


finalstate(q([], []) ,[]).
finalstate(q([], QR), []) :- reverse(QR, NQR), finalstate(q(NQR,[]), []).  
finalstate(q([_], []), []).
/*finalstate(q([QL], [QR]), []) :- QL =< QR.*/
finalstate(q([QH], QR), []) :- reverse(QR, NQR), finalstate(q([QH| NQR], []), []).
/*finalstate(q([QH, QSec], QR), []) :- QH =< QSec, reverse(QR, NQR), finalstate(q([QSec| NQR], []), []). */
finalstate(q([QH, QSec| QT], QR), []) :- QH =< QSec, finalstate(q([QSec | QT], QR), []).





formque1(q(QL, []), q(QL, [])).
formque1(q([], QR), q(NQR, [])) :- reverse(QR, NQR).
formque1(q(QL, QR), q(Q, [])) :- reverse(QR, NQR), append(QL, NQR, Q).

queue2list(q(L, []), L).

formque(Q, L):- formque1(Q, NQ), queue2list(NQ, L).

stepsodd(Q,[S],_,_, ['S']):- enque(S, Q, QNew),
                               finalstate(QNew, []).


stepsodd(Q1, S1,QFinal,SFinal,[Move| Moves]) :-                                  
    /*write("this is odd steps"),write(Q1),writeln(S1),*/formque(Q1, FQ),/*
                                                     addAndSquare((FQ,S1)),*/
                                                     not(visit((FQ,S1))),
                                                     write("this was not in seen :"), write(Q1),writeln(S1),
                                                     assert_seen((FQ,S1)), 
                                                     move(Q1, S1, Q, S,Move),
                                                     steps(Q, S, QFinal, SFinal, Moves).



/*
q[1, 2, 3][4,5,6] -> 
[1, 2, 3, 6, 5, 4]
q[1, 2, 3, 6][4, 5]       
*/
steps(Q2, S2, QFinal, SFinal, [Move| Moves]) :-                    /*write("this is normal steps"),write(Q2),writeln(S2),*/
                                                  formque(Q2, FQ),/*
                                                  addAndSquare((FQ,S2)),*/
                                                  not(visit((FQ,S2))),
                                                  write("this was not in seen :"), write(Q2),writeln(S2),
                                                  assert_seen((FQ,S2)),
                                                  move(Q2, S2, Q, S,Move),
                                                  stepsodd(Q, S,QFinal,SFinal,Moves).
/*
[3, 42, 34, 2]
[3, 42] "342" [34, 2] "342"
[34, 2] "342" [3, 42] "342"
*/
solve(Moves, Q1) :-
            (length(Moves, _)),
            deque(Q1, Bs, Q),
  			
            /*write("this is the first steps"),write(Q),writeln([Bs]),*/
            stepsodd(Q, [Bs],_,_, Moves).



qssort:-
    Q=q([7,17,3,42],[]),
    not(finalstate(Q, [])),
    once(solve(Moves, Q)),
    writeln(Moves).