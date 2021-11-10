parent(nikos,kostas).
parent(janna,nikos).
parent(george,nikos).
parent(alex,george).
parent(stavros,alex).
grandparent(GP,GC):-
    parent(GP,P),parent(P,GC).
child(C,P):-
    parent(P,C).
greatgrandparent(GGP,GGC):-
    parent(GGP,GP),parent(GP,P),parent(P,GGC).
ethnocity(nikos,greek).
ethnocity(kostas,american).
greekethnocity(H,E):-
    E=greek,ethnocity(H,E).
adding:-
    open('a.txt', read, H), read_file(H,Lines), close(H),write(Lines),nl.
read_file(Stream,[]) :-
    at_end_of_stream(Stream).
read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_codes(Stream,Codes),
    atom_chars(X, Codes),
    read_file(Stream,L), !.
calcprefix([], [], _).
calcprefix([XH| XT], [YH| YT], S):- YH is XH + S,
                                    calcprefix(XT, YT, YH).