#include <iostream>
#include <vector>
#include <stdint.h>
#include <arpa/inet.h>
#include <unordered_map>
#include "instruction.h"
#include "op.h"

#define INST_ADDR 0x10000
using namespace std;

extern uint32_t INST_MEM[INST_ADDR];
extern uint32_t PC;
extern uint32_t OP;
extern bool stepflag;
extern bool inputflag;

extern vector<long long int> instCount;

int do_op() {
	//cout << "PC: " << hex << (PC << 2) << endl;
	OP = htonl(INST_MEM[PC]);
	uint32_t opname = get_opname(OP);
	//cout << "operation:" << opname  << " "<< dec;
	bool result = 0;
	
	switch((int)opname) {
		case 0:
			//cout << "opname li" << endl;
			instCount[0]++;
			result = load_imm();PC++;break;
		case 1:
			//cout << "opname mr" << endl;
			instCount[1]++;
			result = move_reg();PC++;break;
		case 2:
			//cout << "opname addi" << endl;
			instCount[2]++;
			add_imm();PC++;break;
		case 3:
			//cout << "opname add" << endl;
			instCount[3]++;
			add_reg();PC++;break;
		case 4:
			//cout << "opname sub" << endl;
			instCount[4]++;
			sub_reg();PC++;break;
		case 5:
			//cout << "opname slwi" << endl;
			instCount[5]++;
			l_shift_lg_imm();PC++;break;
		case 6:
			//cout << "opname srwi" << endl;
			instCount[6]++;
			r_shift_lg_imm();PC++;break;
		case 7:
			//cout << "opname fadd" << endl;
			instCount[7]++;
			fadd();PC++;break;
		case 8:
			//cout << "opname fsub" << endl;
			instCount[8]++;
			fsub();PC++;break;
		case 9:
			//cout << "opname fdiv" << endl;
			instCount[9]++;
			fdiv();PC++;break;
		case 10:
			//cout << "opname fmul" << endl;
			instCount[10]++;
			fmul();PC++;break;
		case 11:
			//cout << "opname fsqrt" << endl;
			instCount[11]++;
			fsqrt();PC++;break;
		case 12:
			instCount[12]++;
			//cout << "opname fabs" << endl;
			fabs();PC++;break;
		case 13:
			//cout << "opname fmr" << endl;
			instCount[13]++;
			fmove_reg();PC++;break;
		case 14:
			//cout << "opname b" << endl;
			instCount[14]++;
			branch();break;
		case 15:
			//cout << "opname beq" << endl;
			instCount[15]++;
			branch_eq();break;
		case 16:
			//cout << "opname bneq" << endl;
			instCount[16]++;
			branch_neq();break;
		case 17:
			//cout << "opname blt" << endl;
			instCount[17]++;
			branch_lt();break;
		case 18:
			//cout << "opname bl" << endl;
			instCount[18]++;
			branch_and_link();break;
		case 19:
			//cout << "opname blr" << endl;
			instCount[19]++;
			branch_link_reg();break;
		case 20:
			//cout << "opname mflr" << endl;
			instCount[20]++;
			move_from_link();PC++;break;
		case 21:
			//cout << "opname mtlr" << endl;
			instCount[21]++;
			move_to_link();PC++;break;
		case 22:
			//cout << "opname cmpwi" << endl;
			instCount[22]++;
			cmp_imm();PC++;break;
		case 23:
			//cout << "opname cmpw" << endl;
			instCount[23]++;
			cmp_reg();PC++;break;
		case 24:
			//cout << "opname fcmp" << endl;
			instCount[24]++;
			fcmp_reg();PC++;break;
		case 25:
			//cout << "opname ld" << endl;
			instCount[25]++;
			result = load();PC++;break;
		case 26:
			//cout << "opname st" << endl;
			instCount[26]++;
			result = store();PC++;break;
		case 27:
			//cout << "opname fld" << endl;
			instCount[27]++;
			result = fload();PC++;break;
		case 28:
			//cout << "opname fst" << endl;
			instCount[28]++;
			result = fstore();PC++;break;
		case 29:
			//cout << "opname slw" << endl;
			instCount[29]++;
			l_shift_lg();PC++;break;
		case 30:
			//cout << "opname srw" << endl;
			instCount[30]++;
			r_shift_lg();PC++;break;
		case 31:
			//cout << "opname bc" << endl;
			instCount[31]++;
			branch_cond();break;
		case 32:
			//cout << "opname itof" << endl;
			instCount[32]++;
			int_to_float();PC++;break;
		case 33:
			//cout << "opname ftoi" << endl;
			instCount[33]++;
			float_to_int();PC++;break;
		case 34:
			//cout << "opname ba" << endl;
			instCount[34]++;
			branch_abs();break;
		case 35:
			//cout << "opname bal" << endl;
			instCount[35]++;
			branch_abs_and_link();break;
		case 62:
			instCount[62]++;
			if (inputflag == 0) {
				cout << "error: no input sld but called instruction \"in\"" << endl;
			}
			in();PC++;break;
		case 63:
			//cout << "opname out" << endl;
			instCount[63]++;
			if (stepflag == 0) {
				out();PC++;
			} else {
				outstep(); PC++;
			}
			break;
		default:
			cerr << "undefined instruction" << endl;
			result = 1;
	}
	if (result == 1) {
		return 1;
	} else {
		return 0;
	}
}
