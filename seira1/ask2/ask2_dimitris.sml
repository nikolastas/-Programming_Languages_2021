fun readint(infile : string) = let
        val ins = TextIO.openIn infile
    fun loop ins =
        case TextIO.scanStream( Int.scan StringCvt.DEC) ins of
    SOME int => int :: loop ins
    | NONE => []
          in
 loop ins before TextIO.closeIn ins
  end;

fun parse file =
  let
    fun next_String input = (TextIO.inputAll input) 
    val stream = TextIO.openIn file
    val a = next_String stream
  in
    explode(a)
  end  

fun get_text file = tl(tl(tl(tl(parse(file)))))

fun list_conv ([], i, j, m) = []
  | list_conv (((#"\n")::t), i, j, m) = list_conv(t, i, j, m) 
  | list_conv (((#"0")::t), i, j, m) = list_conv(t, i, j, m) 
  | list_conv (((#"1")::t), i, j, m) = list_conv(t, i, j, m) 
  | list_conv (((#"2")::t), i, j, m) = list_conv(t, i, j, m) 
  | list_conv (((#"3")::t), i, j, m) = list_conv(t, i, j, m) 
  | list_conv (((#"4")::t), i, j, m) = list_conv(t, i, j, m) 
  | list_conv (((#"5")::t), i, j, m) = list_conv(t, i, j, m) 
  | list_conv (((#"6")::t), i, j, m) = list_conv(t, i, j, m) 
  | list_conv (((#"7")::t), i, j, m) = list_conv(t, i, j, m) 
  | list_conv (((#"8")::t), i, j, m) = list_conv(t, i, j, m) 
  | list_conv (((#"9")::t), i, j, m) = list_conv(t, i, j, m) 
  | list_conv ((h :: t), i, j, m) = 
    if (j < m) then (h, i, j) :: list_conv(t, i, (j + 1), m)
    else (h, (i + 1), 0) :: list_conv(t, (i + 1), 1, m)

fun cr_array file = list_conv((get_text file), 0, 0, hd(tl (readint file)))

fun move (#"U", i, j) = ((i-1), j)
  | move (#"D", i, j) = ((i+1), j)
  | move (#"L", i, j) = (i, (j-1))
  | move (#"R", i, j) = (i, (j+1))
  | move (#"W", i, j) = (i, j)
  | move (c, i, j) = (print("wrong letter\n"); (0, 0))

fun help (l, 1) = hd(l)
  | help (l, n) = help((tl l), (n - 1))

fun arraymove (a, (x, y), m)  = 
    help (a, (x * m) + y + 1)

fun compare tr [] = false
  | compare tr l =
    if (tr = hd(l)) then true
    else compare tr (tl l)

fun loses (tr, n, m, a, visited) =
  let
    val (x, y) = move(tr)
  in
    if ((x < 0) orelse (y < 0) orelse (x >= n) orelse (y >= m)) then false
    else 
      (if (compare tr visited) then true
      else loses ((arraymove(a, (x, y), m)), n, m, a, (tr :: visited))
      )
  end
fun winner ((#"U", 0, j), n, m) = true
  | winner ((#"R", i, j), n, m) = if (j = m-1) then true else false
  | winner((#"D", i ,j), n, m)= if (i = (n-1)) then true else false
  | winner ((#"L", i, 0), n, m) = true
  | winner((#"W",i,j), n, m) = true
  | winner(tr, n, m) = false
  
fun is_valid (i,j,n,m) =
  if ((i < 0) orelse  (j  < 0) orelse (i >= n) orelse (j >= m)) then false 
  else true

(*https://stackoverflow.com/questions/26580176/change-a-variable-in-standard-ml-list*)

fun change(i,v,[]) = []
  | change(0, v, x::xs) =  v :: xs
  | change(i, v, x::xs) =  if i < 0 then x :: xs
                           else  x :: change((i-1), v, xs)


fun from_block(i, j, n, m, a) =
  let 
    val U = is_valid(i + 1, j, n, m) andalso ((move(arraymove(a, (i + 1, j), m))) = (i, j));
    val D = is_valid(i - 1, j, n, m) andalso ((move(arraymove(a, (i - 1, j), m))) = (i, j));
    val L = is_valid(i, j + 1, n, m) andalso ((move(arraymove(a, (i, j + 1), m))) = (i, j));
    val R = is_valid(i, j - 1, n, m) andalso ((move(arraymove(a, (i, j - 1), m))) = (i, j));
  in
    (U, D, L, R)
  end

fun win_path(i, j, n, m, a) =
  let
    val fb = from_block(i, j, n, m, a)
  in
    case fb of
       (false, false, false, false) => 1
      | (true, false, false, false) => 1 + win_path(i + 1, j, n, m, a)
      | (false, true, false, false) => 1 + win_path(i - 1, j, n, m, a)
      | (false, false, true, false) => 1 + win_path(i, j + 1, n, m, a)
      | (false, false, false, true) => 1 + win_path(i, j - 1, n, m, a)
      | (true, true, false, false) => 1 + win_path(i + 1, j, n, m, a) + win_path(i - 1, j, n, m, a)
      | (true, false, true, false) => 1 + win_path(i + 1, j, n, m, a) + win_path(i, j + 1, n, m, a)
      | (true, false, false, true) => 1 + win_path(i + 1, j, n, m, a) + win_path(i, j - 1, n, m, a)
      | (false, true, true, false) => 1 + win_path(i - 1, j, n, m, a) + win_path(i, j + 1, n, m, a)
      | (false, true, false, true) => 1 + win_path(i - 1, j, n, m, a) + win_path(i, j - 1, n, m, a)
      | (false, false, true, true) => 1 + win_path(i, j + 1, n, m, a) + win_path(i, j - 1, n, m, a)
      | (true, true, true, false) => 1 + win_path(i + 1, j, n, m, a) + win_path(i - 1, j, n, m, a) + win_path(i, j + 1, n, m, a)
      | (true, true, false, true) => 1 + win_path(i + 1, j, n, m, a) + win_path(i - 1, j, n, m, a) + win_path(i, j - 1, n, m, a)
      | (true, false, true, true) => 1 + win_path(i + 1, j, n, m, a) + win_path(i, j + 1, n, m, a) + win_path(i, j - 1, n, m, a)
      | (false, true, true, true) => 1 + win_path(i - 1, j, n, m, a) + win_path(i, j + 1, n, m, a) + win_path(i, j - 1, n, m, a) 
  end



(*
fun win_path (a, i, j, n, m) = win_help(a, i, j, n, m, i, j)

fun win_help (a, i, j, n, m, call_i, call_j) = 
  let 
    val (x, y) = from_block(a, i, j, n, m, #"U")
  in
    if ((x, y) = (~1, ~1)) then 1
    else win_help(change (j + i * m, (#"W", i, j), a), x, y)

*)

fun hor_sum (a, i, 0, n, m) =  if winner((arraymove(a, (i, 0) ,m)), n, m) then win_path(i, 0, n, m, a) else 0
  | hor_sum (a, i, j, n, m) = 
   if (winner((arraymove(a, (i, j) ,m)), n, m)) then hor_sum(a, i, j-1, n, m) + win_path(i, j, n, m, a)
   else hor_sum(a, i, j-1, n, m)

fun vert_sum (a, 0, j, n, m) = 0
  | vert_sum (a, 1, j, n, m) =  if winner((arraymove(a, (1, j) ,m)), n, m) then win_path(1, j, n, m, a) else 0
  | vert_sum (a, i, j, n, m) = 
   if (winner((arraymove(a, (i, j) ,m)), n, m)) then vert_sum(a, i-1, j , n, m) + win_path(i, j, n, m, a)
   else vert_sum(a, i-1, j, n, m)
  
fun other_sum (a,n,m)=
hor_sum(a,0,m-1,n,m) + hor_sum(a,n-1,m-1,n,m)+ vert_sum(a,n-2,0,n,m)+vert_sum(a,n-2,m-1,n,m)
 
fun loop_rooms file =
  let 
    val i = readint file
    val a = cr_array file
  in
    print(Int.toString(hd(i) * hd(tl(i)) - other_sum(a, (hd (i)), (hd(tl (i)))))) 
  end
