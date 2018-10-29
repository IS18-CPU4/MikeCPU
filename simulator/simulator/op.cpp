#include <iostream>
#include <vector>
#include <stdint.h>
#include <arpa/inet.h>
#include "instruction.h"
#include "op.h"

#define INST_ADDR 0x10000
using namespace std;

extern uint32_t INST_MEM[INST_ADDR];
extern uint32_t PC;
extern uint32_t OP;

inline uint32_t get_opname(const uint32_t ui) {
	uint32_t opname = ui>>26;
	return opname;
}

int do_op() {
	cout << "PC: " << hex << (PC << 2) << endl;
	OP = htonl(INST_MEM[PC]);
	uint32_t opname = get_opname(OP);
	cout << "operation:" << opname  << " "<< dec;
	
	switch((int)opname) {
		case 0:
			cout << "opname li" << endl;
			load_imm();PC++;break;
		case 1:
			cout << "opname mr" << endl;
			move_reg();PC++;break;
		case 2:
			cout << "opname addi" << endl;
			add_imm();PC++;break;
		case 3:
			cout << "opname add" << endl;
			add_reg();PC++;break;
		case 4:
			cout << "opname sub" << endl;
			sub_reg();PC++;break;
		case 5:
			cout << "opname slwi" << endl;
			l_shift_lg_imm();PC++;break;
		case 6:
			cout << "opname srwi" << endl;
			r_shift_lg_imm();PC++;break;
		case 7:
			cout << "opname fadd" << endl;
			fadd();PC++;break;
		case 8:
			cout << "opname fsub" << endl;
			fsub();PC++;break;
		case 9:
			cout << "opname fdiv" << endl;
			fdiv();PC++;break;
		case 10:
			cout << "opname fmul" << endl;
			fmul();PC++;break;
		case 11:
			cout << "opname fsqrt" << endl;
			fsqrt();PC++;break;
		case 12:
			cout << "opname fabs" << endl;
			fabs();PC++;break;
		case 13:
			cout << "opname fmr" << endl;
			fmove_reg();PC++;break;
		case 14:
			cout << "opname b" << endl;
			branch();break;
		case 15:
			cout << "opname beq" << endl;
			branch_eq();break;
		case 16:
			cout << "opname bneq" << endl;
			branch_neq();break;
		case 17:
			cout << "opname blt" << endl;
			branch_lt();break;
		case 18:
			cout << "opname bl" << endl;
			branch_and_link();break;
		case 19:
			cout << "opname blr" << endl;
			branch_link_reg();break;
		case 20:
			cout << "opname mflr" << endl;
			move_from_link();PC++;break;
		case 21:
			cout << "opname mtlr" << endl;
			move_to_link();PC++;break;
		case 22:
			cout << "opname cmpwi" << endl;
			cmp_imm();PC++;break;
		case 23:
			cout << "opname cmpw" << endl;
			cmp_reg();PC++;break;
		case 24:
			cout << "opname fcmp" << endl;
			fcmp_reg();PC++;break;
		case 25:
			cout << "opname ld" << endl;
			load();PC++;break;
		case 26:
			cout << "opname st" << endl;
			store();PC++;break;
		case 27:
			cout << "opname fld" << endl;
			fload();PC++;break;
		case 28:
			cout << "opname fst" << endl;
			fstore();PC++;break;
		case 29:
			cout << "opname slw" << endl;
			l_shift_lg();PC++;break;
		case 30:
			cout << "opname srw" << endl;
			r_shift_lg();PC++;break;
		case 31:
			cout << "opname bc" << endl;
			branch_cond();break;
		case 32:
			cout << "opname itof" << endl;
			int_to_float();PC++;break;
		case 33:
			cout << "opname ftoi" << endl;
			float_to_int();PC++;break;
		case 63:
			cout << "opname out" << endl;
			out();PC++;break;
		default:
			cerr << "undefined instruction" << endl;
			return 1;
	}

	return 0;
}

