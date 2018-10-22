#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <inttypes.h>

// M_{1/A} = (2 * M_{x0} - M_{A0} * M_{x0}^2 / 2^(23+k)) - M_{A1} * M_{x0}^2 / 2^47

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

int main(int argc, char *argv[]){
  uint32_t key;
  union fp input;
  union fp x0;
  union fp x1;
  union fp x2;
  union fp one;
  union fp gradient;
  union fp constant;

  one.f = 1.0;

  // A0: 0 ~ 1023
  for (key = 0; key < 0x400; key++) {
    printf("(key == 10'b");
    printbit(key, 9, 0);
    printf(") ? 46'b");
    input.i = one.i + (key << 13);
    x1.i = input.i;
    x2.i = input.i + ((uint32_t)1 << 13);
    x0.f = 1.0 / x1.f + 1.0 / x2.f;
    constant.f = 2.0 * x0.f - input.f * x0.f * x0.f;
    printbit(constant.i, 22, 0);
    gradient.f = x0.f * x0.f;
    if (get_up2down(gradient.i, 30, 23) == 127) {
      printbit(get_up2down(gradient.i, 22, 1), 22, 0);
    } else if (get_up2down(gradient.i, 30, 23) == 128) {
      printbit(get_up2down(gradient.i, 22, 1) + ((uint32_t)1 << 23), 22, 0);
    } else {
      return 1;
    }
    if (key == 0x3ff) {
      printf(" : 46'd0;\n");
    } else {
      printf(" :\n");
    }
  }

  return 0;
}
