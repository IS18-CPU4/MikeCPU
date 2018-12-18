#include <iostream>
#include <cmath>
#include <stdint.h>
#include <random>
#include <algorithm>
#include "float/fsub.h"

using namespace std;

int main() {
	random_device rd;
	mt19937 mt(rd());
	float x1, x2, sub_result, mysub_result;
	uint32_t ux1, ux2, umysub_result;
	//float LOW = -pow(2, 127);
	float LOW = -1000;
	//float HI = pow(2, 127);
	float HI = 1000;
	float epsilon = pow(2, -126);
	uniform_real_distribution<> dis(LOW, HI);
	int count = 0;
	float diff, difftmp;

	//for (int i = 0; i < 1000000000; i++) {
	for (int i = 0; i < 1000000000; i++) {
		x1 = (float)dis(mt);
		x2 = (float)dis(mt);
		sub_result = (float)(x1 - x2);
		if (sub_result >= HI || sub_result <= LOW) {
			continue;
		}

		ux1 = *(uint32_t*)&x1;
		ux2 = *(uint32_t*)&x2;
		umysub_result = fsub_f(ux1, ux2);
		mysub_result = *(float*)&umysub_result;
		difftmp = max({abs(x1)*pow(2, -23), abs(x2)*pow(2, -23), abs(sub_result)*pow(2, -23)});
		diff = max(difftmp, epsilon);
		
		if (abs(mysub_result - sub_result) >= diff) {
			count++;
			cout << "invalid result when x1 = " << x1 << ", x2 = " << x2 << endl;
			cout << "x1 - x2 = " << sub_result << endl;
			cout << "fsub(x1, x2) = " << mysub_result << endl;
		}
	}
	cout << endl;
	cout << "invalid fsub count " << count << endl;
}
