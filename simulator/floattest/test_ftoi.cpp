#include <iostream>
#include <cmath>
#include <stdint.h>
#include <random>
#include <algorithm>
#include "float/fcalc.h"
#include "float/ftoi.h"

using namespace std;

int main() {
	uint32_t x;
	uint32_t m;
	uint32_t y;

	for (uint32_t i = 0; i < 158; i++) {
		for (uint32_t s1 = 0; s1 < 2; s1++) {
			for (int it = 0; it < 4194304; it++) {
				m  = it;
				x = (s1 << 31) | (i << 23) | m;

				y = ftoi_f(x);

				if (abs(static_cast<int>(y) - static_cast<int>(*(float*)(&x))) > 1) {
					cout << "invalid result in ftoi" << endl;
					cout << "x " << *(float*)(&x) << endl;
					cout << "e " << i << endl;
					cout << "y " << (int)(*(float*)(&x)) << endl;
					cout << "myy " << (int)(y) << endl;
				}
			}
		}
	}
}
