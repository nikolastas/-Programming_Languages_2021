
fun max (a, b) = 
  if (a > b) then a
  else b


fun check (h) = if (h mod 2 = 0) then true else false 

fun count(h,m) = if (check(h)=check(m)) then 0 else 1

fun oddeven [t] = 1
| oddeven [h,t]= count(h,t)+1
| oddeven (h::m::t) = if (count(h,m)=1) then count(h,m)+ oddeven(m::t) else 1

fun help [one] = 1
| help [h,s] = if (count(h,s)=1) then 2 else 1
| help (h::t) = max( oddeven(h::t), help (t) )

