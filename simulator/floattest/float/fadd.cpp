#include <iostream>
#include <cmath>
#include <stdint.h>
#include "fcalc.h"

using namespace std;

uint32_t priority_encoder(uint32_t);

uint32_t fadd_f(uint32_t x1, uint32_t x2) {//とりあえず結果yだけ返す オーバーフローは無視

	//1
	uint32_t s1, s2, e1, e2, m1, m2; //bit数 先頭から 1,1,8,8,23,23

	s1 = getBit32(x1, 31, 31);
	s2 = getBit32(x2, 31, 31);
	e1 = getBit32(x1, 30, 23);
	e2 = getBit32(x2, 30, 23);
	m1 = getBit32(x1, 22, 0);
	m2 = getBit32(x2, 22, 0);


	//2
	uint32_t m1a, m2a; //bit数 25, 25

	if (e1 == 0) {
		m1a = m1;
	} else {
		m1a = (m1 | (1 << 23));
	}
	if (e2 == 0) {
		m2a = m2;
	} else {
		m2a = (m2 | (1 << 23));
	}


	//3
	uint32_t e1a, e2a; //bit数 8, 8

	e1a = (e1 == 0) ? 1 : e1;
	e2a = (e2 == 0) ? 1 : e2;

	//4
	uint32_t e2ai; //bit数 8
	e2ai = getBit32(~e2a, 7, 0);

	//5
	uint32_t te; //bit数 9
	te = getBit32(e1a + e2ai, 8, 0);

	//6
	uint32_t ce, tde, tmp1, tmp2; //bit数 1, 8, 9, 8;

	ce = ((te & (1 << 8)) != 0) ? 0 : 1;
	tmp1 = te + 1;
	tmp2 = getBit32(~te, 7, 0);
	tde = ((te & (1 << 8)) != 0) ? getBit32(tmp1, 7, 0) : getBit32(tmp2, 7, 0);

	//7
	uint32_t de; //bit数 5

	de = (getBit32(tde, 7, 5) != 0)? 31: getBit32(tde, 4, 0);

	//8
	uint32_t sel; //bit数 1
	if (de == 0) {
		sel = (m1a > m2a) ? 0 : 1;
	} else {
		sel = ce;
	}

	//9
	uint32_t ms, mi, es,ss; //bit数 25, 25, 8, 1
	//ei 8bit

	ms = (sel == 0)? m1a : m2a;
	mi = (sel == 0)? m2a : m1a;
	es = (sel == 0)? e1a : e2a;
//	ei = (sel == 0)? e2a : e1a;
	ss = (sel == 0)? s1 : s2;

	//10
	uint64_t mie; //bit数 56
	mie = getBit64(((uint64_t)mi << 31), 55, 0);

	//11
	uint64_t mia; //bit数 56
	mia = getBit64((mie >> de), 55, 0);

	//12
	uint32_t tstck; //bit数 1
	tstck = (getBit32(mia, 28, 0) != 0) ? 1 : 0;

	//13
	uint32_t mye; //bit数 27
	if (s1 == s2) {
		mye = (ms << 2) + (uint32_t)getBit64(mia, 55, 29);
	} else {
		mye = (ms << 2) - (uint32_t)getBit64(mia, 55, 29);
	}

	//14
	uint32_t esi; //bit数 8
	esi = es + 1;

	//15
	uint32_t eyd, myd, stck; //bit数 8, 27, 1

	if ((mye & (1 << 26)) != 0) {
		eyd = (esi == 255) ? 255 : esi;
	} else {
		eyd = es;
	}
	if ((mye & (1 << 26)) != 0) {
		uint32_t mydtmp;
		mydtmp = (esi == 255) ? (1 << 26): (mye >> 1);
		myd = getBit32(mydtmp, 26, 0);
	} else {
		myd = mye;
	}
	if ((mye & (1 << 26)) != 0) {
		stck = (tstck || (mye & (1 << 0)));
	} else {
		stck = tstck;
	}

	//16
	uint32_t se; //bit数 5
	se = priority_encoder(myd);

	//17
	int32_t eyf; //bit数 9
	eyf = (int32_t)eyd - (int32_t)se;

	//18
	uint32_t eyr, myf; //bit数 8, 27
	uint32_t myftmp;
	if (eyf > 0) {
		myftmp = myd << se;
		myf = getBit32(myftmp, 26, 0);
	} else {
		myftmp = myd << (getBit32(eyd, 4, 0) -1);
		myf = getBit32(myftmp, 26, 0);
	}
	eyr = (eyf > 0) ? (getBit32((uint32_t)eyf, 7, 0)) : 0;

	//19
	uint32_t myr; //bit数 25
	myr =  ((((myf & (1 << 1)) != 0) && ((myf & (1 << 0)) == 0) && (stck = 0) && (((myf & (1 << 2)) != 0))) || (((myf & (1 << 1)) != 0) && ((myf & (1 << 0)) == 0) && (s1 == s2) && (stck = 1)) || (((myf & (1 << 1)) != 0) && ((myf & (1 << 0)) != 0))) ? (getBit32(myf, 26, 2) + (1 << 25)) : (getBit32(myf, 26, 2));

	//20
	uint32_t eyri; //bit数 8
	eyri = getBit32(eyr + 1, 7, 0);

	//21
	uint32_t ey, my; //bit数 8, 23
	ey = ((myr & (1 << 24)) != 0) ? eyri : ((getBit32(myr, 23, 0) == 0)? 0 : eyr);
	my = ((myr & (1 << 24)) != 0) ? 0 : ((getBit32(myr, 23, 0) == 0)? 0 : getBit32(myr, 22, 0));

	//22
	uint32_t sy; //bit数 1
	sy = (ey == 0 && my == 0) ? (s1 && s2) : ss;

	//23
	uint32_t nzm1, nzm2;//bit数 1, 1
	nzm1 = (getBit32(m1, 22, 0) != 0) ? 1:0;
	nzm2 = (getBit32(m2, 22, 0) != 0) ? 1:0;

	uint32_t y;//output 32bit
	y = ((e1 == 255)&&(e2 != 255)) ? ((s1 << 31) | (255 << 23) | (nzm1 << 22) | getBit32(m1, 21, 0)) : (((e2 == 255)&&(e1 != 255)) ? ((s2 << 31) | (255 << 23) | (nzm2 << 22) | getBit32(m2, 21, 0)) : (((e1 == 255) && (e2 == 255) && nzm2) ? ((s2 << 31) | (255 << 23) | (1 << 22) | getBit32(m2, 21, 0)) : (((e1 == 255) && (e2 == 255) && nzm1) ? ((s1 << 31) | (255 << 23) | (1 << 22) | getBit32(m1, 21, 0)) : (((e1 == 255) && (e2 == 255) && (s1 == s2)) ? ((s1 << 31) | (255 << 23)) : (((e1 == 255 && e2 == 255)) ? ((1 << 31) | (255 << 23) | (1 << 21)) : ((sy << 31) | (ey << 23) | my))))));
	//uint32_t ovf

	return y;
	
}

uint32_t priority_encoder(uint32_t x) {
	uint32_t myd = getBit32(x, 26, 0);//26bit
	uint32_t se;//5bit
	if ((myd & (1 << 25)) != 0) { se = 0;}
	else if ((myd & (1 << 24)) != 0) { se = 1;}
	else if ((myd & (1 << 23)) != 0) { se = 2;}
	else if ((myd & (1 << 22)) != 0) { se = 3;}
	else if ((myd & (1 << 21)) != 0) { se = 4;}
	else if ((myd & (1 << 20)) != 0) { se = 5;}
	else if ((myd & (1 << 19)) != 0) { se = 6;}
	else if ((myd & (1 << 18)) != 0) { se = 7;}
	else if ((myd & (1 << 17)) != 0) { se = 8;}
	else if ((myd & (1 << 16)) != 0) { se = 9;}
	else if ((myd & (1 << 15)) != 0) { se = 10;}
	else if ((myd & (1 << 14)) != 0) { se = 11;}
	else if ((myd & (1 << 13)) != 0) { se = 12;}
	else if ((myd & (1 << 12)) != 0) { se = 13;}
	else if ((myd & (1 << 11)) != 0) { se = 14;}
	else if ((myd & (1 << 10)) != 0) { se = 15;}
	else if ((myd & (1 << 9)) != 0) { se = 16;}
	else if ((myd & (1 << 8)) != 0) { se = 17;}
	else if ((myd & (1 << 7)) != 0) { se = 18;}
	else if ((myd & (1 << 6)) != 0) { se = 19;}
	else if ((myd & (1 << 5)) != 0) { se = 20;}
	else if ((myd & (1 << 4)) != 0) { se = 21;}
	else if ((myd & (1 << 3)) != 0) { se = 22;}
	else if ((myd & (1 << 2)) != 0) { se = 23;}
	else if ((myd & (1 << 1)) != 0) { se = 24;}
	else if ((myd & (1 << 0)) != 0) { se = 25;}
	else {se = 26;}
	return se;
}
