#ifndef REVASM_H_
#define REVASM_H_

void print_rD(const uint32_t);
void print_rA(const uint32_t);
void print_rB(const uint32_t);
void print_simm16(const uint32_t);
void print_BI(const uint32_t);
void print_BD(const uint32_t);
void print_imm5(const uint32_t);
void print_simm26(const uint32_t);
//void print_BD();

void rev_asm(const uint32_t);

#endif //REVASM_H_
