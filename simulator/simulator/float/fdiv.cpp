#include <iostream>
#include <cmath>
#include <stdint.h>
#include "fcalc.h"
#include "fmul.h"
#include "finv.h"

using namespace std;

uint32_t fdiv_f(uint32_t x1, uint32_t x2) {
	uint32_t x2_inv = finv_f(x2);
	uint32_t y = fmul_f(x1, x2_inv);
	return y;
}
