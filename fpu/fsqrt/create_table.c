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

  // A0: 0 ~ 2047
  for (key = 0; key < 0x400*2; key++) {
    printf("(key == 11'b");
    printbit(key, 10, 0);
    printf(") ? 46'b");
    if (key < 0x400) {
      // even
      // sqrt(2) / sqrt(1.m)
      input.i = one.i + (key << 13);
      x1.i = input.i;
      x2.i = input.i + ((uint32_t)1 << 13);
      x0.f = (1 / sqrtf(x1.f) + 1 / sqrtf(x2.f)) / sqrt(2);
      constant.f = 3 * x0.f;
      printbit(constant.i, 22, 0);
      gradient.f = powf(x0.f, 3);
      printbit(constant.i, 22, 0);
    } else {
      // odd
      // 2 / sqrt(1.m)
      input.i = one.i + ((key - ((uint32_t)1<<11)) << 13);
      x1.i = input.i;
      x2.i = input.i + ((uint32_t)1 << 13);
      x0.f = (1 / sqrtf(x1.f) + 1 / sqrtf(x2.f));
      constant.f = 3 * x0.f;
      printbit(constant.i, 22, 0);
      gradient.f = powf(x0.f, 3);
      printbit(constant.i, 22, 0);
    }
    
    if (key == 0x400*2-1) {
      printf(" : 46'd0;\n");
    } else {
      printf(" :\n");
    }
  }

  return 0;
}
