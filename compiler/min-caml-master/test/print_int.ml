let rec mul_10 n =
  n * 2 + n * 8
in

let rec div_10_loop n left right =
  if right - left > 1 then
    let mid = (left + right) / 2 in
    let mid10 = mul_10 mid in
    if mid10 > n then div_10_loop n left mid
    else div_10_loop n mid right
  else left
in

let rec div_10 n =
  let left = n / 16 in
  let right = n / 8 in
  div_10_loop n left right
in

let rec mod_10 n =
  let div10 = div_10 n in
  let divmul = mul_10 div10 in
  n - divmul
in

let rec print_int_rec n =
  if n = 0 then ()
  else let m = mod_10 n in (print_int_rec (div_10 n); print_byte (m + 48))
in



let rec a_print_int n =
  if n = 0 then (print_byte 48; print_byte 10)
  else
    if n < 0 then
      (print_byte 45;print_int_rec (-n); print_byte 10)
    else
      (print_int_rec n; print_byte 10)
in a_print_int (3*8+8)
