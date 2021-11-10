floor(node(T,L,R),Value,FinalBinaryTreeSearch):-
    ( T=:=Value -> FinalBinaryTreeSearch is T
        ; T < Value -> floor (L,Value,FinalBinaryTreeSearch) 
        ; floor (R,T,FinalBinaryTreeSearch)
    ).
