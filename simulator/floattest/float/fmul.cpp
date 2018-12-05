#include <iostream>
#include <cmath>
#include <stdint.h>
#include "fcalc.h"

using namespace std;

uint32_t fmul_f(uint32_t x1, uint32_t x2) {

	//split sequence to each subsequence
	uint32_t s1, s2, e1, e2, m1, m2;//bit数 1,1,8,8,23,23

	s1 = getBit32(x1, 31, 31);
	s2 = getBit32(x2, 31, 31);
	e1 = getBit32(x1, 30, 23);
	e2 = getBit32(x2, 30, 23);
	m1 = getBit32(x1, 22, 0);
	m2 = getBit32(x2, 22, 0);

	//ok

	//calc s for y
	uint32_t s;//bit数 1
	s = s1 ^ s2;

	//calc m
	uint64_t tmp_m;//bit数 48
	uint64_t tmp_tmp_m;
	tmp_tmp_m = (uint64_t)((1 << 23) | m1) * (uint64_t)((1 << 23) | m2);
	tmp_m = getBit64(tmp_tmp_m, 47, 0);

	uint32_t m;//bit数 23
	m = ((((uint64_t)1 << 47) & tmp_m) == 0)? (uint32_t)getBit64(tmp_m, 45, 23):(uint32_t)getBit64(tmp_m, 46, 24);

	//calc e
	uint32_t tmp_e;//bit数9
	tmp_e = ((((uint64_t)1 << 47) & tmp_m) == 0) ? (e1 + e2) : (e1 + e2 + 1);
	uint32_t tmp_tmp_e, e;//bit数 9, 8
	tmp_tmp_e = getBit32(tmp_e - 127, 8, 0);
	e = getBit32(tmp_tmp_e, 7, 0);

	//determine whether overflow or underflow
	bool unf;//bit数1
	unf = (tmp_e <= 127) || ((e1 == 0) || (e2 == 0));
	bool ovf;
	ovf = (tmp_e >= 382);

	uint32_t y;
	y = (unf) ? 0 : ((ovf) ? ((s << 31) | 0x7F800000) : ((s << 31) | (e << 23) | m)); 
	return y;
}
