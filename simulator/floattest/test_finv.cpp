#include <iostream>
#include <cmath>
#include <stdint.h>
#include <random>
#include <algorithm>
#include "float/fcalc.h"
#include "float/finv.h"

using namespace std;

int main() {
	uint32_t x, y;

	uint32_t i;//int
	uint32_t m;//23bit
	uint32_t s, e, dum;//1bit, 8bit, 23bit

	uint32_t xi;//32bit
	float fx, fy;
	uint32_t tmpfy;
	float my_y;
	float epsilon = pow(2, -126);
	int count = 0;

	for (i = 0; i < 8388608; i++) {
		m = getBit32(i, 22, 0);
		s = 0;
		e = 150;
		dum = 1;
		xi = (s << 31) | (e << 23) | m;
		x = xi;

		fx = *(float*)&xi;
		tmpfy = 127 << 23;
		fy = *(float*)&tmpfy / fx;

		y = finv_f(x);
		my_y = *(float*)&y;
		if (abs(my_y - fy) >= max(float(fy*pow(2, -20)), epsilon)){
			count++;
			cout << "invalid result when x = " << *(float*)&x << endl;
			cout << "inverse x = " << fy << endl;
			cout << "finv(x) = " << my_y << endl;
			cout << "count " << count << endl;
		}
	}
	cout << endl;
	cout << "invalid fsqrt count" << count << endl;
}
