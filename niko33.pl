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




formque(q([],L),L).
formque(q(QL, []), QL).
formque(q([X|T], QR),[X|R]) :- formque(q(T, QR),R). 

stepsodd(Q,[S], ['S']):- enque(S, Q, QNew),
                               finalstate(QNew, []).


stepsodd(Q1, S1,[Move| Moves]) :- 
                                                     move(Q1, S1, Q, S,Move),
    write("this is odd steps"),write(Q),writeln(S),formque(Q, FQ),
                                                     addAndSquare((FQ,S)),
                                                     steps(Q, S,Moves).


                        
steps(Q2, S2,[Move| Moves]) :- 
                                                  move(Q2, S2, Q, S,Move),
    write("this is normal steps"),write(Q),writeln(S),
    formque(Q, FQ),
                                                  addAndSquare((FQ,S)),
                                                  stepsodd(Q, S,Moves).



solve(Moves, Q1) :-
            (length(Moves, _)),
            deque(Q1, Bs, Q),
  			
    write("this is the first steps"),write(FQ),writeln(S),
            stepsodd(FQ, [Bs], Moves).



qssort:-
    Q=q([7,17,3,42],[]),
    not(finalstate(Q, [])),
    once(solve(Moves, Q)),
    writeln(Moves).