let rec mul_10 n =
  n + n + n + n + n + n + n + n + n + n

let rec div_10_loop n left right =
  if right - left > 1 then
    let mid = (left + right) / 2 in
    let mid10 = mul_10 mid in
    if mid10 > n then div_10_loop n left mid
    else div_10_loop n mid right
  else left
let rec div_10 n =
  let left = 0 in
  let right = n / 2 in
  div_10_loop n left right

let rec mod_10 n =
  let div10 = div_10 n in
  let divmul = mul_10 div10 in
  n - divmul


let rec print_int_rec n =
  if n = 0 then ()
  else let m = mod_10 n in (print_int_rec (div_10 n); print_byte (m + 48))

let rec _print_int n =
  if n = 0 then (print_byte 48; print_byte 10)
  else
    let m = mod_10 n in
    (print_int_rec (div_10 m); print_byte 10)
