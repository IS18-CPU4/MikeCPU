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
fispos.2390:
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr1, fr2
	blt	le.8589
	beq	le.8589
	li	r2, 1
	blr
le.8589:
	li	r2, 0
	blr
fisneg.2392:
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr2, fr1
	blt	le.8590
	beq	le.8590
	li	r2, 1
	blr
le.8590:
	li	r2, 0
	blr
fiszero.2394:
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr1, fr2
	bne	beq_else.8591
	li	r2, 1
	blr
beq_else.8591:
	li	r2, 0
	blr
xor.2426:
	cmpwi	cr0, r2, 0
	bne	beq_else.8592
	mr	r2, r5
	blr
beq_else.8592:
	cmpwi	cr0, r5, 0
	bne	beq_else.8593
	li	r2, 1
	blr
beq_else.8593:
	li	r2, 0
	blr
sgn.2429:
	fst	fr1, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	fiszero.2394
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8594
	fld	fr1, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	fispos.2390
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8595
	li	r31, 49024
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	blr
beq_else.8595:
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	blr
beq_else.8594:
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	blr
fneg_cond.2431:
	cmpwi	cr0, r2, 0
	bne	beq_else.8596
	fsub	fr1, fr0, fr1
	blr
beq_else.8596:
	blr
add_mod5.2434:
	add	r2, r2, r5
	cmpwi	cr0, r2, 5
	blt	bge_else.8597
	addi	r2, r2, -5
	blr
bge_else.8597:
	blr
vecset.2437:
	fst	fr1, r2, 0
	fst	fr2, r2, 4
	fst	fr3, r2, 8
	blr
vecfill.2442:
	fst	fr1, r2, 0
	fst	fr1, r2, 4
	fst	fr1, r2, 8
	blr
vecbzero.2445:
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	b	vecfill.2442
veccpy.2447:
	fld	fr1, r5, 0
	fst	fr1, r2, 0
	fld	fr1, r5, 4
	fst	fr1, r2, 4
	fld	fr1, r5, 8
	fst	fr1, r2, 8
	blr
vecunit_sgn.2455:
	fld	fr1, r2, 0
	st	r5, r3, 0
	st	r2, r3, 4
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_fsqr
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r2, r3, 4
	fld	fr2, r2, 4
	fst	fr1, r3, 8
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_fsqr
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	fld	fr2, r3, 8
	fadd	fr1, fr2, fr1
	ld	r2, r3, 4
	fld	fr2, r2, 8
	fst	fr1, r3, 12
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_fsqr
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 12
	fadd	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_sqrt
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fst	fr1, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	fiszero.2394
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8601
	ld	r2, r3, 0
	cmpwi	cr0, r2, 0
	bne	beq_else.8603
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 24
	fld	fr1, r3, 24
	fld	fr2, r3, 16
	fdiv	fr1, fr1, fr2
	b	beq_cont.8604
beq_else.8603:
	li	r31, 49024
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 24
	fld	fr1, r3, 24
	fld	fr2, r3, 16
	fdiv	fr1, fr1, fr2
beq_cont.8604:
	b	beq_cont.8602
beq_else.8601:
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 24
	fld	fr1, r3, 24
beq_cont.8602:
	ld	r2, r3, 4
	fld	fr2, r2, 0
	fmul	fr2, fr2, fr1
	fst	fr2, r2, 0
	fld	fr2, r2, 4
	fmul	fr2, fr2, fr1
	fst	fr2, r2, 4
	fld	fr2, r2, 8
	fmul	fr1, fr2, fr1
	fst	fr1, r2, 8
	blr
veciprod.2458:
	fld	fr1, r2, 0
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r2, 4
	fld	fr3, r5, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r2, 8
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	blr
veciprod2.2461:
	fld	fr4, r2, 0
	fmul	fr1, fr4, fr1
	fld	fr4, r2, 4
	fmul	fr2, fr4, fr2
	fadd	fr1, fr1, fr2
	fld	fr2, r2, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	blr
vecaccum.2466:
	fld	fr2, r2, 0
	fld	fr3, r5, 0
	fmul	fr3, fr1, fr3
	fadd	fr2, fr2, fr3
	fst	fr2, r2, 0
	fld	fr2, r2, 4
	fld	fr3, r5, 4
	fmul	fr3, fr1, fr3
	fadd	fr2, fr2, fr3
	fst	fr2, r2, 4
	fld	fr2, r2, 8
	fld	fr3, r5, 8
	fmul	fr1, fr1, fr3
	fadd	fr1, fr2, fr1
	fst	fr1, r2, 8
	blr
vecadd.2470:
	fld	fr1, r2, 0
	fld	fr2, r5, 0
	fadd	fr1, fr1, fr2
	fst	fr1, r2, 0
	fld	fr1, r2, 4
	fld	fr2, r5, 4
	fadd	fr1, fr1, fr2
	fst	fr1, r2, 4
	fld	fr1, r2, 8
	fld	fr2, r5, 8
	fadd	fr1, fr1, fr2
	fst	fr1, r2, 8
	blr
vecscale.2476:
	fld	fr2, r2, 0
	fmul	fr2, fr2, fr1
	fst	fr2, r2, 0
	fld	fr2, r2, 4
	fmul	fr2, fr2, fr1
	fst	fr2, r2, 4
	fld	fr2, r2, 8
	fmul	fr1, fr2, fr1
	fst	fr1, r2, 8
	blr
vecaccumv.2479:
	fld	fr1, r2, 0
	fld	fr2, r5, 0
	fld	fr3, r6, 0
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r2, 0
	fld	fr1, r2, 4
	fld	fr2, r5, 4
	fld	fr3, r6, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r2, 4
	fld	fr1, r2, 8
	fld	fr2, r5, 8
	fld	fr3, r6, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r2, 8
	blr
o_texturetype.2483:
	ld	r2, r2, 0
	blr
o_form.2485:
	ld	r2, r2, 4
	blr
o_reflectiontype.2487:
	ld	r2, r2, 8
	blr
o_isinvert.2489:
	ld	r2, r2, 24
	blr
o_isrot.2491:
	ld	r2, r2, 12
	blr
o_param_a.2493:
	ld	r2, r2, 16
	fld	fr1, r2, 0
	blr
o_param_b.2495:
	ld	r2, r2, 16
	fld	fr1, r2, 4
	blr
o_param_c.2497:
	ld	r2, r2, 16
	fld	fr1, r2, 8
	blr
o_param_abc.2499:
	ld	r2, r2, 16
	blr
o_param_x.2501:
	ld	r2, r2, 20
	fld	fr1, r2, 0
	blr
o_param_y.2503:
	ld	r2, r2, 20
	fld	fr1, r2, 4
	blr
o_param_z.2505:
	ld	r2, r2, 20
	fld	fr1, r2, 8
	blr
o_diffuse.2507:
	ld	r2, r2, 28
	fld	fr1, r2, 0
	blr
o_hilight.2509:
	ld	r2, r2, 28
	fld	fr1, r2, 4
	blr
o_color_red.2511:
	ld	r2, r2, 32
	fld	fr1, r2, 0
	blr
o_color_green.2513:
	ld	r2, r2, 32
	fld	fr1, r2, 4
	blr
o_color_blue.2515:
	ld	r2, r2, 32
	fld	fr1, r2, 8
	blr
o_param_r1.2517:
	ld	r2, r2, 36
	fld	fr1, r2, 0
	blr
o_param_r2.2519:
	ld	r2, r2, 36
	fld	fr1, r2, 4
	blr
o_param_r3.2521:
	ld	r2, r2, 36
	fld	fr1, r2, 8
	blr
o_param_ctbl.2523:
	ld	r2, r2, 40
	blr
p_rgb.2525:
	ld	r2, r2, 0
	blr
p_intersection_points.2527:
	ld	r2, r2, 4
	blr
p_surface_ids.2529:
	ld	r2, r2, 8
	blr
p_calc_diffuse.2531:
	ld	r2, r2, 12
	blr
p_energy.2533:
	ld	r2, r2, 16
	blr
p_received_ray_20percent.2535:
	ld	r2, r2, 20
	blr
p_group_id.2537:
	ld	r2, r2, 24
	ld	r2, r2, 0
	blr
p_set_group_id.2539:
	ld	r2, r2, 24
	st	r5, r2, 0
	blr
p_nvectors.2542:
	ld	r2, r2, 28
	blr
d_vec.2544:
	ld	r2, r2, 0
	blr
d_const.2546:
	ld	r2, r2, 4
	blr
r_surface_id.2548:
	ld	r2, r2, 0
	blr
r_dvec.2550:
	ld	r2, r2, 4
	blr
r_bright.2552:
	fld	fr1, r2, 8
	blr
rad.2554:
	li	r31, 15503
	slwi	r31, r31, 16
	addi	r31, r31, 64053
	st	r31, r3, 8
	fld	fr2, r3, 8
	fmul	fr1, fr1, fr2
	blr
read_screen_settings.2556:
	ld	r2, r30, 20
	ld	r5, r30, 16
	ld	r6, r30, 12
	ld	r7, r30, 8
	ld	r8, r30, 4
	st	r2, r3, 0
	st	r6, r3, 4
	st	r7, r3, 8
	st	r5, r3, 12
	st	r8, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_read_float
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 16
	fst	fr1, r2, 0
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_read_float
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 16
	fst	fr1, r2, 4
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_read_float
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 16
	fst	fr1, r2, 8
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_read_float
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	rad.2554
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fst	fr1, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_cos
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 20
	fst	fr1, r3, 24
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_sin
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fst	fr1, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_read_float
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	rad.2554
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fst	fr1, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_cos
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 32
	fst	fr1, r3, 36
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_sin
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 24
	fmul	fr3, fr2, fr1
	li	r31, 17224
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 48
	fld	fr4, r3, 48
	fmul	fr3, fr3, fr4
	ld	r2, r3, 12
	fst	fr3, r2, 0
	li	r31, 49992
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 48
	fld	fr3, r3, 48
	fld	fr4, r3, 28
	fmul	fr3, fr4, fr3
	fst	fr3, r2, 4
	fld	fr3, r3, 36
	fmul	fr5, fr2, fr3
	li	r31, 17224
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 48
	fld	fr6, r3, 48
	fmul	fr5, fr5, fr6
	fst	fr5, r2, 8
	ld	r5, r3, 8
	fst	fr3, r5, 0
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 48
	fld	fr5, r3, 48
	fst	fr5, r5, 4
	fsub	fr5, fr0, fr1
	fst	fr5, r5, 8
	fsub	fr5, fr0, fr4
	fmul	fr1, fr5, fr1
	ld	r5, r3, 4
	fst	fr1, r5, 0
	fsub	fr1, fr0, fr2
	fst	fr1, r5, 4
	fsub	fr1, fr0, fr4
	fmul	fr1, fr1, fr3
	fst	fr1, r5, 8
	ld	r5, r3, 16
	fld	fr1, r5, 0
	fld	fr2, r2, 0
	fsub	fr1, fr1, fr2
	ld	r6, r3, 0
	fst	fr1, r6, 0
	fld	fr1, r5, 4
	fld	fr2, r2, 4
	fsub	fr1, fr1, fr2
	fst	fr1, r6, 4
	fld	fr1, r5, 8
	fld	fr2, r2, 8
	fsub	fr1, fr1, fr2
	fst	fr1, r6, 8
	blr
read_light.2558:
	ld	r2, r30, 8
	ld	r5, r30, 4
	st	r5, r3, 0
	st	r2, r3, 4
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_read_int
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_read_float
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	rad.2554
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	fst	fr1, r3, 8
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_sin
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	fsub	fr1, fr0, fr1
	ld	r2, r3, 4
	fst	fr1, r2, 4
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_read_float
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	rad.2554
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	fld	fr2, r3, 8
	fst	fr1, r3, 12
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_cos
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 12
	fst	fr1, r3, 16
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_sin
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 16
	fmul	fr1, fr2, fr1
	ld	r2, r3, 4
	fst	fr1, r2, 0
	fld	fr1, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_cos
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 16
	fmul	fr1, fr2, fr1
	ld	r2, r3, 4
	fst	fr1, r2, 8
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_read_float
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 0
	fst	fr1, r2, 0
	blr
rotate_quadratic_matrix.2560:
	fld	fr1, r5, 0
	st	r2, r3, 0
	st	r5, r3, 4
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_cos
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r2, r3, 4
	fld	fr2, r2, 0
	fst	fr1, r3, 8
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_sin
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r2, r3, 4
	fld	fr2, r2, 4
	fst	fr1, r3, 12
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_cos
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 4
	fld	fr2, r2, 4
	fst	fr1, r3, 16
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_sin
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 4
	fld	fr2, r2, 8
	fst	fr1, r3, 20
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_cos
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 4
	fld	fr2, r2, 8
	fst	fr1, r3, 24
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_sin
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 24
	fld	fr3, r3, 16
	fmul	fr4, fr3, fr2
	fld	fr5, r3, 20
	fld	fr6, r3, 12
	fmul	fr7, fr6, fr5
	fmul	fr7, fr7, fr2
	fld	fr8, r3, 8
	fmul	fr9, fr8, fr1
	fsub	fr7, fr7, fr9
	fmul	fr9, fr8, fr5
	fmul	fr9, fr9, fr2
	fmul	fr10, fr6, fr1
	fadd	fr9, fr9, fr10
	fmul	fr10, fr3, fr1
	fmul	fr11, fr6, fr5
	fmul	fr11, fr11, fr1
	fmul	fr12, fr8, fr2
	fadd	fr11, fr11, fr12
	fmul	fr12, fr8, fr5
	fmul	fr1, fr12, fr1
	fmul	fr2, fr6, fr2
	fsub	fr1, fr1, fr2
	fsub	fr2, fr0, fr5
	fmul	fr5, fr6, fr3
	fmul	fr3, fr8, fr3
	ld	r2, r3, 0
	fld	fr6, r2, 0
	fld	fr8, r2, 4
	fld	fr12, r2, 8
	fst	fr4, r3, 28
	fst	fr3, r3, 32
	fst	fr1, r3, 36
	fst	fr9, r3, 40
	fst	fr5, r3, 44
	fst	fr11, r3, 48
	fst	fr7, r3, 52
	fst	fr12, r3, 56
	fst	fr2, r3, 60
	fst	fr8, r3, 64
	fst	fr10, r3, 68
	fst	fr6, r3, 72
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_fsqr
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 72
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 68
	fst	fr1, r3, 76
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_fsqr
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	fld	fr2, r3, 64
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 76
	fadd	fr1, fr3, fr1
	fld	fr3, r3, 60
	fst	fr1, r3, 80
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_fsqr
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	fld	fr2, r3, 56
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 80
	fadd	fr1, fr3, fr1
	ld	r2, r3, 0
	fst	fr1, r2, 0
	fld	fr1, r3, 52
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_fsqr
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	fld	fr2, r3, 72
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 48
	fst	fr1, r3, 84
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fsqr
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	fld	fr2, r3, 64
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 84
	fadd	fr1, fr3, fr1
	fld	fr3, r3, 44
	fst	fr1, r3, 88
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fsqr
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	fld	fr2, r3, 56
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 88
	fadd	fr1, fr3, fr1
	ld	r2, r3, 0
	fst	fr1, r2, 4
	fld	fr1, r3, 40
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fsqr
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	fld	fr2, r3, 72
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 36
	fst	fr1, r3, 92
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fsqr
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	fld	fr2, r3, 64
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 92
	fadd	fr1, fr3, fr1
	fld	fr3, r3, 32
	fst	fr1, r3, 96
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fsqr
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	fld	fr2, r3, 56
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 96
	fadd	fr1, fr3, fr1
	ld	r2, r3, 0
	fst	fr1, r2, 8
	li	r31, 16384
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 104
	fld	fr1, r3, 104
	fld	fr3, r3, 52
	fld	fr4, r3, 72
	fmul	fr5, fr4, fr3
	fld	fr6, r3, 40
	fmul	fr5, fr5, fr6
	fld	fr7, r3, 48
	fld	fr8, r3, 64
	fmul	fr9, fr8, fr7
	fld	fr10, r3, 36
	fmul	fr9, fr9, fr10
	fadd	fr5, fr5, fr9
	fld	fr9, r3, 44
	fmul	fr11, fr2, fr9
	fld	fr12, r3, 32
	fmul	fr11, fr11, fr12
	fadd	fr5, fr5, fr11
	fmul	fr1, fr1, fr5
	ld	r2, r3, 4
	fst	fr1, r2, 0
	li	r31, 16384
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 104
	fld	fr1, r3, 104
	fld	fr5, r3, 28
	fmul	fr11, fr4, fr5
	fmul	fr6, fr11, fr6
	fld	fr11, r3, 68
	fmul	fr13, fr8, fr11
	fmul	fr10, fr13, fr10
	fadd	fr6, fr6, fr10
	fld	fr10, r3, 60
	fmul	fr13, fr2, fr10
	fmul	fr12, fr13, fr12
	fadd	fr6, fr6, fr12
	fmul	fr1, fr1, fr6
	fst	fr1, r2, 4
	li	r31, 16384
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 104
	fld	fr1, r3, 104
	fmul	fr4, fr4, fr5
	fmul	fr3, fr4, fr3
	fmul	fr4, fr8, fr11
	fmul	fr4, fr4, fr7
	fadd	fr3, fr3, fr4
	fmul	fr2, fr2, fr10
	fmul	fr2, fr2, fr9
	fadd	fr2, fr3, fr2
	fmul	fr1, fr1, fr2
	fst	fr1, r2, 8
	blr
read_nth_object.2563:
	ld	r5, r30, 4
	st	r5, r3, 0
	st	r2, r3, 4
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_read_int
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.8614
	li	r2, 0
	blr
beq_else.8614:
	st	r2, r3, 8
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_read_int
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	st	r2, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_read_int
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	st	r2, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_read_int
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 24
	fld	fr1, r3, 24
	st	r2, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	st	r2, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_read_float
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 24
	fst	fr1, r2, 0
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_read_float
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 24
	fst	fr1, r2, 4
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_read_float
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 24
	fst	fr1, r2, 8
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 32
	fld	fr1, r3, 32
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	st	r2, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_read_float
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	fst	fr1, r2, 0
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_read_float
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	fst	fr1, r2, 4
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_read_float
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	fst	fr1, r2, 8
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_read_float
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	fisneg.2392
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	li	r5, 2
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr1, r3, 40
	st	r2, r3, 32
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	st	r2, r3, 36
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_read_float
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 36
	fst	fr1, r2, 0
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_read_float
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 36
	fst	fr1, r2, 4
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 48
	fld	fr1, r3, 48
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	st	r2, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_read_float
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 40
	fst	fr1, r2, 0
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_read_float
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 40
	fst	fr1, r2, 4
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_read_float
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 40
	fst	fr1, r2, 8
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 48
	fld	fr1, r3, 48
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 20
	cmpwi	cr0, r5, 0
	bne	beq_else.8615
	b	beq_cont.8616
beq_else.8615:
	st	r2, r3, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_read_float
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	rad.2554
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	fst	fr1, r2, 0
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_read_float
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	rad.2554
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	fst	fr1, r2, 4
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_read_float
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	rad.2554
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	fst	fr1, r2, 8
beq_cont.8616:
	ld	r5, r3, 12
	cmpwi	cr0, r5, 2
	bne	beq_else.8617
	li	r6, 1
	b	beq_cont.8618
beq_else.8617:
	ld	r6, r3, 32
beq_cont.8618:
	li	r7, 4
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 56
	fld	fr1, r3, 56
	st	r6, r3, 48
	st	r2, r3, 44
	mflr	r31
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_float_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 48
	st	r2, r5, 40
	ld	r2, r3, 44
	st	r2, r5, 36
	ld	r6, r3, 40
	st	r6, r5, 32
	ld	r6, r3, 36
	st	r6, r5, 28
	ld	r6, r3, 48
	st	r6, r5, 24
	ld	r6, r3, 28
	st	r6, r5, 20
	ld	r6, r3, 24
	st	r6, r5, 16
	ld	r7, r3, 20
	st	r7, r5, 12
	ld	r8, r3, 16
	st	r8, r5, 8
	ld	r8, r3, 12
	st	r8, r5, 4
	ld	r9, r3, 8
	st	r9, r5, 0
	ld	r9, r3, 4
	slwi	r9, r9, 2
	ld	r10, r3, 0
	add	r31, r10, r9
	st	r5, r31, 0
	cmpwi	cr0, r8, 3
	bne	beq_else.8619
	fld	fr1, r6, 0
	fst	fr1, r3, 52
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	fiszero.2394
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8621
	fld	fr1, r3, 52
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	sgn.2429
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 52
	fst	fr1, r3, 56
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fsqr
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 56
	fdiv	fr1, fr2, fr1
	b	beq_cont.8622
beq_else.8621:
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 64
	fld	fr1, r3, 64
beq_cont.8622:
	ld	r2, r3, 24
	fst	fr1, r2, 0
	fld	fr1, r2, 4
	fst	fr1, r3, 60
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	fiszero.2394
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8623
	fld	fr1, r3, 60
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	sgn.2429
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 60
	fst	fr1, r3, 64
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_fsqr
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 64
	fdiv	fr1, fr2, fr1
	b	beq_cont.8624
beq_else.8623:
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 72
	fld	fr1, r3, 72
beq_cont.8624:
	ld	r2, r3, 24
	fst	fr1, r2, 4
	fld	fr1, r2, 8
	fst	fr1, r3, 68
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	fiszero.2394
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8625
	fld	fr1, r3, 68
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	sgn.2429
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 68
	fst	fr1, r3, 72
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_fsqr
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 72
	fdiv	fr1, fr2, fr1
	b	beq_cont.8626
beq_else.8625:
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 80
	fld	fr1, r3, 80
beq_cont.8626:
	ld	r2, r3, 24
	fst	fr1, r2, 8
	b	beq_cont.8620
beq_else.8619:
	cmpwi	cr0, r8, 2
	bne	beq_else.8627
	ld	r5, r3, 32
	cmpwi	cr0, r5, 0
	bne	beq_else.8629
	li	r5, 1
	b	beq_cont.8630
beq_else.8629:
	li	r5, 0
beq_cont.8630:
	mflr	r31
	mr	r2, r6
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	vecunit_sgn.2455
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	b	beq_cont.8628
beq_else.8627:
beq_cont.8628:
beq_cont.8620:
	ld	r2, r3, 20
	cmpwi	cr0, r2, 0
	bne	beq_else.8631
	b	beq_cont.8632
beq_else.8631:
	ld	r2, r3, 24
	ld	r5, r3, 44
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	rotate_quadratic_matrix.2560
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
beq_cont.8632:
	li	r2, 1
	blr
read_object.2565:
	ld	r5, r30, 8
	ld	r6, r30, 4
	cmpwi	cr0, r2, 60
	blt	bge_else.8633
	blr
bge_else.8633:
	st	r30, r3, 0
	st	r6, r3, 4
	st	r2, r3, 8
	mflr	r31
	mr	r30, r5
	st	r31, r3, 12
	addi	r3, r3, 16
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8635
	ld	r2, r3, 4
	ld	r5, r3, 8
	st	r5, r2, 0
	blr
beq_else.8635:
	ld	r2, r3, 8
	addi	r2, r2, 1
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
read_all_object.2567:
	ld	r30, r30, 4
	li	r2, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
read_net_item.2569:
	st	r2, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_read_int
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.8637
	ld	r2, r3, 0
	addi	r2, r2, 1
	li	r5, -1
	b	min_caml_create_array
beq_else.8637:
	ld	r5, r3, 0
	addi	r6, r5, 1
	st	r2, r3, 4
	mflr	r31
	mr	r2, r6
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	read_net_item.2569
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 0
	slwi	r5, r5, 2
	ld	r6, r3, 4
	add	r31, r2, r5
	st	r6, r31, 0
	blr
read_or_network.2571:
	li	r5, 0
	st	r2, r3, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	read_net_item.2569
	addi	r3, r3, -8
	ld	r31, r3, 4
	mr	r5, r2
	mtlr	r31
	ld	r2, r5, 0
	cmpwi	cr0, r2, -1
	bne	beq_else.8638
	ld	r2, r3, 0
	addi	r2, r2, 1
	b	min_caml_create_array
beq_else.8638:
	ld	r2, r3, 0
	addi	r6, r2, 1
	st	r5, r3, 4
	mflr	r31
	mr	r2, r6
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	read_or_network.2571
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 0
	slwi	r5, r5, 2
	ld	r6, r3, 4
	add	r31, r2, r5
	st	r6, r31, 0
	blr
read_and_network.2573:
	ld	r5, r30, 4
	li	r6, 0
	st	r30, r3, 0
	st	r5, r3, 4
	st	r2, r3, 8
	mflr	r31
	mr	r2, r6
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	read_net_item.2569
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r2, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.8639
	blr
beq_else.8639:
	ld	r5, r3, 8
	slwi	r6, r5, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, 1
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
read_parameter.2575:
	ld	r2, r30, 20
	ld	r5, r30, 16
	ld	r6, r30, 12
	ld	r7, r30, 8
	ld	r8, r30, 4
	st	r8, r3, 0
	st	r6, r3, 4
	st	r7, r3, 8
	st	r5, r3, 12
	mflr	r31
	mr	r30, r2
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r30, r3, 8
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r2, 0
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r2, 0
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	read_or_network.2571
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 0
	st	r2, r5, 0
	blr
solver_rect_surface.2577:
	ld	r9, r30, 4
	slwi	r10, r6, 2
	add	r5, r5, r10
	fld	fr4, r5, 0
	sub	r5, r5, r10
	st	r9, r3, 0
	fst	fr3, r3, 4
	st	r8, r3, 8
	fst	fr2, r3, 12
	st	r7, r3, 16
	fst	fr1, r3, 20
	st	r5, r3, 24
	st	r6, r3, 28
	st	r2, r3, 32
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	fiszero.2394
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8642
	ld	r2, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_abc.2499
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 32
	st	r2, r3, 36
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_isinvert.2489
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 28
	slwi	r6, r5, 2
	ld	r7, r3, 24
	add	r7, r7, r6
	fld	fr1, r7, 0
	sub	r7, r7, r6
	st	r2, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	fisneg.2392
	addi	r3, r3, -48
	ld	r31, r3, 44
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	xor.2426
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 28
	slwi	r6, r5, 2
	ld	r7, r3, 36
	add	r7, r7, r6
	fld	fr1, r7, 0
	sub	r7, r7, r6
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	fneg_cond.2431
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 20
	fsub	fr1, fr1, fr2
	ld	r2, r3, 28
	slwi	r2, r2, 2
	ld	r5, r3, 24
	add	r5, r5, r2
	fld	fr2, r5, 0
	sub	r5, r5, r2
	fdiv	fr1, fr1, fr2
	ld	r2, r3, 16
	slwi	r6, r2, 2
	ld	r7, r3, 36
	add	r7, r7, r6
	fld	fr2, r7, 0
	sub	r7, r7, r6
	slwi	r2, r2, 2
	add	r5, r5, r2
	fld	fr3, r5, 0
	sub	r5, r5, r2
	fmul	fr3, fr1, fr3
	fld	fr4, r3, 12
	fadd	fr3, fr3, fr4
	fst	fr1, r3, 44
	fst	fr2, r3, 48
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fabs
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 48
	fcmp	cr0, fr2, fr1
	blt	le.8643
	beq	le.8643
	ld	r2, r3, 8
	slwi	r5, r2, 2
	ld	r6, r3, 36
	add	r6, r6, r5
	fld	fr1, r6, 0
	sub	r6, r6, r5
	slwi	r2, r2, 2
	ld	r5, r3, 24
	add	r5, r5, r2
	fld	fr2, r5, 0
	sub	r5, r5, r2
	fld	fr3, r3, 44
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 4
	fadd	fr2, fr2, fr4
	fst	fr1, r3, 52
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fabs
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 52
	fcmp	cr0, fr2, fr1
	blt	le.8644
	beq	le.8644
	ld	r2, r3, 0
	fld	fr1, r3, 44
	fst	fr1, r2, 0
	li	r2, 1
	blr
le.8644:
	li	r2, 0
	blr
le.8643:
	li	r2, 0
	blr
beq_else.8642:
	li	r2, 0
	blr
solver_rect.2586:
	ld	r30, r30, 4
	li	r6, 0
	li	r7, 1
	li	r8, 2
	fst	fr1, r3, 0
	fst	fr3, r3, 4
	fst	fr2, r3, 8
	st	r5, r3, 12
	st	r2, r3, 16
	st	r30, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8645
	li	r6, 1
	li	r7, 2
	li	r8, 0
	fld	fr1, r3, 8
	fld	fr2, r3, 4
	fld	fr3, r3, 0
	ld	r2, r3, 16
	ld	r5, r3, 12
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8646
	li	r6, 2
	li	r7, 0
	li	r8, 1
	fld	fr1, r3, 4
	fld	fr2, r3, 0
	fld	fr3, r3, 8
	ld	r2, r3, 16
	ld	r5, r3, 12
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8647
	li	r2, 0
	blr
beq_else.8647:
	li	r2, 3
	blr
beq_else.8646:
	li	r2, 2
	blr
beq_else.8645:
	li	r2, 1
	blr
solver_surface.2592:
	ld	r6, r30, 4
	st	r6, r3, 0
	fst	fr3, r3, 4
	fst	fr2, r3, 8
	fst	fr1, r3, 12
	st	r5, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_param_abc.2499
	addi	r3, r3, -24
	ld	r31, r3, 20
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	st	r5, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	veciprod.2458
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fst	fr1, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	fispos.2390
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8648
	li	r2, 0
	blr
beq_else.8648:
	fld	fr1, r3, 12
	fld	fr2, r3, 8
	fld	fr3, r3, 4
	ld	r2, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	veciprod2.2461
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fsub	fr1, fr0, fr1
	fld	fr2, r3, 24
	fdiv	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 0
	li	r2, 1
	blr
quadratic.2598:
	fst	fr1, r3, 0
	fst	fr3, r3, 4
	fst	fr2, r3, 8
	st	r2, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_fsqr
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 12
	fst	fr1, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_param_a.2493
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 16
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 8
	fst	fr1, r3, 20
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_fsqr
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 12
	fst	fr1, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_param_b.2495
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 24
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 20
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 4
	fst	fr1, r3, 28
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fsqr
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 12
	fst	fr1, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_c.2497
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 32
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 28
	fadd	fr1, fr2, fr1
	ld	r2, r3, 12
	fst	fr1, r3, 36
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_isrot.2491
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8649
	fld	fr1, r3, 36
	blr
beq_else.8649:
	fld	fr1, r3, 4
	fld	fr2, r3, 8
	fmul	fr3, fr2, fr1
	ld	r2, r3, 12
	fst	fr3, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_param_r1.2517
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 40
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 36
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 0
	fld	fr3, r3, 4
	fmul	fr3, fr3, fr2
	ld	r2, r3, 12
	fst	fr1, r3, 44
	fst	fr3, r3, 48
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	o_param_r2.2519
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 48
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 44
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 8
	fld	fr3, r3, 0
	fmul	fr2, fr3, fr2
	ld	r2, r3, 12
	fst	fr1, r3, 52
	fst	fr2, r3, 56
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	o_param_r3.2521
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 56
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 52
	fadd	fr1, fr2, fr1
	blr
bilinear.2603:
	fmul	fr7, fr1, fr4
	fst	fr4, r3, 0
	fst	fr1, r3, 4
	fst	fr6, r3, 8
	fst	fr3, r3, 12
	st	r2, r3, 16
	fst	fr5, r3, 20
	fst	fr2, r3, 24
	fst	fr7, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_a.2493
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 28
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 20
	fld	fr3, r3, 24
	fmul	fr4, fr3, fr2
	ld	r2, r3, 16
	fst	fr1, r3, 32
	fst	fr4, r3, 36
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_param_b.2495
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 36
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 32
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 8
	fld	fr3, r3, 12
	fmul	fr4, fr3, fr2
	ld	r2, r3, 16
	fst	fr1, r3, 40
	fst	fr4, r3, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	o_param_c.2497
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 44
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 40
	fadd	fr1, fr2, fr1
	ld	r2, r3, 16
	fst	fr1, r3, 48
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	o_isrot.2491
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8650
	fld	fr1, r3, 48
	blr
beq_else.8650:
	fld	fr1, r3, 20
	fld	fr2, r3, 12
	fmul	fr3, fr2, fr1
	fld	fr4, r3, 8
	fld	fr5, r3, 24
	fmul	fr6, fr5, fr4
	fadd	fr3, fr3, fr6
	ld	r2, r3, 16
	fst	fr3, r3, 52
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	o_param_r1.2517
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 52
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 8
	fld	fr3, r3, 4
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 0
	fld	fr5, r3, 12
	fmul	fr5, fr5, fr4
	fadd	fr2, fr2, fr5
	ld	r2, r3, 16
	fst	fr1, r3, 56
	fst	fr2, r3, 60
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	o_param_r2.2519
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 60
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 56
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 20
	fld	fr3, r3, 4
	fmul	fr2, fr3, fr2
	fld	fr3, r3, 0
	fld	fr4, r3, 24
	fmul	fr3, fr4, fr3
	fadd	fr2, fr2, fr3
	ld	r2, r3, 16
	fst	fr1, r3, 64
	fst	fr2, r3, 68
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	o_param_r3.2521
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 68
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 64
	fadd	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_fhalf
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 48
	fadd	fr1, fr2, fr1
	blr
solver_second.2611:
	ld	r6, r30, 4
	fld	fr4, r5, 0
	fld	fr5, r5, 4
	fld	fr6, r5, 8
	st	r6, r3, 0
	fst	fr3, r3, 4
	fst	fr2, r3, 8
	fst	fr1, r3, 12
	st	r2, r3, 16
	st	r5, r3, 20
	mflr	r31
	fmr	fr3, fr6
	fmr	fr2, fr5
	fmr	fr1, fr4
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	quadratic.2598
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fst	fr1, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	fiszero.2394
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8651
	ld	r2, r3, 20
	fld	fr1, r2, 0
	fld	fr2, r2, 4
	fld	fr3, r2, 8
	fld	fr4, r3, 12
	fld	fr5, r3, 8
	fld	fr6, r3, 4
	ld	r2, r3, 16
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	bilinear.2603
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 12
	fld	fr3, r3, 8
	fld	fr4, r3, 4
	ld	r2, r3, 16
	fst	fr1, r3, 28
	mflr	r31
	fmr	fr1, fr2
	fmr	fr2, fr3
	fmr	fr3, fr4
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	quadratic.2598
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 16
	fst	fr1, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_form.2485
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	cmpwi	cr0, r2, 3
	bne	beq_else.8652
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr1, r3, 40
	fld	fr2, r3, 32
	fsub	fr1, fr2, fr1
	b	beq_cont.8653
beq_else.8652:
	fld	fr1, r3, 32
beq_cont.8653:
	fld	fr2, r3, 28
	fst	fr1, r3, 36
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_fsqr
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 36
	fld	fr3, r3, 24
	fmul	fr2, fr3, fr2
	fsub	fr1, fr1, fr2
	fst	fr1, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	fispos.2390
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8654
	li	r2, 0
	blr
beq_else.8654:
	fld	fr1, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_sqrt
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 16
	fst	fr1, r3, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	o_isinvert.2489
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8655
	fld	fr1, r3, 44
	fsub	fr1, fr0, fr1
	b	beq_cont.8656
beq_else.8655:
	fld	fr1, r3, 44
beq_cont.8656:
	fld	fr2, r3, 28
	fsub	fr1, fr1, fr2
	fld	fr2, r3, 24
	fdiv	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 0
	li	r2, 1
	blr
beq_else.8651:
	li	r2, 0
	blr
solver.2617:
	ld	r7, r30, 16
	ld	r8, r30, 12
	ld	r9, r30, 8
	ld	r10, r30, 4
	slwi	r2, r2, 2
	add	r31, r10, r2
	ld	r2, r31, 0
	fld	fr1, r6, 0
	st	r8, r3, 0
	st	r7, r3, 4
	st	r5, r3, 8
	st	r9, r3, 12
	st	r2, r3, 16
	st	r6, r3, 20
	fst	fr1, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_param_x.2501
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 24
	fsub	fr1, fr2, fr1
	ld	r2, r3, 20
	fld	fr2, r2, 4
	ld	r5, r3, 16
	fst	fr1, r3, 28
	fst	fr2, r3, 32
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_y.2503
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 32
	fsub	fr1, fr2, fr1
	ld	r2, r3, 20
	fld	fr2, r2, 8
	ld	r2, r3, 16
	fst	fr1, r3, 36
	fst	fr2, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_param_z.2505
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 40
	fsub	fr1, fr2, fr1
	ld	r2, r3, 16
	fst	fr1, r3, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	o_form.2485
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, 1
	bne	beq_else.8657
	fld	fr1, r3, 28
	fld	fr2, r3, 36
	fld	fr3, r3, 44
	ld	r2, r3, 16
	ld	r5, r3, 8
	ld	r30, r3, 12
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8657:
	cmpwi	cr0, r2, 2
	bne	beq_else.8658
	fld	fr1, r3, 28
	fld	fr2, r3, 36
	fld	fr3, r3, 44
	ld	r2, r3, 16
	ld	r5, r3, 8
	ld	r30, r3, 4
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8658:
	fld	fr1, r3, 28
	fld	fr2, r3, 36
	fld	fr3, r3, 44
	ld	r2, r3, 16
	ld	r5, r3, 8
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
solver_rect_fast.2621:
	ld	r7, r30, 4
	fld	fr4, r6, 0
	fsub	fr4, fr4, fr1
	fld	fr5, r6, 4
	fmul	fr4, fr4, fr5
	st	r7, r3, 0
	fst	fr1, r3, 4
	st	r6, r3, 8
	fst	fr3, r3, 12
	st	r2, r3, 16
	fst	fr2, r3, 20
	fst	fr4, r3, 24
	st	r5, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_b.2495
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	fld	fr2, r2, 4
	fld	fr3, r3, 24
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 20
	fadd	fr2, fr2, fr4
	fst	fr1, r3, 32
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fabs
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 32
	fcmp	cr0, fr2, fr1
	blt	le.8659
	beq	le.8659
	ld	r2, r3, 16
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_c.2497
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	fld	fr2, r2, 8
	fld	fr3, r3, 24
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 12
	fadd	fr2, fr2, fr4
	fst	fr1, r3, 36
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_fabs
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 36
	fcmp	cr0, fr2, fr1
	blt	le.8661
	beq	le.8661
	ld	r2, r3, 8
	fld	fr1, r2, 4
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	fiszero.2394
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8663
	li	r2, 1
	b	beq_cont.8664
beq_else.8663:
	li	r2, 0
beq_cont.8664:
	b	gt_cont.8662
le.8661:
	li	r2, 0
gt_cont.8662:
	b	gt_cont.8660
le.8659:
	li	r2, 0
gt_cont.8660:
	cmpwi	cr0, r2, 0
	bne	beq_else.8665
	ld	r2, r3, 8
	fld	fr1, r2, 8
	fld	fr2, r3, 20
	fsub	fr1, fr1, fr2
	fld	fr3, r2, 12
	fmul	fr1, fr1, fr3
	ld	r5, r3, 16
	fst	fr1, r3, 40
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_param_a.2493
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 28
	fld	fr2, r2, 0
	fld	fr3, r3, 40
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 4
	fadd	fr2, fr2, fr4
	fst	fr1, r3, 44
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fabs
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 44
	fcmp	cr0, fr2, fr1
	blt	le.8666
	beq	le.8666
	ld	r2, r3, 16
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	o_param_c.2497
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 28
	fld	fr2, r2, 8
	fld	fr3, r3, 40
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 12
	fadd	fr2, fr2, fr4
	fst	fr1, r3, 48
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fabs
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 48
	fcmp	cr0, fr2, fr1
	blt	le.8668
	beq	le.8668
	ld	r2, r3, 8
	fld	fr1, r2, 12
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	fiszero.2394
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8670
	li	r2, 1
	b	beq_cont.8671
beq_else.8670:
	li	r2, 0
beq_cont.8671:
	b	gt_cont.8669
le.8668:
	li	r2, 0
gt_cont.8669:
	b	gt_cont.8667
le.8666:
	li	r2, 0
gt_cont.8667:
	cmpwi	cr0, r2, 0
	bne	beq_else.8672
	ld	r2, r3, 8
	fld	fr1, r2, 16
	fld	fr2, r3, 12
	fsub	fr1, fr1, fr2
	fld	fr2, r2, 20
	fmul	fr1, fr1, fr2
	ld	r5, r3, 16
	fst	fr1, r3, 52
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	o_param_a.2493
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 28
	fld	fr2, r2, 0
	fld	fr3, r3, 52
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 4
	fadd	fr2, fr2, fr4
	fst	fr1, r3, 56
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fabs
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 56
	fcmp	cr0, fr2, fr1
	blt	le.8673
	beq	le.8673
	ld	r2, r3, 16
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	o_param_b.2495
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 28
	fld	fr2, r2, 4
	fld	fr3, r3, 52
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 20
	fadd	fr2, fr2, fr4
	fst	fr1, r3, 60
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_fabs
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 60
	fcmp	cr0, fr2, fr1
	blt	le.8675
	beq	le.8675
	ld	r2, r3, 8
	fld	fr1, r2, 20
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	fiszero.2394
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8677
	li	r2, 1
	b	beq_cont.8678
beq_else.8677:
	li	r2, 0
beq_cont.8678:
	b	gt_cont.8676
le.8675:
	li	r2, 0
gt_cont.8676:
	b	gt_cont.8674
le.8673:
	li	r2, 0
gt_cont.8674:
	cmpwi	cr0, r2, 0
	bne	beq_else.8679
	li	r2, 0
	blr
beq_else.8679:
	ld	r2, r3, 0
	fld	fr1, r3, 52
	fst	fr1, r2, 0
	li	r2, 3
	blr
beq_else.8672:
	ld	r2, r3, 0
	fld	fr1, r3, 40
	fst	fr1, r2, 0
	li	r2, 2
	blr
beq_else.8665:
	ld	r2, r3, 0
	fld	fr1, r3, 24
	fst	fr1, r2, 0
	li	r2, 1
	blr
solver_surface_fast.2628:
	ld	r2, r30, 4
	fld	fr4, r5, 0
	st	r2, r3, 0
	fst	fr3, r3, 4
	fst	fr2, r3, 8
	fst	fr1, r3, 12
	st	r5, r3, 16
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	fisneg.2392
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8680
	li	r2, 0
	blr
beq_else.8680:
	ld	r2, r3, 16
	fld	fr1, r2, 4
	fld	fr2, r3, 12
	fmul	fr1, fr1, fr2
	fld	fr2, r2, 8
	fld	fr3, r3, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r2, 12
	fld	fr3, r3, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 0
	li	r2, 1
	blr
solver_second_fast.2634:
	ld	r6, r30, 4
	fld	fr4, r5, 0
	st	r6, r3, 0
	fst	fr4, r3, 4
	st	r2, r3, 8
	fst	fr3, r3, 12
	fst	fr2, r3, 16
	fst	fr1, r3, 20
	st	r5, r3, 24
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	fiszero.2394
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8681
	ld	r2, r3, 24
	fld	fr1, r2, 4
	fld	fr2, r3, 20
	fmul	fr1, fr1, fr2
	fld	fr3, r2, 8
	fld	fr4, r3, 16
	fmul	fr3, fr3, fr4
	fadd	fr1, fr1, fr3
	fld	fr3, r2, 12
	fld	fr5, r3, 12
	fmul	fr3, fr3, fr5
	fadd	fr1, fr1, fr3
	ld	r5, r3, 8
	fst	fr1, r3, 28
	mflr	r31
	mr	r2, r5
	fmr	fr3, fr5
	fmr	fr1, fr2
	fmr	fr2, fr4
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	quadratic.2598
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 8
	fst	fr1, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_form.2485
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	cmpwi	cr0, r2, 3
	bne	beq_else.8682
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr1, r3, 40
	fld	fr2, r3, 32
	fsub	fr1, fr2, fr1
	b	beq_cont.8683
beq_else.8682:
	fld	fr1, r3, 32
beq_cont.8683:
	fld	fr2, r3, 28
	fst	fr1, r3, 36
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_fsqr
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 36
	fld	fr3, r3, 4
	fmul	fr2, fr3, fr2
	fsub	fr1, fr1, fr2
	fst	fr1, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	fispos.2390
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8684
	li	r2, 0
	blr
beq_else.8684:
	ld	r2, r3, 8
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_isinvert.2489
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8685
	fld	fr1, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_sqrt
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 28
	fsub	fr1, fr2, fr1
	ld	r2, r3, 24
	fld	fr2, r2, 16
	fmul	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 0
	b	beq_cont.8686
beq_else.8685:
	fld	fr1, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_sqrt
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 28
	fadd	fr1, fr2, fr1
	ld	r2, r3, 24
	fld	fr2, r2, 16
	fmul	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 0
beq_cont.8686:
	li	r2, 1
	blr
beq_else.8681:
	li	r2, 0
	blr
solver_fast.2640:
	ld	r7, r30, 16
	ld	r8, r30, 12
	ld	r9, r30, 8
	ld	r10, r30, 4
	slwi	r11, r2, 2
	add	r31, r10, r11
	ld	r10, r31, 0
	fld	fr1, r6, 0
	st	r8, r3, 0
	st	r7, r3, 4
	st	r9, r3, 8
	st	r2, r3, 12
	st	r5, r3, 16
	st	r10, r3, 20
	st	r6, r3, 24
	fst	fr1, r3, 28
	mflr	r31
	mr	r2, r10
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_x.2501
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 28
	fsub	fr1, fr2, fr1
	ld	r2, r3, 24
	fld	fr2, r2, 4
	ld	r5, r3, 20
	fst	fr1, r3, 32
	fst	fr2, r3, 36
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_param_y.2503
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 36
	fsub	fr1, fr2, fr1
	ld	r2, r3, 24
	fld	fr2, r2, 8
	ld	r2, r3, 20
	fst	fr1, r3, 40
	fst	fr2, r3, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	o_param_z.2505
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 44
	fsub	fr1, fr2, fr1
	ld	r2, r3, 16
	fst	fr1, r3, 48
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	d_const.2546
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r5, r3, 12
	slwi	r5, r5, 2
	add	r31, r2, r5
	ld	r2, r31, 0
	ld	r5, r3, 20
	st	r2, r3, 52
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	o_form.2485
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, 1
	bne	beq_else.8687
	ld	r2, r3, 16
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	d_vec.2544
	addi	r3, r3, -64
	ld	r31, r3, 60
	mr	r5, r2
	mtlr	r31
	fld	fr1, r3, 32
	fld	fr2, r3, 40
	fld	fr3, r3, 48
	ld	r2, r3, 20
	ld	r6, r3, 52
	ld	r30, r3, 8
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8687:
	cmpwi	cr0, r2, 2
	bne	beq_else.8688
	fld	fr1, r3, 32
	fld	fr2, r3, 40
	fld	fr3, r3, 48
	ld	r2, r3, 20
	ld	r5, r3, 52
	ld	r30, r3, 4
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8688:
	fld	fr1, r3, 32
	fld	fr2, r3, 40
	fld	fr3, r3, 48
	ld	r2, r3, 20
	ld	r5, r3, 52
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
solver_surface_fast2.2644:
	ld	r2, r30, 4
	fld	fr1, r5, 0
	st	r2, r3, 0
	st	r6, r3, 4
	st	r5, r3, 8
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	fisneg.2392
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8689
	li	r2, 0
	blr
beq_else.8689:
	ld	r2, r3, 8
	fld	fr1, r2, 0
	ld	r2, r3, 4
	fld	fr2, r2, 12
	fmul	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 0
	li	r2, 1
	blr
solver_second_fast2.2651:
	ld	r7, r30, 4
	fld	fr4, r5, 0
	st	r7, r3, 0
	st	r2, r3, 4
	fst	fr4, r3, 8
	st	r6, r3, 12
	fst	fr3, r3, 16
	fst	fr2, r3, 20
	fst	fr1, r3, 24
	st	r5, r3, 28
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	fiszero.2394
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8690
	ld	r2, r3, 28
	fld	fr1, r2, 4
	fld	fr2, r3, 24
	fmul	fr1, fr1, fr2
	fld	fr2, r2, 8
	fld	fr3, r3, 20
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r2, 12
	fld	fr3, r3, 16
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	ld	r5, r3, 12
	fld	fr2, r5, 12
	fst	fr1, r3, 32
	fst	fr2, r3, 36
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_fsqr
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 36
	fld	fr3, r3, 8
	fmul	fr2, fr3, fr2
	fsub	fr1, fr1, fr2
	fst	fr1, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	fispos.2390
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8691
	li	r2, 0
	blr
beq_else.8691:
	ld	r2, r3, 4
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_isinvert.2489
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8692
	fld	fr1, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_sqrt
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 32
	fsub	fr1, fr2, fr1
	ld	r2, r3, 28
	fld	fr2, r2, 16
	fmul	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 0
	b	beq_cont.8693
beq_else.8692:
	fld	fr1, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_sqrt
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 32
	fadd	fr1, fr2, fr1
	ld	r2, r3, 28
	fld	fr2, r2, 16
	fmul	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 0
beq_cont.8693:
	li	r2, 1
	blr
beq_else.8690:
	li	r2, 0
	blr
solver_fast2.2658:
	ld	r6, r30, 16
	ld	r7, r30, 12
	ld	r8, r30, 8
	ld	r9, r30, 4
	slwi	r10, r2, 2
	add	r31, r9, r10
	ld	r9, r31, 0
	st	r7, r3, 0
	st	r6, r3, 4
	st	r8, r3, 8
	st	r9, r3, 12
	st	r2, r3, 16
	st	r5, r3, 20
	mflr	r31
	mr	r2, r9
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_param_ctbl.2523
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr1, r2, 0
	fld	fr2, r2, 4
	fld	fr3, r2, 8
	ld	r5, r3, 20
	st	r2, r3, 24
	fst	fr3, r3, 28
	fst	fr2, r3, 32
	fst	fr1, r3, 36
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	d_const.2546
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 16
	slwi	r5, r5, 2
	add	r31, r2, r5
	ld	r2, r31, 0
	ld	r5, r3, 12
	st	r2, r3, 40
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_form.2485
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, 1
	bne	beq_else.8694
	ld	r2, r3, 20
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	d_vec.2544
	addi	r3, r3, -48
	ld	r31, r3, 44
	mr	r5, r2
	mtlr	r31
	fld	fr1, r3, 36
	fld	fr2, r3, 32
	fld	fr3, r3, 28
	ld	r2, r3, 12
	ld	r6, r3, 40
	ld	r30, r3, 8
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8694:
	cmpwi	cr0, r2, 2
	bne	beq_else.8695
	fld	fr1, r3, 36
	fld	fr2, r3, 32
	fld	fr3, r3, 28
	ld	r2, r3, 12
	ld	r5, r3, 40
	ld	r6, r3, 24
	ld	r30, r3, 4
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8695:
	fld	fr1, r3, 36
	fld	fr2, r3, 32
	fld	fr3, r3, 28
	ld	r2, r3, 12
	ld	r5, r3, 40
	ld	r6, r3, 24
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
setup_rect_table.2661:
	li	r6, 6
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	st	r5, r3, 0
	st	r2, r3, 4
	mflr	r31
	mr	r2, r6
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 4
	fld	fr1, r5, 0
	st	r2, r3, 8
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	fiszero.2394
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8696
	ld	r2, r3, 0
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	o_isinvert.2489
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 4
	fld	fr1, r5, 0
	st	r2, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	fisneg.2392
	addi	r3, r3, -24
	ld	r31, r3, 20
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	xor.2426
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 0
	st	r2, r3, 16
	mflr	r31
	mr	r2, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_param_a.2493
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	fneg_cond.2431
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 8
	fst	fr1, r2, 0
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 24
	fld	fr1, r3, 24
	ld	r5, r3, 4
	fld	fr2, r5, 0
	fdiv	fr1, fr1, fr2
	fst	fr1, r2, 4
	b	beq_cont.8697
beq_else.8696:
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 24
	fld	fr1, r3, 24
	ld	r2, r3, 8
	fst	fr1, r2, 4
beq_cont.8697:
	ld	r5, r3, 4
	fld	fr1, r5, 4
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	fiszero.2394
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8698
	ld	r2, r3, 0
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_isinvert.2489
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 4
	fld	fr1, r5, 4
	st	r2, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	fisneg.2392
	addi	r3, r3, -32
	ld	r31, r3, 28
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	xor.2426
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 0
	st	r2, r3, 24
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_param_b.2495
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	fneg_cond.2431
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 8
	fst	fr1, r2, 8
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 32
	fld	fr1, r3, 32
	ld	r5, r3, 4
	fld	fr2, r5, 4
	fdiv	fr1, fr1, fr2
	fst	fr1, r2, 12
	b	beq_cont.8699
beq_else.8698:
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 32
	fld	fr1, r3, 32
	ld	r2, r3, 8
	fst	fr1, r2, 12
beq_cont.8699:
	ld	r5, r3, 4
	fld	fr1, r5, 8
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	fiszero.2394
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8700
	ld	r2, r3, 0
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_isinvert.2489
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 4
	fld	fr1, r5, 8
	st	r2, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	fisneg.2392
	addi	r3, r3, -40
	ld	r31, r3, 36
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	xor.2426
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 0
	st	r2, r3, 32
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_c.2497
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	fneg_cond.2431
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 8
	fst	fr1, r2, 16
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr1, r3, 40
	ld	r5, r3, 4
	fld	fr2, r5, 8
	fdiv	fr1, fr1, fr2
	fst	fr1, r2, 20
	b	beq_cont.8701
beq_else.8700:
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr1, r3, 40
	ld	r2, r3, 8
	fst	fr1, r2, 20
beq_cont.8701:
	blr
setup_surface_table.2664:
	li	r6, 4
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	st	r5, r3, 0
	st	r2, r3, 4
	mflr	r31
	mr	r2, r6
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 4
	fld	fr1, r5, 0
	ld	r6, r3, 0
	st	r2, r3, 8
	fst	fr1, r3, 12
	mflr	r31
	mr	r2, r6
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_param_a.2493
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 12
	fmul	fr1, fr2, fr1
	ld	r2, r3, 4
	fld	fr2, r2, 4
	ld	r5, r3, 0
	fst	fr1, r3, 16
	fst	fr2, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_param_b.2495
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 20
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 16
	fadd	fr1, fr2, fr1
	ld	r2, r3, 4
	fld	fr2, r2, 8
	ld	r2, r3, 0
	fst	fr1, r3, 24
	fst	fr2, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_c.2497
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 28
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 24
	fadd	fr1, fr2, fr1
	fst	fr1, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	fispos.2390
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8702
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr1, r3, 40
	ld	r2, r3, 8
	fst	fr1, r2, 0
	b	beq_cont.8703
beq_else.8702:
	li	r31, 49024
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr1, r3, 40
	fld	fr2, r3, 32
	fdiv	fr1, fr1, fr2
	ld	r2, r3, 8
	fst	fr1, r2, 0
	ld	r5, r3, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_a.2493
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 32
	fdiv	fr1, fr1, fr2
	fsub	fr1, fr0, fr1
	ld	r2, r3, 8
	fst	fr1, r2, 4
	ld	r5, r3, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_b.2495
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 32
	fdiv	fr1, fr1, fr2
	fsub	fr1, fr0, fr1
	ld	r2, r3, 8
	fst	fr1, r2, 8
	ld	r5, r3, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_c.2497
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 32
	fdiv	fr1, fr1, fr2
	fsub	fr1, fr0, fr1
	ld	r2, r3, 8
	fst	fr1, r2, 12
beq_cont.8703:
	blr
setup_second_table.2667:
	li	r6, 5
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	st	r5, r3, 0
	st	r2, r3, 4
	mflr	r31
	mr	r2, r6
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 4
	fld	fr1, r5, 0
	fld	fr2, r5, 4
	fld	fr3, r5, 8
	ld	r6, r3, 0
	st	r2, r3, 8
	mflr	r31
	mr	r2, r6
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	quadratic.2598
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r2, r3, 4
	fld	fr2, r2, 0
	ld	r5, r3, 0
	fst	fr1, r3, 12
	fst	fr2, r3, 16
	mflr	r31
	mr	r2, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_param_a.2493
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 16
	fmul	fr1, fr2, fr1
	fsub	fr1, fr0, fr1
	ld	r2, r3, 4
	fld	fr2, r2, 4
	ld	r5, r3, 0
	fst	fr1, r3, 20
	fst	fr2, r3, 24
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_param_b.2495
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 24
	fmul	fr1, fr2, fr1
	fsub	fr1, fr0, fr1
	ld	r2, r3, 4
	fld	fr2, r2, 8
	ld	r5, r3, 0
	fst	fr1, r3, 28
	fst	fr2, r3, 32
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_c.2497
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 32
	fmul	fr1, fr2, fr1
	fsub	fr1, fr0, fr1
	ld	r2, r3, 8
	fld	fr2, r3, 12
	fst	fr2, r2, 0
	ld	r5, r3, 0
	fst	fr1, r3, 36
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_isrot.2491
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8704
	ld	r2, r3, 8
	fld	fr1, r3, 20
	fst	fr1, r2, 4
	fld	fr1, r3, 28
	fst	fr1, r2, 8
	fld	fr1, r3, 36
	fst	fr1, r2, 12
	b	beq_cont.8705
beq_else.8704:
	ld	r2, r3, 4
	fld	fr1, r2, 8
	ld	r5, r3, 0
	fst	fr1, r3, 40
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_param_r2.2519
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 40
	fmul	fr1, fr2, fr1
	ld	r2, r3, 4
	fld	fr2, r2, 4
	ld	r5, r3, 0
	fst	fr1, r3, 44
	fst	fr2, r3, 48
	mflr	r31
	mr	r2, r5
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	o_param_r3.2521
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 48
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 44
	fadd	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fhalf
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 20
	fsub	fr1, fr2, fr1
	ld	r2, r3, 8
	fst	fr1, r2, 4
	ld	r5, r3, 4
	fld	fr1, r5, 8
	ld	r6, r3, 0
	fst	fr1, r3, 52
	mflr	r31
	mr	r2, r6
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	o_param_r1.2517
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 52
	fmul	fr1, fr2, fr1
	ld	r2, r3, 4
	fld	fr2, r2, 0
	ld	r5, r3, 0
	fst	fr1, r3, 56
	fst	fr2, r3, 60
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	o_param_r3.2521
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 60
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 56
	fadd	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_fhalf
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 28
	fsub	fr1, fr2, fr1
	ld	r2, r3, 8
	fst	fr1, r2, 8
	ld	r5, r3, 4
	fld	fr1, r5, 4
	ld	r6, r3, 0
	fst	fr1, r3, 64
	mflr	r31
	mr	r2, r6
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	o_param_r1.2517
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 64
	fmul	fr1, fr2, fr1
	ld	r2, r3, 4
	fld	fr2, r2, 0
	ld	r2, r3, 0
	fst	fr1, r3, 68
	fst	fr2, r3, 72
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	o_param_r2.2519
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 72
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 68
	fadd	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_fhalf
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 36
	fsub	fr1, fr2, fr1
	ld	r2, r3, 8
	fst	fr1, r2, 12
beq_cont.8705:
	fld	fr1, r3, 12
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	fiszero.2394
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8706
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 80
	fld	fr1, r3, 80
	fld	fr2, r3, 12
	fdiv	fr1, fr1, fr2
	ld	r2, r3, 8
	fst	fr1, r2, 16
	b	beq_cont.8707
beq_else.8706:
beq_cont.8707:
	ld	r2, r3, 8
	blr
iter_setup_dirvec_constants.2670:
	ld	r6, r30, 4
	cmpwi	cr0, r5, 0
	blt	bge_else.8708
	slwi	r7, r5, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	st	r30, r3, 0
	st	r5, r3, 4
	st	r6, r3, 8
	st	r2, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	d_const.2546
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	st	r2, r3, 16
	mflr	r31
	mr	r2, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	d_vec.2544
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 8
	st	r2, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_form.2485
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 1
	bne	beq_else.8709
	ld	r2, r3, 20
	ld	r5, r3, 8
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	setup_rect_table.2661
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 4
	slwi	r6, r5, 2
	ld	r7, r3, 16
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.8710
beq_else.8709:
	cmpwi	cr0, r2, 2
	bne	beq_else.8711
	ld	r2, r3, 20
	ld	r5, r3, 8
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	setup_surface_table.2664
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 4
	slwi	r6, r5, 2
	ld	r7, r3, 16
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.8712
beq_else.8711:
	ld	r2, r3, 20
	ld	r5, r3, 8
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	setup_second_table.2667
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 4
	slwi	r6, r5, 2
	ld	r7, r3, 16
	add	r31, r7, r6
	st	r2, r31, 0
beq_cont.8712:
beq_cont.8710:
	addi	r5, r5, -1
	ld	r2, r3, 12
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
bge_else.8708:
	blr
setup_dirvec_constants.2673:
	ld	r5, r30, 8
	ld	r30, r30, 4
	ld	r5, r5, 0
	addi	r5, r5, -1
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
setup_startp_constants.2675:
	ld	r6, r30, 4
	cmpwi	cr0, r5, 0
	blt	bge_else.8714
	slwi	r7, r5, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	st	r30, r3, 0
	st	r5, r3, 4
	st	r2, r3, 8
	st	r6, r3, 12
	mflr	r31
	mr	r2, r6
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_param_ctbl.2523
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	st	r2, r3, 16
	mflr	r31
	mr	r2, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_form.2485
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 8
	fld	fr1, r5, 0
	ld	r6, r3, 12
	st	r2, r3, 20
	fst	fr1, r3, 24
	mflr	r31
	mr	r2, r6
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_param_x.2501
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 24
	fsub	fr1, fr2, fr1
	ld	r2, r3, 16
	fst	fr1, r2, 0
	ld	r5, r3, 8
	fld	fr1, r5, 4
	ld	r6, r3, 12
	fst	fr1, r3, 28
	mflr	r31
	mr	r2, r6
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_y.2503
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 28
	fsub	fr1, fr2, fr1
	ld	r2, r3, 16
	fst	fr1, r2, 4
	ld	r5, r3, 8
	fld	fr1, r5, 8
	ld	r6, r3, 12
	fst	fr1, r3, 32
	mflr	r31
	mr	r2, r6
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_z.2505
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 32
	fsub	fr1, fr2, fr1
	ld	r2, r3, 16
	fst	fr1, r2, 8
	ld	r5, r3, 20
	cmpwi	cr0, r5, 2
	bne	beq_else.8715
	ld	r5, r3, 12
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_abc.2499
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 16
	fld	fr1, r5, 0
	fld	fr2, r5, 4
	fld	fr3, r5, 8
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	veciprod2.2461
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 16
	fst	fr1, r2, 12
	b	beq_cont.8716
beq_else.8715:
	cmpwi	cr0, r5, 2
	blt	le.8717
	beq	le.8717
	fld	fr1, r2, 0
	fld	fr2, r2, 4
	fld	fr3, r2, 8
	ld	r6, r3, 12
	mflr	r31
	mr	r2, r6
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	quadratic.2598
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 20
	cmpwi	cr0, r2, 3
	bne	beq_else.8719
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr2, r3, 40
	fsub	fr1, fr1, fr2
	b	beq_cont.8720
beq_else.8719:
beq_cont.8720:
	ld	r2, r3, 16
	fst	fr1, r2, 12
	b	gt_cont.8718
le.8717:
gt_cont.8718:
beq_cont.8716:
	ld	r2, r3, 4
	addi	r5, r2, -1
	ld	r2, r3, 8
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
bge_else.8714:
	blr
setup_startp.2678:
	ld	r5, r30, 12
	ld	r6, r30, 8
	ld	r7, r30, 4
	st	r2, r3, 0
	st	r6, r3, 4
	st	r7, r3, 8
	mflr	r31
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	veccpy.2447
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r2, r3, 8
	ld	r2, r2, 0
	addi	r5, r2, -1
	ld	r2, r3, 0
	ld	r30, r3, 4
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
is_rect_outside.2680:
	fst	fr3, r3, 0
	fst	fr2, r3, 4
	st	r2, r3, 8
	fst	fr1, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_param_a.2493
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 12
	fst	fr1, r3, 16
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_fabs
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 16
	fcmp	cr0, fr2, fr1
	blt	le.8722
	beq	le.8722
	ld	r2, r3, 8
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_param_b.2495
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 4
	fst	fr1, r3, 20
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_fabs
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 20
	fcmp	cr0, fr2, fr1
	blt	le.8724
	beq	le.8724
	ld	r2, r3, 8
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_param_c.2497
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 0
	fst	fr1, r3, 24
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_fabs
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 24
	fcmp	cr0, fr2, fr1
	blt	le.8726
	beq	le.8726
	li	r2, 1
	b	gt_cont.8727
le.8726:
	li	r2, 0
gt_cont.8727:
	b	gt_cont.8725
le.8724:
	li	r2, 0
gt_cont.8725:
	b	gt_cont.8723
le.8722:
	li	r2, 0
gt_cont.8723:
	cmpwi	cr0, r2, 0
	bne	beq_else.8728
	ld	r2, r3, 8
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_isinvert.2489
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8729
	li	r2, 1
	blr
beq_else.8729:
	li	r2, 0
	blr
beq_else.8728:
	ld	r2, r3, 8
	b	o_isinvert.2489
is_plane_outside.2685:
	st	r2, r3, 0
	fst	fr3, r3, 4
	fst	fr2, r3, 8
	fst	fr1, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_param_abc.2499
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr1, r3, 12
	fld	fr2, r3, 8
	fld	fr3, r3, 4
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	veciprod2.2461
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 0
	fst	fr1, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_isinvert.2489
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr1, r3, 16
	st	r2, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	fisneg.2392
	addi	r3, r3, -32
	ld	r31, r3, 28
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	xor.2426
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8730
	li	r2, 1
	blr
beq_else.8730:
	li	r2, 0
	blr
is_second_outside.2690:
	st	r2, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	quadratic.2598
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r2, r3, 0
	fst	fr1, r3, 4
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	o_form.2485
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	cmpwi	cr0, r2, 3
	bne	beq_else.8731
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 16
	fld	fr1, r3, 16
	fld	fr2, r3, 4
	fsub	fr1, fr2, fr1
	b	beq_cont.8732
beq_else.8731:
	fld	fr1, r3, 4
beq_cont.8732:
	ld	r2, r3, 0
	fst	fr1, r3, 8
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	o_isinvert.2489
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	fld	fr1, r3, 8
	st	r2, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	fisneg.2392
	addi	r3, r3, -24
	ld	r31, r3, 20
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	xor.2426
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8733
	li	r2, 1
	blr
beq_else.8733:
	li	r2, 0
	blr
is_outside.2695:
	fst	fr3, r3, 0
	fst	fr2, r3, 4
	st	r2, r3, 8
	fst	fr1, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_param_x.2501
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 12
	fsub	fr1, fr2, fr1
	ld	r2, r3, 8
	fst	fr1, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_param_y.2503
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 4
	fsub	fr1, fr2, fr1
	ld	r2, r3, 8
	fst	fr1, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_param_z.2505
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 0
	fsub	fr1, fr2, fr1
	ld	r2, r3, 8
	fst	fr1, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_form.2485
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 1
	bne	beq_else.8734
	fld	fr1, r3, 16
	fld	fr2, r3, 20
	fld	fr3, r3, 24
	ld	r2, r3, 8
	b	is_rect_outside.2680
beq_else.8734:
	cmpwi	cr0, r2, 2
	bne	beq_else.8735
	fld	fr1, r3, 16
	fld	fr2, r3, 20
	fld	fr3, r3, 24
	ld	r2, r3, 8
	b	is_plane_outside.2685
beq_else.8735:
	fld	fr1, r3, 16
	fld	fr2, r3, 20
	fld	fr3, r3, 24
	ld	r2, r3, 8
	b	is_second_outside.2690
check_all_inside.2700:
	ld	r6, r30, 4
	slwi	r7, r2, 2
	add	r31, r5, r7
	ld	r7, r31, 0
	cmpwi	cr0, r7, -1
	bne	beq_else.8736
	li	r2, 1
	blr
beq_else.8736:
	slwi	r7, r7, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	fst	fr3, r3, 0
	fst	fr2, r3, 4
	fst	fr1, r3, 8
	st	r5, r3, 12
	st	r30, r3, 16
	st	r2, r3, 20
	mflr	r31
	mr	r2, r6
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	is_outside.2695
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8737
	ld	r2, r3, 20
	addi	r2, r2, 1
	fld	fr1, r3, 8
	fld	fr2, r3, 4
	fld	fr3, r3, 0
	ld	r5, r3, 12
	ld	r30, r3, 16
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8737:
	li	r2, 0
	blr
shadow_check_and_group.2706:
	ld	r6, r30, 28
	ld	r7, r30, 24
	ld	r8, r30, 20
	ld	r9, r30, 16
	ld	r10, r30, 12
	ld	r11, r30, 8
	ld	r12, r30, 4
	slwi	r13, r2, 2
	add	r31, r5, r13
	ld	r13, r31, 0
	cmpwi	cr0, r13, -1
	bne	beq_else.8738
	li	r2, 0
	blr
beq_else.8738:
	slwi	r13, r2, 2
	add	r31, r5, r13
	ld	r13, r31, 0
	st	r12, r3, 0
	st	r11, r3, 4
	st	r10, r3, 8
	st	r5, r3, 12
	st	r30, r3, 16
	st	r2, r3, 20
	st	r8, r3, 24
	st	r13, r3, 28
	st	r7, r3, 32
	mflr	r31
	mr	r5, r9
	mr	r2, r13
	mr	r30, r6
	mr	r6, r11
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 32
	fld	fr1, r5, 0
	cmpwi	cr0, r2, 0
	bne	beq_else.8739
	li	r2, 0
	b	beq_cont.8740
beq_else.8739:
	li	r31, 48717
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r3, 40
	fld	fr2, r3, 40
	fcmp	cr0, fr2, fr1
	blt	le.8741
	beq	le.8741
	li	r2, 1
	b	gt_cont.8742
le.8741:
	li	r2, 0
gt_cont.8742:
beq_cont.8740:
	cmpwi	cr0, r2, 0
	bne	beq_else.8743
	ld	r2, r3, 28
	slwi	r2, r2, 2
	ld	r5, r3, 24
	add	r31, r5, r2
	ld	r2, r31, 0
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_isinvert.2489
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8744
	li	r2, 0
	blr
beq_else.8744:
	ld	r2, r3, 20
	addi	r2, r2, 1
	ld	r5, r3, 12
	ld	r30, r3, 16
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8743:
	li	r31, 15396
	slwi	r31, r31, 16
	addi	r31, r31, 55050
	st	r31, r3, 40
	fld	fr2, r3, 40
	fadd	fr1, fr1, fr2
	ld	r2, r3, 8
	fld	fr2, r2, 0
	fmul	fr2, fr2, fr1
	ld	r5, r3, 4
	fld	fr3, r5, 0
	fadd	fr2, fr2, fr3
	fld	fr3, r2, 4
	fmul	fr3, fr3, fr1
	fld	fr4, r5, 4
	fadd	fr3, fr3, fr4
	fld	fr4, r2, 8
	fmul	fr1, fr4, fr1
	fld	fr4, r5, 8
	fadd	fr1, fr1, fr4
	li	r2, 0
	ld	r5, r3, 12
	ld	r30, r3, 0
	mflr	r31
	fmr	fr31, fr3
	fmr	fr3, fr1
	fmr	fr1, fr2
	fmr	fr2, fr31
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8745
	ld	r2, r3, 20
	addi	r2, r2, 1
	ld	r5, r3, 12
	ld	r30, r3, 16
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8745:
	li	r2, 1
	blr
shadow_check_one_or_group.2709:
	ld	r6, r30, 8
	ld	r7, r30, 4
	slwi	r8, r2, 2
	add	r31, r5, r8
	ld	r8, r31, 0
	cmpwi	cr0, r8, -1
	bne	beq_else.8746
	li	r2, 0
	blr
beq_else.8746:
	slwi	r8, r8, 2
	add	r31, r7, r8
	ld	r7, r31, 0
	li	r8, 0
	st	r5, r3, 0
	st	r30, r3, 4
	st	r2, r3, 8
	mflr	r31
	mr	r5, r7
	mr	r2, r8
	mr	r30, r6
	st	r31, r3, 12
	addi	r3, r3, 16
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8747
	ld	r2, r3, 8
	addi	r2, r2, 1
	ld	r5, r3, 0
	ld	r30, r3, 4
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8747:
	li	r2, 1
	blr
shadow_check_one_or_matrix.2712:
	ld	r6, r30, 20
	ld	r7, r30, 16
	ld	r8, r30, 12
	ld	r9, r30, 8
	ld	r10, r30, 4
	slwi	r11, r2, 2
	add	r31, r5, r11
	ld	r11, r31, 0
	ld	r12, r11, 0
	cmpwi	cr0, r12, -1
	bne	beq_else.8748
	li	r2, 0
	blr
beq_else.8748:
	st	r11, r3, 0
	st	r8, r3, 4
	st	r5, r3, 8
	st	r30, r3, 12
	st	r2, r3, 16
	cmpwi	cr0, r12, 99
	bne	beq_else.8749
	li	r2, 1
	b	beq_cont.8750
beq_else.8749:
	st	r7, r3, 20
	mflr	r31
	mr	r5, r9
	mr	r2, r12
	mr	r30, r6
	mr	r6, r10
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8751
	li	r2, 0
	b	beq_cont.8752
beq_else.8751:
	li	r31, 48589
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r3, 32
	fld	fr1, r3, 32
	ld	r2, r3, 20
	fld	fr2, r2, 0
	fcmp	cr0, fr1, fr2
	blt	le.8753
	beq	le.8753
	li	r2, 1
	ld	r5, r3, 0
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8755
	li	r2, 0
	b	beq_cont.8756
beq_else.8755:
	li	r2, 1
beq_cont.8756:
	b	gt_cont.8754
le.8753:
	li	r2, 0
gt_cont.8754:
beq_cont.8752:
beq_cont.8750:
	cmpwi	cr0, r2, 0
	bne	beq_else.8757
	ld	r2, r3, 16
	addi	r2, r2, 1
	ld	r5, r3, 8
	ld	r30, r3, 12
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8757:
	li	r2, 1
	ld	r5, r3, 0
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8758
	ld	r2, r3, 16
	addi	r2, r2, 1
	ld	r5, r3, 8
	ld	r30, r3, 12
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8758:
	li	r2, 1
	blr
solve_each_element.2715:
	ld	r7, r30, 36
	ld	r8, r30, 32
	ld	r9, r30, 28
	ld	r10, r30, 24
	ld	r11, r30, 20
	ld	r12, r30, 16
	ld	r13, r30, 12
	ld	r14, r30, 8
	ld	r15, r30, 4
	slwi	r16, r2, 2
	add	r31, r5, r16
	ld	r16, r31, 0
	cmpwi	cr0, r16, -1
	bne	beq_else.8759
	blr
beq_else.8759:
	st	r12, r3, 0
	st	r14, r3, 4
	st	r13, r3, 8
	st	r15, r3, 12
	st	r8, r3, 16
	st	r7, r3, 20
	st	r9, r3, 24
	st	r6, r3, 28
	st	r5, r3, 32
	st	r30, r3, 36
	st	r2, r3, 40
	st	r11, r3, 44
	st	r16, r3, 48
	mflr	r31
	mr	r5, r6
	mr	r2, r16
	mr	r30, r10
	mr	r6, r8
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8761
	ld	r2, r3, 48
	slwi	r2, r2, 2
	ld	r5, r3, 44
	add	r31, r5, r2
	ld	r2, r31, 0
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	o_isinvert.2489
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8762
	blr
beq_else.8762:
	ld	r2, r3, 40
	addi	r2, r2, 1
	ld	r5, r3, 32
	ld	r6, r3, 28
	ld	r30, r3, 36
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8761:
	ld	r5, r3, 24
	fld	fr1, r5, 0
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 56
	fld	fr2, r3, 56
	fcmp	cr0, fr1, fr2
	blt	le.8764
	beq	le.8764
	ld	r5, r3, 20
	fld	fr2, r5, 0
	fcmp	cr0, fr2, fr1
	blt	le.8766
	beq	le.8766
	li	r31, 15396
	slwi	r31, r31, 16
	addi	r31, r31, 55050
	st	r31, r3, 56
	fld	fr2, r3, 56
	fadd	fr1, fr1, fr2
	ld	r6, r3, 28
	fld	fr2, r6, 0
	fmul	fr2, fr2, fr1
	ld	r7, r3, 16
	fld	fr3, r7, 0
	fadd	fr2, fr2, fr3
	fld	fr3, r6, 4
	fmul	fr3, fr3, fr1
	fld	fr4, r7, 4
	fadd	fr3, fr3, fr4
	fld	fr4, r6, 8
	fmul	fr4, fr4, fr1
	fld	fr5, r7, 8
	fadd	fr4, fr4, fr5
	li	r7, 0
	ld	r8, r3, 32
	ld	r30, r3, 12
	st	r2, r3, 52
	fst	fr4, r3, 56
	fst	fr3, r3, 60
	fst	fr2, r3, 64
	fst	fr1, r3, 68
	mflr	r31
	mr	r5, r8
	mr	r2, r7
	fmr	fr1, fr2
	fmr	fr2, fr3
	fmr	fr3, fr4
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8768
	b	beq_cont.8769
beq_else.8768:
	ld	r2, r3, 20
	fld	fr1, r3, 68
	fst	fr1, r2, 0
	fld	fr1, r3, 64
	fld	fr2, r3, 60
	fld	fr3, r3, 56
	ld	r2, r3, 8
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	vecset.2437
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 4
	ld	r5, r3, 48
	st	r5, r2, 0
	ld	r2, r3, 0
	ld	r5, r3, 52
	st	r5, r2, 0
beq_cont.8769:
	b	gt_cont.8767
le.8766:
gt_cont.8767:
	b	gt_cont.8765
le.8764:
gt_cont.8765:
	ld	r2, r3, 40
	addi	r2, r2, 1
	ld	r5, r3, 32
	ld	r6, r3, 28
	ld	r30, r3, 36
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
solve_one_or_network.2719:
	ld	r7, r30, 8
	ld	r8, r30, 4
	slwi	r9, r2, 2
	add	r31, r5, r9
	ld	r9, r31, 0
	cmpwi	cr0, r9, -1
	bne	beq_else.8770
	blr
beq_else.8770:
	slwi	r9, r9, 2
	add	r31, r8, r9
	ld	r8, r31, 0
	li	r9, 0
	st	r6, r3, 0
	st	r5, r3, 4
	st	r30, r3, 8
	st	r2, r3, 12
	mflr	r31
	mr	r5, r8
	mr	r2, r9
	mr	r30, r7
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 12
	addi	r2, r2, 1
	ld	r5, r3, 4
	ld	r6, r3, 0
	ld	r30, r3, 8
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
trace_or_matrix.2723:
	ld	r7, r30, 20
	ld	r8, r30, 16
	ld	r9, r30, 12
	ld	r10, r30, 8
	ld	r11, r30, 4
	slwi	r12, r2, 2
	add	r31, r5, r12
	ld	r12, r31, 0
	ld	r13, r12, 0
	cmpwi	cr0, r13, -1
	bne	beq_else.8772
	blr
beq_else.8772:
	st	r6, r3, 0
	st	r5, r3, 4
	st	r30, r3, 8
	st	r2, r3, 12
	cmpwi	cr0, r13, 99
	bne	beq_else.8774
	li	r7, 1
	mflr	r31
	mr	r5, r12
	mr	r2, r7
	mr	r30, r11
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	b	beq_cont.8775
beq_else.8774:
	st	r12, r3, 16
	st	r11, r3, 20
	st	r7, r3, 24
	st	r9, r3, 28
	mflr	r31
	mr	r5, r6
	mr	r2, r13
	mr	r30, r10
	mr	r6, r8
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8776
	b	beq_cont.8777
beq_else.8776:
	ld	r2, r3, 28
	fld	fr1, r2, 0
	ld	r2, r3, 24
	fld	fr2, r2, 0
	fcmp	cr0, fr2, fr1
	blt	le.8778
	beq	le.8778
	li	r2, 1
	ld	r5, r3, 16
	ld	r6, r3, 0
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	b	gt_cont.8779
le.8778:
gt_cont.8779:
beq_cont.8777:
beq_cont.8775:
	ld	r2, r3, 12
	addi	r2, r2, 1
	ld	r5, r3, 4
	ld	r6, r3, 0
	ld	r30, r3, 8
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
judge_intersection.2727:
	ld	r5, r30, 12
	ld	r6, r30, 8
	ld	r7, r30, 4
	li	r31, 20078
	slwi	r31, r31, 16
	addi	r31, r31, 27432
	st	r31, r3, 8
	fld	fr1, r3, 8
	fst	fr1, r6, 0
	li	r8, 0
	ld	r7, r7, 0
	st	r6, r3, 0
	mflr	r31
	mr	r6, r2
	mr	r30, r5
	mr	r5, r7
	mr	r2, r8
	st	r31, r3, 4
	addi	r3, r3, 8
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r2, r3, 0
	fld	fr1, r2, 0
	li	r31, 48589
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr1, fr2
	blt	le.8780
	beq	le.8780
	li	r31, 19647
	slwi	r31, r31, 16
	addi	r31, r31, 48160
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr2, fr1
	blt	le.8781
	beq	le.8781
	li	r2, 1
	blr
le.8781:
	li	r2, 0
	blr
le.8780:
	li	r2, 0
	blr
solve_each_element_fast.2729:
	ld	r7, r30, 36
	ld	r8, r30, 32
	ld	r9, r30, 28
	ld	r10, r30, 24
	ld	r11, r30, 20
	ld	r12, r30, 16
	ld	r13, r30, 12
	ld	r14, r30, 8
	ld	r15, r30, 4
	st	r12, r3, 0
	st	r14, r3, 4
	st	r13, r3, 8
	st	r15, r3, 12
	st	r8, r3, 16
	st	r7, r3, 20
	st	r10, r3, 24
	st	r30, r3, 28
	st	r11, r3, 32
	st	r6, r3, 36
	st	r9, r3, 40
	st	r5, r3, 44
	st	r2, r3, 48
	mflr	r31
	mr	r2, r6
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	d_vec.2544
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r5, r3, 48
	slwi	r6, r5, 2
	ld	r7, r3, 44
	add	r31, r7, r6
	ld	r6, r31, 0
	cmpwi	cr0, r6, -1
	bne	beq_else.8782
	blr
beq_else.8782:
	ld	r8, r3, 36
	ld	r30, r3, 40
	st	r2, r3, 52
	st	r6, r3, 56
	mflr	r31
	mr	r5, r8
	mr	r2, r6
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8784
	ld	r2, r3, 56
	slwi	r2, r2, 2
	ld	r5, r3, 32
	add	r31, r5, r2
	ld	r2, r31, 0
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	o_isinvert.2489
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8785
	blr
beq_else.8785:
	ld	r2, r3, 48
	addi	r2, r2, 1
	ld	r5, r3, 44
	ld	r6, r3, 36
	ld	r30, r3, 28
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8784:
	ld	r5, r3, 24
	fld	fr1, r5, 0
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 64
	fld	fr2, r3, 64
	fcmp	cr0, fr1, fr2
	blt	le.8787
	beq	le.8787
	ld	r5, r3, 20
	fld	fr2, r5, 0
	fcmp	cr0, fr2, fr1
	blt	le.8789
	beq	le.8789
	li	r31, 15396
	slwi	r31, r31, 16
	addi	r31, r31, 55050
	st	r31, r3, 64
	fld	fr2, r3, 64
	fadd	fr1, fr1, fr2
	ld	r6, r3, 52
	fld	fr2, r6, 0
	fmul	fr2, fr2, fr1
	ld	r7, r3, 16
	fld	fr3, r7, 0
	fadd	fr2, fr2, fr3
	fld	fr3, r6, 4
	fmul	fr3, fr3, fr1
	fld	fr4, r7, 4
	fadd	fr3, fr3, fr4
	fld	fr4, r6, 8
	fmul	fr4, fr4, fr1
	fld	fr5, r7, 8
	fadd	fr4, fr4, fr5
	li	r6, 0
	ld	r7, r3, 44
	ld	r30, r3, 12
	st	r2, r3, 60
	fst	fr4, r3, 64
	fst	fr3, r3, 68
	fst	fr2, r3, 72
	fst	fr1, r3, 76
	mflr	r31
	mr	r5, r7
	mr	r2, r6
	fmr	fr1, fr2
	fmr	fr2, fr3
	fmr	fr3, fr4
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8791
	b	beq_cont.8792
beq_else.8791:
	ld	r2, r3, 20
	fld	fr1, r3, 76
	fst	fr1, r2, 0
	fld	fr1, r3, 72
	fld	fr2, r3, 68
	fld	fr3, r3, 64
	ld	r2, r3, 8
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	vecset.2437
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r2, r3, 4
	ld	r5, r3, 56
	st	r5, r2, 0
	ld	r2, r3, 0
	ld	r5, r3, 60
	st	r5, r2, 0
beq_cont.8792:
	b	gt_cont.8790
le.8789:
gt_cont.8790:
	b	gt_cont.8788
le.8787:
gt_cont.8788:
	ld	r2, r3, 48
	addi	r2, r2, 1
	ld	r5, r3, 44
	ld	r6, r3, 36
	ld	r30, r3, 28
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
solve_one_or_network_fast.2733:
	ld	r7, r30, 8
	ld	r8, r30, 4
	slwi	r9, r2, 2
	add	r31, r5, r9
	ld	r9, r31, 0
	cmpwi	cr0, r9, -1
	bne	beq_else.8793
	blr
beq_else.8793:
	slwi	r9, r9, 2
	add	r31, r8, r9
	ld	r8, r31, 0
	li	r9, 0
	st	r6, r3, 0
	st	r5, r3, 4
	st	r30, r3, 8
	st	r2, r3, 12
	mflr	r31
	mr	r5, r8
	mr	r2, r9
	mr	r30, r7
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 12
	addi	r2, r2, 1
	ld	r5, r3, 4
	ld	r6, r3, 0
	ld	r30, r3, 8
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
trace_or_matrix_fast.2737:
	ld	r7, r30, 16
	ld	r8, r30, 12
	ld	r9, r30, 8
	ld	r10, r30, 4
	slwi	r11, r2, 2
	add	r31, r5, r11
	ld	r11, r31, 0
	ld	r12, r11, 0
	cmpwi	cr0, r12, -1
	bne	beq_else.8795
	blr
beq_else.8795:
	st	r6, r3, 0
	st	r5, r3, 4
	st	r30, r3, 8
	st	r2, r3, 12
	cmpwi	cr0, r12, 99
	bne	beq_else.8797
	li	r7, 1
	mflr	r31
	mr	r5, r11
	mr	r2, r7
	mr	r30, r10
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	b	beq_cont.8798
beq_else.8797:
	st	r11, r3, 16
	st	r10, r3, 20
	st	r7, r3, 24
	st	r9, r3, 28
	mflr	r31
	mr	r5, r6
	mr	r2, r12
	mr	r30, r8
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8799
	b	beq_cont.8800
beq_else.8799:
	ld	r2, r3, 28
	fld	fr1, r2, 0
	ld	r2, r3, 24
	fld	fr2, r2, 0
	fcmp	cr0, fr2, fr1
	blt	le.8801
	beq	le.8801
	li	r2, 1
	ld	r5, r3, 16
	ld	r6, r3, 0
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	b	gt_cont.8802
le.8801:
gt_cont.8802:
beq_cont.8800:
beq_cont.8798:
	ld	r2, r3, 12
	addi	r2, r2, 1
	ld	r5, r3, 4
	ld	r6, r3, 0
	ld	r30, r3, 8
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
judge_intersection_fast.2741:
	ld	r5, r30, 12
	ld	r6, r30, 8
	ld	r7, r30, 4
	li	r31, 20078
	slwi	r31, r31, 16
	addi	r31, r31, 27432
	st	r31, r3, 8
	fld	fr1, r3, 8
	fst	fr1, r6, 0
	li	r8, 0
	ld	r7, r7, 0
	st	r6, r3, 0
	mflr	r31
	mr	r6, r2
	mr	r30, r5
	mr	r5, r7
	mr	r2, r8
	st	r31, r3, 4
	addi	r3, r3, 8
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r2, r3, 0
	fld	fr1, r2, 0
	li	r31, 48589
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr1, fr2
	blt	le.8803
	beq	le.8803
	li	r31, 19647
	slwi	r31, r31, 16
	addi	r31, r31, 48160
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr2, fr1
	blt	le.8804
	beq	le.8804
	li	r2, 1
	blr
le.8804:
	li	r2, 0
	blr
le.8803:
	li	r2, 0
	blr
get_nvector_rect.2743:
	ld	r5, r30, 8
	ld	r6, r30, 4
	ld	r6, r6, 0
	st	r5, r3, 0
	st	r2, r3, 4
	st	r6, r3, 8
	mflr	r31
	mr	r2, r5
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	vecbzero.2445
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r2, r3, 8
	addi	r5, r2, -1
	addi	r2, r2, -1
	slwi	r2, r2, 2
	ld	r6, r3, 4
	add	r6, r6, r2
	fld	fr1, r6, 0
	sub	r6, r6, r2
	st	r5, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	sgn.2429
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fsub	fr1, fr0, fr1
	ld	r2, r3, 12
	slwi	r2, r2, 2
	ld	r5, r3, 0
	add	r5, r5, r2
	fst	fr1, r5, 0
	sub	r5, r5, r2
	blr
get_nvector_plane.2745:
	ld	r5, r30, 4
	st	r2, r3, 0
	st	r5, r3, 4
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	o_param_a.2493
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	fsub	fr1, fr0, fr1
	ld	r2, r3, 4
	fst	fr1, r2, 0
	ld	r5, r3, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	o_param_b.2495
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	fsub	fr1, fr0, fr1
	ld	r2, r3, 4
	fst	fr1, r2, 4
	ld	r5, r3, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	o_param_c.2497
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	fsub	fr1, fr0, fr1
	ld	r2, r3, 4
	fst	fr1, r2, 8
	blr
get_nvector_second.2747:
	ld	r5, r30, 8
	ld	r6, r30, 4
	fld	fr1, r6, 0
	st	r5, r3, 0
	st	r2, r3, 4
	st	r6, r3, 8
	fst	fr1, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_param_x.2501
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 12
	fsub	fr1, fr2, fr1
	ld	r2, r3, 8
	fld	fr2, r2, 4
	ld	r5, r3, 4
	fst	fr1, r3, 16
	fst	fr2, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_param_y.2503
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 20
	fsub	fr1, fr2, fr1
	ld	r2, r3, 8
	fld	fr2, r2, 8
	ld	r2, r3, 4
	fst	fr1, r3, 24
	fst	fr2, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_z.2505
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 28
	fsub	fr1, fr2, fr1
	ld	r2, r3, 4
	fst	fr1, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_a.2493
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 16
	fmul	fr1, fr2, fr1
	ld	r2, r3, 4
	fst	fr1, r3, 36
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_param_b.2495
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 24
	fmul	fr1, fr2, fr1
	ld	r2, r3, 4
	fst	fr1, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_param_c.2497
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 32
	fmul	fr1, fr2, fr1
	ld	r2, r3, 4
	fst	fr1, r3, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	o_isrot.2491
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8807
	ld	r2, r3, 0
	fld	fr1, r3, 36
	fst	fr1, r2, 0
	fld	fr1, r3, 40
	fst	fr1, r2, 4
	fld	fr1, r3, 44
	fst	fr1, r2, 8
	b	beq_cont.8808
beq_else.8807:
	ld	r2, r3, 4
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	o_param_r3.2521
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 24
	fmul	fr1, fr2, fr1
	ld	r2, r3, 4
	fst	fr1, r3, 48
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	o_param_r2.2519
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 32
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 48
	fadd	fr1, fr3, fr1
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fhalf
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 36
	fadd	fr1, fr2, fr1
	ld	r2, r3, 0
	fst	fr1, r2, 0
	ld	r5, r3, 4
	mflr	r31
	mr	r2, r5
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	o_param_r3.2521
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 16
	fmul	fr1, fr2, fr1
	ld	r2, r3, 4
	fst	fr1, r3, 52
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	o_param_r1.2517
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 32
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 52
	fadd	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fhalf
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 40
	fadd	fr1, fr2, fr1
	ld	r2, r3, 0
	fst	fr1, r2, 4
	ld	r5, r3, 4
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	o_param_r2.2519
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 16
	fmul	fr1, fr2, fr1
	ld	r2, r3, 4
	fst	fr1, r3, 56
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	o_param_r1.2517
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 24
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 56
	fadd	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fhalf
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 44
	fadd	fr1, fr2, fr1
	ld	r2, r3, 0
	fst	fr1, r2, 8
beq_cont.8808:
	ld	r5, r3, 4
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	o_isinvert.2489
	addi	r3, r3, -64
	ld	r31, r3, 60
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 0
	b	vecunit_sgn.2455
get_nvector.2749:
	ld	r6, r30, 12
	ld	r7, r30, 8
	ld	r8, r30, 4
	st	r6, r3, 0
	st	r2, r3, 4
	st	r8, r3, 8
	st	r5, r3, 12
	st	r7, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_form.2485
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, 1
	bne	beq_else.8809
	ld	r2, r3, 12
	ld	r30, r3, 16
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8809:
	cmpwi	cr0, r2, 2
	bne	beq_else.8810
	ld	r2, r3, 4
	ld	r30, r3, 8
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8810:
	ld	r2, r3, 4
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
utexture.2752:
	ld	r6, r30, 4
	st	r5, r3, 0
	st	r6, r3, 4
	st	r2, r3, 8
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	o_texturetype.2483
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 8
	st	r2, r3, 12
	mflr	r31
	mr	r2, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_color_red.2511
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 4
	fst	fr1, r2, 0
	ld	r5, r3, 8
	mflr	r31
	mr	r2, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_color_green.2513
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 4
	fst	fr1, r2, 4
	ld	r5, r3, 8
	mflr	r31
	mr	r2, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_color_blue.2515
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 4
	fst	fr1, r2, 8
	ld	r5, r3, 12
	cmpwi	cr0, r5, 1
	bne	beq_else.8811
	ld	r5, r3, 0
	fld	fr1, r5, 0
	ld	r6, r3, 8
	fst	fr1, r3, 16
	mflr	r31
	mr	r2, r6
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_param_x.2501
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 16
	fsub	fr1, fr2, fr1
	li	r31, 15693
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r3, 24
	fld	fr2, r3, 24
	fmul	fr2, fr1, fr2
	fst	fr1, r3, 20
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_floor
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	li	r31, 16800
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 32
	fld	fr2, r3, 32
	fmul	fr1, fr1, fr2
	li	r31, 16672
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 32
	fld	fr2, r3, 32
	fld	fr3, r3, 20
	fsub	fr1, fr3, fr1
	fcmp	cr0, fr2, fr1
	blt	le.8812
	beq	le.8812
	li	r2, 1
	b	gt_cont.8813
le.8812:
	li	r2, 0
gt_cont.8813:
	ld	r5, r3, 0
	fld	fr1, r5, 8
	ld	r5, r3, 8
	st	r2, r3, 24
	fst	fr1, r3, 28
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_z.2505
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 28
	fsub	fr1, fr2, fr1
	li	r31, 15693
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r3, 40
	fld	fr2, r3, 40
	fmul	fr2, fr1, fr2
	fst	fr1, r3, 32
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_floor
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	li	r31, 16800
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr2, r3, 40
	fmul	fr1, fr1, fr2
	li	r31, 16672
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr2, r3, 40
	fld	fr3, r3, 32
	fsub	fr1, fr3, fr1
	fcmp	cr0, fr2, fr1
	blt	le.8814
	beq	le.8814
	li	r2, 1
	b	gt_cont.8815
le.8814:
	li	r2, 0
gt_cont.8815:
	ld	r5, r3, 24
	cmpwi	cr0, r5, 0
	bne	beq_else.8816
	cmpwi	cr0, r2, 0
	bne	beq_else.8818
	li	r31, 17279
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr1, r3, 40
	b	beq_cont.8819
beq_else.8818:
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr1, r3, 40
beq_cont.8819:
	b	beq_cont.8817
beq_else.8816:
	cmpwi	cr0, r2, 0
	bne	beq_else.8820
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr1, r3, 40
	b	beq_cont.8821
beq_else.8820:
	li	r31, 17279
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr1, r3, 40
beq_cont.8821:
beq_cont.8817:
	ld	r2, r3, 4
	fst	fr1, r2, 4
	blr
beq_else.8811:
	cmpwi	cr0, r5, 2
	bne	beq_else.8823
	ld	r5, r3, 0
	fld	fr1, r5, 4
	li	r31, 16000
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr2, r3, 40
	fmul	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_sin
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fsqr
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	li	r31, 17279
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr2, r3, 40
	fmul	fr2, fr2, fr1
	ld	r2, r3, 4
	fst	fr2, r2, 0
	li	r31, 17279
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr2, r3, 40
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr3, r3, 40
	fsub	fr1, fr3, fr1
	fmul	fr1, fr2, fr1
	fst	fr1, r2, 4
	blr
beq_else.8823:
	cmpwi	cr0, r5, 3
	bne	beq_else.8825
	ld	r5, r3, 0
	fld	fr1, r5, 0
	ld	r6, r3, 8
	fst	fr1, r3, 36
	mflr	r31
	mr	r2, r6
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_param_x.2501
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 36
	fsub	fr1, fr2, fr1
	ld	r2, r3, 0
	fld	fr2, r2, 8
	ld	r2, r3, 8
	fst	fr1, r3, 40
	fst	fr2, r3, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	o_param_z.2505
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 44
	fsub	fr1, fr2, fr1
	fld	fr2, r3, 40
	fst	fr1, r3, 48
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fsqr
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 48
	fst	fr1, r3, 52
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fsqr
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 52
	fadd	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_sqrt
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	li	r31, 16672
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 64
	fld	fr2, r3, 64
	fdiv	fr1, fr1, fr2
	fst	fr1, r3, 56
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_floor
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 56
	fsub	fr1, fr2, fr1
	li	r31, 16457
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 64
	fld	fr2, r3, 64
	fmul	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_cos
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fsqr
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	li	r31, 17279
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 64
	fld	fr2, r3, 64
	fmul	fr2, fr1, fr2
	ld	r2, r3, 4
	fst	fr2, r2, 4
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 64
	fld	fr2, r3, 64
	fsub	fr1, fr2, fr1
	li	r31, 17279
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 64
	fld	fr2, r3, 64
	fmul	fr1, fr1, fr2
	fst	fr1, r2, 8
	blr
beq_else.8825:
	cmpwi	cr0, r5, 4
	bne	beq_else.8827
	ld	r5, r3, 0
	fld	fr1, r5, 0
	ld	r6, r3, 8
	fst	fr1, r3, 60
	mflr	r31
	mr	r2, r6
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	o_param_x.2501
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 60
	fsub	fr1, fr2, fr1
	ld	r2, r3, 8
	fst	fr1, r3, 64
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	o_param_a.2493
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_sqrt
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 64
	fmul	fr1, fr2, fr1
	ld	r2, r3, 0
	fld	fr2, r2, 8
	ld	r5, r3, 8
	fst	fr1, r3, 68
	fst	fr2, r3, 72
	mflr	r31
	mr	r2, r5
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	o_param_z.2505
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 72
	fsub	fr1, fr2, fr1
	ld	r2, r3, 8
	fst	fr1, r3, 76
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	o_param_c.2497
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_sqrt
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	fld	fr2, r3, 76
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 68
	fst	fr1, r3, 80
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_fsqr
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	fld	fr2, r3, 80
	fst	fr1, r3, 84
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fsqr
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	fld	fr2, r3, 84
	fadd	fr1, fr2, fr1
	li	r31, 14546
	slwi	r31, r31, 16
	addi	r31, r31, 46871
	st	r31, r3, 96
	fld	fr2, r3, 96
	fld	fr3, r3, 68
	fst	fr1, r3, 88
	fst	fr2, r3, 92
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fabs
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	fld	fr2, r3, 92
	fcmp	cr0, fr2, fr1
	blt	le.8828
	beq	le.8828
	li	r31, 16752
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 104
	fld	fr1, r3, 104
	b	gt_cont.8829
le.8828:
	fld	fr1, r3, 68
	fld	fr2, r3, 80
	fdiv	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fabs
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_atan
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	li	r31, 16880
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 104
	fld	fr2, r3, 104
	fmul	fr1, fr1, fr2
	li	r31, 16457
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 104
	fld	fr2, r3, 104
	fdiv	fr1, fr1, fr2
gt_cont.8829:
	fst	fr1, r3, 96
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_floor
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	fld	fr2, r3, 96
	fsub	fr1, fr2, fr1
	ld	r2, r3, 0
	fld	fr2, r2, 4
	ld	r2, r3, 8
	fst	fr1, r3, 100
	fst	fr2, r3, 104
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	o_param_y.2503
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	fld	fr2, r3, 104
	fsub	fr1, fr2, fr1
	ld	r2, r3, 8
	fst	fr1, r3, 108
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	o_param_b.2495
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_sqrt
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	fld	fr2, r3, 108
	fmul	fr1, fr2, fr1
	li	r31, 14546
	slwi	r31, r31, 16
	addi	r31, r31, 46871
	st	r31, r3, 120
	fld	fr2, r3, 120
	fld	fr3, r3, 88
	fst	fr1, r3, 112
	fst	fr2, r3, 116
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_fabs
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	fld	fr2, r3, 116
	fcmp	cr0, fr2, fr1
	blt	le.8830
	beq	le.8830
	li	r31, 16752
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 128
	fld	fr1, r3, 128
	b	gt_cont.8831
le.8830:
	fld	fr1, r3, 88
	fld	fr2, r3, 112
	fdiv	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_fabs
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	mflr	r31
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_atan
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	li	r31, 16880
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 128
	fld	fr2, r3, 128
	fmul	fr1, fr1, fr2
	li	r31, 16457
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 128
	fld	fr2, r3, 128
	fdiv	fr1, fr1, fr2
gt_cont.8831:
	fst	fr1, r3, 120
	mflr	r31
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_floor
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	fld	fr2, r3, 120
	fsub	fr1, fr2, fr1
	li	r31, 15898
	slwi	r31, r31, 16
	addi	r31, r31, 39322
	st	r31, r3, 128
	fld	fr2, r3, 128
	li	r31, 16128
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 128
	fld	fr3, r3, 128
	fld	fr4, r3, 100
	fsub	fr3, fr3, fr4
	fst	fr1, r3, 124
	fst	fr2, r3, 128
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_fsqr
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	fld	fr2, r3, 128
	fsub	fr1, fr2, fr1
	li	r31, 16128
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 136
	fld	fr2, r3, 136
	fld	fr3, r3, 124
	fsub	fr2, fr2, fr3
	fst	fr1, r3, 132
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_fsqr
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	fld	fr2, r3, 132
	fsub	fr1, fr2, fr1
	fst	fr1, r3, 136
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	fisneg.2392
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8832
	fld	fr1, r3, 136
	b	beq_cont.8833
beq_else.8832:
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 144
	fld	fr1, r3, 144
beq_cont.8833:
	li	r31, 17279
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 144
	fld	fr2, r3, 144
	fmul	fr1, fr2, fr1
	li	r31, 16026
	slwi	r31, r31, 16
	addi	r31, r31, 39322
	st	r31, r3, 144
	fld	fr2, r3, 144
	fdiv	fr1, fr1, fr2
	ld	r2, r3, 4
	fst	fr1, r2, 8
	blr
beq_else.8827:
	blr
add_light.2755:
	ld	r2, r30, 8
	ld	r5, r30, 4
	fst	fr3, r3, 0
	fst	fr2, r3, 4
	fst	fr1, r3, 8
	st	r2, r3, 12
	st	r5, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	fispos.2390
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8836
	b	beq_cont.8837
beq_else.8836:
	fld	fr1, r3, 8
	ld	r2, r3, 16
	ld	r5, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	vecaccum.2466
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
beq_cont.8837:
	fld	fr1, r3, 4
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	fispos.2390
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8838
	blr
beq_else.8838:
	fld	fr1, r3, 4
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_fsqr
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_fsqr
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 0
	fmul	fr1, fr1, fr2
	ld	r2, r3, 16
	fld	fr2, r2, 0
	fadd	fr2, fr2, fr1
	fst	fr2, r2, 0
	fld	fr2, r2, 4
	fadd	fr2, fr2, fr1
	fst	fr2, r2, 4
	fld	fr2, r2, 8
	fadd	fr1, fr2, fr1
	fst	fr1, r2, 8
	blr
trace_reflections.2759:
	ld	r6, r30, 32
	ld	r7, r30, 28
	ld	r8, r30, 24
	ld	r9, r30, 20
	ld	r10, r30, 16
	ld	r11, r30, 12
	ld	r12, r30, 8
	ld	r13, r30, 4
	cmpwi	cr0, r2, 0
	blt	bge_else.8841
	slwi	r14, r2, 2
	add	r31, r7, r14
	ld	r7, r31, 0
	st	r30, r3, 0
	st	r2, r3, 4
	fst	fr2, r3, 8
	st	r13, r3, 12
	st	r5, r3, 16
	fst	fr1, r3, 20
	st	r9, r3, 24
	st	r6, r3, 28
	st	r8, r3, 32
	st	r7, r3, 36
	st	r11, r3, 40
	st	r12, r3, 44
	st	r10, r3, 48
	mflr	r31
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	r_dvec.2550
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r30, r3, 48
	st	r2, r3, 52
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8842
	b	beq_cont.8843
beq_else.8842:
	ld	r2, r3, 44
	ld	r2, r2, 0
	slwi	r2, r2, 2
	ld	r5, r3, 40
	ld	r5, r5, 0
	add	r2, r2, r5
	ld	r5, r3, 36
	st	r2, r3, 56
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	r_surface_id.2548
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 56
	cmpw	cr0, r5, r2
	bne	beq_else.8844
	li	r2, 0
	ld	r5, r3, 32
	ld	r5, r5, 0
	ld	r30, r3, 28
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8846
	ld	r2, r3, 52
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	d_vec.2544
	addi	r3, r3, -64
	ld	r31, r3, 60
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 24
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	veciprod.2458
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 36
	fst	fr1, r3, 60
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	r_bright.2552
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 20
	fmul	fr3, fr1, fr2
	fld	fr4, r3, 60
	fmul	fr3, fr3, fr4
	ld	r2, r3, 52
	fst	fr3, r3, 64
	fst	fr1, r3, 68
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	d_vec.2544
	addi	r3, r3, -80
	ld	r31, r3, 76
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	veciprod.2458
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 68
	fmul	fr2, fr2, fr1
	fld	fr1, r3, 64
	fld	fr3, r3, 8
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	b	beq_cont.8847
beq_else.8846:
beq_cont.8847:
	b	beq_cont.8845
beq_else.8844:
beq_cont.8845:
beq_cont.8843:
	ld	r2, r3, 4
	addi	r2, r2, -1
	fld	fr1, r3, 20
	fld	fr2, r3, 8
	ld	r5, r3, 16
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
bge_else.8841:
	blr
trace_ray.2764:
	ld	r7, r30, 80
	ld	r8, r30, 76
	ld	r9, r30, 72
	ld	r10, r30, 68
	ld	r11, r30, 64
	ld	r12, r30, 60
	ld	r13, r30, 56
	ld	r14, r30, 52
	ld	r15, r30, 48
	ld	r16, r30, 44
	ld	r17, r30, 40
	ld	r18, r30, 36
	ld	r19, r30, 32
	ld	r20, r30, 28
	ld	r21, r30, 24
	ld	r22, r30, 20
	ld	r23, r30, 16
	ld	r24, r30, 12
	ld	r25, r30, 8
	ld	r26, r30, 4
	cmpwi	cr0, r2, 4
	blt	le.8849
	beq	le.8849
	blr
le.8849:
	st	r30, r3, 0
	fst	fr2, r3, 4
	st	r9, r3, 8
	st	r8, r3, 12
	st	r18, r3, 16
	st	r13, r3, 20
	st	r26, r3, 24
	st	r12, r3, 28
	st	r15, r3, 32
	st	r17, r3, 36
	st	r10, r3, 40
	st	r6, r3, 44
	st	r21, r3, 48
	st	r7, r3, 52
	st	r22, r3, 56
	st	r11, r3, 60
	st	r24, r3, 64
	st	r16, r3, 68
	st	r23, r3, 72
	st	r14, r3, 76
	st	r25, r3, 80
	fst	fr1, r3, 84
	st	r19, r3, 88
	st	r2, r3, 92
	st	r5, r3, 96
	st	r20, r3, 100
	mflr	r31
	mr	r2, r6
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	p_surface_ids.2529
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	ld	r5, r3, 96
	ld	r30, r3, 100
	st	r2, r3, 104
	mflr	r31
	mr	r2, r5
	st	r31, r3, 108
	addi	r3, r3, 112
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8851
	li	r2, -1
	ld	r5, r3, 92
	slwi	r6, r5, 2
	ld	r7, r3, 104
	add	r31, r7, r6
	st	r2, r31, 0
	cmpwi	cr0, r5, 0
	bne	beq_else.8852
	blr
beq_else.8852:
	ld	r2, r3, 96
	ld	r5, r3, 88
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	veciprod.2458
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	fsub	fr1, fr0, fr1
	fst	fr1, r3, 108
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	fispos.2390
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8854
	blr
beq_else.8854:
	fld	fr1, r3, 108
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_fsqr
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	fld	fr2, r3, 108
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 84
	fmul	fr1, fr1, fr2
	ld	r2, r3, 80
	fld	fr2, r2, 0
	fmul	fr1, fr1, fr2
	ld	r2, r3, 76
	fld	fr2, r2, 0
	fadd	fr2, fr2, fr1
	fst	fr2, r2, 0
	fld	fr2, r2, 4
	fadd	fr2, fr2, fr1
	fst	fr2, r2, 4
	fld	fr2, r2, 8
	fadd	fr1, fr2, fr1
	fst	fr1, r2, 8
	blr
beq_else.8851:
	ld	r2, r3, 72
	ld	r2, r2, 0
	slwi	r5, r2, 2
	ld	r6, r3, 68
	add	r31, r6, r5
	ld	r5, r31, 0
	st	r2, r3, 112
	st	r5, r3, 116
	mflr	r31
	mr	r2, r5
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	o_reflectiontype.2487
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	ld	r5, r3, 116
	st	r2, r3, 120
	mflr	r31
	mr	r2, r5
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	o_diffuse.2507
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	fld	fr2, r3, 84
	fmul	fr1, fr1, fr2
	ld	r2, r3, 116
	ld	r5, r3, 96
	ld	r30, r3, 64
	fst	fr1, r3, 124
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r2, r3, 60
	ld	r5, r3, 56
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	veccpy.2447
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r2, r3, 116
	ld	r5, r3, 56
	ld	r30, r3, 52
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r2, r3, 112
	slwi	r2, r2, 2
	ld	r5, r3, 48
	ld	r5, r5, 0
	add	r2, r2, r5
	ld	r5, r3, 92
	slwi	r6, r5, 2
	ld	r7, r3, 104
	add	r31, r7, r6
	st	r2, r31, 0
	ld	r2, r3, 44
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	p_intersection_points.2527
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r5, r3, 92
	slwi	r6, r5, 2
	add	r31, r2, r6
	ld	r2, r31, 0
	ld	r6, r3, 56
	mflr	r31
	mr	r5, r6
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	veccpy.2447
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r2, r3, 44
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	p_calc_diffuse.2531
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	li	r31, 16128
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 136
	fld	fr1, r3, 136
	ld	r5, r3, 116
	st	r2, r3, 128
	fst	fr1, r3, 132
	mflr	r31
	mr	r2, r5
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	o_diffuse.2507
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	fld	fr2, r3, 132
	fcmp	cr0, fr2, fr1
	blt	le.8857
	beq	le.8857
	li	r2, 0
	ld	r5, r3, 92
	slwi	r6, r5, 2
	ld	r7, r3, 128
	add	r31, r7, r6
	st	r2, r31, 0
	b	gt_cont.8858
le.8857:
	li	r2, 1
	ld	r5, r3, 92
	slwi	r6, r5, 2
	ld	r7, r3, 128
	add	r31, r7, r6
	st	r2, r31, 0
	ld	r2, r3, 44
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	p_energy.2533
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	ld	r5, r3, 92
	slwi	r6, r5, 2
	add	r31, r2, r6
	ld	r6, r31, 0
	ld	r7, r3, 40
	st	r2, r3, 136
	mflr	r31
	mr	r5, r7
	mr	r2, r6
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	veccpy.2447
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	ld	r2, r3, 92
	slwi	r5, r2, 2
	ld	r6, r3, 136
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r31, 15232
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 144
	fld	fr1, r3, 144
	fld	fr2, r3, 124
	fmul	fr1, fr1, fr2
	mflr	r31
	mr	r2, r5
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	vecscale.2476
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	ld	r2, r3, 44
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	p_nvectors.2542
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	ld	r5, r3, 92
	slwi	r6, r5, 2
	add	r31, r2, r6
	ld	r2, r31, 0
	ld	r6, r3, 36
	mflr	r31
	mr	r5, r6
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	veccpy.2447
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
gt_cont.8858:
	li	r31, 49152
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 144
	fld	fr1, r3, 144
	ld	r2, r3, 96
	ld	r5, r3, 36
	fst	fr1, r3, 140
	mflr	r31
	st	r31, r3, 148
	addi	r3, r3, 152
	bl	veciprod.2458
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	fld	fr2, r3, 140
	fmul	fr1, fr2, fr1
	ld	r2, r3, 96
	ld	r5, r3, 36
	mflr	r31
	st	r31, r3, 148
	addi	r3, r3, 152
	bl	vecaccum.2466
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	ld	r2, r3, 116
	mflr	r31
	st	r31, r3, 148
	addi	r3, r3, 152
	bl	o_hilight.2509
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	fld	fr2, r3, 84
	fmul	fr1, fr2, fr1
	li	r2, 0
	ld	r5, r3, 32
	ld	r5, r5, 0
	ld	r30, r3, 28
	fst	fr1, r3, 144
	mflr	r31
	st	r31, r3, 148
	addi	r3, r3, 152
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8859
	ld	r2, r3, 36
	ld	r5, r3, 88
	mflr	r31
	st	r31, r3, 148
	addi	r3, r3, 152
	bl	veciprod.2458
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	fsub	fr1, fr0, fr1
	fld	fr2, r3, 124
	fmul	fr1, fr1, fr2
	ld	r2, r3, 96
	ld	r5, r3, 88
	fst	fr1, r3, 148
	mflr	r31
	st	r31, r3, 156
	addi	r3, r3, 160
	bl	veciprod.2458
	addi	r3, r3, -160
	ld	r31, r3, 156
	mtlr	r31
	fsub	fr2, fr0, fr1
	fld	fr1, r3, 148
	fld	fr3, r3, 144
	ld	r30, r3, 24
	mflr	r31
	st	r31, r3, 156
	addi	r3, r3, 160
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -160
	ld	r31, r3, 156
	mtlr	r31
	b	beq_cont.8860
beq_else.8859:
beq_cont.8860:
	ld	r2, r3, 56
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 156
	addi	r3, r3, 160
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -160
	ld	r31, r3, 156
	mtlr	r31
	ld	r2, r3, 16
	ld	r2, r2, 0
	addi	r2, r2, -1
	fld	fr1, r3, 124
	fld	fr2, r3, 144
	ld	r5, r3, 96
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 156
	addi	r3, r3, 160
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -160
	ld	r31, r3, 156
	mtlr	r31
	li	r31, 15821
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r3, 160
	fld	fr1, r3, 160
	fld	fr2, r3, 84
	fcmp	cr0, fr2, fr1
	blt	le.8861
	beq	le.8861
	ld	r2, r3, 92
	cmpwi	cr0, r2, 4
	blt	bge_else.8862
	b	bge_cont.8863
bge_else.8862:
	addi	r5, r2, 1
	li	r6, -1
	slwi	r5, r5, 2
	ld	r7, r3, 104
	add	r31, r7, r5
	st	r6, r31, 0
bge_cont.8863:
	ld	r5, r3, 120
	cmpwi	cr0, r5, 2
	bne	beq_else.8864
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 160
	fld	fr1, r3, 160
	ld	r5, r3, 116
	fst	fr1, r3, 152
	mflr	r31
	mr	r2, r5
	st	r31, r3, 156
	addi	r3, r3, 160
	bl	o_diffuse.2507
	addi	r3, r3, -160
	ld	r31, r3, 156
	mtlr	r31
	fld	fr2, r3, 152
	fsub	fr1, fr2, fr1
	fld	fr2, r3, 84
	fmul	fr1, fr2, fr1
	ld	r2, r3, 92
	addi	r2, r2, 1
	ld	r5, r3, 8
	fld	fr2, r5, 0
	fld	fr3, r3, 4
	fadd	fr2, fr3, fr2
	ld	r5, r3, 96
	ld	r6, r3, 44
	ld	r30, r3, 0
	mflr	r31
	st	r31, r3, 156
	addi	r3, r3, 160
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -160
	ld	r31, r3, 156
	mtlr	r31
	b	beq_cont.8865
beq_else.8864:
beq_cont.8865:
	blr
le.8861:
	blr
trace_diffuse_ray.2770:
	ld	r5, r30, 48
	ld	r6, r30, 44
	ld	r7, r30, 40
	ld	r8, r30, 36
	ld	r9, r30, 32
	ld	r10, r30, 28
	ld	r11, r30, 24
	ld	r12, r30, 20
	ld	r13, r30, 16
	ld	r14, r30, 12
	ld	r15, r30, 8
	ld	r16, r30, 4
	st	r6, r3, 0
	st	r16, r3, 4
	fst	fr1, r3, 8
	st	r11, r3, 12
	st	r10, r3, 16
	st	r7, r3, 20
	st	r8, r3, 24
	st	r13, r3, 28
	st	r5, r3, 32
	st	r15, r3, 36
	st	r2, r3, 40
	st	r9, r3, 44
	st	r14, r3, 48
	mflr	r31
	mr	r30, r12
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8868
	blr
beq_else.8868:
	ld	r2, r3, 48
	ld	r2, r2, 0
	slwi	r2, r2, 2
	ld	r5, r3, 44
	add	r31, r5, r2
	ld	r2, r31, 0
	ld	r5, r3, 40
	st	r2, r3, 52
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	d_vec.2544
	addi	r3, r3, -64
	ld	r31, r3, 60
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 52
	ld	r30, r3, 36
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 52
	ld	r5, r3, 28
	ld	r30, r3, 32
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	li	r2, 0
	ld	r5, r3, 24
	ld	r5, r5, 0
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8870
	ld	r2, r3, 16
	ld	r5, r3, 12
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	veciprod.2458
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fsub	fr1, fr0, fr1
	fst	fr1, r3, 56
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	fispos.2390
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8871
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 64
	fld	fr1, r3, 64
	b	beq_cont.8872
beq_else.8871:
	fld	fr1, r3, 56
beq_cont.8872:
	fld	fr2, r3, 8
	fmul	fr1, fr2, fr1
	ld	r2, r3, 52
	fst	fr1, r3, 60
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	o_diffuse.2507
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 60
	fmul	fr1, fr2, fr1
	ld	r2, r3, 4
	ld	r5, r3, 0
	b	vecaccum.2466
beq_else.8870:
	blr
iter_trace_diffuse_rays.2773:
	ld	r8, r30, 4
	cmpwi	cr0, r7, 0
	blt	bge_else.8874
	slwi	r9, r7, 2
	add	r31, r2, r9
	ld	r9, r31, 0
	st	r6, r3, 0
	st	r30, r3, 4
	st	r8, r3, 8
	st	r2, r3, 12
	st	r7, r3, 16
	st	r5, r3, 20
	mflr	r31
	mr	r2, r9
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	d_vec.2544
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	veciprod.2458
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fst	fr1, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	fisneg.2392
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8875
	ld	r2, r3, 16
	slwi	r5, r2, 2
	ld	r6, r3, 12
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r31, 17174
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 32
	fld	fr1, r3, 32
	fld	fr2, r3, 24
	fdiv	fr1, fr2, fr1
	ld	r30, r3, 8
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	b	beq_cont.8876
beq_else.8875:
	ld	r2, r3, 16
	addi	r5, r2, 1
	slwi	r5, r5, 2
	ld	r6, r3, 12
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r31, 49942
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 32
	fld	fr1, r3, 32
	fld	fr2, r3, 24
	fdiv	fr1, fr2, fr1
	ld	r30, r3, 8
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
beq_cont.8876:
	ld	r2, r3, 16
	addi	r7, r2, -2
	ld	r2, r3, 12
	ld	r5, r3, 20
	ld	r6, r3, 0
	ld	r30, r3, 4
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
bge_else.8874:
	blr
trace_diffuse_rays.2778:
	ld	r7, r30, 8
	ld	r8, r30, 4
	st	r6, r3, 0
	st	r5, r3, 4
	st	r2, r3, 8
	st	r8, r3, 12
	mflr	r31
	mr	r2, r6
	mr	r30, r7
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r7, 118
	ld	r2, r3, 8
	ld	r5, r3, 4
	ld	r6, r3, 0
	ld	r30, r3, 12
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
trace_diffuse_ray_80percent.2782:
	ld	r7, r30, 8
	ld	r8, r30, 4
	st	r6, r3, 0
	st	r5, r3, 4
	st	r7, r3, 8
	st	r8, r3, 12
	st	r2, r3, 16
	cmpwi	cr0, r2, 0
	bne	beq_else.8878
	b	beq_cont.8879
beq_else.8878:
	ld	r9, r8, 0
	mflr	r31
	mr	r2, r9
	mr	r30, r7
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
beq_cont.8879:
	ld	r2, r3, 16
	cmpwi	cr0, r2, 1
	bne	beq_else.8880
	b	beq_cont.8881
beq_else.8880:
	ld	r5, r3, 12
	ld	r6, r5, 4
	ld	r7, r3, 4
	ld	r8, r3, 0
	ld	r30, r3, 8
	mflr	r31
	mr	r5, r7
	mr	r2, r6
	mr	r6, r8
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
beq_cont.8881:
	ld	r2, r3, 16
	cmpwi	cr0, r2, 2
	bne	beq_else.8882
	b	beq_cont.8883
beq_else.8882:
	ld	r5, r3, 12
	ld	r6, r5, 8
	ld	r7, r3, 4
	ld	r8, r3, 0
	ld	r30, r3, 8
	mflr	r31
	mr	r5, r7
	mr	r2, r6
	mr	r6, r8
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
beq_cont.8883:
	ld	r2, r3, 16
	cmpwi	cr0, r2, 3
	bne	beq_else.8884
	b	beq_cont.8885
beq_else.8884:
	ld	r5, r3, 12
	ld	r6, r5, 12
	ld	r7, r3, 4
	ld	r8, r3, 0
	ld	r30, r3, 8
	mflr	r31
	mr	r5, r7
	mr	r2, r6
	mr	r6, r8
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
beq_cont.8885:
	ld	r2, r3, 16
	cmpwi	cr0, r2, 4
	bne	beq_else.8886
	blr
beq_else.8886:
	ld	r2, r3, 12
	ld	r2, r2, 16
	ld	r5, r3, 4
	ld	r6, r3, 0
	ld	r30, r3, 8
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
calc_diffuse_using_1point.2786:
	ld	r6, r30, 12
	ld	r7, r30, 8
	ld	r8, r30, 4
	st	r7, r3, 0
	st	r6, r3, 4
	st	r8, r3, 8
	st	r5, r3, 12
	st	r2, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	p_received_ray_20percent.2535
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 16
	st	r2, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	p_nvectors.2542
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 16
	st	r2, r3, 24
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	p_intersection_points.2527
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 16
	st	r2, r3, 28
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	p_energy.2533
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 12
	slwi	r6, r5, 2
	ld	r7, r3, 20
	add	r31, r7, r6
	ld	r6, r31, 0
	ld	r7, r3, 8
	st	r2, r3, 32
	mflr	r31
	mr	r5, r6
	mr	r2, r7
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	veccpy.2447
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 16
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	p_group_id.2537
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 12
	slwi	r6, r5, 2
	ld	r7, r3, 24
	add	r31, r7, r6
	ld	r6, r31, 0
	slwi	r7, r5, 2
	ld	r8, r3, 28
	add	r31, r8, r7
	ld	r7, r31, 0
	ld	r30, r3, 4
	mflr	r31
	mr	r5, r6
	mr	r6, r7
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 12
	slwi	r2, r2, 2
	ld	r5, r3, 32
	add	r31, r5, r2
	ld	r5, r31, 0
	ld	r2, r3, 0
	ld	r6, r3, 8
	b	vecaccumv.2479
calc_diffuse_using_5points.2789:
	ld	r9, r30, 8
	ld	r10, r30, 4
	slwi	r11, r2, 2
	add	r31, r5, r11
	ld	r5, r31, 0
	st	r9, r3, 0
	st	r10, r3, 4
	st	r8, r3, 8
	st	r7, r3, 12
	st	r6, r3, 16
	st	r2, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	p_received_ray_20percent.2535
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 20
	addi	r6, r5, -1
	slwi	r6, r6, 2
	ld	r7, r3, 16
	add	r31, r7, r6
	ld	r6, r31, 0
	st	r2, r3, 24
	mflr	r31
	mr	r2, r6
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	p_received_ray_20percent.2535
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 20
	slwi	r6, r5, 2
	ld	r7, r3, 16
	add	r31, r7, r6
	ld	r6, r31, 0
	st	r2, r3, 28
	mflr	r31
	mr	r2, r6
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	p_received_ray_20percent.2535
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 20
	addi	r6, r5, 1
	slwi	r6, r6, 2
	ld	r7, r3, 16
	add	r31, r7, r6
	ld	r6, r31, 0
	st	r2, r3, 32
	mflr	r31
	mr	r2, r6
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	p_received_ray_20percent.2535
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 20
	slwi	r6, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r6
	ld	r6, r31, 0
	st	r2, r3, 36
	mflr	r31
	mr	r2, r6
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	p_received_ray_20percent.2535
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 8
	slwi	r6, r5, 2
	ld	r7, r3, 24
	add	r31, r7, r6
	ld	r6, r31, 0
	ld	r7, r3, 4
	st	r2, r3, 40
	mflr	r31
	mr	r5, r6
	mr	r2, r7
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	veccpy.2447
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 8
	slwi	r5, r2, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r6, r3, 4
	mflr	r31
	mr	r2, r6
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	vecadd.2470
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 8
	slwi	r5, r2, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r6, r3, 4
	mflr	r31
	mr	r2, r6
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	vecadd.2470
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 8
	slwi	r5, r2, 2
	ld	r6, r3, 36
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r6, r3, 4
	mflr	r31
	mr	r2, r6
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	vecadd.2470
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 8
	slwi	r5, r2, 2
	ld	r6, r3, 40
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r6, r3, 4
	mflr	r31
	mr	r2, r6
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	vecadd.2470
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 20
	slwi	r2, r2, 2
	ld	r5, r3, 16
	add	r31, r5, r2
	ld	r2, r31, 0
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	p_energy.2533
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 8
	slwi	r5, r5, 2
	add	r31, r2, r5
	ld	r5, r31, 0
	ld	r2, r3, 0
	ld	r6, r3, 4
	b	vecaccumv.2479
do_without_neighbors.2795:
	ld	r6, r30, 4
	cmpwi	cr0, r5, 4
	blt	le.8888
	beq	le.8888
	blr
le.8888:
	st	r30, r3, 0
	st	r6, r3, 4
	st	r2, r3, 8
	st	r5, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	p_surface_ids.2529
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	slwi	r6, r5, 2
	add	r31, r2, r6
	ld	r2, r31, 0
	cmpwi	cr0, r2, 0
	blt	bge_else.8890
	ld	r2, r3, 8
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	p_calc_diffuse.2531
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	slwi	r6, r5, 2
	add	r31, r2, r6
	ld	r2, r31, 0
	cmpwi	cr0, r2, 0
	bne	beq_else.8891
	b	beq_cont.8892
beq_else.8891:
	ld	r2, r3, 8
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
beq_cont.8892:
	ld	r2, r3, 12
	addi	r5, r2, 1
	ld	r2, r3, 8
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
bge_else.8890:
	blr
neighbors_exist.2798:
	ld	r6, r30, 4
	ld	r7, r6, 4
	addi	r8, r5, 1
	cmpw	cr0, r7, r8
	blt	le.8894
	beq	le.8894
	cmpwi	cr0, r5, 0
	blt	le.8895
	beq	le.8895
	ld	r5, r6, 0
	addi	r6, r2, 1
	cmpw	cr0, r5, r6
	blt	le.8896
	beq	le.8896
	cmpwi	cr0, r2, 0
	blt	le.8897
	beq	le.8897
	li	r2, 1
	blr
le.8897:
	li	r2, 0
	blr
le.8896:
	li	r2, 0
	blr
le.8895:
	li	r2, 0
	blr
le.8894:
	li	r2, 0
	blr
get_surface_id.2802:
	st	r5, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	p_surface_ids.2529
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r5, r3, 0
	slwi	r5, r5, 2
	add	r31, r2, r5
	ld	r2, r31, 0
	blr
neighbors_are_available.2805:
	slwi	r9, r2, 2
	add	r31, r6, r9
	ld	r9, r31, 0
	st	r6, r3, 0
	st	r7, r3, 4
	st	r8, r3, 8
	st	r5, r3, 12
	st	r2, r3, 16
	mflr	r31
	mr	r5, r8
	mr	r2, r9
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	get_surface_id.2802
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 16
	slwi	r6, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r6
	ld	r6, r31, 0
	ld	r7, r3, 8
	st	r2, r3, 20
	mflr	r31
	mr	r5, r7
	mr	r2, r6
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	get_surface_id.2802
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 20
	cmpw	cr0, r2, r5
	bne	beq_else.8898
	ld	r2, r3, 16
	slwi	r6, r2, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	ld	r6, r31, 0
	ld	r7, r3, 8
	mflr	r31
	mr	r5, r7
	mr	r2, r6
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	get_surface_id.2802
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 20
	cmpw	cr0, r2, r5
	bne	beq_else.8899
	ld	r2, r3, 16
	addi	r6, r2, -1
	slwi	r6, r6, 2
	ld	r7, r3, 0
	add	r31, r7, r6
	ld	r6, r31, 0
	ld	r8, r3, 8
	mflr	r31
	mr	r5, r8
	mr	r2, r6
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	get_surface_id.2802
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 20
	cmpw	cr0, r2, r5
	bne	beq_else.8900
	ld	r2, r3, 16
	addi	r2, r2, 1
	slwi	r2, r2, 2
	ld	r6, r3, 0
	add	r31, r6, r2
	ld	r2, r31, 0
	ld	r6, r3, 8
	mflr	r31
	mr	r5, r6
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	get_surface_id.2802
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 20
	cmpw	cr0, r2, r5
	bne	beq_else.8901
	li	r2, 1
	blr
beq_else.8901:
	li	r2, 0
	blr
beq_else.8900:
	li	r2, 0
	blr
beq_else.8899:
	li	r2, 0
	blr
beq_else.8898:
	li	r2, 0
	blr
try_exploit_neighbors.2811:
	ld	r10, r30, 8
	ld	r11, r30, 4
	slwi	r12, r2, 2
	add	r31, r7, r12
	ld	r12, r31, 0
	cmpwi	cr0, r9, 4
	blt	le.8902
	beq	le.8902
	blr
le.8902:
	st	r5, r3, 0
	st	r30, r3, 4
	st	r11, r3, 8
	st	r12, r3, 12
	st	r10, r3, 16
	st	r9, r3, 20
	st	r8, r3, 24
	st	r7, r3, 28
	st	r6, r3, 32
	st	r2, r3, 36
	mflr	r31
	mr	r5, r9
	mr	r2, r12
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	get_surface_id.2802
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, 0
	blt	bge_else.8904
	ld	r2, r3, 36
	ld	r5, r3, 32
	ld	r6, r3, 28
	ld	r7, r3, 24
	ld	r8, r3, 20
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	neighbors_are_available.2805
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8905
	ld	r2, r3, 36
	slwi	r2, r2, 2
	ld	r5, r3, 28
	add	r31, r5, r2
	ld	r2, r31, 0
	ld	r5, r3, 20
	ld	r30, r3, 16
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8905:
	ld	r2, r3, 12
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	p_calc_diffuse.2531
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r8, r3, 20
	slwi	r5, r8, 2
	add	r31, r2, r5
	ld	r2, r31, 0
	cmpwi	cr0, r2, 0
	bne	beq_else.8906
	b	beq_cont.8907
beq_else.8906:
	ld	r2, r3, 36
	ld	r5, r3, 32
	ld	r6, r3, 28
	ld	r7, r3, 24
	ld	r30, r3, 8
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
beq_cont.8907:
	ld	r2, r3, 20
	addi	r9, r2, 1
	ld	r2, r3, 36
	ld	r5, r3, 0
	ld	r6, r3, 32
	ld	r7, r3, 28
	ld	r8, r3, 24
	ld	r30, r3, 4
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
bge_else.8904:
	blr
write_ppm_header.2818:
	ld	r2, r30, 4
	li	r5, 80
	st	r2, r3, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_char
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r2, 51
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_char
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r2, 10
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_char
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r2, r3, 0
	ld	r5, r2, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r2, 32
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_char
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r2, r3, 0
	ld	r2, r2, 4
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r2, 32
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_char
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r2, 255
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r2, 10
	b	min_caml_print_char
write_rgb_element.2820:
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_int_of_float
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	cmpwi	cr0, r2, 255
	blt	le.8909
	beq	le.8909
	li	r2, 255
	b	gt_cont.8910
le.8909:
	cmpwi	cr0, r2, 0
	blt	bge_else.8911
	b	bge_cont.8912
bge_else.8911:
	li	r2, 0
bge_cont.8912:
gt_cont.8910:
	b	min_caml_print_int
write_rgb.2822:
	ld	r2, r30, 4
	fld	fr1, r2, 0
	st	r2, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	write_rgb_element.2820
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r2, 32
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_char
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r2, r3, 0
	fld	fr1, r2, 4
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	write_rgb_element.2820
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r2, 32
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_char
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r2, r3, 0
	fld	fr1, r2, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	write_rgb_element.2820
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r2, 10
	b	min_caml_print_char
pretrace_diffuse_rays.2824:
	ld	r6, r30, 12
	ld	r7, r30, 8
	ld	r8, r30, 4
	cmpwi	cr0, r5, 4
	blt	le.8913
	beq	le.8913
	blr
le.8913:
	st	r30, r3, 0
	st	r6, r3, 4
	st	r7, r3, 8
	st	r8, r3, 12
	st	r5, r3, 16
	st	r2, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	get_surface_id.2802
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	blt	bge_else.8915
	ld	r2, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	p_calc_diffuse.2531
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 16
	slwi	r6, r5, 2
	add	r31, r2, r6
	ld	r2, r31, 0
	cmpwi	cr0, r2, 0
	bne	beq_else.8916
	b	beq_cont.8917
beq_else.8916:
	ld	r2, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	p_group_id.2537
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 12
	st	r2, r3, 24
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	vecbzero.2445
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	p_nvectors.2542
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 20
	st	r2, r3, 28
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	p_intersection_points.2527
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 24
	slwi	r5, r5, 2
	ld	r6, r3, 8
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r6, r3, 16
	slwi	r7, r6, 2
	ld	r8, r3, 28
	add	r31, r8, r7
	ld	r7, r31, 0
	slwi	r8, r6, 2
	add	r31, r2, r8
	ld	r2, r31, 0
	ld	r30, r3, 4
	mflr	r31
	mr	r6, r2
	mr	r2, r5
	mr	r5, r7
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 20
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	p_received_ray_20percent.2535
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 16
	slwi	r6, r5, 2
	add	r31, r2, r6
	ld	r2, r31, 0
	ld	r6, r3, 12
	mflr	r31
	mr	r5, r6
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	veccpy.2447
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
beq_cont.8917:
	ld	r2, r3, 16
	addi	r5, r2, 1
	ld	r2, r3, 20
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
bge_else.8915:
	blr
pretrace_pixels.2827:
	ld	r7, r30, 36
	ld	r8, r30, 32
	ld	r9, r30, 28
	ld	r10, r30, 24
	ld	r11, r30, 20
	ld	r12, r30, 16
	ld	r13, r30, 12
	ld	r14, r30, 8
	ld	r15, r30, 4
	cmpwi	cr0, r5, 0
	blt	bge_else.8919
	fld	fr4, r11, 0
	ld	r11, r15, 0
	sub	r11, r5, r11
	st	r30, r3, 0
	st	r14, r3, 4
	st	r6, r3, 8
	st	r8, r3, 12
	st	r2, r3, 16
	st	r5, r3, 20
	st	r7, r3, 24
	st	r9, r3, 28
	st	r12, r3, 32
	fst	fr3, r3, 36
	fst	fr2, r3, 40
	st	r13, r3, 44
	fst	fr1, r3, 48
	st	r10, r3, 52
	fst	fr4, r3, 56
	mflr	r31
	mr	r2, r11
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_float_of_int
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 56
	fmul	fr1, fr2, fr1
	ld	r2, r3, 52
	fld	fr2, r2, 0
	fmul	fr2, fr1, fr2
	fld	fr3, r3, 48
	fadd	fr2, fr2, fr3
	ld	r5, r3, 44
	fst	fr2, r5, 0
	fld	fr2, r2, 4
	fmul	fr2, fr1, fr2
	fld	fr4, r3, 40
	fadd	fr2, fr2, fr4
	fst	fr2, r5, 4
	fld	fr2, r2, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 36
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 8
	li	r2, 0
	mflr	r31
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	vecunit_sgn.2455
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 32
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	vecbzero.2445
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 28
	ld	r5, r3, 24
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	veccpy.2447
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	li	r2, 0
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 64
	fld	fr1, r3, 64
	ld	r5, r3, 20
	slwi	r6, r5, 2
	ld	r7, r3, 16
	add	r31, r7, r6
	ld	r6, r31, 0
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 64
	fld	fr2, r3, 64
	ld	r8, r3, 44
	ld	r30, r3, 12
	mflr	r31
	mr	r5, r8
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 20
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	p_rgb.2525
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 32
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	veccpy.2447
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 20
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r7, r3, 8
	mflr	r31
	mr	r2, r5
	mr	r5, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	p_set_group_id.2539
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 20
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r30, r3, 4
	mflr	r31
	mr	r2, r5
	mr	r5, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 20
	addi	r2, r2, -1
	li	r5, 1
	ld	r6, r3, 8
	st	r2, r3, 60
	mflr	r31
	mr	r2, r6
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	add_mod5.2434
	addi	r3, r3, -72
	ld	r31, r3, 68
	mr	r6, r2
	mtlr	r31
	fld	fr1, r3, 48
	fld	fr2, r3, 40
	fld	fr3, r3, 36
	ld	r2, r3, 16
	ld	r5, r3, 60
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
bge_else.8919:
	blr
pretrace_line.2834:
	ld	r7, r30, 24
	ld	r8, r30, 20
	ld	r9, r30, 16
	ld	r10, r30, 12
	ld	r11, r30, 8
	ld	r12, r30, 4
	fld	fr1, r9, 0
	ld	r9, r12, 4
	sub	r5, r5, r9
	st	r6, r3, 0
	st	r2, r3, 4
	st	r10, r3, 8
	st	r11, r3, 12
	st	r7, r3, 16
	st	r8, r3, 20
	fst	fr1, r3, 24
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_float_of_int
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 24
	fmul	fr1, fr2, fr1
	ld	r2, r3, 20
	fld	fr2, r2, 0
	fmul	fr2, fr1, fr2
	ld	r5, r3, 16
	fld	fr3, r5, 0
	fadd	fr2, fr2, fr3
	fld	fr3, r2, 4
	fmul	fr3, fr1, fr3
	fld	fr4, r5, 4
	fadd	fr3, fr3, fr4
	fld	fr4, r2, 8
	fmul	fr1, fr1, fr4
	fld	fr4, r5, 8
	fadd	fr1, fr1, fr4
	ld	r2, r3, 12
	ld	r2, r2, 0
	addi	r5, r2, -1
	ld	r2, r3, 4
	ld	r6, r3, 0
	ld	r30, r3, 8
	fmr	fr31, fr3
	fmr	fr3, fr1
	fmr	fr1, fr2
	fmr	fr2, fr31
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
scan_pixel.2838:
	ld	r9, r30, 24
	ld	r10, r30, 20
	ld	r11, r30, 16
	ld	r12, r30, 12
	ld	r13, r30, 8
	ld	r14, r30, 4
	ld	r13, r13, 0
	cmpw	cr0, r13, r2
	blt	le.8921
	beq	le.8921
	slwi	r13, r2, 2
	add	r31, r7, r13
	ld	r13, r31, 0
	st	r30, r3, 0
	st	r9, r3, 4
	st	r6, r3, 8
	st	r10, r3, 12
	st	r14, r3, 16
	st	r7, r3, 20
	st	r8, r3, 24
	st	r5, r3, 28
	st	r2, r3, 32
	st	r12, r3, 36
	st	r11, r3, 40
	mflr	r31
	mr	r2, r13
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	p_rgb.2525
	addi	r3, r3, -48
	ld	r31, r3, 44
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	veccpy.2447
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 32
	ld	r5, r3, 28
	ld	r6, r3, 24
	ld	r30, r3, 36
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.8922
	ld	r2, r3, 32
	slwi	r5, r2, 2
	ld	r6, r3, 20
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r30, r3, 16
	mflr	r31
	mr	r2, r5
	mr	r5, r7
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	b	beq_cont.8923
beq_else.8922:
	li	r9, 0
	ld	r2, r3, 32
	ld	r5, r3, 28
	ld	r6, r3, 8
	ld	r7, r3, 20
	ld	r8, r3, 24
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
beq_cont.8923:
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 32
	addi	r2, r2, 1
	ld	r5, r3, 28
	ld	r6, r3, 8
	ld	r7, r3, 20
	ld	r8, r3, 24
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
le.8921:
	blr
scan_line.2844:
	ld	r9, r30, 12
	ld	r10, r30, 8
	ld	r11, r30, 4
	ld	r12, r11, 4
	cmpw	cr0, r12, r2
	blt	le.8925
	beq	le.8925
	ld	r11, r11, 4
	addi	r11, r11, -1
	st	r30, r3, 0
	st	r8, r3, 4
	st	r7, r3, 8
	st	r6, r3, 12
	st	r5, r3, 16
	st	r2, r3, 20
	st	r9, r3, 24
	cmpw	cr0, r11, r2
	blt	le.8926
	beq	le.8926
	addi	r11, r2, 1
	mflr	r31
	mr	r6, r8
	mr	r5, r11
	mr	r2, r7
	mr	r30, r10
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	b	gt_cont.8927
le.8926:
gt_cont.8927:
	li	r2, 0
	ld	r5, r3, 20
	ld	r6, r3, 16
	ld	r7, r3, 12
	ld	r8, r3, 8
	ld	r30, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 20
	addi	r2, r2, 1
	li	r5, 2
	ld	r6, r3, 4
	st	r2, r3, 28
	mflr	r31
	mr	r2, r6
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	add_mod5.2434
	addi	r3, r3, -40
	ld	r31, r3, 36
	mr	r8, r2
	mtlr	r31
	ld	r2, r3, 28
	ld	r5, r3, 12
	ld	r6, r3, 8
	ld	r7, r3, 16
	ld	r30, r3, 0
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	blr
le.8925:
	blr
create_float5x3array.2850:
	li	r2, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_create_float_array
	addi	r3, r3, -8
	ld	r31, r3, 4
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_create_array
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	st	r2, r3, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_create_float_array
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r5, r3, 0
	st	r2, r5, 4
	li	r2, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_create_float_array
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r5, r3, 0
	st	r2, r5, 8
	li	r2, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_create_float_array
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r5, r3, 0
	st	r2, r5, 12
	li	r2, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_create_float_array
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r5, r3, 0
	st	r2, r5, 16
	mr	r2, r5
	blr
create_pixel.2852:
	li	r2, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_create_float_array
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	st	r2, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	create_float5x3array.2850
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r5, 5
	li	r6, 0
	st	r2, r3, 4
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	li	r5, 5
	li	r6, 0
	st	r2, r3, 8
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	st	r2, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	create_float5x3array.2850
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	st	r2, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	create_float5x3array.2850
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r5, 1
	li	r6, 0
	st	r2, r3, 20
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	st	r2, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	create_float5x3array.2850
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 32
	st	r2, r5, 28
	ld	r2, r3, 24
	st	r2, r5, 24
	ld	r2, r3, 20
	st	r2, r5, 20
	ld	r2, r3, 16
	st	r2, r5, 16
	ld	r2, r3, 12
	st	r2, r5, 12
	ld	r2, r3, 8
	st	r2, r5, 8
	ld	r2, r3, 4
	st	r2, r5, 4
	ld	r2, r3, 0
	st	r2, r5, 0
	mr	r2, r5
	blr
init_line_elements.2854:
	cmpwi	cr0, r5, 0
	blt	bge_else.8930
	st	r2, r3, 0
	st	r5, r3, 4
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	create_pixel.2852
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 4
	slwi	r6, r5, 2
	ld	r7, r3, 0
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r5, r5, -1
	mr	r2, r7
	b	init_line_elements.2854
bge_else.8930:
	blr
create_pixelline.2857:
	ld	r2, r30, 4
	ld	r5, r2, 0
	st	r2, r3, 0
	st	r5, r3, 4
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	create_pixel.2852
	addi	r3, r3, -16
	ld	r31, r3, 12
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 4
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 0
	ld	r5, r5, 0
	addi	r5, r5, -2
	b	init_line_elements.2854
tan.2859:
	fst	fr1, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_sin
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	fld	fr2, r3, 0
	fst	fr1, r3, 4
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_cos
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	fld	fr2, r3, 4
	fdiv	fr1, fr2, fr1
	blr
adjust_position.2861:
	fmul	fr1, fr1, fr1
	li	r31, 15821
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r3, 8
	fld	fr3, r3, 8
	fadd	fr1, fr1, fr3
	fst	fr2, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_sqrt
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	fdiv	fr2, fr2, fr1
	fst	fr1, r3, 4
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_atan
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	fld	fr2, r3, 0
	fmul	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	tan.2859
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	fld	fr2, r3, 4
	fmul	fr1, fr1, fr2
	blr
calc_dirvec.2864:
	ld	r7, r30, 4
	cmpwi	cr0, r2, 5
	blt	bge_else.8931
	st	r6, r3, 0
	st	r7, r3, 4
	st	r5, r3, 8
	fst	fr1, r3, 12
	fst	fr2, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_fsqr
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 16
	fst	fr1, r3, 20
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_fsqr
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 20
	fadd	fr1, fr2, fr1
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 32
	fld	fr2, r3, 32
	fadd	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_sqrt
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 12
	fdiv	fr2, fr2, fr1
	fld	fr3, r3, 16
	fdiv	fr3, fr3, fr1
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 32
	fld	fr4, r3, 32
	fdiv	fr1, fr4, fr1
	ld	r2, r3, 8
	slwi	r2, r2, 2
	ld	r5, r3, 4
	add	r31, r5, r2
	ld	r2, r31, 0
	ld	r5, r3, 0
	slwi	r6, r5, 2
	add	r31, r2, r6
	ld	r6, r31, 0
	st	r2, r3, 24
	fst	fr1, r3, 28
	fst	fr3, r3, 32
	fst	fr2, r3, 36
	mflr	r31
	mr	r2, r6
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	d_vec.2544
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr1, r3, 36
	fld	fr2, r3, 32
	fld	fr3, r3, 28
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	vecset.2437
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 0
	addi	r5, r2, 40
	slwi	r5, r5, 2
	ld	r6, r3, 24
	add	r31, r6, r5
	ld	r5, r31, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	d_vec.2544
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr1, r3, 32
	fsub	fr3, fr0, fr1
	fld	fr2, r3, 36
	fld	fr4, r3, 28
	mflr	r31
	fmr	fr1, fr2
	fmr	fr2, fr4
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	vecset.2437
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 0
	addi	r5, r2, 80
	slwi	r5, r5, 2
	ld	r6, r3, 24
	add	r31, r6, r5
	ld	r5, r31, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	d_vec.2544
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr1, r3, 36
	fsub	fr2, fr0, fr1
	fld	fr3, r3, 32
	fsub	fr4, fr0, fr3
	fld	fr5, r3, 28
	mflr	r31
	fmr	fr3, fr4
	fmr	fr1, fr5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	vecset.2437
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 0
	addi	r5, r2, 1
	slwi	r5, r5, 2
	ld	r6, r3, 24
	add	r31, r6, r5
	ld	r5, r31, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	d_vec.2544
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr1, r3, 36
	fsub	fr2, fr0, fr1
	fld	fr3, r3, 32
	fsub	fr4, fr0, fr3
	fld	fr5, r3, 28
	fsub	fr6, fr0, fr5
	mflr	r31
	fmr	fr3, fr6
	fmr	fr1, fr2
	fmr	fr2, fr4
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	vecset.2437
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 0
	addi	r5, r2, 41
	slwi	r5, r5, 2
	ld	r6, r3, 24
	add	r31, r6, r5
	ld	r5, r31, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	d_vec.2544
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr1, r3, 36
	fsub	fr2, fr0, fr1
	fld	fr3, r3, 28
	fsub	fr4, fr0, fr3
	fld	fr5, r3, 32
	mflr	r31
	fmr	fr3, fr5
	fmr	fr1, fr2
	fmr	fr2, fr4
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	vecset.2437
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 0
	addi	r2, r2, 81
	slwi	r2, r2, 2
	ld	r5, r3, 24
	add	r31, r5, r2
	ld	r2, r31, 0
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	d_vec.2544
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr1, r3, 28
	fsub	fr1, fr0, fr1
	fld	fr2, r3, 36
	fld	fr3, r3, 32
	b	vecset.2437
bge_else.8931:
	fst	fr3, r3, 40
	st	r6, r3, 0
	st	r5, r3, 8
	st	r30, r3, 44
	fst	fr4, r3, 48
	st	r2, r3, 52
	mflr	r31
	fmr	fr1, fr2
	fmr	fr2, fr3
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	adjust_position.2861
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 52
	addi	r2, r2, 1
	fld	fr2, r3, 48
	fst	fr1, r3, 56
	st	r2, r3, 60
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	adjust_position.2861
	addi	r3, r3, -72
	ld	r31, r3, 68
	fmr	fr2, fr1
	mtlr	r31
	fld	fr1, r3, 56
	fld	fr3, r3, 40
	fld	fr4, r3, 48
	ld	r2, r3, 60
	ld	r5, r3, 8
	ld	r6, r3, 0
	ld	r30, r3, 44
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
calc_dirvecs.2872:
	ld	r7, r30, 4
	cmpwi	cr0, r2, 0
	blt	bge_else.8932
	st	r30, r3, 0
	st	r2, r3, 4
	fst	fr1, r3, 8
	st	r6, r3, 12
	st	r5, r3, 16
	st	r7, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_float_of_int
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	li	r31, 15949
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r3, 32
	fld	fr2, r3, 32
	fmul	fr1, fr1, fr2
	li	r31, 16230
	slwi	r31, r31, 16
	addi	r31, r31, 26214
	st	r31, r3, 32
	fld	fr2, r3, 32
	fsub	fr3, fr1, fr2
	li	r2, 0
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 32
	fld	fr1, r3, 32
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 32
	fld	fr2, r3, 32
	fld	fr4, r3, 8
	ld	r5, r3, 16
	ld	r6, r3, 12
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 4
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_float_of_int
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	li	r31, 15949
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r3, 32
	fld	fr2, r3, 32
	fmul	fr1, fr1, fr2
	li	r31, 15821
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r3, 32
	fld	fr2, r3, 32
	fadd	fr3, fr1, fr2
	li	r2, 0
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 32
	fld	fr1, r3, 32
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 32
	fld	fr2, r3, 32
	ld	r5, r3, 12
	addi	r6, r5, 2
	fld	fr4, r3, 8
	ld	r7, r3, 16
	ld	r30, r3, 20
	mflr	r31
	mr	r5, r7
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 4
	addi	r2, r2, -1
	li	r5, 1
	ld	r6, r3, 16
	st	r2, r3, 24
	mflr	r31
	mr	r2, r6
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	add_mod5.2434
	addi	r3, r3, -32
	ld	r31, r3, 28
	mr	r5, r2
	mtlr	r31
	fld	fr1, r3, 8
	ld	r2, r3, 24
	ld	r6, r3, 12
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
bge_else.8932:
	blr
calc_dirvec_rows.2877:
	ld	r7, r30, 4
	cmpwi	cr0, r2, 0
	blt	bge_else.8934
	st	r30, r3, 0
	st	r2, r3, 4
	st	r6, r3, 8
	st	r5, r3, 12
	st	r7, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_float_of_int
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r31, 15949
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r3, 24
	fld	fr2, r3, 24
	fmul	fr1, fr1, fr2
	li	r31, 16230
	slwi	r31, r31, 16
	addi	r31, r31, 26214
	st	r31, r3, 24
	fld	fr2, r3, 24
	fsub	fr1, fr1, fr2
	li	r2, 4
	ld	r5, r3, 12
	ld	r6, r3, 8
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 4
	addi	r2, r2, -1
	li	r5, 2
	ld	r6, r3, 12
	st	r2, r3, 20
	mflr	r31
	mr	r2, r6
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	add_mod5.2434
	addi	r3, r3, -32
	ld	r31, r3, 28
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 8
	addi	r6, r2, 4
	ld	r2, r3, 20
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
bge_else.8934:
	blr
create_dirvec.2881:
	ld	r2, r30, 4
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	st	r2, r3, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_create_float_array
	addi	r3, r3, -8
	ld	r31, r3, 4
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 0
	ld	r2, r2, 0
	st	r5, r3, 4
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 4
	st	r2, r5, 0
	mr	r2, r5
	blr
create_dirvec_elements.2883:
	ld	r6, r30, 4
	cmpwi	cr0, r5, 0
	blt	bge_else.8936
	st	r30, r3, 0
	st	r2, r3, 4
	st	r5, r3, 8
	mflr	r31
	mr	r30, r6
	st	r31, r3, 12
	addi	r3, r3, 16
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 8
	slwi	r6, r5, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r5, r5, -1
	ld	r30, r3, 0
	mr	r2, r7
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
bge_else.8936:
	blr
create_dirvecs.2886:
	ld	r5, r30, 12
	ld	r6, r30, 8
	ld	r7, r30, 4
	cmpwi	cr0, r2, 0
	blt	bge_else.8938
	li	r8, 120
	st	r30, r3, 0
	st	r6, r3, 4
	st	r5, r3, 8
	st	r2, r3, 12
	st	r8, r3, 16
	mflr	r31
	mr	r30, r7
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	slwi	r6, r5, 2
	ld	r7, r3, 8
	add	r31, r7, r6
	st	r2, r31, 0
	slwi	r2, r5, 2
	add	r31, r7, r2
	ld	r2, r31, 0
	li	r6, 118
	ld	r30, r3, 4
	mflr	r31
	mr	r5, r6
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 12
	addi	r2, r2, -1
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
bge_else.8938:
	blr
init_dirvec_constants.2888:
	ld	r6, r30, 4
	cmpwi	cr0, r5, 0
	blt	bge_else.8940
	slwi	r7, r5, 2
	add	r31, r2, r7
	ld	r7, r31, 0
	st	r2, r3, 0
	st	r30, r3, 4
	st	r5, r3, 8
	mflr	r31
	mr	r2, r7
	mr	r30, r6
	st	r31, r3, 12
	addi	r3, r3, 16
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r2, r3, 8
	addi	r5, r2, -1
	ld	r2, r3, 0
	ld	r30, r3, 4
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
bge_else.8940:
	blr
init_vecset_constants.2891:
	ld	r5, r30, 8
	ld	r6, r30, 4
	cmpwi	cr0, r2, 0
	blt	bge_else.8942
	slwi	r7, r2, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	li	r7, 119
	st	r30, r3, 0
	st	r2, r3, 4
	mflr	r31
	mr	r2, r6
	mr	r30, r5
	mr	r5, r7
	st	r31, r3, 12
	addi	r3, r3, 16
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r2, r3, 4
	addi	r2, r2, -1
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
bge_else.8942:
	blr
init_dirvecs.2893:
	ld	r2, r30, 12
	ld	r5, r30, 8
	ld	r6, r30, 4
	li	r7, 4
	st	r2, r3, 0
	st	r6, r3, 4
	mflr	r31
	mr	r2, r7
	mr	r30, r5
	st	r31, r3, 12
	addi	r3, r3, 16
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	li	r2, 9
	li	r5, 0
	li	r6, 0
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	li	r2, 4
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
add_reflection.2895:
	ld	r6, r30, 12
	ld	r7, r30, 8
	ld	r30, r30, 4
	st	r7, r3, 0
	st	r2, r3, 4
	st	r5, r3, 8
	fst	fr1, r3, 12
	st	r6, r3, 16
	fst	fr4, r3, 20
	fst	fr3, r3, 24
	fst	fr2, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	st	r2, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	d_vec.2544
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr1, r3, 28
	fld	fr2, r3, 24
	fld	fr3, r3, 20
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	vecset.2437
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 32
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	mr	r2, r4
	addi	r4, r4, 16
	fld	fr1, r3, 12
	fst	fr1, r2, 8
	ld	r5, r3, 32
	st	r5, r2, 4
	ld	r5, r3, 8
	st	r5, r2, 0
	ld	r5, r3, 4
	slwi	r5, r5, 2
	ld	r6, r3, 0
	add	r31, r6, r5
	st	r2, r31, 0
	blr
setup_rect_reflection.2902:
	ld	r6, r30, 12
	ld	r7, r30, 8
	ld	r8, r30, 4
	slwi	r2, r2, 2
	ld	r9, r6, 0
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	st	r6, r3, 0
	st	r9, r3, 4
	st	r8, r3, 8
	st	r2, r3, 12
	st	r7, r3, 16
	fst	fr1, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_diffuse.2507
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 20
	fsub	fr1, fr2, fr1
	ld	r2, r3, 16
	fld	fr2, r2, 0
	fsub	fr2, fr0, fr2
	fld	fr3, r2, 4
	fsub	fr3, fr0, fr3
	fld	fr4, r2, 8
	fsub	fr4, fr0, fr4
	ld	r5, r3, 12
	addi	r6, r5, 1
	fld	fr5, r2, 0
	ld	r7, r3, 4
	ld	r30, r3, 8
	fst	fr3, r3, 24
	fst	fr4, r3, 28
	fst	fr2, r3, 32
	fst	fr1, r3, 36
	mflr	r31
	mr	r5, r6
	mr	r2, r7
	fmr	fr2, fr5
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 4
	addi	r5, r2, 1
	ld	r6, r3, 12
	addi	r7, r6, 2
	ld	r8, r3, 16
	fld	fr3, r8, 4
	fld	fr1, r3, 36
	fld	fr2, r3, 32
	fld	fr4, r3, 28
	ld	r30, r3, 8
	mflr	r31
	mr	r2, r5
	mr	r5, r7
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 4
	addi	r5, r2, 2
	ld	r6, r3, 12
	addi	r6, r6, 3
	ld	r7, r3, 16
	fld	fr4, r7, 8
	fld	fr1, r3, 36
	fld	fr2, r3, 32
	fld	fr3, r3, 24
	ld	r30, r3, 8
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 4
	addi	r2, r2, 3
	ld	r5, r3, 0
	st	r2, r5, 0
	blr
setup_surface_reflection.2905:
	ld	r6, r30, 12
	ld	r7, r30, 8
	ld	r8, r30, 4
	slwi	r2, r2, 2
	addi	r2, r2, 1
	ld	r9, r6, 0
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	st	r6, r3, 0
	st	r2, r3, 4
	st	r9, r3, 8
	st	r8, r3, 12
	st	r7, r3, 16
	st	r5, r3, 20
	fst	fr1, r3, 24
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	o_diffuse.2507
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 24
	fsub	fr1, fr2, fr1
	ld	r2, r3, 20
	fst	fr1, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	o_param_abc.2499
	addi	r3, r3, -40
	ld	r31, r3, 36
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	veciprod.2458
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	li	r31, 16384
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr2, r3, 40
	ld	r2, r3, 20
	fst	fr1, r3, 32
	fst	fr2, r3, 36
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	o_param_a.2493
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 36
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 32
	fmul	fr1, fr1, fr2
	ld	r2, r3, 16
	fld	fr3, r2, 0
	fsub	fr1, fr1, fr3
	li	r31, 16384
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 48
	fld	fr3, r3, 48
	ld	r5, r3, 20
	fst	fr1, r3, 40
	fst	fr3, r3, 44
	mflr	r31
	mr	r2, r5
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	o_param_b.2495
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 44
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 32
	fmul	fr1, fr1, fr2
	ld	r2, r3, 16
	fld	fr3, r2, 4
	fsub	fr1, fr1, fr3
	li	r31, 16384
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 56
	fld	fr3, r3, 56
	ld	r5, r3, 20
	fst	fr1, r3, 48
	fst	fr3, r3, 52
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	o_param_c.2497
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 52
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 32
	fmul	fr1, fr1, fr2
	ld	r2, r3, 16
	fld	fr2, r2, 8
	fsub	fr4, fr1, fr2
	fld	fr1, r3, 28
	fld	fr2, r3, 40
	fld	fr3, r3, 48
	ld	r2, r3, 8
	ld	r5, r3, 4
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 8
	addi	r2, r2, 1
	ld	r5, r3, 0
	st	r2, r5, 0
	blr
setup_reflections.2908:
	ld	r5, r30, 12
	ld	r6, r30, 8
	ld	r7, r30, 4
	cmpwi	cr0, r2, 0
	blt	bge_else.8947
	slwi	r8, r2, 2
	add	r31, r7, r8
	ld	r7, r31, 0
	st	r5, r3, 0
	st	r2, r3, 4
	st	r6, r3, 8
	st	r7, r3, 12
	mflr	r31
	mr	r2, r7
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_reflectiontype.2487
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, 2
	bne	beq_else.8948
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 24
	fld	fr1, r3, 24
	ld	r2, r3, 12
	fst	fr1, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_diffuse.2507
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 16
	fcmp	cr0, fr2, fr1
	blt	le.8949
	beq	le.8949
	ld	r2, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	o_form.2485
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, 1
	bne	beq_else.8950
	ld	r2, r3, 4
	ld	r5, r3, 12
	ld	r30, r3, 8
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8950:
	cmpwi	cr0, r2, 2
	bne	beq_else.8951
	ld	r2, r3, 4
	ld	r5, r3, 12
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
beq_else.8951:
	blr
le.8949:
	blr
beq_else.8948:
	blr
bge_else.8947:
	blr
rt.2910:
	ld	r6, r30, 56
	ld	r7, r30, 52
	ld	r8, r30, 48
	ld	r9, r30, 44
	ld	r10, r30, 40
	ld	r11, r30, 36
	ld	r12, r30, 32
	ld	r13, r30, 28
	ld	r14, r30, 24
	ld	r15, r30, 20
	ld	r16, r30, 16
	ld	r17, r30, 12
	ld	r18, r30, 8
	ld	r19, r30, 4
	st	r2, r17, 0
	st	r5, r17, 4
	srwi	r17, r2, 1
	st	r17, r18, 0
	srwi	r5, r5, 1
	st	r5, r18, 4
	li	r31, 17152
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	st	r10, r3, 0
	st	r12, r3, 4
	st	r7, r3, 8
	st	r13, r3, 12
	st	r8, r3, 16
	st	r15, r3, 20
	st	r14, r3, 24
	st	r16, r3, 28
	st	r6, r3, 32
	st	r11, r3, 36
	st	r19, r3, 40
	st	r9, r3, 44
	fst	fr1, r3, 48
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_float_of_int
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 48
	fdiv	fr1, fr2, fr1
	ld	r2, r3, 44
	fst	fr1, r2, 0
	ld	r30, r3, 40
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r30, r3, 40
	st	r2, r3, 52
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r30, r3, 40
	st	r2, r3, 56
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r30, r3, 36
	st	r2, r3, 60
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r30, r3, 32
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r30, r3, 28
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 24
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	d_vec.2544
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r5, r3, 20
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	veccpy.2447
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 24
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 12
	ld	r2, r2, 0
	addi	r2, r2, -1
	ld	r30, r3, 8
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	li	r5, 0
	li	r6, 0
	ld	r2, r3, 56
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	li	r2, 0
	li	r8, 2
	ld	r5, r3, 52
	ld	r6, r3, 56
	ld	r7, r3, 60
	ld	r30, r3, 0
	ld	r29, r30, 0
	mr	r29, r29
	ba r29
_min_caml_start:
#	main program starts
	li	r2, 1
	li	r5, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_create_array
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r5, 0
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	st	r2, r3, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_create_float_array
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r5, 60
	li	r6, 0
	li	r7, 0
	li	r8, 0
	li	r9, 0
	li	r10, 0
	mr	r11, r4
	addi	r4, r4, 48
	st	r2, r11, 40
	st	r2, r11, 36
	st	r2, r11, 32
	st	r2, r11, 28
	st	r10, r11, 24
	st	r2, r11, 20
	st	r2, r11, 16
	st	r9, r11, 12
	st	r8, r11, 8
	st	r7, r11, 4
	st	r6, r11, 0
	mr	r2, r11
	mflr	r31
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_create_array
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	st	r2, r3, 4
	mflr	r31
	mr	r2, r5
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 16
	fld	fr1, r3, 16
	st	r2, r3, 8
	mflr	r31
	mr	r2, r5
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 16
	fld	fr1, r3, 16
	st	r2, r3, 12
	mflr	r31
	mr	r2, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r5, 1
	li	r31, 17279
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 24
	fld	fr1, r3, 24
	st	r2, r3, 16
	mflr	r31
	mr	r2, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r5, 50
	li	r6, 1
	li	r7, -1
	st	r2, r3, 20
	st	r5, r3, 24
	mflr	r31
	mr	r5, r7
	mr	r2, r6
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	li	r5, 1
	li	r6, 1
	ld	r7, r2, 0
	st	r2, r3, 28
	st	r5, r3, 32
	mflr	r31
	mr	r5, r7
	mr	r2, r6
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	li	r5, 1
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 40
	fld	fr1, r3, 40
	st	r2, r3, 36
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	li	r5, 1
	li	r6, 0
	st	r2, r3, 40
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	li	r5, 1
	li	r31, 20078
	slwi	r31, r31, 16
	addi	r31, r31, 27432
	st	r31, r3, 48
	fld	fr1, r3, 48
	st	r2, r3, 44
	mflr	r31
	mr	r2, r5
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_float_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 56
	fld	fr1, r3, 56
	st	r2, r3, 48
	mflr	r31
	mr	r2, r5
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_float_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	li	r5, 1
	li	r6, 0
	st	r2, r3, 52
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 64
	fld	fr1, r3, 64
	st	r2, r3, 56
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_float_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 64
	fld	fr1, r3, 64
	st	r2, r3, 60
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_float_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 72
	fld	fr1, r3, 72
	st	r2, r3, 64
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_float_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 72
	fld	fr1, r3, 72
	st	r2, r3, 68
	mflr	r31
	mr	r2, r5
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_float_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	li	r5, 2
	li	r6, 0
	st	r2, r3, 72
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	li	r5, 2
	li	r6, 0
	st	r2, r3, 76
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	li	r5, 1
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 88
	fld	fr1, r3, 88
	st	r2, r3, 80
	mflr	r31
	mr	r2, r5
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_float_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 88
	fld	fr1, r3, 88
	st	r2, r3, 84
	mflr	r31
	mr	r2, r5
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_float_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 96
	fld	fr1, r3, 96
	st	r2, r3, 88
	mflr	r31
	mr	r2, r5
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_float_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 96
	fld	fr1, r3, 96
	st	r2, r3, 92
	mflr	r31
	mr	r2, r5
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_float_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 104
	fld	fr1, r3, 104
	st	r2, r3, 96
	mflr	r31
	mr	r2, r5
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_float_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 104
	fld	fr1, r3, 104
	st	r2, r3, 100
	mflr	r31
	mr	r2, r5
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_create_float_array
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 112
	fld	fr1, r3, 112
	st	r2, r3, 104
	mflr	r31
	mr	r2, r5
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_create_float_array
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	li	r5, 0
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 112
	fld	fr1, r3, 112
	st	r2, r3, 108
	mflr	r31
	mr	r2, r5
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_create_float_array
	addi	r3, r3, -120
	ld	r31, r3, 116
	mr	r5, r2
	mtlr	r31
	li	r2, 0
	st	r5, r3, 112
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_create_array
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	li	r5, 0
	mr	r6, r4
	addi	r4, r4, 8
	st	r2, r6, 4
	ld	r2, r3, 112
	st	r2, r6, 0
	mr	r2, r6
	mflr	r31
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_create_array
	addi	r3, r3, -120
	ld	r31, r3, 116
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_create_array
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	li	r5, 0
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 120
	fld	fr1, r3, 120
	st	r2, r3, 116
	mflr	r31
	mr	r2, r5
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_create_float_array
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	li	r5, 3
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 128
	fld	fr1, r3, 128
	st	r2, r3, 120
	mflr	r31
	mr	r2, r5
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_create_float_array
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	li	r5, 60
	ld	r6, r3, 120
	st	r2, r3, 124
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_create_array
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 124
	st	r2, r5, 0
	mr	r2, r5
	li	r5, 0
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 136
	fld	fr1, r3, 136
	st	r2, r3, 128
	mflr	r31
	mr	r2, r5
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_create_float_array
	addi	r3, r3, -136
	ld	r31, r3, 132
	mr	r5, r2
	mtlr	r31
	li	r2, 0
	st	r5, r3, 132
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_create_array
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 132
	st	r2, r5, 0
	mr	r2, r5
	li	r5, 180
	li	r6, 0
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 144
	fld	fr1, r3, 144
	mr	r7, r4
	addi	r4, r4, 16
	fst	fr1, r7, 8
	st	r2, r7, 4
	st	r6, r7, 0
	mr	r2, r7
	mflr	r31
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_create_array
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	li	r5, 1
	li	r6, 0
	st	r2, r3, 136
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_create_array
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 24
	li	r6, lo16(read_screen_settings.2556)
	slwi	r6, r6, 16
	srwi	r6, r6, 31
	addi	r6, r6, ha16(read_screen_settings.2556)
	slwi	r6, r6, 16
	addi	r6, r6, lo16(read_screen_settings.2556)
	st	r6, r5, 0
	ld	r6, r3, 12
	st	r6, r5, 20
	ld	r7, r3, 104
	st	r7, r5, 16
	ld	r8, r3, 100
	st	r8, r5, 12
	ld	r9, r3, 96
	st	r9, r5, 8
	ld	r10, r3, 8
	st	r10, r5, 4
	mr	r10, r4
	addi	r4, r4, 16
	li	r11, lo16(read_light.2558)
	slwi	r11, r11, 16
	srwi	r11, r11, 31
	addi	r11, r11, ha16(read_light.2558)
	slwi	r11, r11, 16
	addi	r11, r11, lo16(read_light.2558)
	st	r11, r10, 0
	ld	r11, r3, 16
	st	r11, r10, 8
	ld	r12, r3, 20
	st	r12, r10, 4
	mr	r13, r4
	addi	r4, r4, 8
	li	r14, lo16(read_nth_object.2563)
	slwi	r14, r14, 16
	srwi	r14, r14, 31
	addi	r14, r14, ha16(read_nth_object.2563)
	slwi	r14, r14, 16
	addi	r14, r14, lo16(read_nth_object.2563)
	st	r14, r13, 0
	ld	r14, r3, 4
	st	r14, r13, 4
	mr	r15, r4
	addi	r4, r4, 16
	li	r16, lo16(read_object.2565)
	slwi	r16, r16, 16
	srwi	r16, r16, 31
	addi	r16, r16, ha16(read_object.2565)
	slwi	r16, r16, 16
	addi	r16, r16, lo16(read_object.2565)
	st	r16, r15, 0
	st	r13, r15, 8
	ld	r13, r3, 0
	st	r13, r15, 4
	mr	r16, r4
	addi	r4, r4, 8
	li	r17, lo16(read_all_object.2567)
	slwi	r17, r17, 16
	srwi	r17, r17, 31
	addi	r17, r17, ha16(read_all_object.2567)
	slwi	r17, r17, 16
	addi	r17, r17, lo16(read_all_object.2567)
	st	r17, r16, 0
	st	r15, r16, 4
	mr	r15, r4
	addi	r4, r4, 8
	li	r17, lo16(read_and_network.2573)
	slwi	r17, r17, 16
	srwi	r17, r17, 31
	addi	r17, r17, ha16(read_and_network.2573)
	slwi	r17, r17, 16
	addi	r17, r17, lo16(read_and_network.2573)
	st	r17, r15, 0
	ld	r17, r3, 28
	st	r17, r15, 4
	mr	r18, r4
	addi	r4, r4, 24
	li	r19, lo16(read_parameter.2575)
	slwi	r19, r19, 16
	srwi	r19, r19, 31
	addi	r19, r19, ha16(read_parameter.2575)
	slwi	r19, r19, 16
	addi	r19, r19, lo16(read_parameter.2575)
	st	r19, r18, 0
	st	r5, r18, 20
	st	r10, r18, 16
	st	r15, r18, 12
	st	r16, r18, 8
	ld	r5, r3, 36
	st	r5, r18, 4
	mr	r10, r4
	addi	r4, r4, 8
	li	r15, lo16(solver_rect_surface.2577)
	slwi	r15, r15, 16
	srwi	r15, r15, 31
	addi	r15, r15, ha16(solver_rect_surface.2577)
	slwi	r15, r15, 16
	addi	r15, r15, lo16(solver_rect_surface.2577)
	st	r15, r10, 0
	ld	r15, r3, 40
	st	r15, r10, 4
	mr	r16, r4
	addi	r4, r4, 8
	li	r19, lo16(solver_rect.2586)
	slwi	r19, r19, 16
	srwi	r19, r19, 31
	addi	r19, r19, ha16(solver_rect.2586)
	slwi	r19, r19, 16
	addi	r19, r19, lo16(solver_rect.2586)
	st	r19, r16, 0
	st	r10, r16, 4
	mr	r10, r4
	addi	r4, r4, 8
	li	r19, lo16(solver_surface.2592)
	slwi	r19, r19, 16
	srwi	r19, r19, 31
	addi	r19, r19, ha16(solver_surface.2592)
	slwi	r19, r19, 16
	addi	r19, r19, lo16(solver_surface.2592)
	st	r19, r10, 0
	st	r15, r10, 4
	mr	r19, r4
	addi	r4, r4, 8
	li	r20, lo16(solver_second.2611)
	slwi	r20, r20, 16
	srwi	r20, r20, 31
	addi	r20, r20, ha16(solver_second.2611)
	slwi	r20, r20, 16
	addi	r20, r20, lo16(solver_second.2611)
	st	r20, r19, 0
	st	r15, r19, 4
	mr	r20, r4
	addi	r4, r4, 24
	li	r21, lo16(solver.2617)
	slwi	r21, r21, 16
	srwi	r21, r21, 31
	addi	r21, r21, ha16(solver.2617)
	slwi	r21, r21, 16
	addi	r21, r21, lo16(solver.2617)
	st	r21, r20, 0
	st	r10, r20, 16
	st	r19, r20, 12
	st	r16, r20, 8
	st	r14, r20, 4
	mr	r10, r4
	addi	r4, r4, 8
	li	r16, lo16(solver_rect_fast.2621)
	slwi	r16, r16, 16
	srwi	r16, r16, 31
	addi	r16, r16, ha16(solver_rect_fast.2621)
	slwi	r16, r16, 16
	addi	r16, r16, lo16(solver_rect_fast.2621)
	st	r16, r10, 0
	st	r15, r10, 4
	mr	r16, r4
	addi	r4, r4, 8
	li	r19, lo16(solver_surface_fast.2628)
	slwi	r19, r19, 16
	srwi	r19, r19, 31
	addi	r19, r19, ha16(solver_surface_fast.2628)
	slwi	r19, r19, 16
	addi	r19, r19, lo16(solver_surface_fast.2628)
	st	r19, r16, 0
	st	r15, r16, 4
	mr	r19, r4
	addi	r4, r4, 8
	li	r21, lo16(solver_second_fast.2634)
	slwi	r21, r21, 16
	srwi	r21, r21, 31
	addi	r21, r21, ha16(solver_second_fast.2634)
	slwi	r21, r21, 16
	addi	r21, r21, lo16(solver_second_fast.2634)
	st	r21, r19, 0
	st	r15, r19, 4
	mr	r21, r4
	addi	r4, r4, 24
	li	r22, lo16(solver_fast.2640)
	slwi	r22, r22, 16
	srwi	r22, r22, 31
	addi	r22, r22, ha16(solver_fast.2640)
	slwi	r22, r22, 16
	addi	r22, r22, lo16(solver_fast.2640)
	st	r22, r21, 0
	st	r16, r21, 16
	st	r19, r21, 12
	st	r10, r21, 8
	st	r14, r21, 4
	mr	r16, r4
	addi	r4, r4, 8
	li	r19, lo16(solver_surface_fast2.2644)
	slwi	r19, r19, 16
	srwi	r19, r19, 31
	addi	r19, r19, ha16(solver_surface_fast2.2644)
	slwi	r19, r19, 16
	addi	r19, r19, lo16(solver_surface_fast2.2644)
	st	r19, r16, 0
	st	r15, r16, 4
	mr	r19, r4
	addi	r4, r4, 8
	li	r22, lo16(solver_second_fast2.2651)
	slwi	r22, r22, 16
	srwi	r22, r22, 31
	addi	r22, r22, ha16(solver_second_fast2.2651)
	slwi	r22, r22, 16
	addi	r22, r22, lo16(solver_second_fast2.2651)
	st	r22, r19, 0
	st	r15, r19, 4
	mr	r22, r4
	addi	r4, r4, 24
	li	r23, lo16(solver_fast2.2658)
	slwi	r23, r23, 16
	srwi	r23, r23, 31
	addi	r23, r23, ha16(solver_fast2.2658)
	slwi	r23, r23, 16
	addi	r23, r23, lo16(solver_fast2.2658)
	st	r23, r22, 0
	st	r16, r22, 16
	st	r19, r22, 12
	st	r10, r22, 8
	st	r14, r22, 4
	mr	r10, r4
	addi	r4, r4, 8
	li	r16, lo16(iter_setup_dirvec_constants.2670)
	slwi	r16, r16, 16
	srwi	r16, r16, 31
	addi	r16, r16, ha16(iter_setup_dirvec_constants.2670)
	slwi	r16, r16, 16
	addi	r16, r16, lo16(iter_setup_dirvec_constants.2670)
	st	r16, r10, 0
	st	r14, r10, 4
	mr	r16, r4
	addi	r4, r4, 16
	li	r19, lo16(setup_dirvec_constants.2673)
	slwi	r19, r19, 16
	srwi	r19, r19, 31
	addi	r19, r19, ha16(setup_dirvec_constants.2673)
	slwi	r19, r19, 16
	addi	r19, r19, lo16(setup_dirvec_constants.2673)
	st	r19, r16, 0
	st	r13, r16, 8
	st	r10, r16, 4
	mr	r10, r4
	addi	r4, r4, 8
	li	r19, lo16(setup_startp_constants.2675)
	slwi	r19, r19, 16
	srwi	r19, r19, 31
	addi	r19, r19, ha16(setup_startp_constants.2675)
	slwi	r19, r19, 16
	addi	r19, r19, lo16(setup_startp_constants.2675)
	st	r19, r10, 0
	st	r14, r10, 4
	mr	r19, r4
	addi	r4, r4, 16
	li	r23, lo16(setup_startp.2678)
	slwi	r23, r23, 16
	srwi	r23, r23, 31
	addi	r23, r23, ha16(setup_startp.2678)
	slwi	r23, r23, 16
	addi	r23, r23, lo16(setup_startp.2678)
	st	r23, r19, 0
	ld	r23, r3, 92
	st	r23, r19, 12
	st	r10, r19, 8
	st	r13, r19, 4
	mr	r10, r4
	addi	r4, r4, 8
	li	r24, lo16(check_all_inside.2700)
	slwi	r24, r24, 16
	srwi	r24, r24, 31
	addi	r24, r24, ha16(check_all_inside.2700)
	slwi	r24, r24, 16
	addi	r24, r24, lo16(check_all_inside.2700)
	st	r24, r10, 0
	st	r14, r10, 4
	mr	r24, r4
	addi	r4, r4, 32
	li	r25, lo16(shadow_check_and_group.2706)
	slwi	r25, r25, 16
	srwi	r25, r25, 31
	addi	r25, r25, ha16(shadow_check_and_group.2706)
	slwi	r25, r25, 16
	addi	r25, r25, lo16(shadow_check_and_group.2706)
	st	r25, r24, 0
	st	r21, r24, 28
	st	r15, r24, 24
	st	r14, r24, 20
	ld	r25, r3, 128
	st	r25, r24, 16
	st	r11, r24, 12
	ld	r26, r3, 52
	st	r26, r24, 8
	st	r10, r24, 4
	mr	r27, r4
	addi	r4, r4, 16
	li	r28, lo16(shadow_check_one_or_group.2709)
	slwi	r28, r28, 16
	srwi	r28, r28, 31
	addi	r28, r28, ha16(shadow_check_one_or_group.2709)
	slwi	r28, r28, 16
	addi	r28, r28, lo16(shadow_check_one_or_group.2709)
	st	r28, r27, 0
	st	r24, r27, 8
	st	r17, r27, 4
	mr	r24, r4
	addi	r4, r4, 24
	li	r28, lo16(shadow_check_one_or_matrix.2712)
	slwi	r28, r28, 16
	srwi	r28, r28, 31
	addi	r28, r28, ha16(shadow_check_one_or_matrix.2712)
	slwi	r28, r28, 16
	addi	r28, r28, lo16(shadow_check_one_or_matrix.2712)
	st	r28, r24, 0
	st	r21, r24, 20
	st	r15, r24, 16
	st	r27, r24, 12
	st	r25, r24, 8
	st	r26, r24, 4
	mr	r21, r4
	addi	r4, r4, 40
	li	r27, lo16(solve_each_element.2715)
	slwi	r27, r27, 16
	srwi	r27, r27, 31
	addi	r27, r27, ha16(solve_each_element.2715)
	slwi	r27, r27, 16
	addi	r27, r27, lo16(solve_each_element.2715)
	st	r27, r21, 0
	ld	r27, r3, 48
	st	r27, r21, 36
	ld	r28, r3, 88
	st	r28, r21, 32
	st	r15, r21, 28
	st	r20, r21, 24
	st	r14, r21, 20
	ld	r29, r3, 44
	st	r29, r21, 16
	st	r26, r21, 12
	ld	r30, r3, 56
	st	r30, r21, 8
	st	r10, r21, 4
	mr	r25, r4
	addi	r4, r4, 16
	st	r18, r3, 140
	li	r18, lo16(solve_one_or_network.2719)
	slwi	r18, r18, 16
	srwi	r18, r18, 31
	addi	r18, r18, ha16(solve_one_or_network.2719)
	slwi	r18, r18, 16
	addi	r18, r18, lo16(solve_one_or_network.2719)
	st	r18, r25, 0
	st	r21, r25, 8
	st	r17, r25, 4
	mr	r18, r4
	addi	r4, r4, 24
	li	r21, lo16(trace_or_matrix.2723)
	slwi	r21, r21, 16
	srwi	r21, r21, 31
	addi	r21, r21, ha16(trace_or_matrix.2723)
	slwi	r21, r21, 16
	addi	r21, r21, lo16(trace_or_matrix.2723)
	st	r21, r18, 0
	st	r27, r18, 20
	st	r28, r18, 16
	st	r15, r18, 12
	st	r20, r18, 8
	st	r25, r18, 4
	mr	r20, r4
	addi	r4, r4, 16
	li	r21, lo16(judge_intersection.2727)
	slwi	r21, r21, 16
	srwi	r21, r21, 31
	addi	r21, r21, ha16(judge_intersection.2727)
	slwi	r21, r21, 16
	addi	r21, r21, lo16(judge_intersection.2727)
	st	r21, r20, 0
	st	r18, r20, 12
	st	r27, r20, 8
	st	r5, r20, 4
	mr	r18, r4
	addi	r4, r4, 40
	li	r21, lo16(solve_each_element_fast.2729)
	slwi	r21, r21, 16
	srwi	r21, r21, 31
	addi	r21, r21, ha16(solve_each_element_fast.2729)
	slwi	r21, r21, 16
	addi	r21, r21, lo16(solve_each_element_fast.2729)
	st	r21, r18, 0
	st	r27, r18, 36
	st	r23, r18, 32
	st	r22, r18, 28
	st	r15, r18, 24
	st	r14, r18, 20
	st	r29, r18, 16
	st	r26, r18, 12
	st	r30, r18, 8
	st	r10, r18, 4
	mr	r10, r4
	addi	r4, r4, 16
	li	r21, lo16(solve_one_or_network_fast.2733)
	slwi	r21, r21, 16
	srwi	r21, r21, 31
	addi	r21, r21, ha16(solve_one_or_network_fast.2733)
	slwi	r21, r21, 16
	addi	r21, r21, lo16(solve_one_or_network_fast.2733)
	st	r21, r10, 0
	st	r18, r10, 8
	st	r17, r10, 4
	mr	r17, r4
	addi	r4, r4, 24
	li	r18, lo16(trace_or_matrix_fast.2737)
	slwi	r18, r18, 16
	srwi	r18, r18, 31
	addi	r18, r18, ha16(trace_or_matrix_fast.2737)
	slwi	r18, r18, 16
	addi	r18, r18, lo16(trace_or_matrix_fast.2737)
	st	r18, r17, 0
	st	r27, r17, 16
	st	r22, r17, 12
	st	r15, r17, 8
	st	r10, r17, 4
	mr	r10, r4
	addi	r4, r4, 16
	li	r15, lo16(judge_intersection_fast.2741)
	slwi	r15, r15, 16
	srwi	r15, r15, 31
	addi	r15, r15, ha16(judge_intersection_fast.2741)
	slwi	r15, r15, 16
	addi	r15, r15, lo16(judge_intersection_fast.2741)
	st	r15, r10, 0
	st	r17, r10, 12
	st	r27, r10, 8
	st	r5, r10, 4
	mr	r15, r4
	addi	r4, r4, 16
	li	r17, lo16(get_nvector_rect.2743)
	slwi	r17, r17, 16
	srwi	r17, r17, 31
	addi	r17, r17, ha16(get_nvector_rect.2743)
	slwi	r17, r17, 16
	addi	r17, r17, lo16(get_nvector_rect.2743)
	st	r17, r15, 0
	ld	r17, r3, 60
	st	r17, r15, 8
	st	r29, r15, 4
	mr	r18, r4
	addi	r4, r4, 8
	li	r21, lo16(get_nvector_plane.2745)
	slwi	r21, r21, 16
	srwi	r21, r21, 31
	addi	r21, r21, ha16(get_nvector_plane.2745)
	slwi	r21, r21, 16
	addi	r21, r21, lo16(get_nvector_plane.2745)
	st	r21, r18, 0
	st	r17, r18, 4
	mr	r21, r4
	addi	r4, r4, 16
	li	r22, lo16(get_nvector_second.2747)
	slwi	r22, r22, 16
	srwi	r22, r22, 31
	addi	r22, r22, ha16(get_nvector_second.2747)
	slwi	r22, r22, 16
	addi	r22, r22, lo16(get_nvector_second.2747)
	st	r22, r21, 0
	st	r17, r21, 8
	st	r26, r21, 4
	mr	r22, r4
	addi	r4, r4, 16
	li	r23, lo16(get_nvector.2749)
	slwi	r23, r23, 16
	srwi	r23, r23, 31
	addi	r23, r23, ha16(get_nvector.2749)
	slwi	r23, r23, 16
	addi	r23, r23, lo16(get_nvector.2749)
	st	r23, r22, 0
	st	r21, r22, 12
	st	r15, r22, 8
	st	r18, r22, 4
	mr	r15, r4
	addi	r4, r4, 8
	li	r18, lo16(utexture.2752)
	slwi	r18, r18, 16
	srwi	r18, r18, 31
	addi	r18, r18, ha16(utexture.2752)
	slwi	r18, r18, 16
	addi	r18, r18, lo16(utexture.2752)
	st	r18, r15, 0
	ld	r18, r3, 64
	st	r18, r15, 4
	mr	r21, r4
	addi	r4, r4, 16
	li	r23, lo16(add_light.2755)
	slwi	r23, r23, 16
	srwi	r23, r23, 31
	addi	r23, r23, ha16(add_light.2755)
	slwi	r23, r23, 16
	addi	r23, r23, lo16(add_light.2755)
	st	r23, r21, 0
	st	r18, r21, 8
	ld	r23, r3, 72
	st	r23, r21, 4
	mr	r25, r4
	addi	r4, r4, 40
	st	r16, r3, 144
	li	r16, lo16(trace_reflections.2759)
	slwi	r16, r16, 16
	srwi	r16, r16, 31
	addi	r16, r16, ha16(trace_reflections.2759)
	slwi	r16, r16, 16
	addi	r16, r16, lo16(trace_reflections.2759)
	st	r16, r25, 0
	st	r24, r25, 32
	ld	r16, r3, 136
	st	r16, r25, 28
	st	r5, r25, 24
	st	r17, r25, 20
	st	r10, r25, 16
	st	r29, r25, 12
	st	r30, r25, 8
	st	r21, r25, 4
	mr	r16, r4
	addi	r4, r4, 88
	li	r13, lo16(trace_ray.2764)
	slwi	r13, r13, 16
	srwi	r13, r13, 31
	addi	r13, r13, ha16(trace_ray.2764)
	slwi	r13, r13, 16
	addi	r13, r13, lo16(trace_ray.2764)
	st	r13, r16, 0
	st	r15, r16, 80
	st	r25, r16, 76
	st	r27, r16, 72
	st	r18, r16, 68
	st	r28, r16, 64
	st	r24, r16, 60
	st	r19, r16, 56
	st	r23, r16, 52
	st	r5, r16, 48
	st	r14, r16, 44
	st	r17, r16, 40
	st	r2, r16, 36
	st	r11, r16, 32
	st	r20, r16, 28
	st	r29, r16, 24
	st	r26, r16, 20
	st	r30, r16, 16
	st	r22, r16, 12
	st	r12, r16, 8
	st	r21, r16, 4
	mr	r12, r4
	addi	r4, r4, 56
	li	r13, lo16(trace_diffuse_ray.2770)
	slwi	r13, r13, 16
	srwi	r13, r13, 31
	addi	r13, r13, ha16(trace_diffuse_ray.2770)
	slwi	r13, r13, 16
	addi	r13, r13, lo16(trace_diffuse_ray.2770)
	st	r13, r12, 0
	st	r15, r12, 48
	st	r18, r12, 44
	st	r24, r12, 40
	st	r5, r12, 36
	st	r14, r12, 32
	st	r17, r12, 28
	st	r11, r12, 24
	st	r10, r12, 20
	st	r26, r12, 16
	st	r30, r12, 12
	st	r22, r12, 8
	ld	r5, r3, 68
	st	r5, r12, 4
	mr	r10, r4
	addi	r4, r4, 8
	li	r13, lo16(iter_trace_diffuse_rays.2773)
	slwi	r13, r13, 16
	srwi	r13, r13, 31
	addi	r13, r13, ha16(iter_trace_diffuse_rays.2773)
	slwi	r13, r13, 16
	addi	r13, r13, lo16(iter_trace_diffuse_rays.2773)
	st	r13, r10, 0
	st	r12, r10, 4
	mr	r12, r4
	addi	r4, r4, 16
	li	r13, lo16(trace_diffuse_rays.2778)
	slwi	r13, r13, 16
	srwi	r13, r13, 31
	addi	r13, r13, ha16(trace_diffuse_rays.2778)
	slwi	r13, r13, 16
	addi	r13, r13, lo16(trace_diffuse_rays.2778)
	st	r13, r12, 0
	st	r19, r12, 8
	st	r10, r12, 4
	mr	r10, r4
	addi	r4, r4, 16
	li	r13, lo16(trace_diffuse_ray_80percent.2782)
	slwi	r13, r13, 16
	srwi	r13, r13, 31
	addi	r13, r13, ha16(trace_diffuse_ray_80percent.2782)
	slwi	r13, r13, 16
	addi	r13, r13, lo16(trace_diffuse_ray_80percent.2782)
	st	r13, r10, 0
	st	r12, r10, 8
	ld	r13, r3, 116
	st	r13, r10, 4
	mr	r15, r4
	addi	r4, r4, 16
	li	r17, lo16(calc_diffuse_using_1point.2786)
	slwi	r17, r17, 16
	srwi	r17, r17, 31
	addi	r17, r17, ha16(calc_diffuse_using_1point.2786)
	slwi	r17, r17, 16
	addi	r17, r17, lo16(calc_diffuse_using_1point.2786)
	st	r17, r15, 0
	st	r10, r15, 12
	st	r23, r15, 8
	st	r5, r15, 4
	mr	r10, r4
	addi	r4, r4, 16
	li	r17, lo16(calc_diffuse_using_5points.2789)
	slwi	r17, r17, 16
	srwi	r17, r17, 31
	addi	r17, r17, ha16(calc_diffuse_using_5points.2789)
	slwi	r17, r17, 16
	addi	r17, r17, lo16(calc_diffuse_using_5points.2789)
	st	r17, r10, 0
	st	r23, r10, 8
	st	r5, r10, 4
	mr	r17, r4
	addi	r4, r4, 8
	li	r18, lo16(do_without_neighbors.2795)
	slwi	r18, r18, 16
	srwi	r18, r18, 31
	addi	r18, r18, ha16(do_without_neighbors.2795)
	slwi	r18, r18, 16
	addi	r18, r18, lo16(do_without_neighbors.2795)
	st	r18, r17, 0
	st	r15, r17, 4
	mr	r15, r4
	addi	r4, r4, 8
	li	r18, lo16(neighbors_exist.2798)
	slwi	r18, r18, 16
	srwi	r18, r18, 31
	addi	r18, r18, ha16(neighbors_exist.2798)
	slwi	r18, r18, 16
	addi	r18, r18, lo16(neighbors_exist.2798)
	st	r18, r15, 0
	ld	r18, r3, 76
	st	r18, r15, 4
	mr	r19, r4
	addi	r4, r4, 16
	li	r20, lo16(try_exploit_neighbors.2811)
	slwi	r20, r20, 16
	srwi	r20, r20, 31
	addi	r20, r20, ha16(try_exploit_neighbors.2811)
	slwi	r20, r20, 16
	addi	r20, r20, lo16(try_exploit_neighbors.2811)
	st	r20, r19, 0
	st	r17, r19, 8
	st	r10, r19, 4
	mr	r10, r4
	addi	r4, r4, 8
	li	r20, lo16(write_ppm_header.2818)
	slwi	r20, r20, 16
	srwi	r20, r20, 31
	addi	r20, r20, ha16(write_ppm_header.2818)
	slwi	r20, r20, 16
	addi	r20, r20, lo16(write_ppm_header.2818)
	st	r20, r10, 0
	st	r18, r10, 4
	mr	r20, r4
	addi	r4, r4, 8
	li	r21, lo16(write_rgb.2822)
	slwi	r21, r21, 16
	srwi	r21, r21, 31
	addi	r21, r21, ha16(write_rgb.2822)
	slwi	r21, r21, 16
	addi	r21, r21, lo16(write_rgb.2822)
	st	r21, r20, 0
	st	r23, r20, 4
	mr	r21, r4
	addi	r4, r4, 16
	li	r22, lo16(pretrace_diffuse_rays.2824)
	slwi	r22, r22, 16
	srwi	r22, r22, 31
	addi	r22, r22, ha16(pretrace_diffuse_rays.2824)
	slwi	r22, r22, 16
	addi	r22, r22, lo16(pretrace_diffuse_rays.2824)
	st	r22, r21, 0
	st	r12, r21, 12
	st	r13, r21, 8
	st	r5, r21, 4
	mr	r5, r4
	addi	r4, r4, 40
	li	r12, lo16(pretrace_pixels.2827)
	slwi	r12, r12, 16
	srwi	r12, r12, 31
	addi	r12, r12, ha16(pretrace_pixels.2827)
	slwi	r12, r12, 16
	addi	r12, r12, lo16(pretrace_pixels.2827)
	st	r12, r5, 0
	st	r6, r5, 36
	st	r16, r5, 32
	st	r28, r5, 28
	st	r9, r5, 24
	ld	r6, r3, 84
	st	r6, r5, 20
	st	r23, r5, 16
	ld	r9, r3, 108
	st	r9, r5, 12
	st	r21, r5, 8
	ld	r9, r3, 80
	st	r9, r5, 4
	mr	r12, r4
	addi	r4, r4, 32
	li	r16, lo16(pretrace_line.2834)
	slwi	r16, r16, 16
	srwi	r16, r16, 31
	addi	r16, r16, ha16(pretrace_line.2834)
	slwi	r16, r16, 16
	addi	r16, r16, lo16(pretrace_line.2834)
	st	r16, r12, 0
	st	r7, r12, 24
	st	r8, r12, 20
	st	r6, r12, 16
	st	r5, r12, 12
	st	r18, r12, 8
	st	r9, r12, 4
	mr	r5, r4
	addi	r4, r4, 32
	li	r7, lo16(scan_pixel.2838)
	slwi	r7, r7, 16
	srwi	r7, r7, 31
	addi	r7, r7, ha16(scan_pixel.2838)
	slwi	r7, r7, 16
	addi	r7, r7, lo16(scan_pixel.2838)
	st	r7, r5, 0
	st	r20, r5, 24
	st	r19, r5, 20
	st	r23, r5, 16
	st	r15, r5, 12
	st	r18, r5, 8
	st	r17, r5, 4
	mr	r7, r4
	addi	r4, r4, 16
	li	r8, lo16(scan_line.2844)
	slwi	r8, r8, 16
	srwi	r8, r8, 31
	addi	r8, r8, ha16(scan_line.2844)
	slwi	r8, r8, 16
	addi	r8, r8, lo16(scan_line.2844)
	st	r8, r7, 0
	st	r5, r7, 12
	st	r12, r7, 8
	st	r18, r7, 4
	mr	r5, r4
	addi	r4, r4, 8
	li	r8, lo16(create_pixelline.2857)
	slwi	r8, r8, 16
	srwi	r8, r8, 31
	addi	r8, r8, ha16(create_pixelline.2857)
	slwi	r8, r8, 16
	addi	r8, r8, lo16(create_pixelline.2857)
	st	r8, r5, 0
	st	r18, r5, 4
	mr	r8, r4
	addi	r4, r4, 8
	li	r15, lo16(calc_dirvec.2864)
	slwi	r15, r15, 16
	srwi	r15, r15, 31
	addi	r15, r15, ha16(calc_dirvec.2864)
	slwi	r15, r15, 16
	addi	r15, r15, lo16(calc_dirvec.2864)
	st	r15, r8, 0
	st	r13, r8, 4
	mr	r15, r4
	addi	r4, r4, 8
	li	r16, lo16(calc_dirvecs.2872)
	slwi	r16, r16, 16
	srwi	r16, r16, 31
	addi	r16, r16, ha16(calc_dirvecs.2872)
	slwi	r16, r16, 16
	addi	r16, r16, lo16(calc_dirvecs.2872)
	st	r16, r15, 0
	st	r8, r15, 4
	mr	r8, r4
	addi	r4, r4, 8
	li	r16, lo16(calc_dirvec_rows.2877)
	slwi	r16, r16, 16
	srwi	r16, r16, 31
	addi	r16, r16, ha16(calc_dirvec_rows.2877)
	slwi	r16, r16, 16
	addi	r16, r16, lo16(calc_dirvec_rows.2877)
	st	r16, r8, 0
	st	r15, r8, 4
	mr	r15, r4
	addi	r4, r4, 8
	li	r16, lo16(create_dirvec.2881)
	slwi	r16, r16, 16
	srwi	r16, r16, 31
	addi	r16, r16, ha16(create_dirvec.2881)
	slwi	r16, r16, 16
	addi	r16, r16, lo16(create_dirvec.2881)
	st	r16, r15, 0
	ld	r16, r3, 0
	st	r16, r15, 4
	mr	r17, r4
	addi	r4, r4, 8
	li	r19, lo16(create_dirvec_elements.2883)
	slwi	r19, r19, 16
	srwi	r19, r19, 31
	addi	r19, r19, ha16(create_dirvec_elements.2883)
	slwi	r19, r19, 16
	addi	r19, r19, lo16(create_dirvec_elements.2883)
	st	r19, r17, 0
	st	r15, r17, 4
	mr	r19, r4
	addi	r4, r4, 16
	li	r20, lo16(create_dirvecs.2886)
	slwi	r20, r20, 16
	srwi	r20, r20, 31
	addi	r20, r20, ha16(create_dirvecs.2886)
	slwi	r20, r20, 16
	addi	r20, r20, lo16(create_dirvecs.2886)
	st	r20, r19, 0
	st	r13, r19, 12
	st	r17, r19, 8
	st	r15, r19, 4
	mr	r17, r4
	addi	r4, r4, 8
	li	r20, lo16(init_dirvec_constants.2888)
	slwi	r20, r20, 16
	srwi	r20, r20, 31
	addi	r20, r20, ha16(init_dirvec_constants.2888)
	slwi	r20, r20, 16
	addi	r20, r20, lo16(init_dirvec_constants.2888)
	st	r20, r17, 0
	ld	r20, r3, 144
	st	r20, r17, 4
	mr	r21, r4
	addi	r4, r4, 16
	li	r22, lo16(init_vecset_constants.2891)
	slwi	r22, r22, 16
	srwi	r22, r22, 31
	addi	r22, r22, ha16(init_vecset_constants.2891)
	slwi	r22, r22, 16
	addi	r22, r22, lo16(init_vecset_constants.2891)
	st	r22, r21, 0
	st	r17, r21, 8
	st	r13, r21, 4
	mr	r13, r4
	addi	r4, r4, 16
	li	r17, lo16(init_dirvecs.2893)
	slwi	r17, r17, 16
	srwi	r17, r17, 31
	addi	r17, r17, ha16(init_dirvecs.2893)
	slwi	r17, r17, 16
	addi	r17, r17, lo16(init_dirvecs.2893)
	st	r17, r13, 0
	st	r21, r13, 12
	st	r19, r13, 8
	st	r8, r13, 4
	mr	r8, r4
	addi	r4, r4, 16
	li	r17, lo16(add_reflection.2895)
	slwi	r17, r17, 16
	srwi	r17, r17, 31
	addi	r17, r17, ha16(add_reflection.2895)
	slwi	r17, r17, 16
	addi	r17, r17, lo16(add_reflection.2895)
	st	r17, r8, 0
	st	r20, r8, 12
	ld	r17, r3, 136
	st	r17, r8, 8
	st	r15, r8, 4
	mr	r15, r4
	addi	r4, r4, 16
	li	r17, lo16(setup_rect_reflection.2902)
	slwi	r17, r17, 16
	srwi	r17, r17, 31
	addi	r17, r17, ha16(setup_rect_reflection.2902)
	slwi	r17, r17, 16
	addi	r17, r17, lo16(setup_rect_reflection.2902)
	st	r17, r15, 0
	st	r2, r15, 12
	st	r11, r15, 8
	st	r8, r15, 4
	mr	r17, r4
	addi	r4, r4, 16
	li	r19, lo16(setup_surface_reflection.2905)
	slwi	r19, r19, 16
	srwi	r19, r19, 31
	addi	r19, r19, ha16(setup_surface_reflection.2905)
	slwi	r19, r19, 16
	addi	r19, r19, lo16(setup_surface_reflection.2905)
	st	r19, r17, 0
	st	r2, r17, 12
	st	r11, r17, 8
	st	r8, r17, 4
	mr	r2, r4
	addi	r4, r4, 16
	li	r8, lo16(setup_reflections.2908)
	slwi	r8, r8, 16
	srwi	r8, r8, 31
	addi	r8, r8, ha16(setup_reflections.2908)
	slwi	r8, r8, 16
	addi	r8, r8, lo16(setup_reflections.2908)
	st	r8, r2, 0
	st	r17, r2, 12
	st	r15, r2, 8
	st	r14, r2, 4
	mr	r30, r4
	addi	r4, r4, 64
	li	r8, lo16(rt.2910)
	slwi	r8, r8, 16
	srwi	r8, r8, 31
	addi	r8, r8, ha16(rt.2910)
	slwi	r8, r8, 16
	addi	r8, r8, lo16(rt.2910)
	st	r8, r30, 0
	st	r10, r30, 56
	st	r2, r30, 52
	st	r20, r30, 48
	st	r6, r30, 44
	st	r7, r30, 40
	ld	r2, r3, 140
	st	r2, r30, 36
	st	r12, r30, 32
	st	r16, r30, 28
	ld	r2, r3, 128
	st	r2, r30, 24
	st	r11, r30, 20
	st	r13, r30, 16
	st	r18, r30, 12
	st	r9, r30, 8
	st	r5, r30, 4
	li	r2, 128
	li	r5, 128
	mflr	r31
	st	r31, r3, 148
	addi	r3, r3, 152
	ld	r31, r30, 0
	mr	r29, r31
	bal	r29
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
#	main program ends
