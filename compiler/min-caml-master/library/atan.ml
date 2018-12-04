let rec ker_atan x =
  let x2 = x *. x in
  let x3 = x *. x2 in
  let x4 = x2 *. x2 in
  let x9 = x3 *. x3 *. x3 in
    x -. x3 *. 0.3333333 +. x3 *. x2 *. 0.2
      -. x3 *. x4 *. 0.142857142 +. x9 *. 0.111111104
      -. x9 *. x2 *. 0.08976446 +. x9 *. x4 *. 0.060035485
in
let rec a_atan x =
  if x < 0.0 then
    -.a_atan (-.x)
  else if x < 0.4375 then
    ker_atan x
  else if x < 2.4375 then
    let pi = 3.14159265 in
      pi /. 4.0 +. ker_atan ((x -. 1.0) /. (x +. 1.0))
  else
    let pi = 3.14159265 in
      pi /. 2.0 -. ker_atan (1.0 /. x)
in
  print_int (int_of_float (a_atan 3.1))
(* (*debug*)
  print_float (a_atan 3.1 -. atan 3.1); print_newline ();
  print_float (a_atan (-.3.1) -. atan (-.3.1)); print_newline ();
  print_float (a_atan 0.0 -. atan 0.0); print_newline ();
  print_float (a_atan (-.0.2) -. atan (-.0.2)); print_newline ();
  print_float (a_atan 2.5 -. atan 2.5); print_newline ();
  print_float (a_atan 100.0 -. atan 100.0); print_newline ()
*)
(*
let rec a_atan x =
  let abs_x = abs x in
  if abs_x < 0.4375 then
    ker_atan x
  else if abs_x < 2.4375 then
    let pi = 3.14159265 in
      pi /. 4.0 +. ker_atan ((abs_x -. 1.0) /. (abs_x +. 1.0))
  else
    let pi = 3.14159265 in
      pi /. 2.0 -. ker_atan (1.0 /. abs_x)
*)
