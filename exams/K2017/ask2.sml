listify ls x =
    let 
        fun traverse (cmp, [a])=
            if cmp<x then [[cmp]] else [[cmp],[]]
        | traverse (cmp, (h::m::t))=
            if (h<x)= (el<x) then
            (cmp::h::m::t)
            else 
           [cmp] :: (h :: m) :: t
            (* Τρέχουμε την traverse σειριακά στην ls μέσω foldl *)
    let result = foldl traverse [[]] ls
    in
    (* Αντιστρέφουμε τη σειρά ομάδων και των στοιχείων τους για να βγει το σωστό
    αποτέλεσμα *)
    rev (map rev result)
end