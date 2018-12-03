#include <iostream>
#include <cmath>
#include <stdint.h>
#include <random>
#include <algorithm>
#include "float/fcalc.h"
#include "float/fdiv.h"

using namespace std;

int main() {
	random_device rd;
	mt19937 mt(rd());
	float x1, x2, div_result, mydiv_result;
	uint32_t ux1, ux2, umydiv_result;
	float LOW = -pow(2, 127);
	float HI = pow(2, 127);
	float epsilon = pow(2, -126);
	uniform_real_distribution<> dis(LOW, HI);
	int count = 0;
	float diff;
	uint32_t i, m, s, e;

	for (i = 0; i < 8388608; i++) {
		x1 = (float)dis(mt);
		//x2 = (float)dis(mt);
		m = getBit32(i, 22, 0);
		s = 0;
		e = 150;
		ux2 = (s << 31) | (e << 23) | m;
		x2 = *(float*)&ux2;

		div_result = (float)(x1 / x2);
		if (div_result >= HI || div_result <= LOW) {
			continue;
		}

		ux1 = *(uint32_t*)&x1;
		//ux2 = *(uint32_t*)&x2;
		umydiv_result = fdiv_f(ux1, ux2);
		mydiv_result = *(float*)&umydiv_result;
		diff = max(float(abs(div_result)*pow(2, -20)), epsilon);
		
		if (abs(mydiv_result - div_result) >= diff) {
			count++;
			cout << "invalid result when x1 = " << x1 << ", x2 = " << x2 << endl;
			cout << "x1 / x2 = " << div_result << endl;
			cout << "fdiv(x1, x2) = " << mydiv_result << endl;
			cout << "invalid fdiv count " << count << endl;
		}
	}
	cout << endl;
	cout << "invalid fdiv count " << count << endl;
}
