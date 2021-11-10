
max_list([],D,D).
max_list([n(D,L)|T],Data,Max):-

CurrentM is max(D,Data),
max_list(L,CurrentM,ML),
max_list(T,ML,Max).

max_data(n(Data,List),Max):- 
    max_list(List,Data,Max).

test_max(Max):- tree(Tree), max_data(Tree,Max).

find_depth(n(Data,_),Data,1).
find_depth(n(_,L),Data,Depth):-

member(Elem,L),
find_depth(Elem,Data,NDepth),
Depth is NDepth+1.

test_depth(Data,Depth):- tree(Tree), find_depth(Tree,Data,Depth).

tree( n(8, [n(4, [n(6, [n(1, [])]), n(3, [n(2, [])])]),
n(5, [n(4, []), n(1, [])]),
n(9, [n(5, [n(0, []), n(4, [])]), n(7, [n(2, [])])])])) .

%tree((n(1,[n(2,[n(17,[]),n(42,[])]),n(4,[n(5,[])])]))).