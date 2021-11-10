fun common_prefix x y =
let fun aux (h1 :: t1) (h2 :: t2) prefix =
            if h1 = h2 then (aux t1 t2 (h1::prefix))
              else (rev prefix,(h1::t1),(h2::t2))
        | aux s1 s2 prefix = (prefix, [], [])
  in  aux x y []
  end