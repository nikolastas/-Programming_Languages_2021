
read_input(File, M, N, K) :-
    open(File, read, Stream),
    read_line(Stream, [M, N]),
    read_line(Stream, K).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

modifyarr([], [], N):- N>0.
modifyarr([XH| XT], [YH| YT], N) :- YH is XH + N,
                                 modifyarr(XT, YT, N). 


calcprefix([], [], _).
calcprefix([XH| XT], [YH| YT], S):- NewS is XH + S, /* edw theloume to S na einai to sum alla to YH = -S */
                                    YH is -NewS,
                                    calcprefix(XT, YT, NewS).
longestsubarray(X, MaxDiff, N) :-
modifyarr(X, Y, N),
calcprefix(Y, Z, 0),

maxindexdiff(Z, _, _,MaxDiff),
writeln(MaxDiff).

lmin([], [], _).
lmin([XH| XT], [YH| YT], Min) :-  YH is min(XH, Min),
                                  lmin(XT, YT, YH).

rmax([], [], _).
rmax([XH| XT], [YH| YT], Max) :-  YH is max(XH, Max),
                                  rmax(XT, YT, YH).

maxdiff(_, [], Max,  0, _, MaxDiff) :- MaxDiff is Max + 1.

maxdiff(_, [], Max, I, _, MaxDiff) :- I > 0, MaxDiff is Max.
                                
maxdiff([], _, Max, I, J, MaxDiff) :- I>0,J>0,MaxDiff is Max.
                                       
maxdiff([LMH| LMT], [RMH| RMT], Max, I, J, MaxDiff) :- 
             LMH < RMH,
             Diff is J - I,
             TempMax is max(Diff, Max),
             
             NewJ is J + 1,
             maxdiff([LMH| LMT], RMT, TempMax, I, NewJ, MaxDiff).

maxdiff([LMH| LMT], [RMH| RMT],Max ,I , J, MaxDiff) :- 
            
            LMH >= RMH,
            NewI is I+1,
            maxdiff(LMT, [RMH| RMT], Max, NewI, J, MaxDiff).


                   
maxindexdiff(X, LM, RM, MaxDiff):-
    lmin(X, LM, 999999999),
    reverse(X, RX),
    rmax(RX, RZ, -9999999),
    reverse(RZ, RM),
    maxdiff(LM, RM, 0, 0, 0, MaxDiff).
    
longest(F,Answer):-
    read_input(F,_,N,K),
    longestsubarray(K,Answer,N).