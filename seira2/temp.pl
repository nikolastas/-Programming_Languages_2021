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
 
assert_seen((Q,S, PrevMoves)) :-   
                                term_hash((Q,S, PrevMoves), Hash),
                                assertz(seen(Hash, (Q,S, PrevMoves))).
                            
visit((Q,S, PrevMoves)) :-
                                term_hash((Q,S, PrevMoves), Hash),
                                seen(Hash, (Q,S, PrevMoves)).
/*
Q
S
_
QQ
QS
SQ
SS
__
QQQ
[Move| Moves]


length(Moves,_)

QQQQQ*/

 
addAndSquare((Q1, S1, PM1)):-
                       
                       not(visit((Q1,S1, _))),
                       write("this was not in seen :"), write(Q1), write("  "), write(S1), write("  "), writeln(PM1),
                       assert_seen((Q1,S1, PM1)). 
                       

addAndSquare((Q1, S1, PM1)) :- 
                                   visit((Q1, S1,PM1)). 
                                   /*write("Checking same state").*/


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
/*
queue2list(q(L, []), L).

formque(Q, L):- formque1(Q, NQ), queue2list(NQ, L).*/

check_state(Q,S,QFinal,SFinal,[Move|Moves], PrevMoves):-formque1(Q, FQ),
                                                        addAndSquare((FQ,S, PrevMoves)),
                                                        steps(Q,S,QFinal,SFinal,[Move|Moves], PrevMoves).

check_state_odd(Q,S,QFinal,SFinal,[Move|Moves], PrevMoves):-formque1(Q, FQ),
                                                            addAndSquare((FQ,S, PrevMoves)),
                                                            stepsodd(Q,S,QFinal,SFinal,[Move|Moves], PrevMoves).

stepsodd(Q,[S],_,_, ['S'], _):- length(Q) 
enque(S, Q, QNew),
                                finalstate(QNew, []).


stepsodd(Q, S,QFinal,SFinal,[Move| Moves], PrevMoves) :-                                  
    /*write("this is odd steps"),write(Q1),writeln(S1),*/ 
                                                     /*atomics_to_string(FQ,Q1),
                                                     atomics_to_string(S,S1),
                                                     atomics_to_string(PrevMoves, PM1),
                                                     write('Stepsodd:'), writeln(PM1),*/
                                                     ( not(visit((Q,S,_))) -> assert_seen((Q,S,PrevMoves)), ( S=[A] -> enque(A, Q, QF), finalstate(QF,[])  )
                                                     ;visit((Q,S,PrevMoves))
                                                     ),
                                                     move(Q, S, QNew, SNew,Move),
                                                     steps(QNew, SNew, QFinal, SFinal, Moves, [Move|PrevMoves]).

    

steps(Q,S,QFinal,SFinal,[Move|Moves], PrevMoves):- 
                                        /*
                                        atomics_to_string(FQ,Q1),
                                        atomics_to_string(S,S1),
                                        atomics_to_string(PrevMoves, PM1),
                                        write('Steps:'), writeln(PM1),*/
                                        ( not(visit((Q,S,_))) -> assert_seen((Q,S,PrevMoves)) ,( S=[A] -> enque(A, Q, QF), finalstate(QF,[]).;  )
                                        ; visit((Q,S,PrevMoves))
                                        ),
                                        move(Q, S, QNew, SNew,Move),
                                        stepsodd(QNew, SNew, QFinal, SFinal, Moves, [Move| PrevMoves]).
/*
Q, S 'Q' [Moves]
Q, S 'Q' [Moves2, 
Q, S 'Q' [Moves Correct]*/

/*
q[1, 2, 3][4,5,6] -> 
[1, 2, 3, 6, 5, 4]
q[1, 2, 3, 6][4, 5]       
*/



/*
[1,3,2],[]  [] visit 
[3,2],[] ,[1] visit (1) 
[2], [], [3, 1]                 QQ(2)
[3, 2, 1], [], [] QS
[], [], [2, 3, 1] QQQ
[2, 3], [], [1] QQS
[3, 2], [], [1] QSQ (X) 
[2, 1], [], [3] QSS
[2], [], [3, 1] QQQS (X)

[3], [], [2, 1] QQSQ
[2, 3, 1], [], [] QQSS
[2], [], [3, 1] QSQQ (X) QSQS
[3, 2], [], [1] QSSQ
QSQS
QSQSQ
QSSQ
*/



/*
[3, 42, 34, 2]
[3, 42] "342" [34, 2] "342"
[34, 2] "342" [3, 42] "342"
*/
solve(Moves, Q1) :-
            (length(Moves, _)),
            deque(Q1, Bs, Q),
  			
            /*write("this is the first steps"),write(Q),writeln([Bs]),*/
            stepsodd(Q, [Bs],_,_, Moves, ['Q']).



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