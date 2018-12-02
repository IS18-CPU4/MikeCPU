#include <iostream>
#include <cmath>
#include <stdint.h>
#include "fcalc.h"

using namespace std;

uint32_t itof_f(uint32_t x) {
	//split sequence to each subsequence
	uint32_t s, i;//bit数1, 30
	s = getBit32(x, 31, 31);
	i = getBit32(x, 30, 0);
	uint32_t i_abs;//30bit
	i_abs = (s == 0) ? i : getBit32(~(i - 1), 30, 0);
	uint32_t l; //5bit

	auto SE =[](uint32_t M){
		if ((M & (1 << 30)) != 0) {return 0;}
		else if ((M & (1 << 29)) != 0) {return 1;}
		else if ((M & (1 << 28)) != 0) {return 2;}
		else if ((M & (1 << 27)) != 0) {return 3;}
		else if ((M & (1 << 26)) != 0) {return 4;}
		else if ((M & (1 << 25)) != 0) {return 5;}
		else if ((M & (1 << 24)) != 0) {return 6;}
		else if ((M & (1 << 23)) != 0) {return 7;}
		else if ((M & (1 << 22)) != 0) {return 8;}
		else if ((M & (1 << 21)) != 0) {return 9;}
		else if ((M & (1 << 20)) != 0) {return 10;}
		else if ((M & (1 << 19)) != 0) {return 11;}
		else if ((M & (1 << 18)) != 0) {return 12;}
		else if ((M & (1 << 17)) != 0) {return 13;}
		else if ((M & (1 << 16)) != 0) {return 14;}
		else if ((M & (1 << 15)) != 0) {return 15;}
		else if ((M & (1 << 14)) != 0) {return 16;}
		else if ((M & (1 << 13)) != 0) {return 17;}
		else if ((M & (1 << 12)) != 0) {return 18;}
		else if ((M & (1 << 11)) != 0) {return 19;}
		else if ((M & (1 << 10)) != 0) {return 20;}
		else if ((M & (1 << 9)) != 0) {return 21;}
		else if ((M & (1 << 8)) != 0) {return 22;}
		else if ((M & (1 << 7)) != 0) {return 23;}
		else if ((M & (1 << 6)) != 0) {return 24;}
		else if ((M & (1 << 5)) != 0) {return 25;}
		else if ((M & (1 << 4)) != 0) {return 26;}
		else if ((M & (1 << 3)) != 0) {return 27;}
		else if ((M & (1 << 2)) != 0) {return 28;}
		else if ((M & (1 << 1)) != 0) {return 29;}
		else if ((M & (1 << 0)) != 0) {return 30;}
		else {return 31;}
	};

	l = SE(i_abs);

	uint32_t e, m, tmp_i;//bit数8, 23, 31
	tmp_i = getBit32((i_abs << (l + 1)), 30, 0);

	m = getBit32(tmp_i, 30, 8);
	e = getBit32((157 - l), 7, 0);

	uint32_t y;
	y = (i == 0) ? 0 : ((x == 4294967295) ? ((1 << 31) | 158) : ((s << 31) | (e << 23) | m));
	return y;
}
