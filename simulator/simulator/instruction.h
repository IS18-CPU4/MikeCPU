#ifndef INSTRUCTION_H_
#define INSTRUCTION_H_


int get_rD(const uint32_t);
int get_rA(const uint32_t);
int get_rB(const uint32_t);
int32_t get_simm16(const uint32_t);
int get_imm5(const uint32_t);
int32_t get_simm26(const uint32_t);

void cr0_set0();
void cr0_set1();
void cr0_set2();

inline void initReg();
inline void initSimm16();
inline void initImm5();


void load_imm();
void move_reg();
void add_imm();
void add_reg();
void sub_reg();
void l_shift_lg_imm();
void r_shift_lg_imm();
void fadd();
void fsub();
void fdiv();
void fmul();
void fsqrt();
void fabs();
void fmove_reg();
void branch();//無条件分岐
void branch_eq();
void branch_neq();
void branch_lt();
void branch_and_link();
void branch_link_reg();
void move_from_link();
void move_to_link();
void cmp_imm();
void cmp_reg();
void fcmp_reg();
void load();//word
void store();
void fload();
void fstore();

#endif //INSTRUCTION_H_
