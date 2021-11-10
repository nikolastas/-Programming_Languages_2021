fun help2 ([], _) = []
    | help2 (h::t, m) = if (m=h) then [h] else help2( t, m) 


fun dp nil = nil
| dp (h::nil) = nil
| dp (h::t) = let val h2 = help2(t,2*h) 
in  if (h2=nil )then dp t else (h::h2)::dp t 
end