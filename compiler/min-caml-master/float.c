#include <stdio.h>
#include <stdint.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>

typedef union {
  int32_t i;
  float d;
} flt;

value get32(value v) {
  flt d;
  d.d = (float) Double_val(v);
  return copy_int32(d.i);
}
