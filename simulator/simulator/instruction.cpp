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
extern uint32_t DATA_MEM[DATA_ADDR];
extern uint32_t PC;
extern uint32_t OP;
extern vector<char> outChar;

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
	rD = get_rD(OP);
	rA = get_rA(OP);
	simm16 = get_simm16(OP);
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
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : add" << endl;
		exit(1);
	}
	GPR[rD] = GPR[rA] + GPR[rB];
}
void sub_reg() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	if (rD == 0) {
		cerr << "cannot write in GPR[0] : sub" << endl;
		exit(1);
	}
	GPR[rD] = GPR[rA] - GPR[rB];
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
	FPR[rD] = FPR[rA] + FPR[rB];
}
void fsub() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	FPR[rD] = FPR[rA] - FPR[rB];
}
void fdiv() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	FPR[rD] = FPR[rA] / FPR[rB];
}
void fmul() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	FPR[rD] = FPR[rA] * FPR[rB];
}
void fsqrt() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	FPR[rD] = sqrt(FPR[rA]);
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
	rD = get_rD(OP);
	rA = get_rA(OP);
	simm16 = get_simm16(OP);
	if (GPR[rA] < simm16) {
		cr0_set0(rD);
	} else if (GPR[rA] == simm16) {
		cr0_set2(rD);
	} else {
		cr0_set1(rD);
	}
}
void cmp_reg() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	rB = get_rB(OP);
	if (GPR[rA] < GPR[rB]) {
		cr0_set0(rD);
	} else if (GPR[rA] == GPR[rB]) {
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
void load() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	simm16 = get_simm16(OP);
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
	rD = get_rD(OP);
	rA = get_rA(OP);
	simm16 = get_simm16(OP);
	uint32_t addr = GPR[rA] + simm16;
	if (!(0 <= addr && addr < 0x10000)) {
		cerr << "cannot store: memory overflow" << " " << hex << addr << endl;
		exit(1);
	}
	//cout << "store " << GPR[rD] << endl;
	DATA_MEM[addr] = GPR[rD];
}
void fload() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	simm16 = get_simm16(OP);
	uint32_t addr = GPR[rA] + simm16;
	if (!(0 <= addr && addr < 0x10000)) {
		cerr << "cannot load: memory overflow" << " " << hex << addr << endl;
		exit(1);
	}
	FPR[rD] = *((float*)&DATA_MEM[addr]);//怪しい
}
void fstore() {
	rD = get_rD(OP);
	rA = get_rA(OP);
	simm16 = get_simm16(OP);
	uint32_t addr = GPR[rA] + simm16;
	if (!(0 <= addr && addr < 0x10000)) {
		cerr << "cannot store: memory overflow" << " " << hex << addr << endl;
		exit(1);
	}
	*((float*)&DATA_MEM[addr]) = FPR[rD];
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
		PC += simm16;
	} else {
		PC++;
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
	uint32_t result = 0x000000FF & GPR[rD];
	cout << "operation out..." << static_cast<char>(result)  << endl;
	outChar.push_back(static_cast<char>(result));
}

void branch_abs() {
	rD = get_rD(OP);
	uint32_t addr = GPR[rD];
	PC = addr;
}	
void branch_abs_and_link() {
	rD = get_rD(OP);
	uint32_t addr = GPR[rD];
	LR = PC + 1;
	PC = addr;
}
