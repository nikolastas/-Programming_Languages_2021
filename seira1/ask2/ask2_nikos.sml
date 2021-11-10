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

fun winner (#"U", 0, j, n, m) = true
  | winner (#"R", i, j, n, m) = if (j = m-1) then true else false
  | winner(#"D", i ,j, n, m)= if (i = (n-1)) then true else false
  | winner (#"L", i, 0, n, m) = true
  | winner(#"W",i,j, n, m) = true
  | winner(a,i,j, n, m) = false
  
fun is_valid (i,j,n,m) =
  if ((i < 0) orelse  (j  < 0) orelse (i >= n) orelse (j >= m)) then false 
  else true

(*https://stackoverflow.com/questions/26580176/change-a-variable-in-standard-ml-list*)



fun from_block (a, i, j, n, m, #"U") = 
  if(is_valid(i - 1, j, n, m)) then
    let
      val result = move(Array2.sub(a,i-1,j),i-1,j)
    in
      if (i, j) = result then (i - 1, j)
      else from_block(a, i, j, n, m, #"D")
    end
  else (from_block(a, i, j, n, m, #"D"))
  | from_block (a, i, j, n, m, #"D") =
  if (is_valid(i + 1, j, n, m)) then
    let
      val result = move(Array2.sub(a,i+1,j),i+1,j)
    in
      if result = (i,j) then (i+1,j)
      else from_block(a, i, j, n, m, #"R")
    end
  else from_block(a, i, j, n, m, #"R")
  | from_block (a, i, j, n, m, #"R") =
  if (is_valid(i , j-1, n, m)) then
    let
      val result = move(Array2.sub(a,i,j-1),i,j-1)
    in
      if result = (i,j) then (i,j-1)
      else from_block(a, i, j, n, m, #"L")
    end
  else from_block(a, i, j, n, m, #"L")
  | from_block (a, i, j, n, m, #"L") =
  if (is_valid(i, j+1, n, m)) then
    let
      val result = move(Array2.sub(a,i,j+1),i,j+1)
    in
      if result = (i,j) then (i,j+1)
      else from_block(a, i, j, n, m, #"W")
    end
  else from_block(a, i, j, n, m, #"W")
  | from_block (a, i, j, n, m, #"W") =  (~1,~1)
    
fun win_path (a, i, j, n, m, counter,deep) = (*mpainoyn mono osa nikane*)
  let
      val (x, y) = from_block(a, i, j, n, m, #"U")
  in
    if ((x, y) = (~1,~1) ) then (*den katalhgei kapoio sto block i,j ara nikaei auto kai na paei se auto pou katalhgei*)
      if(deep=0) then (*periferiako*)
        ( Array2.update(a,i,j,#"W"),counter+1) 
      else 
        let
          val (k,l)=move(Array2.sub(a,i,j),i,j)
        in
          win_path(Array2.update(a,i,j,#"W"), k, l, n, m, counter,(deep-1))
        end
    else win_path(a, x, y, n, m, counter + 1,deep+1)
  end

fun hor_sum (a, i, 0, n, m) =  if winner(Array2.sub(a,i,0),i,0, n, m) then #2 (win_path(a, i, 0, n, m, 0,0))  else 0
  | hor_sum (a, i, j, n, m) = 
  if (winner(Array2.sub(a,i,j),i,j, n, m)) then
  let 
    val (arr,sum)= win_path(a,i,j,n,m,0,0)
  in
    (hor_sum(arr, i, j-1, n, m)+sum)
   
  end
  else hor_sum(a, i, j-1, n, m)

fun vert_sum(a,0,j,n,m,s)=0
  | vert_sum (a, 1, j, n, m,s) =  if winner((Array2.sub(a,1,j)),1,j, n, m) then #2 (win_path(a, 1, j, n, m, 0,0)) else 0
  | vert_sum (a, i, j, n, m,s) = 
  if (winner((Array2.sub(a,i,j)),i,j, n, m)) then
  let 
    val (c,sum)= win_path(a,i,j,n,m,0,0)
  in
    vert_sum(c, i-1, j , n, m)+sum
   
  end
  else vert_sum(a, i-1, j, n, m)
  
fun other_sum (a,n,m)=
hor_sum(a,0,m-1,n,m) + hor_sum(a,n-1,m-1,n,m)+ vert_sum(a,n-2,0,n,m)+vert_sum(a,n-2,m-1,n,m)
 
fun loop_rooms file =
  let 
    val (n,m,a)= parse file
    val b = Array2.fromList(a);
  in
    print(Int.toString(other_sum(b, n, m))) 
  end