#include <iostream>
#include <cmath>
#include <stdint.h>
#include "fcalc.h"

using namespace std;

uint32_t ftoi_f(uint32_t x) {

	//split sequence to each subsequence
	uint32_t s, e, m;//bit数 1, 8, 23
	s = getBit32(x, 31, 31);
	e = getBit32(x, 30, 23);
	m = getBit32(x, 22, 0);

	uint32_t m1;//24bit
	m1 = (1 << 23) | m;

	uint64_t shift_m1;//54bit
	uint64_t tmp_shift_m1;
	tmp_shift_m1 = (uint64_t)m1 << (e - 127);
	shift_m1 = getBit64(tmp_shift_m1, 53, 0);

	uint32_t i;//31bit
	i = (e == 126) ? 1 : ((e <= 125)? 0 : ((e >= 150) ? (uint32_t)getBit64(shift_m1, 53, 23): ((uint32_t)getBit64(shift_m1, 53, 23) + (uint32_t)getBit64(shift_m1, 22, 22))));

	//ovf
	//ovf = (e >= 158);

	uint32_t y;
	y = (s == 0) ? ((s << 31) | getBit32(i, 30, 0)) : (((1 << 31) | getBit32(~i, 30, 0)) + 1);
	return y;
	
}
