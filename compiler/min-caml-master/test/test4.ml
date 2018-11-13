let rec f x =
  let x = x + 5 in
  let y = x + 5 + 3 + 2 in
  let z = x + 5 + 3 + 2 in
  let s = (1,2,3) in
  let t = (1,2,3) in
  let rec f x = x + 1 in
  let u = f 1 in
  let v = f 1 in
  let g = let h = 5 + u in
          let i = 5 + u in
            h + i in
  let c = let a = x + y in
          let b = x + y in
            x + y + a + b + x + y + z in
    c + 5
  in print_int (f 5)
