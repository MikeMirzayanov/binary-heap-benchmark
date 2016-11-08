(* ocamlopt unix.cmxa -unsafe heap.ml -o heap *)

let _ =
  let n = 10_000_000 in
  let h = Array.init n (fun i -> i) in
  let push_down pos n =
    let pos = ref pos in
      while 2 * !pos + 1 < n do
        let j = 2 * !pos + 1 in
	let j =
          if j + 1 < n && h.(j + 1) > h.(j)
          then j + 1
	  else j
	in
          if h.(!pos) >= h.(j)
	  then pos := n
          else (
	    let tmp = h.(!pos) in
	      h.(!pos) <- h.(j);
	      h.(j) <- tmp;
              pos := j;
	  )
      done
  in
  let start = Unix.gettimeofday () in
    for i = n / 2 downto 0 do
      push_down i n
    done;
    for i = n - 1 downto 1 do
       let tmp = h.(0) in
	 h.(0) <- h.(i);
	 h.(i) <- tmp;
	 push_down 0 i;
    done;
    for i = 0 to n - 1 do
      assert (h.(i) = i)
    done;
    Printf.printf "Done in %f\n" (Unix.gettimeofday () -. start)


