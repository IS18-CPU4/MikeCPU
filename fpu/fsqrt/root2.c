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

int main() {
  union fp root2;
  root2.f = sqrtf(2.0);
  printbit(root2.i, 31, 0);
  printf("\n");

  return 0;
}
