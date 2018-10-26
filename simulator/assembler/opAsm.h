#ifndef OPASM_H_
#define OPASM_H_

#include <vector>
#include <string>
#include <stdint.h>

using namespace std;

vector<string> StringSplit(const string, const char);

uint32_t get_rD(const string);
uint32_t get_rA(const string);
uint32_t get_rB(const string);
uint32_t get_simm16(const string);
uint32_t get_imm5(const string);
uint32_t get_simm26(const string);

uint32_t op_li(const vector<string>&);
uint32_t op_mr(const vector<string>&);
uint32_t op_addi(const vector<string>&);
uint32_t op_add(const vector<string>&);
uint32_t op_sub(const vector<string>&);
uint32_t op_slwi(const vector<string>&);
uint32_t op_srwi(const vector<string>&);
uint32_t op_fadd(const vector<string>&);
uint32_t op_fsub(const vector<string>&);
uint32_t op_fdiv(const vector<string>&);
uint32_t op_fmul(const vector<string>&);
uint32_t op_fsqrt(const vector<string>&);
uint32_t op_fabs(const vector<string>&);
uint32_t op_fmr(const vector<string>&);
uint32_t op_b(const vector<string>&);
uint32_t op_beq(const vector<string>&);
uint32_t op_bne(const vector<string>&);
uint32_t op_blt(const vector<string>&);
uint32_t op_bl(const vector<string>&);
uint32_t op_blr(const vector<string>&);
uint32_t op_mflr(const vector<string>&);
uint32_t op_mtlr(const vector<string>&);
uint32_t op_cmpwi(const vector<string>&);
uint32_t op_cmpw(const vector<string>&);
uint32_t op_fcmp(const vector<string>&);
uint32_t op_ld(const vector<string>&);
uint32_t op_st(const vector<string>&);
uint32_t op_fld(const vector<string>&);
uint32_t op_fst(const vector<string>&);

uint32_t op_slw(const vector<string>&);
uint32_t op_srw(const vector<string>&);
uint32_t op_bc(const vector<string>&);
uint32_t op_itof(const vector<string>&);
uint32_t op_ftoi(const vector<string>&);

uint32_t set_txt(const vector<string>&);
uint32_t set_align(const vector<string>&);
uint32_t set_globl(const vector<string>&);
uint32_t set_label(const vector<string>&);

#endif //OPASM_H_
