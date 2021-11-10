fun createlist (l,0)=[]
    | createlist ([],n) = []
    | createlist (h::t, 1) = [h]
    | createlist (h::t, n) =  h::createlist(t,(n-1))

fun fixed ([], _) = []
    |fixed (h::t, 0) = t
    | fixed (h::t, n) = fixed( t, n-1)

fun reconstruct [] =[]
    | reconstruct ([a,b]) = if (a>=1) then [[a,b]] 
    else [[a],[b]]
 | reconstruct (h::m::t) = (h::createlist(m::t , h)) ::reconstruct ( fixed(h::m::t, h) )

fun help (_, 0) = []
      | help (h::t, n) = (h :: (help (t, (n-1))))


fun reconstruct1 ([], _) = []
  | reconstruct1 (h::t, 0) = help(h::t, h+1) :: reconstruct1(t, h)
  | reconstruct1 (h::t, n) = reconstruct1(t, n - 1)
fun reconstruct F = reconstruct1 (F, 0)
