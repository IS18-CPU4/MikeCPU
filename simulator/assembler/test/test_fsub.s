	.text
	.globl _min_caml_start
	.align 2
#Library
min_caml_print_newline:
  li r2, 10
  out r2
  blr
# min_caml_print_int:
min_caml_print_int_mul_10.29:
	slwi	r5, r2, 1
	slwi	r2, r2, 3
	add	r2, r5, r2
	blr
min_caml_print_int_div_10_loop.31:
	sub	r7, r6, r5
	cmpwi	cr0, r7, 1
	blt	min_caml_print_int_le.89
	beq	min_caml_print_int_le.89
	add	r7, r5, r6
	srwi	r7, r7, 1
	st	r5, r3, 0
	st	r6, r3, 4
	st	r7, r3, 8
	st	r2, r3, 12
	mflr	r31
	mr	r2, r7
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_print_int_mul_10.29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	cmpw	cr0, r2, r5
	blt	min_caml_print_int_le.90
	beq	min_caml_print_int_le.90
	ld	r2, r3, 0
	ld	r6, r3, 8
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	b	min_caml_print_int_div_10_loop.31
min_caml_print_int_le.90:
	ld	r2, r3, 8
	ld	r6, r3, 4
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	b	min_caml_print_int_div_10_loop.31
min_caml_print_int_le.89:
	mr	r2, r5
	blr
min_caml_print_int_div_10.35:
	srwi	r5, r2, 4
	srwi	r6, r2, 3
	addi	r6, r6, 1
	b	min_caml_print_int_div_10_loop.31
min_caml_print_int_mod_10.37:
	st	r2, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int_div_10.35
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int_mul_10.29
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r5, r3, 0
	sub	r2, r5, r2
	blr
min_caml_print_int_print_int_rec.39:
	cmpwi	cr0, r2, 0
	bne	min_caml_print_int_beq_else.91
	blr
min_caml_print_int_beq_else.91:
	st	r2, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int_mod_10.37
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r5, r3, 0
	st	r2, r3, 4
	mflr	r31
	mr	r2, r5
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_print_int_div_10.35
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_print_int_print_int_rec.39
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r2, r3, 4
	addi	r2, r2, 48
	b	min_caml_print_byte
min_caml_print_int:
	cmpwi	cr0, r2, 0
	bne	min_caml_print_int_beq_else.93
	li	r2, 48
	b	min_caml_print_byte
min_caml_print_int_beq_else.93:
	cmpwi	cr0, r2, 0
	blt	min_caml_print_int_bge_else.94
	b	min_caml_print_int_print_int_rec.39
min_caml_print_int_bge_else.94:
	li	r5, 45
	st	r2, r3, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_byte
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r2, r3, 0
	sub	r2, r0, r2
	b	min_caml_print_int_print_int_rec.39
# print_char = print_byte
min_caml_print_char:
min_caml_print_byte:
  out r2
  blr
# min_caml_prerr_int:
min_caml_prerr_byte:
	out r2
	blr
# min_caml_prerr_float:
min_caml_read_int:
  in r2
  slwi  r2, r2, 8
  in r31
  add r2, r2, r31
  slwi  r2, r2, 8
  in r31
  add r2, r2, r31
  slwi  r2, r2, 8
  in r31
  add r2, r2, r31
  blr
min_caml_read_float:
  in r2
  slwi  r2, r2, 8
  in r31
  add r2, r2, r31
  slwi  r2, r2, 8
  in r31
  add r2, r2, r31
  slwi  r2, r2, 8
  in r31
  add r2, r2, r31
  st  r2, r3, 8
  fld fr1, r3, 8
  blr
# create_array
min_caml_create_array:
  mr	r6, r2
  mr	r2, r4
create_array_loop:
  cmpwi	cr0, r6, 0
  bne	create_array_cont
  blr
create_array_cont:
  st	r5, r4, 0
  addi  r6, r6, -1
  addi	r4, r4, 4
  b	create_array_loop
# create_float_array
min_caml_create_float_array:
	mr	r5, r2
	mr	r2, r4
create_float_array_loop:
	cmpwi	cr0, r5, 0
	bne	create_float_array_cont
	blr
create_float_array_cont:
	fst	fr1, r4, 0
	addi	r5, r5, -1
	addi	r4, r4, 4
	b	create_float_array_loop
# for min-rt libs :fhalf, fsqr, fneg
min_caml_fhalf:
  li	r31, 16128
  slwi	r31, r31, 16
  addi	r31, r31, 0
  st	r31, r3, 8
  fld	fr2, r3, 8
  fmul	fr1, fr1, fr2
  blr
min_caml_fsqr:
  fmul	fr1, fr1, fr1
  blr
min_caml_abs_float:
  fabs fr1, fr1
  blr
min_caml_fabs:
  fabs fr1, fr1
  blr
min_caml_sqrt:
  fsqrt fr1, fr1
  blr
# min_caml_floor:
min_caml_floor:
	li	r31, 16128
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	fsub	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_int_of_float
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	b	min_caml_float_of_int
min_caml_int_of_float:
  ftoi r2, fr1
  blr
min_caml_truncate:
  ftoi r2, fr1
  blr
min_caml_float_of_int:
  itof fr1, r2
  blr
# min_caml_cos:
# min_caml_sin:
min_caml_sincos_ker_sin.85:
	fmul	fr2, fr1, fr1
	fmul	fr3, fr1, fr2
	li	r31, 15915
	slwi	r31, r31, 16
	addi	r31, r31, 43692
	st	r31, r3, 8
	fld	fr4, r3, 8
	fmul	fr4, fr3, fr4
	fsub	fr1, fr1, fr4
	fmul	fr4, fr3, fr2
	li	r31, 15369
	slwi	r31, r31, 16
	addi	r31, r31, 34406
	st	r31, r3, 8
	fld	fr5, r3, 8
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fmul	fr3, fr3, fr2
	fmul	fr2, fr3, fr2
	li	r31, 14669
	slwi	r31, r31, 16
	addi	r31, r31, 25782
	st	r31, r3, 8
	fld	fr3, r3, 8
	fmul	fr2, fr2, fr3
	fsub	fr1, fr1, fr2
	blr
min_caml_sincos_ker_cos.87:
	fmul	fr1, fr1, fr1
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	li	r31, 16128
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr3, r3, 8
	fmul	fr3, fr1, fr3
	fsub	fr2, fr2, fr3
	fmul	fr3, fr1, fr1
	li	r31, 15659
	slwi	r31, r31, 16
	addi	r31, r31, 42889
	st	r31, r3, 8
	fld	fr4, r3, 8
	fmul	fr3, fr3, fr4
	fadd	fr2, fr2, fr3
	fmul	fr3, fr1, fr1
	fmul	fr1, fr3, fr1
	li	r31, 15028
	slwi	r31, r31, 16
	addi	r31, r31, 33030
	st	r31, r3, 8
	fld	fr3, r3, 8
	fmul	fr1, fr1, fr3
	fsub	fr1, fr2, fr1
	blr
min_caml_sin:
	li	r31, 16457
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr3, r3, 8
	fcmp	cr0, fr3, fr1
	blt	min_caml_sincos_le.207
	beq	min_caml_sincos_le.207
	fsub	fr1, fr0, fr1
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_sin
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	fsub	fr1, fr0, fr1
	blr
min_caml_sincos_le.207:
	li	r31, 16585
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr3, r3, 8
	fcmp	cr0, fr3, fr1
	blt	min_caml_sincos_le.208
	beq	min_caml_sincos_le.208
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.209
	beq	min_caml_sincos_le.209
	li	r31, 16329
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.210
	beq	min_caml_sincos_le.210
	li	r31, 16201
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.211
	beq	min_caml_sincos_le.211
	b	min_caml_sincos_ker_sin.85
min_caml_sincos_le.211:
	li	r31, 16329
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fsub	fr1, fr2, fr1
	b	min_caml_sincos_ker_cos.87
min_caml_sincos_le.210:
	li	r31, 16329
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fsub	fr1, fr1, fr2
	b	min_caml_sin
min_caml_sincos_le.209:
	fsub	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_sin
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	fsub	fr1, fr0, fr1
	blr
min_caml_sincos_le.208:
	li	r31, 16585
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr3, r3, 8
	fdiv	fr3, fr1, fr3
	fst	fr1, r3, 0
	fst	fr2, r3, 4
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_int_of_float
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_float_of_int
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	li	r31, 16384
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 16
	fld	fr2, r3, 16
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 0
	fsub	fr1, fr2, fr1
	b	min_caml_sin
min_caml_cos:
	li	r31, 16457
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr3, r3, 8
	fcmp	cr0, fr3, fr1
	blt	min_caml_sincos_le.212
	beq	min_caml_sincos_le.212
	fsub	fr1, fr0, fr1
	b	min_caml_cos
min_caml_sincos_le.212:
	li	r31, 16585
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr3, r3, 8
	fcmp	cr0, fr3, fr1
	blt	min_caml_sincos_le.213
	beq	min_caml_sincos_le.213
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.214
	beq	min_caml_sincos_le.214
	li	r31, 16329
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.215
	beq	min_caml_sincos_le.215
	li	r31, 16201
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.216
	beq	min_caml_sincos_le.216
	b	min_caml_sincos_ker_cos.87
min_caml_sincos_le.216:
	li	r31, 16329
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fsub	fr1, fr2, fr1
	b	min_caml_sincos_ker_sin.85
min_caml_sincos_le.215:
	li	r31, 16329
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fsub	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_cos
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	fsub	fr1, fr0, fr1
	blr
min_caml_sincos_le.214:
	fsub	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_cos
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	fsub	fr1, fr0, fr1
	blr
min_caml_sincos_le.213:
	li	r31, 16585
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr3, r3, 8
	fdiv	fr3, fr1, fr3
	fst	fr1, r3, 0
	fst	fr2, r3, 4
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_int_of_float
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_float_of_int
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	li	r31, 16384
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 16
	fld	fr2, r3, 16
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 0
	fsub	fr1, fr2, fr1
	b	min_caml_cos
# min_caml_atan:
min_caml_atan_ker_atan.44:
	fmul	fr2, fr1, fr1
	fmul	fr3, fr1, fr2
	fmul	fr4, fr2, fr2
	fmul	fr5, fr3, fr3
	fmul	fr5, fr5, fr3
	li	r31, 16043
	slwi	r31, r31, 16
	addi	r31, r31, 43690
	st	r31, r3, 8
	fld	fr6, r3, 8
	fmul	fr6, fr3, fr6
	fsub	fr1, fr1, fr6
	fmul	fr6, fr3, fr2
	li	r31, 15949
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r3, 8
	fld	fr7, r3, 8
	fmul	fr6, fr6, fr7
	fadd	fr1, fr1, fr6
	fmul	fr3, fr3, fr4
	li	r31, 15890
	slwi	r31, r31, 16
	addi	r31, r31, 18725
	st	r31, r3, 8
	fld	fr6, r3, 8
	fmul	fr3, fr3, fr6
	fsub	fr1, fr1, fr3
	li	r31, 15844
	slwi	r31, r31, 16
	addi	r31, r31, 36408
	st	r31, r3, 8
	fld	fr3, r3, 8
	fmul	fr3, fr5, fr3
	fadd	fr1, fr1, fr3
	fmul	fr2, fr5, fr2
	li	r31, 15800
	slwi	r31, r31, 16
	addi	r31, r31, 54894
	st	r31, r3, 8
	fld	fr3, r3, 8
	fmul	fr2, fr2, fr3
	fsub	fr1, fr1, fr2
	fmul	fr2, fr5, fr4
	li	r31, 15734
	slwi	r31, r31, 16
	addi	r31, r31, 59333
	st	r31, r3, 8
	fld	fr3, r3, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	blr
min_caml_atan:
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr2, fr1
	blt	min_caml_atan_le.113
	beq	min_caml_atan_le.113
	fsub	fr1, fr0, fr1
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_atan
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	fsub	fr1, fr0, fr1
	blr
min_caml_atan_le.113:
	li	r31, 16096
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr2, fr1
	blt	min_caml_atan_le.114
	beq	min_caml_atan_le.114
	b	min_caml_atan_ker_atan.44
min_caml_atan_le.114:
	li	r31, 16412
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr2, fr1
	blt	min_caml_atan_le.115
	beq	min_caml_atan_le.115
	li	r31, 16201
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr3, r3, 8
	fsub	fr3, fr1, fr3
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr4, r3, 8
	fadd	fr1, fr1, fr4
	fdiv	fr1, fr3, fr1
	fst	fr2, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_atan_ker_atan.44
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	fld	fr2, r3, 0
	fadd	fr1, fr2, fr1
	blr
min_caml_atan_le.115:
	li	r31, 16329
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr3, r3, 8
	fdiv	fr1, fr3, fr1
	fst	fr2, r3, 4
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_atan_ker_atan.44
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	fld	fr2, r3, 4
	fsub	fr1, fr2, fr1
	blr
#End Library
calc.17:
	li	r31, 16544
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	fsub	fr1, fr0, fr1
	fadd	fr1, fr2, fr1
	li	r31, 16672
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	fsub	fr2, fr2, fr1
	li	r31, 16672
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr3, r3, 8
	fsub	fr1, fr3, fr1
	fsub	fr1, fr1, fr2
	blr
_min_caml_start:
#	main program starts
	li	r31, 16457
	slwi	r31, r31, 16
	addi	r31, r31, 4056
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	calc.17
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_int_of_float
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r31, 16309
	slwi	r31, r31, 16
	addi	r31, r31, 1267
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	calc.17
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_int_of_float
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r31, 16309
	slwi	r31, r31, 16
	addi	r31, r31, 1153
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	calc.17
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_int_of_float
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
#	main program ends
