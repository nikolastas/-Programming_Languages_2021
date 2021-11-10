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
  if ((i < 0) andalso  (j  < 0) andalso (i >= n) andalso (j >= m)) then false 
  else true

(*https://stackoverflow.com/questions/26580176/change-a-variable-in-standard-ml-list*)

fun change(i,v,[]) = raise Error
  | change(0, v, x::xs) =  v :: xs
  | change(i, v, x::xs) =  if i < 0 then raise Error
                           else  x :: change((i-1), v, xs)

fun from_block (a, i, j, n, m, #"U") = 
  if(is_valid(i - 1, j, n, m)) then
    let
      val result = move(arraymove(a, i - 1, j), m)
    in
      if (i, j) = result then (i - 1, j)
      else from_block(a, i, j, n, m, #"D")
    end
  else (from_block(a, i, j, n, m, #"D"))
  | from_block (a, i, j, n, m, #"D") =
  if (is_valid(i + 1, j, n, m)) then
    let
      val result = move(arraymove(a,i+1,j),m)
    in
      if result = (i,j) then (i+1,j)
    end
      else from_block(a, i, j, n, m, #"R")
  else from_block(a, i, j, n, m, #"R")
  | from_block (a, i, j, n, m, #"R") =
  if (is_valid(i + 1, j, n, m)) then
    let
      val result = move(arraymove(a,i+1,j),m)
    in
      if result = (i,j) then (i+1,j)
    end
      else from_block(a, i, j, n, m, #"L")
  else from_block(a, i, j, n, m, #"L")
  | from_block (a, i, j+1, n, m, #"L") =
  if (is_valid(i, j+1, n, m)) then
    let
      val result = move(arraymove(a,i,j+1),m)
    in
      if result = (i,j) then (i,j+1)
    end
      else from_block(a, i, j, n, m, #"W")
  else from_block(a, i, j, n, m, #"W")
  | from_block (a, i, j, n, m, #"W") =  (~1,~1)
    
fun  win_path (a, i, j, n, m, counter) = (*mpainoyn mono osa nikane*)
  let
      val (x, y) = from_block(a, i, j, n, m, #"U")
  in
    if ((x, y) = (~1,~1) ) then (*den katalhgei kapoio sto block i,j ara nikaei auto kai na paei se auto pou katalhgei*)
      if((i=0) orelse (j=0) orelse (i=n-1) orelse (j=m-1)) then (*periferiako*)
        (change (j+i*m, (#"W", i, j), a), counter + 1)
      else 
        let
          val (k,l)=move(arraymove(a,i,j,m))
        in
          win_path(change (j+i*m, (#"W", i, j),k,l,n,m,counter+1)
        end
    else win_path(a, x, y, n, m, counter)
  end

fun count_loss ([], n, m, ia) = 0
  | count_loss (a, n, m, ia)= 
  if (loses (hd a, n, m, ia, [])) then (count_loss (tl a, n, m, ia) + 1)
  else (count_loss (tl a, n, m, ia))
 
fun loop_rooms file =
  let 
    val i = readint file
    val a = cr_array file
  in
    print(Int.toString(count_loss (a, (hd (i)), (hd(tl (i))), a)) 
  end