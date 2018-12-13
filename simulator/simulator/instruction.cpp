#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>
#include <cstdlib>
#include <stdint.h>
#include <algorithm>
#include "instruction.h"
#include "float/fadd.h"
#include "float/fsub.h"
#include "float/fmul.h"
#include "float/finv.h"
#include "float/fdiv.h"
#include "float/ftoi.h"
#include "float/itof.h"
#include "float/fsqrt.h"

using namespace std;


const int DATA_ADDR = 0x100000;
extern vector<uint32_t> GPR;
extern vector<float> FPR;
extern uint32_t CR;
extern uint32_t LR;
extern uint32_t DATA_MEM[DATA_ADDR];
extern uint32_t PC;
extern uint32_t OP;
extern vector<char> outChar;
extern ofstream fileout;

extern vector<uint32_t> uinput_vector;
int uinput_byte_count = 0;;//1byteずつ取得したい
int uinput_index = 0;


int rD;
int rA;
int rB;
int32_t simm16;
int imm5;
int32_t simm26;


void cr0_set0(uint32_t cr) {
	int bit = (8 - cr) * 4 - 1;
	uint32_t tmp = (1 << bit) | (1 << (bit-1)) | (1 << (bit-2))| (1 << (bit-3));
	CR = CR & ~tmp;
	CR = CR | (1 << bit);
}
void cr0_set1(uint32_t cr) {
	int bit = (8 - cr) * 4 - 2;
	uint32_t tmp = (1 << (bit+1)) | (1 << (bit)) | (1 << (bit-1))| (1 << (bit-2));
	CR = CR & ~tmp;
	CR = CR | (1 << bit);
}
void cr0_set2(uint32_t cr) {
	int bit = (8 - cr) * 4 - 3;
	uint32_t tmp = (1 << (bit+2)) | (1 << (bit+1)) | (1 << bit)| (1 << (bit-1));
	CR = CR & ~tmp;
	CR = CR | (1 << bit);
}
void cr0_set3(uint32_t cr){
	int bit = (8 -cr) * 4 - 4;
	uint32_t tmp = (1 << (bit+3)) | (1 << (bit+2)) | (1 << (bit+1))| (1 << bit);
	CR = CR & ~tmp;
	CR = CR | (1 << bit);
}


//int
bool load_imm() {
	rD = get_rD(OP);
	if (rD == 0) {
		cerr << "cannot load to GPR[0]" << endl;
		return 1;
	}
	simm16 = get_simm16(OP);
	GPR[rD] = (uint32_t)simm16;
	return 0;
}
bool move_reg() {
	rD = get_rD(OP);
	if (rD == 0) {
		cerr << "cannot move to GPR[0]" << endl;
		return 1;
	}
	rA = get_rA(OP);
	GPR[rD] = GPR[rA];
	return 0;
}

void add_imm() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	simm16 = get_simm16(OP);
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : addi" << endl;
		exit(1);
	}
	if (rA == 0) {
		GPR[rD] = uint32_t(simm16);
	} else {
		GPR[rD] = uint32_t(int32_t(GPR[rA]) + simm16);
	}
}
void add_reg() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : add" << endl;
		exit(1);
	}
	GPR[rD] = (uint32_t)((int32_t)GPR[rA] + (int32_t)GPR[rB]);
}
void sub_reg() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : sub" << endl;
		exit(1);
	}
	GPR[rD] = uint32_t((int32_t)GPR[rA] - (int32_t)GPR[rB]);
}



//logical shift
void l_shift_lg_imm() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	imm5 = get_imm5(OP);
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : slwi" << endl;
		exit(1);
	}
	GPR[rD] = (GPR[rA] << imm5);
}
void r_shift_lg_imm() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	imm5 = get_imm5(OP);
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : srwi" << endl;
		exit(1);
	}
	GPR[rD] = (GPR[rA] >> imm5);
}

//float
void fadd() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	//FPR[rD] = FPR[rA] + FPR[rB];
	uint32_t x1 = *(uint32_t*)&FPR[rA];
	uint32_t x2 = *(uint32_t*)&FPR[rB];
	uint32_t tmp = fadd_f(x1, x2);
	FPR[rD] = *(float*)&tmp;
}
void fsub() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	//FPR[rD] = FPR[rA] - FPR[rB];
	uint32_t x1 = *(uint32_t*)&FPR[rA];
	uint32_t x2 = *(uint32_t*)&FPR[rB];
	uint32_t tmp = fsub_f(x1, x2);
	FPR[rD] = *(float*)&tmp;
}
void fdiv() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	//FPR[rD] = FPR[rA]/FPR[rB];
	uint32_t x1 = *(uint32_t*)&FPR[rA];
	uint32_t x2 = *(uint32_t*)&FPR[rB];
	uint32_t tmp = fdiv_f(x1, x2);
	FPR[rD] = *(float*)&tmp;
}
void fmul() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	uint32_t x1 = *(uint32_t*)&FPR[rA];
	uint32_t x2 = *(uint32_t*)&FPR[rB];
	uint32_t tmp = fmul_f(x1, x2);
	FPR[rD] = *(float*)&tmp;
}
void fsqrt() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	uint32_t x = *(uint32_t*)&FPR[rA];
	uint32_t tmp = fsqrt_f(x);
	FPR[rD] = *(float*)&tmp;
}
void fabs() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	*((uint32_t*)&FPR[rD]) = *((uint32_t*)&FPR[rA]) & 0x7FFFFFFF;
}
void fmove_reg() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	FPR[rD] = FPR[rA];
}


//jump
void branch() {
	simm26 = get_simm26(OP);
	//	PC += simm26;
	PC = uint32_t((int32_t)PC + simm26);

	//本来はPCはwordごとなので2bit左シフト
	//今はただ配列のindex

	//型を合わせているがPCは必ず正なのでいらない
}
void branch_eq() {
	if (CR & (1 << 29)) {
		simm26 = get_simm26(OP);
		PC = uint32_t((int32_t)PC + simm26);
	} else {
		PC++;
	}
}
void branch_neq() {
	if (CR & (1 << 29)) {
		PC++;
	} else {
		simm26 = get_simm26(OP);
		PC = uint32_t((int32_t)PC + simm26);
	}
}
void branch_lt() {
	if (CR & (1 << 31)) {
		simm26 = get_simm26(OP);
		PC = uint32_t((int32_t)PC + simm26);
	} else {
		PC++;
	}
}
void branch_and_link() {
	simm26 = get_simm26(OP);
	LR = (PC + 1)<<2;
	PC = uint32_t((int32_t)PC + simm26);
}
void branch_link_reg() {
	PC = LR>>2;
}
void move_from_link() {
	rD = get_rD(OP);
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : mflr" << endl;
		exit(1);
	}
	GPR[rD] = LR;
}
void move_to_link() {
	rD = get_rD(OP);
	LR = GPR[rD];
}



//compare
void cmp_imm(){
	rD = get_rD(OP);
	rA = get_rA(OP);
	simm16 = get_simm16(OP);
	if ((int32_t)GPR[rA] < simm16) {
		cr0_set0(rD);
	} else if ((int32_t)GPR[rA] == simm16) {
		cr0_set2(rD);
	} else {
		cr0_set1(rD);
	}
}
void cmp_reg() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	if ((int32_t)GPR[rA] < (int32_t)GPR[rB]) {
		cr0_set0(rD);
	} else if ((int32_t)GPR[rA] == (int32_t)GPR[rB]) {
		cr0_set2(rD);
	} else {
		cr0_set1(rD);
	}
}
void fcmp_reg() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	if (FPR[rA] < FPR[rB]) {
		cr0_set0(rD);
	} else if (FPR[rA] == FPR[rB]) {
		cr0_set2(rD);
	} else {
		cr0_set1(rD);
	}
}



//memory
bool load() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	simm16 = get_simm16(OP);
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : ld" << endl;
		return 1;
	}
	uint32_t addr = (uint32_t)((int32_t)GPR[rA] + simm16);
	if (!(0 <= addr && addr < DATA_ADDR)) {
		cerr << "cannot load: memory overflow" << " " << hex << addr << endl;
		return 1;
	}
	//cout << "load " <<  DATA_MEM[addr] << endl;
	GPR[rD] = DATA_MEM[addr];
	return 0;
}
bool store() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	simm16 = get_simm16(OP);
	//uint32_t addr = GPR[rA] + simm16;
	uint32_t addr = (uint32_t)((int32_t)GPR[rA] + simm16);
	if (!(0 <= addr && addr < DATA_ADDR)) {
		cerr << "cannot store: memory overflow" << " " << hex << addr << endl;
		return 1;
	}
	//cout << "store " << GPR[rD] << endl;
	DATA_MEM[addr] = GPR[rD];
	return 0;
}
bool fload() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	simm16 = get_simm16(OP);
	uint32_t addr = (uint32_t)((int32_t)GPR[rA] + simm16);
	if (!(0 <= addr && addr < DATA_ADDR)) {
		cerr << "cannot fload: memory overflow" << " " << hex << addr << endl;
		return 1;
	}
	FPR[rD] = *((float*)&DATA_MEM[addr]);//怪しい
	return 0;
}
bool fstore() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	simm16 = get_simm16(OP);
	uint32_t addr = (uint32_t)((int32_t)GPR[rA] + simm16);
	if (!(0 <= addr && addr < DATA_ADDR)) {
		cerr << "cannot fstore: memory overflow" << " " << hex << addr << endl;
		return 1;
	}
	DATA_MEM[addr] = *(uint32_t*)&FPR[rD];
	return 0;
}

//added

void l_shift_lg() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : slw" << endl;
		exit(1);
	}
	GPR[rD] = (GPR[rA] << GPR[rB]);
}
void r_shift_lg() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : srw" << endl;
		exit(1);
	}
	GPR[rD] = (GPR[rA] >> GPR[rB]);
}
void branch_cond() {
	rA = get_rA(OP);
	int bit = 31 - rA;
	if (CR & (1 << bit)) {
		simm16 = get_simm16(OP);
		PC = (uint32_t)((int32_t)PC + simm16);
	} else {
		PC++;
	}
}
void int_to_float() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	//FPR[rD] = (float)((int32_t)GPR[rA]);
	uint32_t tmp = itof_f(GPR[rA]);
	FPR[rD] = *(float*)&tmp;
}
void float_to_int() {
	rD = get_rD(OP);
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : ftoi" << endl;
		exit(1);
	}
	rA = get_rA(OP);
	//GPR[rD] = (uint32_t)((int32_t)(FPR[rA]));
	uint32_t tmp = *(uint32_t*)&FPR[rA];
	GPR[rD] = ftoi_f(tmp);
}

void out() {
	rD = get_rD(OP);
	uint32_t result = 0x000000FF & GPR[rD];
	char resultc = static_cast<char>(result);
	fileout << resultc;
}
void outstep() {
	rD = get_rD(OP);
	uint32_t result = 0x000000FF & GPR[rD];
	cout << "operation out..." << static_cast<char>(result)  << endl;
	outChar.push_back(static_cast<char>(result));
}

void branch_abs() {
	rD = get_rD(OP);
	uint32_t addr = GPR[rD];
	PC = addr >> 2;
}	
void branch_abs_and_link() {
	rD = get_rD(OP);
	uint32_t addr = GPR[rD];
	LR = (PC + 1)<<2;
	PC = addr >> 2;
}

void in() {
	rD = get_rD(OP);
	//some exec
	//input_byte_count input_string_indexでアクセス
	if (uinput_byte_count == 4) {
		uinput_byte_count = 0;
		uinput_index++;
	}
	uint32_t uinput = uinput_vector[uinput_index];
	uint32_t utmp = uinput << (uinput_byte_count * 8);
	uint32_t uin = utmp >> 24;
	GPR[rD] = uin;
	
	uinput_byte_count++;
}
