#include <iostream>
#include <cmath>
#include <stdint.h>
#include "fcalc.h"
#include "fadd.h"

using namespace std;

uint32_t fsub_f(uint32_t x1, uint32_t x2) {
	uint32_t x2flip;
	if ((x2 & (1 << 31)) != 0) {
		x2flip = getBit32(x2, 30, 0);
	}else {
		x2flip = ((1 << 31) | (getBit32(x2, 30, 0)));
	}
	return fadd_f(x1, x2flip);
}
