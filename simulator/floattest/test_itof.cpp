#include <iostream>
#include <cmath>
#include <stdint.h>
#include <random>
#include <algorithm>
#include "float/fcalc.h"
#include "float/itof.h"

using namespace std;

int main() {
	uint32_t xli;
	uint32_t x;
	float y;
	uint32_t myy;

	for (int i = -4294967295; i < 4294967295; i++) {
	//for (int i = 10000000; i < 100000000; i++) {
	//for (int i = 10000000; i < 100000000; i++) {
		xli = i;
		x = xli;
		y = static_cast<float>(xli);
		myy = itof_f(x);

		if (y != *(float*)(&myy)) {
			cout << "invalid result in itof" << endl;
			cout << "x " <<  hex << x << endl;
			cout << "y " << hex << *(uint32_t*)&y << endl;
			cout << "myy " << hex << myy << endl;
		}
	}
}
