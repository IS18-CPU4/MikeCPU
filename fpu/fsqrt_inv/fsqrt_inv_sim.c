#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <inttypes.h>

union fp {
  float    f;
  uint32_t i;
};
void printbit(uint32_t f, int up, int down){
  for(; down < up+1; down++){
    printf("%d", (int)((f & ((uint32_t)1 << (up-down))) >> (up-down)));
  }
}

uint32_t get_up2down(uint32_t from, int up, int down){
  uint32_t to = 0;
  int i;

  for(i = up; i > down-1; i--){
    to = (to << 1) | ((from >> i) & (uint32_t)1);
  }

  return to;
}

uint64_t get_up2down64(uint64_t from, int up, int down){
  uint64_t to = 0;
  int i;

  for(i = up; i > down-1; i--){
    to = (to << 1) | ((from >> i) & (uint64_t)1);
  }

  return to;
}
uint32_t get_constant(uint32_t key) {
  union fp input;
  union fp x0;
  union fp x1;
  union fp x2;
  union fp one;
  one.f = 1.0;
  union fp gradient;
  union fp constant;
  if (key < 0x400) {
    // even (e=2k)
    // sqrt(2) / sqrt(1.m)
    input.i = one.i + (key << 13);
    x1.i = input.i;
    x2.i = input.i + ((uint32_t)1 << 13);
    x0.f = (1 / sqrtf(x1.f) + 1 / sqrtf(x2.f)) / sqrtf(2);
    constant.f = 3 * x0.f;
    if (get_up2down(constant.i, 30, 23) == 128) {
      return get_up2down(get_up2down(constant.i, 22, 0) + ((uint32_t)1 << 23), 24, 0);
    } else if (get_up2down(constant.i, 30, 23) == 129) {
      return get_up2down((get_up2down(constant.i, 22, 0) + ((uint32_t)1 << 23)) << 1, 24, 0);
    }
  } else {
    // odd (e=2k+1)
    // 2 / sqrt(1.m)
    input.i = one.i + ((key - ((uint32_t)1<<10)) << 13);
    x1.i = input.i;
    x2.i = input.i + ((uint32_t)1 << 13);
    x0.f = (1 / sqrtf(x1.f) + 1 / sqrtf(x2.f));
    constant.f = 3 * x0.f;
    return get_up2down((get_up2down(constant.i, 22, 0) + ((uint32_t)1 << 23)) << 1, 24, 0);
  }
}

uint32_t get_grad(uint32_t key) {
  union fp input;
  union fp x0;
  union fp x1;
  union fp x2;
  union fp one;
  one.f = 1.0;
  union fp gradient;
  union fp constant;
  if (key < 0x400) {
    // even (e=2k)
    // sqrt(2) / sqrt(1.m)
    input.i = one.i + (key << 13);
    x1.i = input.i;
    x2.i = input.i + ((uint32_t)1 << 13);
    x0.f = (1 / sqrtf(x1.f) + 1 / sqrtf(x2.f)) / sqrtf(2);
    gradient.f = powf(x0.f, 3);
    return get_up2down(gradient.i, 22, 0);
  } else {
    // odd (e=2k+1)
    // 2 / sqrt(1.m)
    input.i = one.i + ((key - ((uint32_t)1<<10)) << 13);
    x1.i = input.i;
    x2.i = input.i + ((uint32_t)1 << 13);
    x0.f = (1 / sqrtf(x1.f) + 1 / sqrtf(x2.f));
    gradient.f = powf(x0.f, 3);
    return get_up2down(gradient.i, 22, 0);
  }
}

int main(int argc, char *argv[]){
  union fp x;
  x.f = 1.8;
  union fp y_true;
  y_true.f = 1.0 / sqrtf(x.f);
  union fp y;
  y.f = 0.0;
  uint32_t key;
  uint32_t gradient;
  uint32_t constant;

  // calc e
  uint32_t shift_xe = get_up2down(x.i, 30, 24);
  if (get_up2down(x.i, 23, 23) == 1) {
    y.i = (189 - shift_xe) << 23;
  } else {
    y.i = (190 - shift_xe) << 23;
  }

  key = get_up2down(x.i, 23, 13);

  constant = get_constant(key);
  gradient = get_grad(key);

  printf("constant\n");
  printbit(constant, 24, 0);
  printf("\n");
  printf("grad\n");
  printbit(gradient, 22, 0);
  printf("\n");

  uint64_t grad2 = (uint64_t)((1 << 23) + get_up2down(x.i, 22, 0)) * (uint64_t)((1 << 23) + gradient);
  uint32_t grad3;
  if (get_up2down64(grad2, 47, 47) == 0) {
    grad3 = (uint32_t)(get_up2down64(grad2, 46, 24));
  } else {
    grad3 = (uint32_t)(get_up2down64(grad2, 47, 25));
  }
  uint32_t tmp_m = constant - grad3;
  y.i += get_up2down(tmp_m, 22, 0);

  printf("x\n");
  printbit(x.i, 31, 0);
  printf("\n");
  printf("y_true\n");
  printbit(y_true.i, 31, 0);
  printf("\n");
  printf("y\n");
  printbit(y.i, 31, 0);
  printf("\n");

  return 0;
}
