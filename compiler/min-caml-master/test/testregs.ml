let rec f i1 f1 i2 =
  if i1 = i2 then
    f1 *. 2.0
  else
    f1 /. 2.0
in
  print_float (f 1 4.5 3)
