
datatype 'a tree = Empty| Node of 'a * 'a tree * 'a tree


fun cntleaves Empty = 0
 | cntleaves (Node(_,Empty,Empty)) = 1
 | cntleaves (Node (_,tree1 , tree2)) = (cntleaves tree1) + (cntleaves tree2);

val t1 = Node(3, Empty, Node(5, Empty, Empty));

fun parity Empty = false
    | parity (Node(a,t1,t2))= if (a mod 2=0) then true else false

fun check (Node(a,Empty,Empty))= true 
| check (Node(a,t1,t2))= if (parity(Node(a,t1,t2))= parity(t1) andalso parity(Node(a,t1,t2))= parity(t2)) then true 
else false  

fun rest (Node(a,t1,t2)) = [t1,t2]

fun trim (Node(a,Empty,Empty)) = []
| trim (Node(a,t1,t2)) = if check(Node(a,t1,t2)) then [trim(t1), trim(t2)] 
    else (a::rest(Node(a,t1,t2)))::trim(t1)