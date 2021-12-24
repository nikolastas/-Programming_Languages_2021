

fun readint(infile : string) = let
        val ins = TextIO.openIn infile
    fun loop ins =
        case TextIO.scanStream( Int.scan StringCvt.DEC) ins of
    SOME int => int :: loop ins
    | NONE => []
          in
 loop ins before TextIO.closeIn ins
  end;

fun max (a, b) = 
  if (a > b) then a
  else b
fun min (a, b) =
  if (a < b) then a
  else b

fun sum_of_moves(n, [], c, currsum, _, currmax) = (currsum, currmax)
  | sum_of_moves(n, (h :: t), c, currsum, i, currmax) = 
      let
        val distance = (c - h) mod n 
      in
        sum_of_moves(n, t, c, currsum + distance, i + 1, max(currmax, distance))
    end;


fun possible_solutions(n, l, c, minsum, bestc) = 
   let
      val (sum, max) = sum_of_moves(n, l, c, 0, 0, ~1)
    in 
      if ((sum < minsum) andalso (max <= sum - max + 1)) then (if (c < n - 1) then possible_solutions(n, l, c + 1, sum, c) else (sum, c))
      else (if (c < n - 1) then possible_solutions(n, l, c + 1, minsum, bestc) else (minsum, bestc))
    end;

fun round file = 
  let 
    val input = readint(file)
    val (m, c) = possible_solutions(hd(input), tl(tl(input)), 0, 999999999, ~1)
  in
    print(Int.toString(m)^ " " ^ Int.toString(c)^ "\n")
  end;

