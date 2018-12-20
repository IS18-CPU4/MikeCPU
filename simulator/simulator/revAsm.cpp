#include <iostream>
#include "revAsm.h"
#include "op.h"
#include "instruction.h"

using namespace std;

void print_rD(const uint32_t op) {
	int rD = get_rD(op);
	cout << "r" << rD;
}
void print_rA(const uint32_t op) {
	int rA = get_rA(op);
	cout << "r" << rA;
}
void print_rB(const uint32_t op) {
	int rB = get_rB(op);
	cout << "r" << rB;
}
void print_simm16(const uint32_t op) {
	int32_t simm16 = get_simm16(op);
	cout << simm16;
}
void print_BI(const uint32_t op) {
	int bit = get_rA(op);
	cout << bit;
}
void print_BD(const uint32_t op) {
	int32_t simm16 = get_simm16(op);
	cout << "0x" << hex << simm16 << dec;
}
void print_imm5(const uint32_t op) {
	int imm5 = get_imm5(op);
	cout <<  imm5;
}
void print_simm26(const uint32_t op) {
	int32_t simm26 = get_simm26(op);
	cout << "0x" << hex << simm26 << dec;
}


void rev_asm(const uint32_t op) {
	uint32_t opname = get_opname(op);
	switch((int)opname) {
		case 0:
			cout << "li "; print_rD(op); cout << ", "; print_simm16(op); cout << endl;break;
		case 1:
			cout << "mr "; print_rD(op); cout << ", "; print_rA(op); cout << endl;break;
		case 2:
			cout << "addi "; print_rD(op); cout << ", "; print_rA(op); cout << ", "; print_simm16(op); cout << endl;break;
		case 3:
			cout << "add "; print_rD(op); cout << ", "; print_rA(op); cout << ", "; print_rB(op); cout << endl;break;
		case 4:
			cout << "sub "; print_rD(op); cout << ", "; print_rA(op); cout << ", "; print_rB(op); cout << endl;break;
		case 5:
			cout << "slwi "; print_rD(op); cout << ", "; print_rA(op); cout << ", "; print_imm5(op); cout << endl;break;
		case 6:
			cout << "srwi "; print_rD(op); cout << ", "; print_rA(op); cout << ", "; print_imm5(op); cout << endl;break;
		case 7:
			cout << "fadd f"; print_rD(op); cout << ", f"; print_rA(op); cout << ", f"; print_rB(op); cout << endl;break;
		case 8:
			cout << "fsub f"; print_rD(op); cout << ", f"; print_rA(op); cout << ", f"; print_rB(op); cout << endl;break;
		case 9:
			cout << "fdiv f"; print_rD(op); cout << ", f"; print_rA(op); cout << ", f"; print_rB(op); cout << endl;break;
		case 10:
			cout << "fmul f"; print_rD(op); cout << ", f"; print_rA(op); cout << ", f"; print_rB(op); cout << endl;break;
		case 11:
			cout << "fsqrt f"; print_rD(op); cout << ", f"; print_rA(op); cout << endl;break;
		case 12:
			cout << "fabs f"; print_rD(op); cout << ", f"; print_rA(op); cout << endl;break;
		case 13:
			cout << "fmr f"; print_rD(op); cout << ", f"; print_rA(op); cout << endl;break;
		case 14:
			cout << "b "; print_simm26(op); cout << endl;break;
		case 15:
			cout << "beq "; print_simm26(op); cout << endl;break;
		case 16:
			cout << "bneq "; print_simm26(op); cout << endl;break;
		case 17:
			cout << "blt "; print_simm26(op); cout << endl;break;
		case 18:
			cout << "bl "; print_simm26(op); cout << endl;break;
		case 19:
			cout << "blr" << endl;break;
		case 20:
			cout << "mflr "; print_rD(op); cout << endl;break;
		case 21:
			cout << "mtlr "; print_rD(op); cout << endl;break;
		case 22:
			cout << "cmpwi c"; print_rD(op); cout << ", "; print_rA(op); cout << ", "; print_simm16(op); cout << endl;break;
		case 23:
			cout << "cmpw c"; print_rD(op); cout << ", "; print_rA(op); cout << ", "; print_rB(op); cout << endl;break;
		case 24:
			cout << "fcmp c"; print_rD(op); cout << ", f"; print_rA(op); cout << ", f"; print_rB(op); cout << endl;break;
		case 25:
			cout << "ld "; print_rD(op); cout << ", "; print_rA(op); cout << ", "; print_simm16(op); cout << endl;break;
		case 26:
			cout << "st "; print_rD(op); cout << ", "; print_rA(op); cout << ", "; print_simm16(op); cout << endl;break;
		case 27:
			cout << "fld f"; print_rD(op); cout << ", "; print_rA(op); cout << ", "; print_simm16(op); cout << endl;break;
		case 28:
			cout << "fst f"; print_rD(op); cout << ", "; print_rA(op); cout << ", "; print_simm16(op); cout << endl;break;
		case 29:
			cout << "slw "; print_rD(op); cout << ", "; print_rA(op); cout << ", "; print_rB(op); cout << endl;break;
		case 30:
			cout << "srw "; print_rD(op); cout << ", "; print_rA(op); cout << ", "; print_rB(op); cout << endl;break;
		case 31:
			cout << "bc "; print_BI(op); cout << ", "; print_BD(op); cout << endl;break;
		case 32:
			cout << "itof f"; print_rD(op); cout << ", "; print_rA(op); cout << endl;break;
		case 33:
			cout << "ftoi "; print_rD(op); cout << ", f"; print_rA(op); cout << endl;break;
		case 34:
			cout << "ba "; print_rD(op); cout << endl;break;
		case 35:
			cout << "bal "; print_rD(op); cout << endl;break;
		case 62:
			cout << "in "; print_rD(op); cout << endl;break;
		case 63:
			cout << "out "; print_rD(op); cout << endl;break;
		default:
			cout << "undefined instruction" << endl;break;
	}
}


