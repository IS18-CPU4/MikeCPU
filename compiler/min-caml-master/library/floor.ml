(* ftoiの仕様依存 *)
let rec a_floor x =
(* (* ftoiが切り捨て *)
  if x < 0.0 then
    int_of_float (x -. 1.0)
  else
    int_of_float x
*)
(* ftoi四捨五入かつfloatで返す *)
  float_of_int(int_of_float (x -. 0.5))
in
  print_int(int_of_float(a_floor 5.2));
  print_int(int_of_float(a_floor 5.6));
  print_int(int_of_float(a_floor (-.5.2)));
  print_int(int_of_float(a_floor (-.5.6)));
  print_int(int_of_float(a_floor 0.2));
  print_int(int_of_float(a_floor 0.0));
  print_int(int_of_float(a_floor (-.0.1)));
  print_int(int_of_float (-.0.6));
  print_int(int_of_float (float_of_int(-1)));
