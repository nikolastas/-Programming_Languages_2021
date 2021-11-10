fun parse file =
    let 
        fun readInt input = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC)input)
        val inStream = TextIO.openIn file
        val (n,m) = (readInt inStream,readInt inStream)
        val _ = TextIO.inputLine inStream

        fun readLines acc=
            case TextIO.inputLine inStream of
                NONE => rev acc
            | SOME line => readLines (explode (String.substring (line,0,m))::acc)
        val inputList = readLines []:char list list
        val _ = TextIO.closeIn inStream
in 
(n,m,inputList)
end


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

fun winner (#"U", 0, j, n, m) = true
  | winner (#"R", i, j, n, m) = if (j = m-1) then true else false
  | winner(#"D", i ,j, n, m)= if (i = (n-1)) then true else false
  | winner (#"L", i, 0, n, m) = true
  | winner(#"W",i,j, n, m) = true
  | winner(a,i,j, n, m) = false
  
fun is_valid (i,j,n,m) =
  if ((i < 0) orelse  (j  < 0) orelse (i >= n) orelse (j >= m)) then false 
  else true




fun from_block(i, j, n, m, a) =
  let 
    val U = if is_valid(i + 1, j, n, m) then ((move(Array2.sub(a,i+1,j),i+1,j)) = (i, j))
            else false; 
    val D = if is_valid(i - 1, j, n, m) then ((move(Array2.sub(a,i-1,j),i-1,j)) = (i, j))
            else false;
    val L = if is_valid(i, j + 1, n, m) then ((move(Array2.sub(a,i,j+1),i,j+1)) = (i, j))
            else false;
    val R = if is_valid(i, j - 1, n, m) then ((move(Array2.sub(a,i,j-1),i,j-1)) = (i, j))
            else false;
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
      | (true,true,true,true) => 0
  end




fun hor_sum (a, i, 0, n, m) =  if winner(Array2.sub(a,i,0),i,0, n, m) then win_path(i, 0, n, m, a) else 0
  | hor_sum (a, i, j, n, m) = 
   if (winner(Array2.sub(a,i,j),i,j, n, m)) then hor_sum(a, i, j-1, n, m) + win_path(i, j, n, m, a)
   else hor_sum(a, i, j-1, n, m)

fun vert_sum (a, 0, j, n, m) = 0
  | vert_sum (a, 1, j, n, m) =  if winner(Array2.sub(a,1,j),1,j, n, m) then win_path(1, j, n, m, a) else 0 
  | vert_sum (a, i, j, n, m) = 
   if (winner((Array2.sub(a,i,j)),i,j, n, m)) then vert_sum(a, i-1, j , n, m) + win_path(i, j, n, m, a)
   else vert_sum(a, i-1, j, n, m)
  
fun other_sum (a,n,m)=
hor_sum(a,0,m-1,n,m) + hor_sum(a,n-1,m-1,n,m)+ vert_sum(a,n-2,0,n,m)+vert_sum(a,n-2,m-1,n,m)
 
fun loop_rooms file =
  let 
    val (n,m,a)= parse file
    val b=Array2.fromList(a);
  in
    print(Int.toString(n * m - other_sum(b, n, m))) 
  end