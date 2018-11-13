let rec x x =
  let x = let x = x - (-x) in
    x - (let y = x in let x = -x in x - (-x)) in
  x - (-x) in
  let x = x 125 in print_int (x - (-x))
