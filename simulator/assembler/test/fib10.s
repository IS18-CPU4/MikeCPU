 .text
 .globl _min_caml_start
 .align 2
min_caml_print_newline:
  li r2, 20
  out r2
  blr
#min_caml_print_int:
min_caml_print_int_mul_10.33:
 slwi r5, r2, 1
 slwi r2, r2, 3
 add r2, r5, r2
 blr
min_caml_print_int_div_10_loop.35:
 sub r7, r6, r5
 cmpwi cr0, r7, 1
 blt min_caml_print_int_le.97
 beq min_caml_print_int_le.97
 add r7, r5, r6
 srwi r7, r7, 1
 st r5, r3, 0
 st r6, r3, 4
 st r7, r3, 8
 st r2, r3, 12
 mflr r31
 mr r2, r7
 st r31, r3, 20
 addi r3, r3, 24
 bl min_caml_print_int_mul_10.33
 li r31, 24
 sub r3, r3, r31
 ld r31, r3, 20
 mtlr r31
 ld r5, r3, 12
 cmpw cr0, r2, r5
 blt min_caml_print_int_le.98
 beq min_caml_print_int_le.98
 ld r2, r3, 0
 ld r6, r3, 8
 mr r29, r5
 mr r5, r2
 mr r2, r29
 b min_caml_print_int_div_10_loop.35
min_caml_print_int_le.98:
 ld r2, r3, 8
 ld r6, r3, 4
 mr r29, r5
 mr r5, r2
 mr r2, r29
 b min_caml_print_int_div_10_loop.35
min_caml_print_int_le.97:
 mr r2, r5
 blr
min_caml_print_int_div_10.39:
 srwi r5, r2, 4
 srwi r6, r2, 3
 b min_caml_print_int_div_10_loop.35
min_caml_print_int_mod_10.41:
 st r2, r3, 0
 mflr r31
 st r31, r3, 4
 addi r3, r3, 8
 bl min_caml_print_int_div_10.39
 li r31, 8
 sub r3, r3, r31
 ld r31, r3, 4
 mtlr r31
 mflr r31
 st r31, r3, 4
 addi r3, r3, 8
 bl min_caml_print_int_mul_10.33
 li r31, 8
 sub r3, r3, r31
 ld r31, r3, 4
 mtlr r31
 ld r5, r3, 0
 sub r2, r5, r2
 blr
min_caml_print_int_print_int_rec.43:
 cmpwi cr0, r2, 0
 bne min_caml_print_int_beq_else.99
 blr
min_caml_print_int_beq_else.99:
 st r2, r3, 0
 mflr r31
 st r31, r3, 4
 addi r3, r3, 8
 bl min_caml_print_int_mod_10.41
 li r31, 8
 sub r3, r3, r31
 ld r31, r3, 4
 mtlr r31
 ld r5, r3, 0
 st r2, r3, 4
 mflr r31
 mr r2, r5
 st r31, r3, 12
 addi r3, r3, 16
 bl min_caml_print_int_div_10.39
 li r31, 16
 sub r3, r3, r31
 ld r31, r3, 12
 mtlr r31
 mflr r31
 st r31, r3, 12
 addi r3, r3, 16
 bl min_caml_print_int_print_int_rec.43
 li r31, 16
 sub r3, r3, r31
 ld r31, r3, 12
 mtlr r31
 ld r2, r3, 4
 addi r2, r2, 48
 b min_caml_print_byte
min_caml_print_int:
 cmpwi cr0, r2, 0
 bne min_caml_print_int_beq_else.101
 li r2, 48
 mflr r31
 st r31, r3, 4
 addi r3, r3, 8
 bl min_caml_print_byte
 li r31, 8
 sub r3, r3, r31
 ld r31, r3, 4
 mtlr r31
 li r2, 10
 b min_caml_print_byte
min_caml_print_int_beq_else.101:
 cmpwi cr0, r2, 0
 blt min_caml_print_int_bge_else.102
 mflr r31
 st r31, r3, 4
 addi r3, r3, 8
 bl min_caml_print_int_print_int_rec.43
 li r31, 8
 sub r3, r3, r31
 ld r31, r3, 4
 mtlr r31
 li r2, 10
 b min_caml_print_byte
min_caml_print_int_bge_else.102:
 li r5, 45
 st r2, r3, 0
 mflr r31
 mr r2, r5
 st r31, r3, 4
 addi r3, r3, 8
 bl min_caml_print_byte
 li r31, 8
 sub r3, r3, r31
 ld r31, r3, 4
 mtlr r31
 ld r2, r3, 0
 sub r2, r0, r2
 mflr r31
 st r31, r3, 4
 addi r3, r3, 8
 bl min_caml_print_int_print_int_rec.43
 li r31, 8
 sub r3, r3, r31
 ld r31, r3, 4
 mtlr r31
 li r2, 10
 b min_caml_print_byte
min_caml_print_byte:
  out r2
  blr
#min_caml_prerr_int:
min_caml_prerr_byte:
 out r2
 blr
#min_caml_prerr_float:
min_caml_read_int:
min_caml_read_float:
min_caml_create_array:
min_caml_create_float_array:
min_caml_abs_float:
min_caml_sqrt:
min_caml_floor:
min_caml_int_of_float:
min_caml_truncate:
min_caml_float_of_int:
min_caml_cos:
min_caml_sin:
min_caml_atan:
fib.10:
 cmpwi cr0, r2, 1
 blt le.24
 beq le.24
 li r5, 1
 sub r5, r2, r5
 st r2, r3, 0
 mflr r31
 mr r2, r5
 st r31, r3, 4
 addi r3, r3, 8
 bl fib.10
 li r31, 8
 sub r3, r3, r31
 ld r31, r3, 4
 mtlr r31
 li r5, 2
 ld r6, r3, 0
 sub r5, r6, r5
 st r2, r3, 4
 mflr r31
 mr r2, r5
 st r31, r3, 12
 addi r3, r3, 16
 bl fib.10
 li r31, 16
 sub r3, r3, r31
 ld r31, r3, 12
 mtlr r31
 ld r5, r3, 4
 add r2, r5, r2
 blr
le.24:
 blr
_min_caml_start:
# main program starts
 li r2, 10
 mflr r31
 st r31, r3, 4
 addi r3, r3, 8
 bl fib.10
 li r31, 8
 sub r3, r3, r31
 ld r31, r3, 4
 mtlr r31
 mflr r31
 st r31, r3, 4
 addi r3, r3, 8
 bl min_caml_print_int
 li r31, 8
 sub r3, r3, r31
 ld r31, r3, 4
 mtlr r31
# main program ends
