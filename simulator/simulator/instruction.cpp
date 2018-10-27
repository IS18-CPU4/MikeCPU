#include <iostream>
#include <vector>
#include <cmath>
#include <stdlib.h>
#include <stdint.h>
#include "instruction.h"
#define DATA_ADDR 0x10000

using namespace std;


extern vector<uint32_t> GPR;
extern vector<float> FPR;
extern uint32_t CR;
extern uint32_t LR;
extern uint32_t CTR;
extern uint32_t DATA_MEM[DATA_ADDR];
extern uint32_t PC;
extern uint32_t OP;

int rD;
int rA;
int rB;
int32_t simm16;
int imm5;
int32_t simm26;

int get_rD(const uint32_t ui) {
	uint32_t tmp = ui << 6;
	tmp = tmp >> 27;
	return int(tmp);
}
int get_rA(const uint32_t ui) {
	uint32_t tmp = ui << 11;
	tmp = tmp >> 27;
	return int(tmp);
}
int get_rB(const uint32_t ui) {
	uint32_t tmp = ui << 16;
	tmp = tmp >> 27;
	return int(tmp);
}
int32_t get_simm16(const uint32_t ui) {
	if (ui & (1 << 15)) {
		return (ui | 0xFFFF0000);
	} else {
		return (ui & 0x0000FFFF);
	}
}
int get_imm5(const uint32_t ui){
	uint32_t tmp = ui << 16;
	tmp = tmp >> 27;
	return int (tmp);
}
int32_t get_simm26(const uint32_t ui) {
	if (ui & (1 << 25)) {
		return (ui | 0xFC000000);
	} else {
		return (ui & 0x03FFFFFF);
	}
}

void cr0_set0() {
	CR = (CR & 0x10000000) | (1 << 31);
}
void cr0_set1() {
	CR = (CR & 0x10000000) | (1 << 30);
}
void cr0_set2() {
	CR = (CR & 0x10000000) | (1 << 29);
}


void initReg() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
}
void initSimm16() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	simm16 = get_simm16(OP);
}

void initImm5() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	imm5 = get_imm5(OP);
}




//int
void load_imm() {
	rD = get_rD(OP);
	if (rD == 0) {
		cerr << "cannot load to GPR[0]" << endl;
		exit(1);
	}
	simm16 = get_simm16(OP);
	GPR[rD] = simm16;
}
void move_reg() {
	rD = get_rD(OP);
	if (rD == 0) {
		cerr << "cannot move to GPR[0]" << endl;
		exit(1);
	}
	rA = get_rA(OP);
	GPR[rD] = GPR[rA];
}

void add_imm() {
	initSimm16();
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : addi" << endl;
		exit(1);
	}
	if (rA == 0) {
		GPR[rD] = 0 + simm16;
	} else {
		GPR[rD] = GPR[rA] + simm16;
	}
}
void add_reg() {
	initReg();
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : add" << endl;
		exit(1);
	}
	GPR[rD] = GPR[rA] + GPR[rB];
}
void sub_reg() {
	initReg();
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : sub" << endl;
		exit(1);
	}
	GPR[rD] = GPR[rA] - GPR[rB];
}



//logical shift
void l_shift_lg_imm() {
	initImm5();
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : slwi" << endl;
		exit(1);
	}
	GPR[rD] = (GPR[rA] << imm5);
}
void r_shift_lg_imm() {
	initImm5();
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : srwi" << endl;
		exit(1);
	}
	GPR[rD] = (GPR[rA] >> imm5);
}

//float
void fadd() {
	initReg();
	if (rD == 0) {
		cerr << "cannot write in FPR[0] : fadd" << endl;
		exit(1);
	}
	FPR[rD] = FPR[rA] + FPR[rB];
}
void fsub() {
	initReg();
	if (rD == 0) {
		cerr << "cannot write in FPR[0] : fsub" << endl;
		exit(1);
	}
	FPR[rD] = FPR[rA] - FPR[rB];
}
void fdiv() {
	initReg();
	if (rD == 0) {
		cerr << "cannot write in FPR[0] : fsub" << endl;
		exit(1);
	}
	FPR[rD] = FPR[rA] / FPR[rB];
}
void fmul() {
	initReg();
	if (rD == 0) {
		cerr << "cannot write in FPR[0] : fmul" << endl;
		exit(1);
	}
	FPR[rD] = FPR[rA] * FPR[rB];
}
void fsqrt() {
	rD = get_rD(OP);
	if (rD == 0) {
		cerr << "cannot write in FPR[0] : fsqrt" << endl;
		exit(1);
	}
	rA = get_rA(OP);
	FPR[rD] = sqrt(FPR[rA]);
}
void fabs() {
	rD = get_rD(OP);
	if (rD == 0) {
		cerr << "cannot write in FPR[0] : fdiv" << endl;
		exit(1);
	}
	rA = get_rA(OP);
	*((uint32_t*)&FPR[rD]) = *((uint32_t*)&FPR[rA]) & 0x7FFFFFFF;
}
void fmove_reg() {
	rD = get_rD(OP);
	if (rD == 0) {
		cerr << "cannot write in FPR[0] : fmr" << endl;
		exit(1);
	}
	rA = get_rA(OP);
	FPR[rD] = FPR[rA];
}


//jump
void branch() {
	simm26 = get_simm26(OP);
	PC += simm26;

	//本来はPCはwordごとなので2bit左シフト
	//今はただ配列のindex
}
void branch_eq() {
	if (CR & (1 << 29)) {
		simm26 = get_simm26(OP);
		PC += simm26;
	} else {
		PC++;
	}
}
void branch_neq() {
	if (CR & (1 << 29)) {
		PC++;
	} else {
		simm26 = get_simm26(OP);
		PC += simm26;
	}
}
void branch_lt() {
	if (CR & (1 << 31)) {
		simm26 = get_simm26(OP);
		PC += simm26;
	} else {
		PC++;
	}
}
void branch_and_link() {
	simm26 = get_simm26(OP);
	LR = PC + 1;
	PC += simm26;
}
void branch_link_reg() {
	PC = LR;
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
	rA = get_rA(OP);
	simm16 = get_simm16(OP);
	if (GPR[rA] < simm16) {
		cr0_set0();
	} else if (GPR[rA] == simm16) {
		cr0_set2();
	} else {
		cr0_set1();
	}
}
void cmp_reg() {
	rA = get_rA(OP);
	rB = get_rB(OP);
	if (GPR[rA] < GPR[rB]) {
		cr0_set0();
	} else if (GPR[rA] == GPR[rB]) {
		cr0_set2();
	} else {
		cr0_set1();
	}
}
void fcmp_reg() {
	rA = get_rA(OP);
	rB = get_rB(OP);
	if (FPR[rA] < FPR[rB]) {
		cr0_set0();
	} else if (FPR[rA] == FPR[rB]) {
		cr0_set2();
	} else {
		cr0_set1();
	}
}



//memory
void load() {
	initSimm16();
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : ld" << endl;
		exit(1);
	}
	uint32_t addr = GPR[rA] + simm16;
	if (!(0 <= addr && addr < 0x10000)) {
		cerr << "cannot load: memory overflow" << " " << hex << addr << endl;
		exit(1);
	}
	//cout << "load " <<  DATA_MEM[addr] << endl;
	GPR[rD] = DATA_MEM[addr];
}
void store() {
	initSimm16();
	uint32_t addr = GPR[rA] + simm16;
	if (!(0 <= addr && addr < 0x10000)) {
		cerr << "cannot store: memory overflow" << " " << hex << addr << endl;
		exit(1);
	}
	//cout << "store " << GPR[rD] << endl;
	DATA_MEM[addr] = GPR[rD];
}
void fload() {
	initSimm16();
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : ld" << endl;
		exit(1);
	}
	uint32_t addr = GPR[rA] + simm16;
	if (!(0 <= addr && addr < 0x10000)) {
		cerr << "cannot load: memory overflow" << " " << hex << addr << endl;
		exit(1);
	}
	FPR[rD] = *((float*)&DATA_MEM[addr]);//怪しい
}
void fstore() {
	initSimm16();
	uint32_t addr = GPR[rA] + simm16;
	if (!(0 <= addr && addr < 0x10000)) {
		cerr << "cannot store: memory overflow" << " " << hex << addr << endl;
		exit(1);
	}
	*((float*)&DATA_MEM[addr]) = FPR[rD];
}

//added

void l_shift_lg() {
	initReg();
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : slw" << endl;
		exit(1);
	}
	GPR[rD] = (GPR[rA] << GPR[rB]);
}
void r_shift_lg() {
	initReg();
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : srw" << endl;
		exit(1);
	}
	GPR[rD] = (GPR[rA] >> GPR[rB]);
}
void branch_cond() {
	rD = get_rD(OP);
	switch (rD) {
	case 0:
		if (CR & (1 << 31)) {
			simm16 = get_simm16(OP);
			PC += simm16;
		} else {
			PC++;
		}
		break;
	case 1:
		if (CR & (1 << 30)) {
			simm16 = get_simm16(OP);
			PC += simm16;
		} else {
			PC++;
		}
		break;
	case 2:
		if (CR & (1 << 29)) {
			simm16 = get_simm16(OP);
			PC += simm16;
		} else {
			PC++;
		}
		break;
	}
}
void int_to_float() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	FPR[rD] = (float)(GPR[rA]);
}
void float_to_int() {
	rD = get_rD(OP);
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : ftoi" << endl;
		exit(1);
	}
	rA = get_rA(OP);
	GPR[rD] = (uint32_t)(FPR[rA]);
}

void out() {
	rD = get_rD(OP);
	uint32_t result = 0x0000FFFF & GPR[rD];
	cout << "operation out..." << hex << result << dec << endl;
}
