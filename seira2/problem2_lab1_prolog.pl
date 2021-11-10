max_data(n(Data, List), Max):-
    max_list(List,Data,Max).
max_list([],Data,Max):- Max is Data.
max_list([H|T],Data,Max):- 
    H=n(D,L),
    CurrentM is max(D,Data),
    max_list(L, CurrentM, ML),
    max_list(T, ML, Max).
find_depth(n(Data,_),Data,1).
fidn_depth(n(_,List),Data,Depth):-
    member(Elem,List),
    find_depth(Elem,Data,Elem_Depth),
    Elem_Depth is Depth-1.


%%-------------- Tests-----------------------
test_max(Max):- tree(Tree), max_data(Tree,Max).
test_depth(Data,Depth):- tree(Tree),find_depth(Tree,Data,Depth).
tree(n(8, [n(4, [n(6, [n(1, [])]), n(3, [n(2, [])])]),
           n(5, [n(4, []), n(1, [])]),
           n(9, [n(5, [n(0, []), n(4, [])]), n(7, [n(2, [])])])])).
tree(n(1,[n(2,[n(17,[]),n(42,[])]),n(4,[n(5,[])])])).