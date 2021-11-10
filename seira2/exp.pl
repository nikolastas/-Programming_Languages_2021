Q
QSQ 
addAndSquare((Q1, S1)):-
                       
                       not(visit((Q1,S1))),
                       write("this was not in seen :"), write(Q1), write("  "), write(S1), write("  "), writeln(PM1),
                       assert_seen((Q1,S1)). FAIL


Q