let rec myfib m =
  let rec fib n a =
    if n <= 1 then n else
    fib (n - 1) 0 + fib (n - 2) 0 + m + a in
  let i = 1 in
  let j = 2 in
  let k = 3 in
  let l = 5 in
    (fib 30 0) + i + j + k + l in
let i = 1 in
let j = 2 in
let k = 3 in
let l = 5 in
  print_int (myfib (30 + (if i + j = k + l then myfib 5 else myfib 8) + j))
