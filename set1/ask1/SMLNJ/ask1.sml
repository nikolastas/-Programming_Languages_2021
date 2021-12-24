fun readint(infile : string) = let
        val ins = TextIO.openIn infile
    fun loop ins =
        case TextIO.scanStream( Int.scan StringCvt.DEC) ins of
    SOME int => int :: loop ins
    | NONE => []
          in
 loop ins before TextIO.closeIn ins
  end;
 (*https://stackoverflow.com/questions/29809722/reading-an-integer-file-to-an-integer-list-in-sml*)

fun max (a, b) = 
  if (a > b) then a
  else b

fun min (a, b) =
  if (a < b) then a
  else b
  
fun reverse xs =
  let
  fun rev (nil, z) = z
    | rev (y::ys, z) = rev (ys, y::z)
  in
    rev (xs, nil)
  end

fun LMin ([h], cMin) = [min(h, cMin)]
  | LMin (h :: t, cMin) = 
    let
      val crMin = min(h, cMin)
    in
      [crMin] @ LMin(t, crMin)
    end
  | LMin ([], cMin) = []

fun RMax ([h], cMax) = [max(h, cMax)]
  | RMax (h :: t, cMax) = 
    let 
      val crMax = max(h, cMax)
    in
      [crMax] @ RMax(t, crMax)
    end
  | RMax ([], cMax) = []

fun help([], rmax, c, i, j) = max(0, c)
  | help(lmin, [], c, 0, j) = c + 1
  | help(lmin, [], c, i, j) = max(0,c)
  | help(lmin, rmax, c, i, j) =
    if (hd(lmin) < hd(rmax)) then 
      let 
        val cl = max((j - i ), c) 
      in
        help(lmin, tl(rmax), cl, i, (j + 1))
      end
    else (help(tl(lmin), rmax, c,i+1,j))



fun maxIndexDiff([]) = 0
  | maxIndexDiff(arr) =
  let 
    val A=LMin(arr, 1000000000)
    val B=reverse(RMax(reverse(arr),~1000000000))
  in
    help(A,B,(~1), 0, 0)
  end

fun modifyarr([], n) = []
  | modifyarr(h::t, n)=
    [h + n] @ modifyarr(t, n)


fun calcprefix(h::k::t)= ~h::calcprefix(h+k::t)
  | calcprefix([xs]) = [~xs]
  | calcprefix([])=[]
  
  
fun longesthelp ([],n ) = 0
  | longesthelp(h::t,n) = maxIndexDiff(calcprefix(modifyarr(h::t,n)))

fun longest file = 
  let
    val fl = readint file
  in
  print(Int.toString(longesthelp(tl(tl(fl)), hd(tl(fl)))) ^ "\n")
  
  end