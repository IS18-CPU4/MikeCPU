(* ftoiの仕様依存 *)
let rec a_floor x =
  if x < 0.0 then
    int_of_float (x -. 1.0)
  else
    int_of_float x
in
  print_int(a_floor 5.2);
  print_int(a_floor 5.6);
  print_int(a_floor (-5.2));
  print_int(a_floor (-5.6));
  print_int(a_floor 0.2);
  print_int(a_floor 0.0);
  print_int(a_floor (-0.1))
