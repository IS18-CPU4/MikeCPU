#include <iostream>
#include <cmath>
#include <stdint.h>
#include <random>
#include <algorithm>
#include "float/fadd.h"

using namespace std;

int main() {
	random_device rd;
	mt19937 mt(rd());
	float x1, x2, add_result, myadd_result;
	uint32_t ux1, ux2, umyadd_result;
	float LOW = -pow(2, 127);
	float HI = pow(2, 127);
	float epsilon = pow(2, -126);
	uniform_real_distribution<> dis(LOW, HI);
	int count = 0;
	float diff, difftmp;

	for (int i = 0; i < 1000000000; i++) {
		x1 = (float)dis(mt);
		x2 = (float)dis(mt);
		add_result = (float)(x1 + x2);
		if (add_result >= HI || add_result <= LOW) {
			continue;
		}

		ux1 = *(uint32_t*)&x1;
		ux2 = *(uint32_t*)&x2;
		umyadd_result = fadd_f(ux1, ux2);
		myadd_result = *(float*)&umyadd_result;
		difftmp = max({abs(x1)*pow(2, -23), abs(x2)*pow(2, -23), abs(add_result)*pow(2, -23)});
		diff = max(difftmp, epsilon);
		
		if (abs(myadd_result - add_result) >= diff) {
			count++;
			cout << "invalid result when x1 = " << x1 << ", x2 = " << x2 << endl;
			cout << "x1 + x2 = " << add_result << endl;
			cout << "fadd(x1, x2) = " << myadd_result << endl;
		}
	}
	cout << endl;
	cout << "invalid fadd count " << count << endl;
}
