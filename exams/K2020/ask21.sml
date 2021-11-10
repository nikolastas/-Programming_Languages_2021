fun s ls =
 let fun c [] a = a
       | c r a = c (tl(r)) (r :: a)
 in 
   c ls []
 end