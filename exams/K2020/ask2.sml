
fun check k n =
 k * k > n orelse
 n mod k <> 0 andalso
 check (k+2) n


fun prime 2 = true
 | prime n = n mod 2 <> 0 andalso
 check 3 n

fun c ls =
 let fun d [] n = n
 | d (42 :: t) n = d t (n + 1)
 | d (h :: t) n = d t n 
 in d ls 0
 end


