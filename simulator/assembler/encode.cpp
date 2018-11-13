#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include "encode.h"

using namespace std;

#define scmp(str) vitem[0] == str

uint32_t encode_to_op(vector<string> vitem) {

	if (scmp("li")) {return op_li(vitem);}
	if (scmp("mr")) {return op_mr(vitem);}
	if (scmp("addi")) {return op_addi(vitem);}
	if (scmp("add")) {return op_add(vitem);}
	if (scmp("sub")) {return op_sub(vitem);}
	if (scmp("slwi")) {return op_slwi(vitem);}
	if (scmp("srwi")) {return op_srwi(vitem);}
	if (scmp("fadd")) {return op_fadd(vitem);}
	if (scmp("fsub")) {return op_fsub(vitem);}
	if (scmp("fdiv")) {return op_fdiv(vitem);}
	if (scmp("fmul")) {return op_fmul(vitem);}
	if (scmp("fsqrt")) {return op_fsqrt(vitem);}
	if (scmp("fabs")) {return op_fabs(vitem);}
	if (scmp("fmr")) {return op_fmr(vitem);}
	if (scmp("b")) {return op_b(vitem);}
	if (scmp("beq")) {return op_beq(vitem);}
	if (scmp("bne")) {return op_bne(vitem);}
	if (scmp("blt")) {return op_blt(vitem);}
	if (scmp("bl")) {return op_bl(vitem);}
	if (scmp("blr")) {return op_blr(vitem);}
	if (scmp("mflr")) {return op_mflr(vitem);}
	if (scmp("mtlr")) {return op_mtlr(vitem);}
	if (scmp("cmpwi")) {return op_cmpwi(vitem);}
	if (scmp("cmpw")) {return op_cmpw(vitem);}
	if (scmp("fcmp")) {return op_fcmp(vitem);}
	if (scmp("ld")) {return op_ld(vitem);}
	if (scmp("st")) {return op_st(vitem);}
	if (scmp("fld")) {return op_fld(vitem);}
	if (scmp("fst")) {return op_fst(vitem);}

	//added
	if (scmp("slw")) {return op_slw(vitem);}
	if (scmp("srw")) {return op_srw(vitem);}
	if (scmp("bc")) {return op_bc(vitem);}
	if (scmp("itof")) {return op_itof(vitem);}
	if (scmp("ftoi")) {return op_ftoi(vitem);}
	if (scmp("out")) {return op_out(vitem);}

	//added 2
	if (scmp("ba")) {return op_ba(vitem);}
	if (scmp("bal")) {return op_bal(vitem);}

	if (scmp(".text")) {return set_txt(vitem);}
	if (scmp(".align")) {return set_align(vitem);}
	if (scmp(".globl")) {return set_globl(vitem);}
	
	if (vitem[0].find_first_of("#", 0) == 0) {
		return 0;
	}
	if (vitem[0].find_last_of(':') == vitem[0].length()-1) {
		return set_label(vitem);
	}
	cerr << "undefined instruction" << endl;
	return 0xFFFFFFFF;
}
