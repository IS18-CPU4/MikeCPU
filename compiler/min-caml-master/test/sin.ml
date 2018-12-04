let rec ker_sin x =
  let x2 = x *. x in
  let x3 = x *. x2 in
  x -. x3 *. 0.16666668
    +. x3 *. x2 *. 0.008332824
    -. x3 *. x2 *. x2 *. 0.00019587841
in

let rec ker_cos x =
  let x2 = x *. x in
  1.0 -. x2 *. 0.5
      +. x2 *. x2 *. 0.04166368
      -. x2 *. x2 *. x2 *. 0.0013695068
in

let rec a_sin x =
  let pi = 3.14159265 in
  if x < 0.0 then
    -.a_sin (-.x)
  else if x >= 2.0 *. pi then
    let div_2pi = int_of_float (x /. (2.0 *. pi)) in
    a_sin (x -. (float_of_int div_2pi) *. 2.0 *. pi)
  else if x >= pi then
    -.a_sin (x -. pi)
  else if x >= pi /. 2.0 then
    a_sin (x -. pi /. 2.0)
  else if x >= pi /. 4.0 then
    ker_cos (pi /. 2.0 -. x)
  else (* 0 <= x < pi/4 *)
    ker_sin x
in

let rec a_cos x =
  let pi = 3.14159265 in
  if x < 0.0 then
    a_cos (-.x)
  else if x >= 2.0 *. pi then
    let div_2pi = int_of_float (x /. (2.0 *. pi)) in
    a_cos (x -. (float_of_int div_2pi) *. 2.0 *. pi)
  else if x >= pi then
    -.a_cos (x -. pi)
  else if x >= pi /. 2.0 then
    -.a_cos (x -. pi /. 2.0)
  else if x >= pi /. 4.0 then
    ker_sin (pi /. 2.0 -. x)
  else (* 0 <= x < pi/4 *)
    ker_cos x
in

print_int (int_of_float (10.0 *. (a_sin 5.0)) + int_of_float (10.0 *. (a_cos 5.0)))
