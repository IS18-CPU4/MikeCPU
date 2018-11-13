#ifndef INSTRUCTION_H_
#define INSTRUCTION_H_


inline int get_rD(const uint32_t);
inline int get_rA(const uint32_t);
inline int get_rB(const uint32_t);
inline int32_t get_simm16(const uint32_t);
inline int get_imm5(const uint32_t);
inline int32_t get_simm26(const uint32_t);

inline void cr0_set0(const uint32_t);
inline void cr0_set1(const uint32_t);
inline void cr0_set2(const uint32_t);

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

//added
void l_shift_lg();
void r_shift_lg();
void branch_cond();
void int_to_float();
void float_to_int();
void out();

//added 2
void branch_abs();
void branch_abs_and_link();

#endif //INSTRUCTION_H_
