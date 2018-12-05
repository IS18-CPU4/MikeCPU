#include <iostream>
#include <cmath>
#include <stdint.h>
#include <random>
#include <algorithm>
#include "float/fmul.h"

using namespace std;

int main() {
	random_device rd;
	mt19937 mt(rd());
	float x1, x2, mul_result, mymul_result;
	uint32_t ux1, ux2, umymul_result;
	float LOW = -pow(2, 127);
	float HI = pow(2, 127);
	float epsilon = pow(2, -126);
	uniform_real_distribution<> dis(LOW, HI);
	int count = 0;
	float diff;

	for (int i = 0; i < 1000000000; i++) {
		x1 = (float)dis(mt);
		x2 = (float)dis(mt);
		mul_result = (float)(x1 * x2);
		if (mul_result >= HI || mul_result <= LOW) {
			continue;
		}

		ux1 = *(uint32_t*)&x1;
		ux2 = *(uint32_t*)&x2;
		umymul_result = fmul_f(ux1, ux2);
		mymul_result = *(float*)&umymul_result;
		diff = max((float)(abs(mul_result)*pow(2, -22)), epsilon);
		
		if (abs(mymul_result - mul_result) >= diff) {
			count++;
			cout << "invalid result when x1 = " << x1 << ", x2 = " << x2 << endl;
			cout << "x1 * x2 = " << mul_result << endl;
			cout << "fmul(x1, x2) = " << mymul_result << endl;
		}
	}
	cout << endl;
	cout << "invalid fmul count " << count << endl;
}
