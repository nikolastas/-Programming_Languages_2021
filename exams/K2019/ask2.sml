datatype 'a tree = Leaf of 'a 
                | Node of ( 'a * ('a tree) * ('a tree))
fun floor (t,k)=
    let fun walk Leaf sofar =sofar
    | walk (Node(x,l,r)) sofar =
    if k=x then SOME x
    else if k<x then walk l sofar
    else walk r (SOME x)
    in walk t NONE
    end


fun test(k) =
let val t2 = Node(10, Node(3,Leaf, Leaf), Leaf)
in  floor(t2,k)
end