
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
move(Q, S, QNew, SNew, 'Q'):-
    deque(Q,Bs,QNew),
    push(Bs, S,SNew).

move(Q, S, QNew, SNew, 'S') :- pop(SH, S, SNew),
                               enque(SH, Q, QNew).


                    visited(q([QL],[QR]),[S],[Last_one],All_of_visited,New_visited):-
                         Last_one \= [q([QL],[QR]),[S]] ,
                        writeln("thelastone"),
                         append([q([QL],[QR]),[S]],All_of_visited,New_visited).
                            
                     visited(q([QL],[QR]),[S],[Start|End],All_of_visited,New_visited):-
                        writeln("onestepcloser"),
                        Start \= [q([QL],[QR]),[S]] ,
                                
                         visited(q([QL],[QR]),[S],[End],All_of_visited,New_visited).




finalstate(q([], []) ,[]).
finalstate(q([], QR), []) :- reverse(QR, NQR), finalstate(q(NQR,[]), []).  
finalstate(q([_], []), []).
finalstate(q([QL], [QR]), []) :- QL =< QR.
finalstate(q([QH], QR), []) :- reverse(QR, NQR), finalstate(q([QH| NQR], []), []).
finalstate(q([QH, QSec], QR), []) :- QH =< QSec, reverse(QR, NQR), finalstate(q([QSec| NQR], []), []). /*EDW*/
finalstate(q([QH, QSec| QT], QR), []) :- QH =< QSec, finalstate(q([QSec | QT], QR), []).



steps(Q,S, _, _, ['S']):- pop(SH, S, SNew),
                          enque(SH, Q, QNew),
                          finalstate(QNew, SNew).
                        
steps(Q, S, QFinal, SFinal,[Move| Moves]) :- move(Q, S, QNew, SNew,Move),
                                            steps(QNew, SNew, QFinal, SFinal,Moves).
                                            
                                            


solve(Moves, Q) :-
            (length(Moves, _)),
            deque(Q, Bs, QNew),
            steps(QNew, [Bs], _, _, Moves).

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




    

