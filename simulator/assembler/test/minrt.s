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
  fld	fr2, r0, 0
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
	fld	fr2, r0, 0
	fsub	fr1, fr1, fr2
  ftoi r2, fr1
  itof fr1, r2
	blr
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
min_caml_sin_cos_ker_sin.186:
	fmul	fr2, fr1, fr1
	fmul	fr3, fr1, fr2
	fld	fr4, r0, 4
	fmul	fr4, fr3, fr4
	fsub	fr1, fr1, fr4
	fmul	fr4, fr3, fr2
	fld	fr5, r0, 8
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fmul	fr3, fr3, fr2
	fmul	fr2, fr3, fr2
	fld	fr3, r0, 12
	fmul	fr2, fr2, fr3
	fsub	fr1, fr1, fr2
	blr
min_caml_sin_cos_ker_cos.188:
	fmul	fr1, fr1, fr1
	fld	fr2, r0, 16
	fld	fr3, r0, 0
	fmul	fr3, fr1, fr3
	fsub	fr2, fr2, fr3
	fmul	fr3, fr1, fr1
	fld	fr4, r0, 20
	fmul	fr3, fr3, fr4
	fadd	fr2, fr2, fr3
	fmul	fr3, fr1, fr1
	fmul	fr1, fr3, fr1
	fld	fr3, r0, 24
	fmul	fr1, fr1, fr3
	fsub	fr1, fr2, fr1
	blr
min_caml_sin:
	fld	fr2, r0, 28
	fld	fr3, r0, 44
	fcmp	cr0, fr3, fr1
	blt	min_caml_sin_cos_le.441
	beq	min_caml_sin_cos_le.441
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
min_caml_sin_cos_le.441:
	fld	fr3, r0, 32
	fcmp	cr0, fr3, fr1
	blt	min_caml_sin_cos_le.442
	beq	min_caml_sin_cos_le.442
	fcmp	cr0, fr2, fr1
	blt	min_caml_sin_cos_le.443
	beq	min_caml_sin_cos_le.443
	fld	fr2, r0, 36
	fcmp	cr0, fr2, fr1
	blt	min_caml_sin_cos_le.444
	beq	min_caml_sin_cos_le.444
	fld	fr2, r0, 40
	fcmp	cr0, fr2, fr1
	blt	min_caml_sin_cos_le.445
	beq	min_caml_sin_cos_le.445
	b	min_caml_sin_cos_ker_sin.186
min_caml_sin_cos_le.445:
	fld	fr2, r0, 36
	fsub	fr1, fr2, fr1
	b	min_caml_sin_cos_ker_cos.188
min_caml_sin_cos_le.444:
	fld	fr2, r0, 36
	fsub	fr1, fr1, fr2
	b	min_caml_sin
min_caml_sin_cos_le.443:
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
min_caml_sin_cos_le.442:
	fld	fr3, r0, 32
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
	fld	fr2, r0, 48
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 0
	fsub	fr1, fr2, fr1
	b	min_caml_sin
min_caml_cos:
	fld	fr2, r0, 28
	fld	fr3, r0, 44
	fcmp	cr0, fr3, fr1
	blt	min_caml_sin_cos_le.446
	beq	min_caml_sin_cos_le.446
	fsub	fr1, fr0, fr1
	b	min_caml_cos
min_caml_sin_cos_le.446:
	fld	fr3, r0, 32
	fcmp	cr0, fr3, fr1
	blt	min_caml_sin_cos_le.447
	beq	min_caml_sin_cos_le.447
	fcmp	cr0, fr2, fr1
	blt	min_caml_sin_cos_le.448
	beq	min_caml_sin_cos_le.448
	fld	fr2, r0, 36
	fcmp	cr0, fr2, fr1
	blt	min_caml_sin_cos_le.449
	beq	min_caml_sin_cos_le.449
	fld	fr2, r0, 40
	fcmp	cr0, fr2, fr1
	blt	min_caml_sin_cos_le.450
	beq	min_caml_sin_cos_le.450
	b	min_caml_sin_cos_ker_cos.188
min_caml_sin_cos_le.450:
	fld	fr2, r0, 36
	fsub	fr1, fr2, fr1
	b	min_caml_sin_cos_ker_sin.186
min_caml_sin_cos_le.449:
	fld	fr2, r0, 36
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
min_caml_sin_cos_le.448:
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
min_caml_sin_cos_le.447:
	fld	fr3, r0, 32
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
	fld	fr2, r0, 48
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
	fld	fr6, r0, 52
	fmul	fr6, fr3, fr6
	fsub	fr1, fr1, fr6
	fmul	fr6, fr3, fr2
	fld	fr7, r0, 56
	fmul	fr6, fr6, fr7
	fadd	fr1, fr1, fr6
	fmul	fr3, fr3, fr4
	fld	fr6, r0, 60
	fmul	fr3, fr3, fr6
	fsub	fr1, fr1, fr3
	fld	fr3, r0, 64
	fmul	fr3, fr5, fr3
	fadd	fr1, fr1, fr3
	fmul	fr2, fr5, fr2
	fld	fr3, r0, 68
	fmul	fr2, fr2, fr3
	fsub	fr1, fr1, fr2
	fmul	fr2, fr5, fr4
	fld	fr3, r0, 72
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	blr
min_caml_atan:
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	min_caml_atan_le.122
	beq	min_caml_atan_le.122
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
min_caml_atan_le.122:
	fld	fr2, r0, 76
	fcmp	cr0, fr2, fr1
	blt	min_caml_atan_le.123
	beq	min_caml_atan_le.123
	b	min_caml_atan_ker_atan.44
min_caml_atan_le.123:
	fld	fr2, r0, 80
	fcmp	cr0, fr2, fr1
	blt	min_caml_atan_le.124
	beq	min_caml_atan_le.124
	fld	fr2, r0, 40
	fld	fr3, r0, 16
	fsub	fr3, fr1, fr3
	fld	fr4, r0, 16
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
min_caml_atan_le.124:
	fld	fr2, r0, 36
	fld	fr3, r0, 16
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
read_screen_settings.2874:
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
	fld	fr2, r0, 84
	fmul	fr1, fr1, fr2
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
	fld	fr2, r0, 84
	fmul	fr1, fr1, fr2
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
	fld	fr4, r0, 88
	fmul	fr3, fr3, fr4
	ld	r2, r3, 12
	fst	fr3, r2, 0
	fld	fr3, r0, 92
	fld	fr4, r3, 28
	fmul	fr3, fr4, fr3
	fst	fr3, r2, 4
	fld	fr3, r3, 36
	fmul	fr5, fr2, fr3
	fld	fr6, r0, 88
	fmul	fr5, fr5, fr6
	fst	fr5, r2, 8
	ld	r5, r3, 8
	fst	fr3, r5, 0
	fld	fr5, r0, 44
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
rotate_quadratic_matrix.2878:
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
	fld	fr1, r0, 48
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
	fld	fr1, r0, 48
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
	fld	fr1, r0, 48
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
read_nth_object.2881:
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
	bne	beq_else.31188
	li	r2, 0
	blr
beq_else.31188:
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.31189
	beq	le.31189
	li	r2, 1
	b	gt_cont.31190
le.31189:
	li	r2, 0
gt_cont.31190:
	li	r5, 2
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	bne	beq_else.31191
	b	beq_cont.31192
beq_else.31191:
	st	r2, r3, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_read_float
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r0, 84
	fmul	fr1, fr1, fr2
	ld	r2, r3, 44
	fst	fr1, r2, 0
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_read_float
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r0, 84
	fmul	fr1, fr1, fr2
	ld	r2, r3, 44
	fst	fr1, r2, 4
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_read_float
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r0, 84
	fmul	fr1, fr1, fr2
	ld	r2, r3, 44
	fst	fr1, r2, 8
beq_cont.31192:
	ld	r5, r3, 12
	cmpwi	cr0, r5, 2
	bne	beq_else.31193
	li	r6, 1
	b	beq_cont.31194
beq_else.31193:
	ld	r6, r3, 32
beq_cont.31194:
	li	r7, 4
	fld	fr1, r0, 44
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
	bne	beq_else.31195
	fld	fr1, r6, 0
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31197
	li	r5, 1
	b	beq_cont.31198
beq_else.31197:
	li	r5, 0
beq_cont.31198:
	cmpwi	cr0, r5, 0
	bne	beq_else.31199
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31201
	li	r5, 1
	b	beq_cont.31202
beq_else.31201:
	li	r5, 0
beq_cont.31202:
	cmpwi	cr0, r5, 0
	bne	beq_else.31203
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.31205
	beq	le.31205
	li	r5, 1
	b	gt_cont.31206
le.31205:
	li	r5, 0
gt_cont.31206:
	cmpwi	cr0, r5, 0
	bne	beq_else.31207
	fld	fr2, r0, 96
	b	beq_cont.31208
beq_else.31207:
	fld	fr2, r0, 16
beq_cont.31208:
	b	beq_cont.31204
beq_else.31203:
	fld	fr2, r0, 44
beq_cont.31204:
	fst	fr2, r3, 52
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fsqr
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 52
	fdiv	fr1, fr2, fr1
	b	beq_cont.31200
beq_else.31199:
	fld	fr1, r0, 44
beq_cont.31200:
	ld	r2, r3, 24
	fst	fr1, r2, 0
	fld	fr1, r2, 4
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31209
	li	r5, 1
	b	beq_cont.31210
beq_else.31209:
	li	r5, 0
beq_cont.31210:
	cmpwi	cr0, r5, 0
	bne	beq_else.31211
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31213
	li	r5, 1
	b	beq_cont.31214
beq_else.31213:
	li	r5, 0
beq_cont.31214:
	cmpwi	cr0, r5, 0
	bne	beq_else.31215
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.31217
	beq	le.31217
	li	r5, 1
	b	gt_cont.31218
le.31217:
	li	r5, 0
gt_cont.31218:
	cmpwi	cr0, r5, 0
	bne	beq_else.31219
	fld	fr2, r0, 96
	b	beq_cont.31220
beq_else.31219:
	fld	fr2, r0, 16
beq_cont.31220:
	b	beq_cont.31216
beq_else.31215:
	fld	fr2, r0, 44
beq_cont.31216:
	fst	fr2, r3, 56
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fsqr
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 56
	fdiv	fr1, fr2, fr1
	b	beq_cont.31212
beq_else.31211:
	fld	fr1, r0, 44
beq_cont.31212:
	ld	r2, r3, 24
	fst	fr1, r2, 4
	fld	fr1, r2, 8
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31221
	li	r5, 1
	b	beq_cont.31222
beq_else.31221:
	li	r5, 0
beq_cont.31222:
	cmpwi	cr0, r5, 0
	bne	beq_else.31223
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31225
	li	r5, 1
	b	beq_cont.31226
beq_else.31225:
	li	r5, 0
beq_cont.31226:
	cmpwi	cr0, r5, 0
	bne	beq_else.31227
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.31229
	beq	le.31229
	li	r5, 1
	b	gt_cont.31230
le.31229:
	li	r5, 0
gt_cont.31230:
	cmpwi	cr0, r5, 0
	bne	beq_else.31231
	fld	fr2, r0, 96
	b	beq_cont.31232
beq_else.31231:
	fld	fr2, r0, 16
beq_cont.31232:
	b	beq_cont.31228
beq_else.31227:
	fld	fr2, r0, 44
beq_cont.31228:
	fst	fr2, r3, 60
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_fsqr
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 60
	fdiv	fr1, fr2, fr1
	b	beq_cont.31224
beq_else.31223:
	fld	fr1, r0, 44
beq_cont.31224:
	ld	r2, r3, 24
	fst	fr1, r2, 8
	b	beq_cont.31196
beq_else.31195:
	cmpwi	cr0, r8, 2
	bne	beq_else.31233
	ld	r5, r3, 32
	cmpwi	cr0, r5, 0
	bne	beq_else.31235
	li	r5, 1
	b	beq_cont.31236
beq_else.31235:
	li	r5, 0
beq_cont.31236:
	fld	fr1, r6, 0
	st	r5, r3, 64
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_fsqr
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 24
	fld	fr2, r2, 4
	fst	fr1, r3, 68
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_fsqr
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 68
	fadd	fr1, fr2, fr1
	ld	r2, r3, 24
	fld	fr2, r2, 8
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
	fadd	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_sqrt
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31237
	li	r2, 1
	b	beq_cont.31238
beq_else.31237:
	li	r2, 0
beq_cont.31238:
	cmpwi	cr0, r2, 0
	bne	beq_else.31239
	ld	r2, r3, 64
	cmpwi	cr0, r2, 0
	bne	beq_else.31241
	fld	fr2, r0, 16
	fdiv	fr1, fr2, fr1
	b	beq_cont.31242
beq_else.31241:
	fld	fr2, r0, 96
	fdiv	fr1, fr2, fr1
beq_cont.31242:
	b	beq_cont.31240
beq_else.31239:
	fld	fr1, r0, 16
beq_cont.31240:
	ld	r2, r3, 24
	fld	fr2, r2, 0
	fmul	fr2, fr2, fr1
	fst	fr2, r2, 0
	fld	fr2, r2, 4
	fmul	fr2, fr2, fr1
	fst	fr2, r2, 4
	fld	fr2, r2, 8
	fmul	fr1, fr2, fr1
	fst	fr1, r2, 8
	b	beq_cont.31234
beq_else.31233:
beq_cont.31234:
beq_cont.31196:
	ld	r2, r3, 20
	cmpwi	cr0, r2, 0
	bne	beq_else.31243
	b	beq_cont.31244
beq_else.31243:
	ld	r2, r3, 24
	ld	r5, r3, 44
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	rotate_quadratic_matrix.2878
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
beq_cont.31244:
	li	r2, 1
	blr
read_object.2883:
	ld	r5, r30, 8
	ld	r6, r30, 4
	cmpwi	cr0, r2, 60
	blt	bge_else.31245
	blr
bge_else.31245:
	st	r30, r3, 0
	st	r5, r3, 4
	st	r6, r3, 8
	st	r2, r3, 12
	mflr	r31
	mr	r30, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31247
	ld	r2, r3, 8
	ld	r5, r3, 12
	st	r5, r2, 0
	blr
beq_else.31247:
	ld	r2, r3, 12
	addi	r2, r2, 1
	cmpwi	cr0, r2, 60
	blt	bge_else.31249
	blr
bge_else.31249:
	ld	r30, r3, 4
	st	r2, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31251
	ld	r2, r3, 8
	ld	r5, r3, 16
	st	r5, r2, 0
	blr
beq_else.31251:
	ld	r2, r3, 16
	addi	r2, r2, 1
	cmpwi	cr0, r2, 60
	blt	bge_else.31253
	blr
bge_else.31253:
	ld	r30, r3, 4
	st	r2, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31255
	ld	r2, r3, 8
	ld	r5, r3, 20
	st	r5, r2, 0
	blr
beq_else.31255:
	ld	r2, r3, 20
	addi	r2, r2, 1
	cmpwi	cr0, r2, 60
	blt	bge_else.31257
	blr
bge_else.31257:
	ld	r30, r3, 4
	st	r2, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31259
	ld	r2, r3, 8
	ld	r5, r3, 24
	st	r5, r2, 0
	blr
beq_else.31259:
	ld	r2, r3, 24
	addi	r2, r2, 1
	cmpwi	cr0, r2, 60
	blt	bge_else.31261
	blr
bge_else.31261:
	ld	r30, r3, 4
	st	r2, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31263
	ld	r2, r3, 8
	ld	r5, r3, 28
	st	r5, r2, 0
	blr
beq_else.31263:
	ld	r2, r3, 28
	addi	r2, r2, 1
	cmpwi	cr0, r2, 60
	blt	bge_else.31265
	blr
bge_else.31265:
	ld	r30, r3, 4
	st	r2, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31267
	ld	r2, r3, 8
	ld	r5, r3, 32
	st	r5, r2, 0
	blr
beq_else.31267:
	ld	r2, r3, 32
	addi	r2, r2, 1
	cmpwi	cr0, r2, 60
	blt	bge_else.31269
	blr
bge_else.31269:
	ld	r30, r3, 4
	st	r2, r3, 36
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31271
	ld	r2, r3, 8
	ld	r5, r3, 36
	st	r5, r2, 0
	blr
beq_else.31271:
	ld	r2, r3, 36
	addi	r2, r2, 1
	cmpwi	cr0, r2, 60
	blt	bge_else.31273
	blr
bge_else.31273:
	ld	r30, r3, 4
	st	r2, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31275
	ld	r2, r3, 8
	ld	r5, r3, 40
	st	r5, r2, 0
	blr
beq_else.31275:
	ld	r2, r3, 40
	addi	r2, r2, 1
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
read_net_item.2887:
	st	r2, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_read_int
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31277
	ld	r2, r3, 0
	addi	r2, r2, 1
	li	r5, -1
	b	min_caml_create_array
beq_else.31277:
	ld	r5, r3, 0
	addi	r6, r5, 1
	st	r2, r3, 4
	st	r6, r3, 8
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_read_int
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31278
	ld	r2, r3, 8
	addi	r2, r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	b	beq_cont.31279
beq_else.31278:
	ld	r5, r3, 8
	addi	r6, r5, 1
	st	r2, r3, 12
	st	r6, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_read_int
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31280
	ld	r2, r3, 16
	addi	r2, r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	b	beq_cont.31281
beq_else.31280:
	ld	r5, r3, 16
	addi	r6, r5, 1
	st	r2, r3, 20
	st	r6, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_read_int
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31282
	ld	r2, r3, 24
	addi	r2, r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	b	beq_cont.31283
beq_else.31282:
	ld	r5, r3, 24
	addi	r6, r5, 1
	st	r2, r3, 28
	st	r6, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_read_int
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31284
	ld	r2, r3, 32
	addi	r2, r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	b	beq_cont.31285
beq_else.31284:
	ld	r5, r3, 32
	addi	r6, r5, 1
	st	r2, r3, 36
	st	r6, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_read_int
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31286
	ld	r2, r3, 40
	addi	r2, r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	b	beq_cont.31287
beq_else.31286:
	ld	r5, r3, 40
	addi	r6, r5, 1
	st	r2, r3, 44
	st	r6, r3, 48
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_read_int
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31288
	ld	r2, r3, 48
	addi	r2, r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	b	beq_cont.31289
beq_else.31288:
	ld	r5, r3, 48
	addi	r6, r5, 1
	st	r2, r3, 52
	st	r6, r3, 56
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_read_int
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31290
	ld	r2, r3, 56
	addi	r2, r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	b	beq_cont.31291
beq_else.31290:
	ld	r5, r3, 56
	addi	r6, r5, 1
	st	r2, r3, 60
	mflr	r31
	mr	r2, r6
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	read_net_item.2887
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r5, r3, 56
	slwi	r5, r5, 2
	ld	r6, r3, 60
	add	r31, r2, r5
	st	r6, r31, 0
beq_cont.31291:
	ld	r5, r3, 48
	slwi	r5, r5, 2
	ld	r6, r3, 52
	add	r31, r2, r5
	st	r6, r31, 0
beq_cont.31289:
	ld	r5, r3, 40
	slwi	r5, r5, 2
	ld	r6, r3, 44
	add	r31, r2, r5
	st	r6, r31, 0
beq_cont.31287:
	ld	r5, r3, 32
	slwi	r5, r5, 2
	ld	r6, r3, 36
	add	r31, r2, r5
	st	r6, r31, 0
beq_cont.31285:
	ld	r5, r3, 24
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r2, r5
	st	r6, r31, 0
beq_cont.31283:
	ld	r5, r3, 16
	slwi	r5, r5, 2
	ld	r6, r3, 20
	add	r31, r2, r5
	st	r6, r31, 0
beq_cont.31281:
	ld	r5, r3, 8
	slwi	r5, r5, 2
	ld	r6, r3, 12
	add	r31, r2, r5
	st	r6, r31, 0
beq_cont.31279:
	ld	r5, r3, 0
	slwi	r5, r5, 2
	ld	r6, r3, 4
	add	r31, r2, r5
	st	r6, r31, 0
	blr
read_or_network.2889:
	st	r2, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_read_int
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31292
	li	r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_create_array
	addi	r3, r3, -8
	ld	r31, r3, 4
	mr	r5, r2
	mtlr	r31
	b	beq_cont.31293
beq_else.31292:
	st	r2, r3, 4
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_read_int
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31294
	li	r2, 2
	li	r5, -1
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	b	beq_cont.31295
beq_else.31294:
	st	r2, r3, 8
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_read_int
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31296
	li	r2, 3
	li	r5, -1
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	b	beq_cont.31297
beq_else.31296:
	st	r2, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_read_int
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31298
	li	r2, 4
	li	r5, -1
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	b	beq_cont.31299
beq_else.31298:
	st	r2, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_read_int
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31300
	li	r2, 5
	li	r5, -1
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	b	beq_cont.31301
beq_else.31300:
	st	r2, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_read_int
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31302
	li	r2, 6
	li	r5, -1
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	b	beq_cont.31303
beq_else.31302:
	st	r2, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_read_int
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31304
	li	r2, 7
	li	r5, -1
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	b	beq_cont.31305
beq_else.31304:
	li	r5, 7
	st	r2, r3, 28
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	read_net_item.2887
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 28
	st	r5, r2, 24
beq_cont.31305:
	ld	r5, r3, 24
	st	r5, r2, 20
beq_cont.31303:
	ld	r5, r3, 20
	st	r5, r2, 16
beq_cont.31301:
	ld	r5, r3, 16
	st	r5, r2, 12
beq_cont.31299:
	ld	r5, r3, 12
	st	r5, r2, 8
beq_cont.31297:
	ld	r5, r3, 8
	st	r5, r2, 4
beq_cont.31295:
	ld	r5, r3, 4
	st	r5, r2, 0
	mr	r5, r2
beq_cont.31293:
	ld	r2, r5, 0
	cmpwi	cr0, r2, -1
	bne	beq_else.31306
	ld	r2, r3, 0
	addi	r2, r2, 1
	b	min_caml_create_array
beq_else.31306:
	ld	r2, r3, 0
	addi	r6, r2, 1
	st	r5, r3, 32
	st	r6, r3, 36
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_read_int
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31307
	li	r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mr	r5, r2
	mtlr	r31
	b	beq_cont.31308
beq_else.31307:
	st	r2, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_read_int
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31309
	li	r2, 2
	li	r5, -1
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	b	beq_cont.31310
beq_else.31309:
	st	r2, r3, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_read_int
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31311
	li	r2, 3
	li	r5, -1
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	b	beq_cont.31312
beq_else.31311:
	st	r2, r3, 48
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_read_int
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31313
	li	r2, 4
	li	r5, -1
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	b	beq_cont.31314
beq_else.31313:
	st	r2, r3, 52
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_read_int
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31315
	li	r2, 5
	li	r5, -1
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	b	beq_cont.31316
beq_else.31315:
	st	r2, r3, 56
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_read_int
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31317
	li	r2, 6
	li	r5, -1
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	b	beq_cont.31318
beq_else.31317:
	li	r5, 6
	st	r2, r3, 60
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	read_net_item.2887
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r5, r3, 60
	st	r5, r2, 20
beq_cont.31318:
	ld	r5, r3, 56
	st	r5, r2, 16
beq_cont.31316:
	ld	r5, r3, 52
	st	r5, r2, 12
beq_cont.31314:
	ld	r5, r3, 48
	st	r5, r2, 8
beq_cont.31312:
	ld	r5, r3, 44
	st	r5, r2, 4
beq_cont.31310:
	ld	r5, r3, 40
	st	r5, r2, 0
	mr	r5, r2
beq_cont.31308:
	ld	r2, r5, 0
	cmpwi	cr0, r2, -1
	bne	beq_else.31319
	ld	r2, r3, 36
	addi	r2, r2, 1
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	b	beq_cont.31320
beq_else.31319:
	ld	r2, r3, 36
	addi	r6, r2, 1
	st	r5, r3, 64
	st	r6, r3, 68
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_read_int
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31321
	li	r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mr	r5, r2
	mtlr	r31
	b	beq_cont.31322
beq_else.31321:
	st	r2, r3, 72
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_read_int
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31323
	li	r2, 2
	li	r5, -1
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	b	beq_cont.31324
beq_else.31323:
	st	r2, r3, 76
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_read_int
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31325
	li	r2, 3
	li	r5, -1
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	b	beq_cont.31326
beq_else.31325:
	st	r2, r3, 80
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_read_int
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31327
	li	r2, 4
	li	r5, -1
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	b	beq_cont.31328
beq_else.31327:
	st	r2, r3, 84
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_read_int
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31329
	li	r2, 5
	li	r5, -1
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	b	beq_cont.31330
beq_else.31329:
	li	r5, 5
	st	r2, r3, 88
	mflr	r31
	mr	r2, r5
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	read_net_item.2887
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r5, r3, 88
	st	r5, r2, 16
beq_cont.31330:
	ld	r5, r3, 84
	st	r5, r2, 12
beq_cont.31328:
	ld	r5, r3, 80
	st	r5, r2, 8
beq_cont.31326:
	ld	r5, r3, 76
	st	r5, r2, 4
beq_cont.31324:
	ld	r5, r3, 72
	st	r5, r2, 0
	mr	r5, r2
beq_cont.31322:
	ld	r2, r5, 0
	cmpwi	cr0, r2, -1
	bne	beq_else.31331
	ld	r2, r3, 68
	addi	r2, r2, 1
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	b	beq_cont.31332
beq_else.31331:
	ld	r2, r3, 68
	addi	r6, r2, 1
	st	r5, r3, 92
	st	r6, r3, 96
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_read_int
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31333
	li	r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mr	r5, r2
	mtlr	r31
	b	beq_cont.31334
beq_else.31333:
	st	r2, r3, 100
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_read_int
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31335
	li	r2, 2
	li	r5, -1
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_create_array
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	b	beq_cont.31336
beq_else.31335:
	st	r2, r3, 104
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_read_int
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31337
	li	r2, 3
	li	r5, -1
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_create_array
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	b	beq_cont.31338
beq_else.31337:
	st	r2, r3, 108
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_read_int
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31339
	li	r2, 4
	li	r5, -1
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_create_array
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	b	beq_cont.31340
beq_else.31339:
	li	r5, 4
	st	r2, r3, 112
	mflr	r31
	mr	r2, r5
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	read_net_item.2887
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	ld	r5, r3, 112
	st	r5, r2, 12
beq_cont.31340:
	ld	r5, r3, 108
	st	r5, r2, 8
beq_cont.31338:
	ld	r5, r3, 104
	st	r5, r2, 4
beq_cont.31336:
	ld	r5, r3, 100
	st	r5, r2, 0
	mr	r5, r2
beq_cont.31334:
	ld	r2, r5, 0
	cmpwi	cr0, r2, -1
	bne	beq_else.31341
	ld	r2, r3, 96
	addi	r2, r2, 1
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_create_array
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	b	beq_cont.31342
beq_else.31341:
	ld	r2, r3, 96
	addi	r6, r2, 1
	st	r5, r3, 116
	mflr	r31
	mr	r2, r6
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	read_or_network.2889
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	ld	r5, r3, 96
	slwi	r5, r5, 2
	ld	r6, r3, 116
	add	r31, r2, r5
	st	r6, r31, 0
beq_cont.31342:
	ld	r5, r3, 68
	slwi	r5, r5, 2
	ld	r6, r3, 92
	add	r31, r2, r5
	st	r6, r31, 0
beq_cont.31332:
	ld	r5, r3, 36
	slwi	r5, r5, 2
	ld	r6, r3, 64
	add	r31, r2, r5
	st	r6, r31, 0
beq_cont.31320:
	ld	r5, r3, 0
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r2, r5
	st	r6, r31, 0
	blr
read_and_network.2891:
	ld	r5, r30, 4
	st	r30, r3, 0
	st	r5, r3, 4
	st	r2, r3, 8
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_read_int
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31343
	li	r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	b	beq_cont.31344
beq_else.31343:
	st	r2, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_read_int
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31345
	li	r2, 2
	li	r5, -1
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	b	beq_cont.31346
beq_else.31345:
	st	r2, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_read_int
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31347
	li	r2, 3
	li	r5, -1
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	b	beq_cont.31348
beq_else.31347:
	st	r2, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_read_int
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31349
	li	r2, 4
	li	r5, -1
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	b	beq_cont.31350
beq_else.31349:
	st	r2, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_read_int
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31351
	li	r2, 5
	li	r5, -1
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	b	beq_cont.31352
beq_else.31351:
	st	r2, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_read_int
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31353
	li	r2, 6
	li	r5, -1
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	b	beq_cont.31354
beq_else.31353:
	st	r2, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_read_int
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31355
	li	r2, 7
	li	r5, -1
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	b	beq_cont.31356
beq_else.31355:
	li	r5, 7
	st	r2, r3, 36
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	read_net_item.2887
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 36
	st	r5, r2, 24
beq_cont.31356:
	ld	r5, r3, 32
	st	r5, r2, 20
beq_cont.31354:
	ld	r5, r3, 28
	st	r5, r2, 16
beq_cont.31352:
	ld	r5, r3, 24
	st	r5, r2, 12
beq_cont.31350:
	ld	r5, r3, 20
	st	r5, r2, 8
beq_cont.31348:
	ld	r5, r3, 16
	st	r5, r2, 4
beq_cont.31346:
	ld	r5, r3, 12
	st	r5, r2, 0
beq_cont.31344:
	ld	r5, r2, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.31357
	blr
beq_else.31357:
	ld	r5, r3, 8
	slwi	r6, r5, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, 1
	st	r2, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_read_int
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31359
	li	r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	b	beq_cont.31360
beq_else.31359:
	st	r2, r3, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_read_int
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31361
	li	r2, 2
	li	r5, -1
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	b	beq_cont.31362
beq_else.31361:
	st	r2, r3, 48
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_read_int
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31363
	li	r2, 3
	li	r5, -1
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	b	beq_cont.31364
beq_else.31363:
	st	r2, r3, 52
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_read_int
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31365
	li	r2, 4
	li	r5, -1
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	b	beq_cont.31366
beq_else.31365:
	st	r2, r3, 56
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_read_int
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31367
	li	r2, 5
	li	r5, -1
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	b	beq_cont.31368
beq_else.31367:
	st	r2, r3, 60
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_read_int
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31369
	li	r2, 6
	li	r5, -1
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	b	beq_cont.31370
beq_else.31369:
	li	r5, 6
	st	r2, r3, 64
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	read_net_item.2887
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r5, r3, 64
	st	r5, r2, 20
beq_cont.31370:
	ld	r5, r3, 60
	st	r5, r2, 16
beq_cont.31368:
	ld	r5, r3, 56
	st	r5, r2, 12
beq_cont.31366:
	ld	r5, r3, 52
	st	r5, r2, 8
beq_cont.31364:
	ld	r5, r3, 48
	st	r5, r2, 4
beq_cont.31362:
	ld	r5, r3, 44
	st	r5, r2, 0
beq_cont.31360:
	ld	r5, r2, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.31371
	blr
beq_else.31371:
	ld	r5, r3, 40
	slwi	r6, r5, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, 1
	st	r2, r3, 68
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_read_int
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31373
	li	r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	b	beq_cont.31374
beq_else.31373:
	st	r2, r3, 72
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_read_int
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31375
	li	r2, 2
	li	r5, -1
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	b	beq_cont.31376
beq_else.31375:
	st	r2, r3, 76
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_read_int
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31377
	li	r2, 3
	li	r5, -1
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	b	beq_cont.31378
beq_else.31377:
	st	r2, r3, 80
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_read_int
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31379
	li	r2, 4
	li	r5, -1
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	b	beq_cont.31380
beq_else.31379:
	st	r2, r3, 84
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_read_int
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31381
	li	r2, 5
	li	r5, -1
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	b	beq_cont.31382
beq_else.31381:
	li	r5, 5
	st	r2, r3, 88
	mflr	r31
	mr	r2, r5
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	read_net_item.2887
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r5, r3, 88
	st	r5, r2, 16
beq_cont.31382:
	ld	r5, r3, 84
	st	r5, r2, 12
beq_cont.31380:
	ld	r5, r3, 80
	st	r5, r2, 8
beq_cont.31378:
	ld	r5, r3, 76
	st	r5, r2, 4
beq_cont.31376:
	ld	r5, r3, 72
	st	r5, r2, 0
beq_cont.31374:
	ld	r5, r2, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.31383
	blr
beq_else.31383:
	ld	r5, r3, 68
	slwi	r6, r5, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, 1
	st	r2, r3, 92
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_read_int
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31385
	li	r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	b	beq_cont.31386
beq_else.31385:
	st	r2, r3, 96
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_read_int
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31387
	li	r2, 2
	li	r5, -1
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	b	beq_cont.31388
beq_else.31387:
	st	r2, r3, 100
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_read_int
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31389
	li	r2, 3
	li	r5, -1
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_create_array
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	b	beq_cont.31390
beq_else.31389:
	st	r2, r3, 104
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_read_int
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31391
	li	r2, 4
	li	r5, -1
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_create_array
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	b	beq_cont.31392
beq_else.31391:
	li	r5, 4
	st	r2, r3, 108
	mflr	r31
	mr	r2, r5
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	read_net_item.2887
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	ld	r5, r3, 108
	st	r5, r2, 12
beq_cont.31392:
	ld	r5, r3, 104
	st	r5, r2, 8
beq_cont.31390:
	ld	r5, r3, 100
	st	r5, r2, 4
beq_cont.31388:
	ld	r5, r3, 96
	st	r5, r2, 0
beq_cont.31386:
	ld	r5, r2, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.31393
	blr
beq_else.31393:
	ld	r5, r3, 92
	slwi	r6, r5, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, 1
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
read_parameter.2893:
	ld	r2, r30, 36
	ld	r5, r30, 32
	ld	r6, r30, 28
	ld	r7, r30, 24
	ld	r8, r30, 20
	ld	r9, r30, 16
	ld	r10, r30, 12
	ld	r11, r30, 8
	ld	r12, r30, 4
	st	r8, r3, 0
	st	r7, r3, 4
	st	r12, r3, 8
	st	r5, r3, 12
	st	r9, r3, 16
	st	r6, r3, 20
	st	r11, r3, 24
	st	r10, r3, 28
	mflr	r31
	mr	r30, r2
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_read_int
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_read_float
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r0, 84
	fmul	fr1, fr1, fr2
	fst	fr1, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_sin
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fsub	fr1, fr0, fr1
	ld	r2, r3, 28
	fst	fr1, r2, 4
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_read_float
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r0, 84
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 32
	fst	fr1, r3, 36
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_cos
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 36
	fst	fr1, r3, 40
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_sin
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 40
	fmul	fr1, fr2, fr1
	ld	r2, r3, 28
	fst	fr1, r2, 0
	fld	fr1, r3, 36
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_cos
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 40
	fmul	fr1, fr2, fr1
	ld	r2, r3, 28
	fst	fr1, r2, 8
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_read_float
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 24
	fst	fr1, r2, 0
	li	r2, 0
	ld	r30, r3, 20
	st	r2, r3, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31395
	ld	r2, r3, 16
	ld	r5, r3, 44
	st	r5, r2, 0
	b	beq_cont.31396
beq_else.31395:
	li	r2, 1
	ld	r30, r3, 20
	st	r2, r3, 48
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31397
	ld	r2, r3, 16
	ld	r5, r3, 48
	st	r5, r2, 0
	b	beq_cont.31398
beq_else.31397:
	li	r2, 2
	ld	r30, r3, 20
	st	r2, r3, 52
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31399
	ld	r2, r3, 16
	ld	r5, r3, 52
	st	r5, r2, 0
	b	beq_cont.31400
beq_else.31399:
	li	r2, 3
	ld	r30, r3, 20
	st	r2, r3, 56
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31401
	ld	r2, r3, 16
	ld	r5, r3, 56
	st	r5, r2, 0
	b	beq_cont.31402
beq_else.31401:
	li	r2, 4
	ld	r30, r3, 20
	st	r2, r3, 60
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31403
	ld	r2, r3, 16
	ld	r5, r3, 60
	st	r5, r2, 0
	b	beq_cont.31404
beq_else.31403:
	li	r2, 5
	ld	r30, r3, 20
	st	r2, r3, 64
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31405
	ld	r2, r3, 16
	ld	r5, r3, 64
	st	r5, r2, 0
	b	beq_cont.31406
beq_else.31405:
	li	r2, 6
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
beq_cont.31406:
beq_cont.31404:
beq_cont.31402:
beq_cont.31400:
beq_cont.31398:
beq_cont.31396:
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_read_int
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31407
	li	r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	b	beq_cont.31408
beq_else.31407:
	st	r2, r3, 68
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_read_int
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31409
	li	r2, 2
	li	r5, -1
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	b	beq_cont.31410
beq_else.31409:
	st	r2, r3, 72
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_read_int
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31411
	li	r2, 3
	li	r5, -1
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	b	beq_cont.31412
beq_else.31411:
	st	r2, r3, 76
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_read_int
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31413
	li	r2, 4
	li	r5, -1
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	b	beq_cont.31414
beq_else.31413:
	st	r2, r3, 80
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_read_int
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31415
	li	r2, 5
	li	r5, -1
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	b	beq_cont.31416
beq_else.31415:
	st	r2, r3, 84
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_read_int
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31417
	li	r2, 6
	li	r5, -1
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	b	beq_cont.31418
beq_else.31417:
	li	r5, 6
	st	r2, r3, 88
	mflr	r31
	mr	r2, r5
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	read_net_item.2887
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r5, r3, 88
	st	r5, r2, 20
beq_cont.31418:
	ld	r5, r3, 84
	st	r5, r2, 16
beq_cont.31416:
	ld	r5, r3, 80
	st	r5, r2, 12
beq_cont.31414:
	ld	r5, r3, 76
	st	r5, r2, 8
beq_cont.31412:
	ld	r5, r3, 72
	st	r5, r2, 4
beq_cont.31410:
	ld	r5, r3, 68
	st	r5, r2, 0
beq_cont.31408:
	ld	r5, r2, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.31419
	b	beq_cont.31420
beq_else.31419:
	ld	r5, r3, 8
	st	r2, r5, 0
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_read_int
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31421
	li	r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	b	beq_cont.31422
beq_else.31421:
	st	r2, r3, 92
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_read_int
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31423
	li	r2, 2
	li	r5, -1
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	b	beq_cont.31424
beq_else.31423:
	st	r2, r3, 96
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_read_int
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31425
	li	r2, 3
	li	r5, -1
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	b	beq_cont.31426
beq_else.31425:
	st	r2, r3, 100
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_read_int
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31427
	li	r2, 4
	li	r5, -1
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_create_array
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	b	beq_cont.31428
beq_else.31427:
	st	r2, r3, 104
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_read_int
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31429
	li	r2, 5
	li	r5, -1
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_create_array
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	b	beq_cont.31430
beq_else.31429:
	li	r5, 5
	st	r2, r3, 108
	mflr	r31
	mr	r2, r5
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	read_net_item.2887
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	ld	r5, r3, 108
	st	r5, r2, 16
beq_cont.31430:
	ld	r5, r3, 104
	st	r5, r2, 12
beq_cont.31428:
	ld	r5, r3, 100
	st	r5, r2, 8
beq_cont.31426:
	ld	r5, r3, 96
	st	r5, r2, 4
beq_cont.31424:
	ld	r5, r3, 92
	st	r5, r2, 0
beq_cont.31422:
	ld	r5, r2, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.31431
	b	beq_cont.31432
beq_else.31431:
	ld	r5, r3, 8
	st	r2, r5, 4
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_read_int
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31433
	li	r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_create_array
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	b	beq_cont.31434
beq_else.31433:
	st	r2, r3, 112
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_read_int
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31435
	li	r2, 2
	li	r5, -1
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_create_array
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	b	beq_cont.31436
beq_else.31435:
	st	r2, r3, 116
	mflr	r31
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_read_int
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31437
	li	r2, 3
	li	r5, -1
	mflr	r31
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_create_array
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	b	beq_cont.31438
beq_else.31437:
	st	r2, r3, 120
	mflr	r31
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_read_int
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31439
	li	r2, 4
	li	r5, -1
	mflr	r31
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_create_array
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	b	beq_cont.31440
beq_else.31439:
	li	r5, 4
	st	r2, r3, 124
	mflr	r31
	mr	r2, r5
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	read_net_item.2887
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r5, r3, 124
	st	r5, r2, 12
beq_cont.31440:
	ld	r5, r3, 120
	st	r5, r2, 8
beq_cont.31438:
	ld	r5, r3, 116
	st	r5, r2, 4
beq_cont.31436:
	ld	r5, r3, 112
	st	r5, r2, 0
beq_cont.31434:
	ld	r5, r2, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.31441
	b	beq_cont.31442
beq_else.31441:
	ld	r5, r3, 8
	st	r2, r5, 8
	li	r2, 3
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
beq_cont.31442:
beq_cont.31432:
beq_cont.31420:
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_read_int
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31443
	li	r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_create_array
	addi	r3, r3, -136
	ld	r31, r3, 132
	mr	r5, r2
	mtlr	r31
	b	beq_cont.31444
beq_else.31443:
	st	r2, r3, 128
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_read_int
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31445
	li	r2, 2
	li	r5, -1
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_create_array
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	b	beq_cont.31446
beq_else.31445:
	st	r2, r3, 132
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_read_int
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31447
	li	r2, 3
	li	r5, -1
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_create_array
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	b	beq_cont.31448
beq_else.31447:
	st	r2, r3, 136
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_read_int
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31449
	li	r2, 4
	li	r5, -1
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_create_array
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	b	beq_cont.31450
beq_else.31449:
	st	r2, r3, 140
	mflr	r31
	st	r31, r3, 148
	addi	r3, r3, 152
	bl	min_caml_read_int
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31451
	li	r2, 5
	li	r5, -1
	mflr	r31
	st	r31, r3, 148
	addi	r3, r3, 152
	bl	min_caml_create_array
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	b	beq_cont.31452
beq_else.31451:
	st	r2, r3, 144
	mflr	r31
	st	r31, r3, 148
	addi	r3, r3, 152
	bl	min_caml_read_int
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31453
	li	r2, 6
	li	r5, -1
	mflr	r31
	st	r31, r3, 148
	addi	r3, r3, 152
	bl	min_caml_create_array
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	b	beq_cont.31454
beq_else.31453:
	li	r5, 6
	st	r2, r3, 148
	mflr	r31
	mr	r2, r5
	st	r31, r3, 156
	addi	r3, r3, 160
	bl	read_net_item.2887
	addi	r3, r3, -160
	ld	r31, r3, 156
	mtlr	r31
	ld	r5, r3, 148
	st	r5, r2, 20
beq_cont.31454:
	ld	r5, r3, 144
	st	r5, r2, 16
beq_cont.31452:
	ld	r5, r3, 140
	st	r5, r2, 12
beq_cont.31450:
	ld	r5, r3, 136
	st	r5, r2, 8
beq_cont.31448:
	ld	r5, r3, 132
	st	r5, r2, 4
beq_cont.31446:
	ld	r5, r3, 128
	st	r5, r2, 0
	mr	r5, r2
beq_cont.31444:
	ld	r2, r5, 0
	cmpwi	cr0, r2, -1
	bne	beq_else.31455
	li	r2, 1
	mflr	r31
	st	r31, r3, 156
	addi	r3, r3, 160
	bl	min_caml_create_array
	addi	r3, r3, -160
	ld	r31, r3, 156
	mtlr	r31
	b	beq_cont.31456
beq_else.31455:
	st	r5, r3, 152
	mflr	r31
	st	r31, r3, 156
	addi	r3, r3, 160
	bl	min_caml_read_int
	addi	r3, r3, -160
	ld	r31, r3, 156
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31457
	li	r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 156
	addi	r3, r3, 160
	bl	min_caml_create_array
	addi	r3, r3, -160
	ld	r31, r3, 156
	mr	r5, r2
	mtlr	r31
	b	beq_cont.31458
beq_else.31457:
	st	r2, r3, 156
	mflr	r31
	st	r31, r3, 164
	addi	r3, r3, 168
	bl	min_caml_read_int
	addi	r3, r3, -168
	ld	r31, r3, 164
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31459
	li	r2, 2
	li	r5, -1
	mflr	r31
	st	r31, r3, 164
	addi	r3, r3, 168
	bl	min_caml_create_array
	addi	r3, r3, -168
	ld	r31, r3, 164
	mtlr	r31
	b	beq_cont.31460
beq_else.31459:
	st	r2, r3, 160
	mflr	r31
	st	r31, r3, 164
	addi	r3, r3, 168
	bl	min_caml_read_int
	addi	r3, r3, -168
	ld	r31, r3, 164
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31461
	li	r2, 3
	li	r5, -1
	mflr	r31
	st	r31, r3, 164
	addi	r3, r3, 168
	bl	min_caml_create_array
	addi	r3, r3, -168
	ld	r31, r3, 164
	mtlr	r31
	b	beq_cont.31462
beq_else.31461:
	st	r2, r3, 164
	mflr	r31
	st	r31, r3, 172
	addi	r3, r3, 176
	bl	min_caml_read_int
	addi	r3, r3, -176
	ld	r31, r3, 172
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31463
	li	r2, 4
	li	r5, -1
	mflr	r31
	st	r31, r3, 172
	addi	r3, r3, 176
	bl	min_caml_create_array
	addi	r3, r3, -176
	ld	r31, r3, 172
	mtlr	r31
	b	beq_cont.31464
beq_else.31463:
	st	r2, r3, 168
	mflr	r31
	st	r31, r3, 172
	addi	r3, r3, 176
	bl	min_caml_read_int
	addi	r3, r3, -176
	ld	r31, r3, 172
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31465
	li	r2, 5
	li	r5, -1
	mflr	r31
	st	r31, r3, 172
	addi	r3, r3, 176
	bl	min_caml_create_array
	addi	r3, r3, -176
	ld	r31, r3, 172
	mtlr	r31
	b	beq_cont.31466
beq_else.31465:
	li	r5, 5
	st	r2, r3, 172
	mflr	r31
	mr	r2, r5
	st	r31, r3, 180
	addi	r3, r3, 184
	bl	read_net_item.2887
	addi	r3, r3, -184
	ld	r31, r3, 180
	mtlr	r31
	ld	r5, r3, 172
	st	r5, r2, 16
beq_cont.31466:
	ld	r5, r3, 168
	st	r5, r2, 12
beq_cont.31464:
	ld	r5, r3, 164
	st	r5, r2, 8
beq_cont.31462:
	ld	r5, r3, 160
	st	r5, r2, 4
beq_cont.31460:
	ld	r5, r3, 156
	st	r5, r2, 0
	mr	r5, r2
beq_cont.31458:
	ld	r2, r5, 0
	cmpwi	cr0, r2, -1
	bne	beq_else.31467
	li	r2, 2
	mflr	r31
	st	r31, r3, 180
	addi	r3, r3, 184
	bl	min_caml_create_array
	addi	r3, r3, -184
	ld	r31, r3, 180
	mtlr	r31
	b	beq_cont.31468
beq_else.31467:
	st	r5, r3, 176
	mflr	r31
	st	r31, r3, 180
	addi	r3, r3, 184
	bl	min_caml_read_int
	addi	r3, r3, -184
	ld	r31, r3, 180
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31469
	li	r2, 1
	li	r5, -1
	mflr	r31
	st	r31, r3, 180
	addi	r3, r3, 184
	bl	min_caml_create_array
	addi	r3, r3, -184
	ld	r31, r3, 180
	mr	r5, r2
	mtlr	r31
	b	beq_cont.31470
beq_else.31469:
	st	r2, r3, 180
	mflr	r31
	st	r31, r3, 188
	addi	r3, r3, 192
	bl	min_caml_read_int
	addi	r3, r3, -192
	ld	r31, r3, 188
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31471
	li	r2, 2
	li	r5, -1
	mflr	r31
	st	r31, r3, 188
	addi	r3, r3, 192
	bl	min_caml_create_array
	addi	r3, r3, -192
	ld	r31, r3, 188
	mtlr	r31
	b	beq_cont.31472
beq_else.31471:
	st	r2, r3, 184
	mflr	r31
	st	r31, r3, 188
	addi	r3, r3, 192
	bl	min_caml_read_int
	addi	r3, r3, -192
	ld	r31, r3, 188
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31473
	li	r2, 3
	li	r5, -1
	mflr	r31
	st	r31, r3, 188
	addi	r3, r3, 192
	bl	min_caml_create_array
	addi	r3, r3, -192
	ld	r31, r3, 188
	mtlr	r31
	b	beq_cont.31474
beq_else.31473:
	st	r2, r3, 188
	mflr	r31
	st	r31, r3, 196
	addi	r3, r3, 200
	bl	min_caml_read_int
	addi	r3, r3, -200
	ld	r31, r3, 196
	mtlr	r31
	cmpwi	cr0, r2, -1
	bne	beq_else.31475
	li	r2, 4
	li	r5, -1
	mflr	r31
	st	r31, r3, 196
	addi	r3, r3, 200
	bl	min_caml_create_array
	addi	r3, r3, -200
	ld	r31, r3, 196
	mtlr	r31
	b	beq_cont.31476
beq_else.31475:
	li	r5, 4
	st	r2, r3, 192
	mflr	r31
	mr	r2, r5
	st	r31, r3, 196
	addi	r3, r3, 200
	bl	read_net_item.2887
	addi	r3, r3, -200
	ld	r31, r3, 196
	mtlr	r31
	ld	r5, r3, 192
	st	r5, r2, 12
beq_cont.31476:
	ld	r5, r3, 188
	st	r5, r2, 8
beq_cont.31474:
	ld	r5, r3, 184
	st	r5, r2, 4
beq_cont.31472:
	ld	r5, r3, 180
	st	r5, r2, 0
	mr	r5, r2
beq_cont.31470:
	ld	r2, r5, 0
	cmpwi	cr0, r2, -1
	bne	beq_else.31477
	li	r2, 3
	mflr	r31
	st	r31, r3, 196
	addi	r3, r3, 200
	bl	min_caml_create_array
	addi	r3, r3, -200
	ld	r31, r3, 196
	mtlr	r31
	b	beq_cont.31478
beq_else.31477:
	li	r2, 3
	st	r5, r3, 196
	mflr	r31
	st	r31, r3, 204
	addi	r3, r3, 208
	bl	read_or_network.2889
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	ld	r5, r3, 196
	st	r5, r2, 8
beq_cont.31478:
	ld	r5, r3, 176
	st	r5, r2, 4
beq_cont.31468:
	ld	r5, r3, 152
	st	r5, r2, 0
beq_cont.31456:
	ld	r5, r3, 0
	st	r2, r5, 0
	blr
solver_rect_surface.2895:
	ld	r9, r30, 4
	slwi	r10, r6, 2
	add	r31, r5, r10
	fld	fr4, r31, 0
	fld	fr5, r0, 44
	fcmp	cr0, fr4, fr5
	bne	beq_else.31480
	li	r10, 1
	b	beq_cont.31481
beq_else.31480:
	li	r10, 0
beq_cont.31481:
	cmpwi	cr0, r10, 0
	bne	beq_else.31482
	ld	r10, r2, 16
	ld	r2, r2, 24
	slwi	r11, r6, 2
	add	r31, r5, r11
	fld	fr4, r31, 0
	fld	fr5, r0, 44
	fcmp	cr0, fr5, fr4
	blt	le.31483
	beq	le.31483
	li	r11, 1
	b	gt_cont.31484
le.31483:
	li	r11, 0
gt_cont.31484:
	cmpwi	cr0, r2, 0
	bne	beq_else.31485
	mr	r2, r11
	b	beq_cont.31486
beq_else.31485:
	cmpwi	cr0, r11, 0
	bne	beq_else.31487
	li	r2, 1
	b	beq_cont.31488
beq_else.31487:
	li	r2, 0
beq_cont.31488:
beq_cont.31486:
	slwi	r11, r6, 2
	add	r31, r10, r11
	fld	fr4, r31, 0
	cmpwi	cr0, r2, 0
	bne	beq_else.31489
	fsub	fr4, fr0, fr4
	b	beq_cont.31490
beq_else.31489:
beq_cont.31490:
	fsub	fr1, fr4, fr1
	slwi	r2, r6, 2
	add	r31, r5, r2
	fld	fr4, r31, 0
	fdiv	fr1, fr1, fr4
	slwi	r2, r7, 2
	add	r31, r5, r2
	fld	fr4, r31, 0
	fmul	fr4, fr1, fr4
	fadd	fr4, fr4, fr2
	st	r9, r3, 0
	fst	fr3, r3, 4
	st	r8, r3, 8
	fst	fr2, r3, 12
	fst	fr1, r3, 16
	st	r5, r3, 20
	st	r10, r3, 24
	st	r7, r3, 28
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fabs
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	slwi	r5, r2, 2
	ld	r6, r3, 24
	add	r31, r6, r5
	fld	fr1, r31, 0
	slwi	r2, r2, 2
	ld	r5, r3, 20
	add	r31, r5, r2
	fld	fr2, r31, 0
	fld	fr3, r3, 16
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 12
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
	blt	le.31491
	beq	le.31491
	li	r2, 1
	b	gt_cont.31492
le.31491:
	li	r2, 0
gt_cont.31492:
	cmpwi	cr0, r2, 0
	bne	beq_else.31493
	li	r2, 0
	blr
beq_else.31493:
	ld	r2, r3, 8
	slwi	r5, r2, 2
	ld	r6, r3, 20
	add	r31, r6, r5
	fld	fr1, r31, 0
	fld	fr2, r3, 16
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 4
	fadd	fr1, fr1, fr3
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fabs
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 8
	slwi	r5, r2, 2
	ld	r6, r3, 24
	add	r31, r6, r5
	fld	fr1, r31, 0
	slwi	r2, r2, 2
	ld	r5, r3, 20
	add	r31, r5, r2
	fld	fr2, r31, 0
	fld	fr3, r3, 16
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 4
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
	blt	le.31494
	beq	le.31494
	li	r2, 1
	b	gt_cont.31495
le.31494:
	li	r2, 0
gt_cont.31495:
	cmpwi	cr0, r2, 0
	bne	beq_else.31496
	li	r2, 0
	blr
beq_else.31496:
	ld	r2, r3, 0
	fld	fr1, r3, 16
	fst	fr1, r2, 0
	li	r2, 1
	blr
beq_else.31482:
	li	r2, 0
	blr
solver_rect.2904:
	ld	r6, r30, 4
	fld	fr4, r5, 0
	fld	fr5, r0, 44
	fcmp	cr0, fr4, fr5
	bne	beq_else.31497
	li	r7, 1
	b	beq_cont.31498
beq_else.31497:
	li	r7, 0
beq_cont.31498:
	st	r6, r3, 0
	fst	fr1, r3, 4
	fst	fr3, r3, 8
	fst	fr2, r3, 12
	st	r2, r3, 16
	st	r5, r3, 20
	cmpwi	cr0, r7, 0
	bne	beq_else.31499
	ld	r7, r2, 16
	ld	r8, r2, 24
	fld	fr4, r5, 0
	fld	fr5, r0, 44
	fcmp	cr0, fr5, fr4
	blt	le.31501
	beq	le.31501
	li	r9, 1
	b	gt_cont.31502
le.31501:
	li	r9, 0
gt_cont.31502:
	cmpwi	cr0, r8, 0
	bne	beq_else.31503
	mr	r8, r9
	b	beq_cont.31504
beq_else.31503:
	cmpwi	cr0, r9, 0
	bne	beq_else.31505
	li	r8, 1
	b	beq_cont.31506
beq_else.31505:
	li	r8, 0
beq_cont.31506:
beq_cont.31504:
	fld	fr4, r7, 0
	cmpwi	cr0, r8, 0
	bne	beq_else.31507
	fsub	fr4, fr0, fr4
	b	beq_cont.31508
beq_else.31507:
beq_cont.31508:
	fsub	fr4, fr4, fr1
	fld	fr5, r5, 0
	fdiv	fr4, fr4, fr5
	fld	fr5, r5, 4
	fmul	fr5, fr4, fr5
	fadd	fr5, fr5, fr2
	fst	fr4, r3, 24
	st	r7, r3, 28
	mflr	r31
	fmr	fr1, fr5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fabs
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	fld	fr1, r2, 4
	ld	r5, r3, 20
	fld	fr2, r5, 4
	fld	fr3, r3, 24
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 12
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
	blt	le.31509
	beq	le.31509
	li	r2, 1
	b	gt_cont.31510
le.31509:
	li	r2, 0
gt_cont.31510:
	cmpwi	cr0, r2, 0
	bne	beq_else.31511
	li	r2, 0
	b	beq_cont.31512
beq_else.31511:
	ld	r2, r3, 20
	fld	fr1, r2, 8
	fld	fr2, r3, 24
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 8
	fadd	fr1, fr1, fr3
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fabs
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	fld	fr1, r2, 8
	ld	r2, r3, 20
	fld	fr2, r2, 8
	fld	fr3, r3, 24
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 8
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
	blt	le.31513
	beq	le.31513
	li	r2, 1
	b	gt_cont.31514
le.31513:
	li	r2, 0
gt_cont.31514:
	cmpwi	cr0, r2, 0
	bne	beq_else.31515
	li	r2, 0
	b	beq_cont.31516
beq_else.31515:
	ld	r2, r3, 0
	fld	fr1, r3, 24
	fst	fr1, r2, 0
	li	r2, 1
beq_cont.31516:
beq_cont.31512:
	b	beq_cont.31500
beq_else.31499:
	li	r2, 0
beq_cont.31500:
	cmpwi	cr0, r2, 0
	bne	beq_else.31517
	ld	r2, r3, 20
	fld	fr1, r2, 4
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31518
	li	r5, 1
	b	beq_cont.31519
beq_else.31518:
	li	r5, 0
beq_cont.31519:
	cmpwi	cr0, r5, 0
	bne	beq_else.31520
	ld	r5, r3, 16
	ld	r6, r5, 16
	ld	r7, r5, 24
	fld	fr1, r2, 4
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.31522
	beq	le.31522
	li	r8, 1
	b	gt_cont.31523
le.31522:
	li	r8, 0
gt_cont.31523:
	cmpwi	cr0, r7, 0
	bne	beq_else.31524
	mr	r7, r8
	b	beq_cont.31525
beq_else.31524:
	cmpwi	cr0, r8, 0
	bne	beq_else.31526
	li	r7, 1
	b	beq_cont.31527
beq_else.31526:
	li	r7, 0
beq_cont.31527:
beq_cont.31525:
	fld	fr1, r6, 4
	cmpwi	cr0, r7, 0
	bne	beq_else.31528
	fsub	fr1, fr0, fr1
	b	beq_cont.31529
beq_else.31528:
beq_cont.31529:
	fld	fr2, r3, 12
	fsub	fr1, fr1, fr2
	fld	fr3, r2, 4
	fdiv	fr1, fr1, fr3
	fld	fr3, r2, 8
	fmul	fr3, fr1, fr3
	fld	fr4, r3, 8
	fadd	fr3, fr3, fr4
	fst	fr1, r3, 40
	st	r6, r3, 44
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fabs
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	fld	fr1, r2, 8
	ld	r5, r3, 20
	fld	fr2, r5, 8
	fld	fr3, r3, 40
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 8
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
	blt	le.31530
	beq	le.31530
	li	r2, 1
	b	gt_cont.31531
le.31530:
	li	r2, 0
gt_cont.31531:
	cmpwi	cr0, r2, 0
	bne	beq_else.31532
	li	r2, 0
	b	beq_cont.31533
beq_else.31532:
	ld	r2, r3, 20
	fld	fr1, r2, 0
	fld	fr2, r3, 40
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 4
	fadd	fr1, fr1, fr3
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fabs
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	fld	fr1, r2, 0
	ld	r2, r3, 20
	fld	fr2, r2, 0
	fld	fr3, r3, 40
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
	blt	le.31534
	beq	le.31534
	li	r2, 1
	b	gt_cont.31535
le.31534:
	li	r2, 0
gt_cont.31535:
	cmpwi	cr0, r2, 0
	bne	beq_else.31536
	li	r2, 0
	b	beq_cont.31537
beq_else.31536:
	ld	r2, r3, 0
	fld	fr1, r3, 40
	fst	fr1, r2, 0
	li	r2, 1
beq_cont.31537:
beq_cont.31533:
	b	beq_cont.31521
beq_else.31520:
	li	r2, 0
beq_cont.31521:
	cmpwi	cr0, r2, 0
	bne	beq_else.31538
	ld	r2, r3, 20
	fld	fr1, r2, 8
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31539
	li	r5, 1
	b	beq_cont.31540
beq_else.31539:
	li	r5, 0
beq_cont.31540:
	cmpwi	cr0, r5, 0
	bne	beq_else.31541
	ld	r5, r3, 16
	ld	r6, r5, 16
	ld	r5, r5, 24
	fld	fr1, r2, 8
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.31543
	beq	le.31543
	li	r7, 1
	b	gt_cont.31544
le.31543:
	li	r7, 0
gt_cont.31544:
	cmpwi	cr0, r5, 0
	bne	beq_else.31545
	mr	r5, r7
	b	beq_cont.31546
beq_else.31545:
	cmpwi	cr0, r7, 0
	bne	beq_else.31547
	li	r5, 1
	b	beq_cont.31548
beq_else.31547:
	li	r5, 0
beq_cont.31548:
beq_cont.31546:
	fld	fr1, r6, 8
	cmpwi	cr0, r5, 0
	bne	beq_else.31549
	fsub	fr1, fr0, fr1
	b	beq_cont.31550
beq_else.31549:
beq_cont.31550:
	fld	fr2, r3, 8
	fsub	fr1, fr1, fr2
	fld	fr2, r2, 8
	fdiv	fr1, fr1, fr2
	fld	fr2, r2, 0
	fmul	fr2, fr1, fr2
	fld	fr3, r3, 4
	fadd	fr2, fr2, fr3
	fst	fr1, r3, 56
	st	r6, r3, 60
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_fabs
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 60
	fld	fr1, r2, 0
	ld	r5, r3, 20
	fld	fr2, r5, 0
	fld	fr3, r3, 56
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 4
	fadd	fr2, fr2, fr4
	fst	fr1, r3, 64
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_fabs
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 64
	fcmp	cr0, fr2, fr1
	blt	le.31551
	beq	le.31551
	li	r2, 1
	b	gt_cont.31552
le.31551:
	li	r2, 0
gt_cont.31552:
	cmpwi	cr0, r2, 0
	bne	beq_else.31553
	li	r2, 0
	b	beq_cont.31554
beq_else.31553:
	ld	r2, r3, 20
	fld	fr1, r2, 4
	fld	fr2, r3, 56
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 12
	fadd	fr1, fr1, fr3
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_fabs
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 60
	fld	fr1, r2, 4
	ld	r2, r3, 20
	fld	fr2, r2, 4
	fld	fr3, r3, 56
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 12
	fadd	fr2, fr2, fr4
	fst	fr1, r3, 68
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_fabs
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 68
	fcmp	cr0, fr2, fr1
	blt	le.31555
	beq	le.31555
	li	r2, 1
	b	gt_cont.31556
le.31555:
	li	r2, 0
gt_cont.31556:
	cmpwi	cr0, r2, 0
	bne	beq_else.31557
	li	r2, 0
	b	beq_cont.31558
beq_else.31557:
	ld	r2, r3, 0
	fld	fr1, r3, 56
	fst	fr1, r2, 0
	li	r2, 1
beq_cont.31558:
beq_cont.31554:
	b	beq_cont.31542
beq_else.31541:
	li	r2, 0
beq_cont.31542:
	cmpwi	cr0, r2, 0
	bne	beq_else.31559
	li	r2, 0
	blr
beq_else.31559:
	li	r2, 3
	blr
beq_else.31538:
	li	r2, 2
	blr
beq_else.31517:
	li	r2, 1
	blr
solver_second.2929:
	ld	r6, r30, 4
	fld	fr4, r5, 0
	fld	fr5, r5, 4
	fld	fr6, r5, 8
	st	r6, r3, 0
	fst	fr3, r3, 4
	fst	fr2, r3, 8
	fst	fr1, r3, 12
	st	r5, r3, 16
	fst	fr4, r3, 20
	fst	fr6, r3, 24
	fst	fr5, r3, 28
	st	r2, r3, 32
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fsqr
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 32
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
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
	ld	r2, r3, 32
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 36
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 24
	fst	fr1, r3, 40
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_fsqr
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 32
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 40
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.31560
	b	beq_cont.31561
beq_else.31560:
	fld	fr2, r3, 24
	fld	fr3, r3, 28
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 20
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.31561:
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31562
	li	r5, 1
	b	beq_cont.31563
beq_else.31562:
	li	r5, 0
beq_cont.31563:
	cmpwi	cr0, r5, 0
	bne	beq_else.31564
	ld	r5, r3, 16
	fld	fr2, r5, 0
	fld	fr3, r5, 4
	fld	fr4, r5, 8
	fld	fr5, r3, 12
	fmul	fr6, fr2, fr5
	ld	r5, r2, 16
	fld	fr7, r5, 0
	fmul	fr6, fr6, fr7
	fld	fr7, r3, 8
	fmul	fr8, fr3, fr7
	ld	r5, r2, 16
	fld	fr9, r5, 4
	fmul	fr8, fr8, fr9
	fadd	fr6, fr6, fr8
	fld	fr8, r3, 4
	fmul	fr9, fr4, fr8
	ld	r5, r2, 16
	fld	fr10, r5, 8
	fmul	fr9, fr9, fr10
	fadd	fr6, fr6, fr9
	ld	r5, r2, 12
	fst	fr1, r3, 44
	cmpwi	cr0, r5, 0
	bne	beq_else.31565
	fmr	fr1, fr6
	b	beq_cont.31566
beq_else.31565:
	fmul	fr9, fr4, fr7
	fmul	fr10, fr3, fr8
	fadd	fr9, fr9, fr10
	ld	r5, r2, 36
	fld	fr10, r5, 0
	fmul	fr9, fr9, fr10
	fmul	fr10, fr2, fr8
	fmul	fr4, fr4, fr5
	fadd	fr4, fr10, fr4
	ld	r5, r2, 36
	fld	fr10, r5, 4
	fmul	fr4, fr4, fr10
	fadd	fr4, fr9, fr4
	fmul	fr2, fr2, fr7
	fmul	fr3, fr3, fr5
	fadd	fr2, fr2, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr2, fr4, fr2
	fst	fr6, r3, 48
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fhalf
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 48
	fadd	fr1, fr2, fr1
beq_cont.31566:
	fld	fr2, r3, 12
	fst	fr1, r3, 52
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fsqr
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 32
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 8
	fst	fr1, r3, 56
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fsqr
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 32
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 56
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 4
	fst	fr1, r3, 60
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_fsqr
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 32
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 60
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.31567
	b	beq_cont.31568
beq_else.31567:
	fld	fr2, r3, 4
	fld	fr3, r3, 8
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 12
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.31568:
	ld	r5, r2, 4
	cmpwi	cr0, r5, 3
	bne	beq_else.31569
	fld	fr2, r0, 16
	fsub	fr1, fr1, fr2
	b	beq_cont.31570
beq_else.31569:
beq_cont.31570:
	fld	fr2, r3, 52
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
	fld	fr3, r3, 44
	fmul	fr2, fr3, fr2
	fsub	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.31571
	beq	le.31571
	li	r2, 1
	b	gt_cont.31572
le.31571:
	li	r2, 0
gt_cont.31572:
	cmpwi	cr0, r2, 0
	bne	beq_else.31573
	li	r2, 0
	blr
beq_else.31573:
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_sqrt
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 32
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.31574
	fsub	fr1, fr0, fr1
	b	beq_cont.31575
beq_else.31574:
beq_cont.31575:
	fld	fr2, r3, 52
	fsub	fr1, fr1, fr2
	fld	fr2, r3, 44
	fdiv	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 0
	li	r2, 1
	blr
beq_else.31564:
	li	r2, 0
	blr
solver.2935:
	ld	r7, r30, 12
	ld	r8, r30, 8
	ld	r9, r30, 4
	slwi	r2, r2, 2
	add	r31, r9, r2
	ld	r2, r31, 0
	fld	fr1, r6, 0
	ld	r9, r2, 20
	fld	fr2, r9, 0
	fsub	fr1, fr1, fr2
	fld	fr2, r6, 4
	ld	r9, r2, 20
	fld	fr3, r9, 4
	fsub	fr2, fr2, fr3
	fld	fr3, r6, 8
	ld	r6, r2, 20
	fld	fr4, r6, 8
	fsub	fr3, fr3, fr4
	ld	r6, r2, 4
	cmpwi	cr0, r6, 1
	bne	beq_else.31576
	li	r6, 0
	li	r8, 1
	li	r9, 2
	fst	fr1, r3, 0
	fst	fr3, r3, 4
	fst	fr2, r3, 8
	st	r5, r3, 12
	st	r2, r3, 16
	st	r7, r3, 20
	mflr	r31
	mr	r30, r7
	mr	r7, r8
	mr	r8, r9
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31577
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
	bal	r31
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31578
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
	bal	r31
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31579
	li	r2, 0
	blr
beq_else.31579:
	li	r2, 3
	blr
beq_else.31578:
	li	r2, 2
	blr
beq_else.31577:
	li	r2, 1
	blr
beq_else.31576:
	cmpwi	cr0, r6, 2
	bne	beq_else.31580
	ld	r2, r2, 16
	fld	fr4, r5, 0
	fld	fr5, r2, 0
	fmul	fr4, fr4, fr5
	fld	fr5, r5, 4
	fld	fr6, r2, 4
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	fld	fr5, r5, 8
	fld	fr6, r2, 8
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	fld	fr5, r0, 44
	fcmp	cr0, fr4, fr5
	blt	le.31581
	beq	le.31581
	li	r5, 1
	b	gt_cont.31582
le.31581:
	li	r5, 0
gt_cont.31582:
	cmpwi	cr0, r5, 0
	bne	beq_else.31583
	li	r2, 0
	blr
beq_else.31583:
	fld	fr5, r2, 0
	fmul	fr1, fr5, fr1
	fld	fr5, r2, 4
	fmul	fr2, fr5, fr2
	fadd	fr1, fr1, fr2
	fld	fr2, r2, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fsub	fr1, fr0, fr1
	fdiv	fr1, fr1, fr4
	fst	fr1, r8, 0
	li	r2, 1
	blr
beq_else.31580:
	fld	fr4, r5, 0
	fld	fr5, r5, 4
	fld	fr6, r5, 8
	st	r8, r3, 24
	fst	fr3, r3, 4
	fst	fr2, r3, 8
	fst	fr1, r3, 0
	st	r5, r3, 12
	fst	fr4, r3, 28
	fst	fr6, r3, 32
	fst	fr5, r3, 36
	st	r2, r3, 16
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_fsqr
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 16
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 36
	fst	fr1, r3, 40
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_fsqr
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 16
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 40
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 32
	fst	fr1, r3, 44
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fsqr
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 16
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 44
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.31584
	b	beq_cont.31585
beq_else.31584:
	fld	fr2, r3, 32
	fld	fr3, r3, 36
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 28
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.31585:
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31586
	li	r5, 1
	b	beq_cont.31587
beq_else.31586:
	li	r5, 0
beq_cont.31587:
	cmpwi	cr0, r5, 0
	bne	beq_else.31588
	ld	r5, r3, 12
	fld	fr2, r5, 0
	fld	fr3, r5, 4
	fld	fr4, r5, 8
	fld	fr5, r3, 0
	fmul	fr6, fr2, fr5
	ld	r5, r2, 16
	fld	fr7, r5, 0
	fmul	fr6, fr6, fr7
	fld	fr7, r3, 8
	fmul	fr8, fr3, fr7
	ld	r5, r2, 16
	fld	fr9, r5, 4
	fmul	fr8, fr8, fr9
	fadd	fr6, fr6, fr8
	fld	fr8, r3, 4
	fmul	fr9, fr4, fr8
	ld	r5, r2, 16
	fld	fr10, r5, 8
	fmul	fr9, fr9, fr10
	fadd	fr6, fr6, fr9
	ld	r5, r2, 12
	fst	fr1, r3, 48
	cmpwi	cr0, r5, 0
	bne	beq_else.31589
	fmr	fr1, fr6
	b	beq_cont.31590
beq_else.31589:
	fmul	fr9, fr4, fr7
	fmul	fr10, fr3, fr8
	fadd	fr9, fr9, fr10
	ld	r5, r2, 36
	fld	fr10, r5, 0
	fmul	fr9, fr9, fr10
	fmul	fr10, fr2, fr8
	fmul	fr4, fr4, fr5
	fadd	fr4, fr10, fr4
	ld	r5, r2, 36
	fld	fr10, r5, 4
	fmul	fr4, fr4, fr10
	fadd	fr4, fr9, fr4
	fmul	fr2, fr2, fr7
	fmul	fr3, fr3, fr5
	fadd	fr2, fr2, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr2, fr4, fr2
	fst	fr6, r3, 52
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fhalf
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r3, 52
	fadd	fr1, fr2, fr1
beq_cont.31590:
	fld	fr2, r3, 0
	fst	fr1, r3, 56
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fsqr
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 16
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 8
	fst	fr1, r3, 60
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_fsqr
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 16
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 60
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 4
	fst	fr1, r3, 64
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_fsqr
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 16
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 64
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.31591
	b	beq_cont.31592
beq_else.31591:
	fld	fr2, r3, 4
	fld	fr3, r3, 8
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 0
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.31592:
	ld	r5, r2, 4
	cmpwi	cr0, r5, 3
	bne	beq_else.31593
	fld	fr2, r0, 16
	fsub	fr1, fr1, fr2
	b	beq_cont.31594
beq_else.31593:
beq_cont.31594:
	fld	fr2, r3, 56
	fst	fr1, r3, 68
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_fsqr
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 68
	fld	fr3, r3, 48
	fmul	fr2, fr3, fr2
	fsub	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.31595
	beq	le.31595
	li	r2, 1
	b	gt_cont.31596
le.31595:
	li	r2, 0
gt_cont.31596:
	cmpwi	cr0, r2, 0
	bne	beq_else.31597
	li	r2, 0
	blr
beq_else.31597:
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_sqrt
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 16
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.31598
	fsub	fr1, fr0, fr1
	b	beq_cont.31599
beq_else.31598:
beq_cont.31599:
	fld	fr2, r3, 56
	fsub	fr1, fr1, fr2
	fld	fr2, r3, 48
	fdiv	fr1, fr1, fr2
	ld	r2, r3, 24
	fst	fr1, r2, 0
	li	r2, 1
	blr
beq_else.31588:
	li	r2, 0
	blr
solver_rect_fast.2939:
	ld	r7, r30, 4
	fld	fr4, r6, 0
	fsub	fr4, fr4, fr1
	fld	fr5, r6, 4
	fmul	fr4, fr4, fr5
	fld	fr5, r5, 4
	fmul	fr5, fr4, fr5
	fadd	fr5, fr5, fr2
	st	r7, r3, 0
	fst	fr1, r3, 4
	st	r6, r3, 8
	fst	fr3, r3, 12
	fst	fr2, r3, 16
	fst	fr4, r3, 20
	st	r5, r3, 24
	st	r2, r3, 28
	mflr	r31
	fmr	fr1, fr5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fabs
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	ld	r5, r2, 16
	fld	fr1, r5, 4
	ld	r5, r3, 24
	fld	fr2, r5, 4
	fld	fr3, r3, 20
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 16
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
	blt	le.31600
	beq	le.31600
	li	r2, 1
	b	gt_cont.31601
le.31600:
	li	r2, 0
gt_cont.31601:
	cmpwi	cr0, r2, 0
	bne	beq_else.31602
	li	r2, 0
	b	beq_cont.31603
beq_else.31602:
	ld	r2, r3, 24
	fld	fr1, r2, 8
	fld	fr2, r3, 20
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 12
	fadd	fr1, fr1, fr3
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fabs
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	ld	r5, r2, 16
	fld	fr1, r5, 8
	ld	r5, r3, 24
	fld	fr2, r5, 8
	fld	fr3, r3, 20
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
	blt	le.31604
	beq	le.31604
	li	r2, 1
	b	gt_cont.31605
le.31604:
	li	r2, 0
gt_cont.31605:
	cmpwi	cr0, r2, 0
	bne	beq_else.31606
	li	r2, 0
	b	beq_cont.31607
beq_else.31606:
	ld	r2, r3, 8
	fld	fr1, r2, 4
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31608
	li	r5, 1
	b	beq_cont.31609
beq_else.31608:
	li	r5, 0
beq_cont.31609:
	cmpwi	cr0, r5, 0
	bne	beq_else.31610
	li	r2, 1
	b	beq_cont.31611
beq_else.31610:
	li	r2, 0
beq_cont.31611:
beq_cont.31607:
beq_cont.31603:
	cmpwi	cr0, r2, 0
	bne	beq_else.31612
	ld	r2, r3, 8
	fld	fr1, r2, 8
	fld	fr2, r3, 16
	fsub	fr1, fr1, fr2
	fld	fr3, r2, 12
	fmul	fr1, fr1, fr3
	ld	r5, r3, 24
	fld	fr3, r5, 0
	fmul	fr3, fr1, fr3
	fld	fr4, r3, 4
	fadd	fr3, fr3, fr4
	fst	fr1, r3, 40
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_fabs
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 28
	ld	r5, r2, 16
	fld	fr1, r5, 0
	ld	r5, r3, 24
	fld	fr2, r5, 0
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
	blt	le.31613
	beq	le.31613
	li	r2, 1
	b	gt_cont.31614
le.31613:
	li	r2, 0
gt_cont.31614:
	cmpwi	cr0, r2, 0
	bne	beq_else.31615
	li	r2, 0
	b	beq_cont.31616
beq_else.31615:
	ld	r2, r3, 24
	fld	fr1, r2, 8
	fld	fr2, r3, 40
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 12
	fadd	fr1, fr1, fr3
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fabs
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 28
	ld	r5, r2, 16
	fld	fr1, r5, 8
	ld	r5, r3, 24
	fld	fr2, r5, 8
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
	blt	le.31617
	beq	le.31617
	li	r2, 1
	b	gt_cont.31618
le.31617:
	li	r2, 0
gt_cont.31618:
	cmpwi	cr0, r2, 0
	bne	beq_else.31619
	li	r2, 0
	b	beq_cont.31620
beq_else.31619:
	ld	r2, r3, 8
	fld	fr1, r2, 12
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31621
	li	r5, 1
	b	beq_cont.31622
beq_else.31621:
	li	r5, 0
beq_cont.31622:
	cmpwi	cr0, r5, 0
	bne	beq_else.31623
	li	r2, 1
	b	beq_cont.31624
beq_else.31623:
	li	r2, 0
beq_cont.31624:
beq_cont.31620:
beq_cont.31616:
	cmpwi	cr0, r2, 0
	bne	beq_else.31625
	ld	r2, r3, 8
	fld	fr1, r2, 16
	fld	fr2, r3, 12
	fsub	fr1, fr1, fr2
	fld	fr2, r2, 20
	fmul	fr1, fr1, fr2
	ld	r5, r3, 24
	fld	fr2, r5, 0
	fmul	fr2, fr1, fr2
	fld	fr3, r3, 4
	fadd	fr2, fr2, fr3
	fst	fr1, r3, 52
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fabs
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 28
	ld	r5, r2, 16
	fld	fr1, r5, 0
	ld	r5, r3, 24
	fld	fr2, r5, 0
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
	blt	le.31626
	beq	le.31626
	li	r2, 1
	b	gt_cont.31627
le.31626:
	li	r2, 0
gt_cont.31627:
	cmpwi	cr0, r2, 0
	bne	beq_else.31628
	li	r2, 0
	b	beq_cont.31629
beq_else.31628:
	ld	r2, r3, 24
	fld	fr1, r2, 4
	fld	fr2, r3, 52
	fmul	fr1, fr2, fr1
	fld	fr3, r3, 16
	fadd	fr1, fr1, fr3
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fabs
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 28
	ld	r2, r2, 16
	fld	fr1, r2, 4
	ld	r2, r3, 24
	fld	fr2, r2, 4
	fld	fr3, r3, 52
	fmul	fr2, fr3, fr2
	fld	fr4, r3, 16
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
	blt	le.31630
	beq	le.31630
	li	r2, 1
	b	gt_cont.31631
le.31630:
	li	r2, 0
gt_cont.31631:
	cmpwi	cr0, r2, 0
	bne	beq_else.31632
	li	r2, 0
	b	beq_cont.31633
beq_else.31632:
	ld	r2, r3, 8
	fld	fr1, r2, 20
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31634
	li	r2, 1
	b	beq_cont.31635
beq_else.31634:
	li	r2, 0
beq_cont.31635:
	cmpwi	cr0, r2, 0
	bne	beq_else.31636
	li	r2, 1
	b	beq_cont.31637
beq_else.31636:
	li	r2, 0
beq_cont.31637:
beq_cont.31633:
beq_cont.31629:
	cmpwi	cr0, r2, 0
	bne	beq_else.31638
	li	r2, 0
	blr
beq_else.31638:
	ld	r2, r3, 0
	fld	fr1, r3, 52
	fst	fr1, r2, 0
	li	r2, 3
	blr
beq_else.31625:
	ld	r2, r3, 0
	fld	fr1, r3, 40
	fst	fr1, r2, 0
	li	r2, 2
	blr
beq_else.31612:
	ld	r2, r3, 0
	fld	fr1, r3, 20
	fst	fr1, r2, 0
	li	r2, 1
	blr
solver_second_fast.2952:
	ld	r6, r30, 4
	fld	fr4, r5, 0
	fld	fr5, r0, 44
	fcmp	cr0, fr4, fr5
	bne	beq_else.31639
	li	r7, 1
	b	beq_cont.31640
beq_else.31639:
	li	r7, 0
beq_cont.31640:
	cmpwi	cr0, r7, 0
	bne	beq_else.31641
	fld	fr5, r5, 4
	fmul	fr5, fr5, fr1
	fld	fr6, r5, 8
	fmul	fr6, fr6, fr2
	fadd	fr5, fr5, fr6
	fld	fr6, r5, 12
	fmul	fr6, fr6, fr3
	fadd	fr5, fr5, fr6
	st	r6, r3, 0
	st	r5, r3, 4
	fst	fr4, r3, 8
	fst	fr5, r3, 12
	fst	fr1, r3, 16
	fst	fr3, r3, 20
	fst	fr2, r3, 24
	st	r2, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fsqr
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 24
	fst	fr1, r3, 32
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fsqr
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 32
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 20
	fst	fr1, r3, 36
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_fsqr
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 28
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 36
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.31642
	b	beq_cont.31643
beq_else.31642:
	fld	fr2, r3, 20
	fld	fr3, r3, 24
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 16
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.31643:
	ld	r5, r2, 4
	cmpwi	cr0, r5, 3
	bne	beq_else.31644
	fld	fr2, r0, 16
	fsub	fr1, fr1, fr2
	b	beq_cont.31645
beq_else.31644:
beq_cont.31645:
	fld	fr2, r3, 12
	fst	fr1, r3, 40
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_fsqr
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 40
	fld	fr3, r3, 8
	fmul	fr2, fr3, fr2
	fsub	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.31646
	beq	le.31646
	li	r2, 1
	b	gt_cont.31647
le.31646:
	li	r2, 0
gt_cont.31647:
	cmpwi	cr0, r2, 0
	bne	beq_else.31648
	li	r2, 0
	blr
beq_else.31648:
	ld	r2, r3, 28
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.31649
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_sqrt
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 12
	fsub	fr1, fr2, fr1
	ld	r2, r3, 4
	fld	fr2, r2, 16
	fmul	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 0
	b	beq_cont.31650
beq_else.31649:
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_sqrt
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 12
	fadd	fr1, fr2, fr1
	ld	r2, r3, 4
	fld	fr2, r2, 16
	fmul	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 0
beq_cont.31650:
	li	r2, 1
	blr
beq_else.31641:
	li	r2, 0
	blr
solver_fast.2958:
	ld	r7, r30, 12
	ld	r8, r30, 8
	ld	r9, r30, 4
	slwi	r10, r2, 2
	add	r31, r9, r10
	ld	r9, r31, 0
	fld	fr1, r6, 0
	ld	r10, r9, 20
	fld	fr2, r10, 0
	fsub	fr1, fr1, fr2
	fld	fr2, r6, 4
	ld	r10, r9, 20
	fld	fr3, r10, 4
	fsub	fr2, fr2, fr3
	fld	fr3, r6, 8
	ld	r6, r9, 20
	fld	fr4, r6, 8
	fsub	fr3, fr3, fr4
	ld	r6, r5, 4
	slwi	r2, r2, 2
	add	r31, r6, r2
	ld	r6, r31, 0
	ld	r2, r9, 4
	cmpwi	cr0, r2, 1
	bne	beq_else.31651
	ld	r5, r5, 0
	mr	r2, r9
	mr	r30, r7
	ld	r29, r30, 0
	ba	r29
beq_else.31651:
	cmpwi	cr0, r2, 2
	bne	beq_else.31652
	fld	fr4, r6, 0
	fld	fr5, r0, 44
	fcmp	cr0, fr5, fr4
	blt	le.31653
	beq	le.31653
	li	r2, 1
	b	gt_cont.31654
le.31653:
	li	r2, 0
gt_cont.31654:
	cmpwi	cr0, r2, 0
	bne	beq_else.31655
	li	r2, 0
	blr
beq_else.31655:
	fld	fr4, r6, 4
	fmul	fr1, fr4, fr1
	fld	fr4, r6, 8
	fmul	fr2, fr4, fr2
	fadd	fr1, fr1, fr2
	fld	fr2, r6, 12
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r8, 0
	li	r2, 1
	blr
beq_else.31652:
	fld	fr4, r6, 0
	fld	fr5, r0, 44
	fcmp	cr0, fr4, fr5
	bne	beq_else.31656
	li	r2, 1
	b	beq_cont.31657
beq_else.31656:
	li	r2, 0
beq_cont.31657:
	cmpwi	cr0, r2, 0
	bne	beq_else.31658
	fld	fr5, r6, 4
	fmul	fr5, fr5, fr1
	fld	fr6, r6, 8
	fmul	fr6, fr6, fr2
	fadd	fr5, fr5, fr6
	fld	fr6, r6, 12
	fmul	fr6, fr6, fr3
	fadd	fr5, fr5, fr6
	st	r8, r3, 0
	st	r6, r3, 4
	fst	fr4, r3, 8
	fst	fr5, r3, 12
	fst	fr1, r3, 16
	fst	fr3, r3, 20
	fst	fr2, r3, 24
	st	r9, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fsqr
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 24
	fst	fr1, r3, 32
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fsqr
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 32
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 20
	fst	fr1, r3, 36
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_fsqr
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 28
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 36
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.31659
	b	beq_cont.31660
beq_else.31659:
	fld	fr2, r3, 20
	fld	fr3, r3, 24
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 16
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.31660:
	ld	r5, r2, 4
	cmpwi	cr0, r5, 3
	bne	beq_else.31661
	fld	fr2, r0, 16
	fsub	fr1, fr1, fr2
	b	beq_cont.31662
beq_else.31661:
beq_cont.31662:
	fld	fr2, r3, 12
	fst	fr1, r3, 40
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_fsqr
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 40
	fld	fr3, r3, 8
	fmul	fr2, fr3, fr2
	fsub	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.31663
	beq	le.31663
	li	r2, 1
	b	gt_cont.31664
le.31663:
	li	r2, 0
gt_cont.31664:
	cmpwi	cr0, r2, 0
	bne	beq_else.31665
	li	r2, 0
	blr
beq_else.31665:
	ld	r2, r3, 28
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.31666
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_sqrt
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 12
	fsub	fr1, fr2, fr1
	ld	r2, r3, 4
	fld	fr2, r2, 16
	fmul	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 0
	b	beq_cont.31667
beq_else.31666:
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_sqrt
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 12
	fadd	fr1, fr2, fr1
	ld	r2, r3, 4
	fld	fr2, r2, 16
	fmul	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 0
beq_cont.31667:
	li	r2, 1
	blr
beq_else.31658:
	li	r2, 0
	blr
solver_fast2.2976:
	ld	r6, r30, 12
	ld	r7, r30, 8
	ld	r8, r30, 4
	slwi	r9, r2, 2
	add	r31, r8, r9
	ld	r8, r31, 0
	ld	r9, r8, 40
	fld	fr1, r9, 0
	fld	fr2, r9, 4
	fld	fr3, r9, 8
	ld	r10, r5, 4
	slwi	r2, r2, 2
	add	r31, r10, r2
	ld	r2, r31, 0
	ld	r10, r8, 4
	cmpwi	cr0, r10, 1
	bne	beq_else.31668
	ld	r5, r5, 0
	mr	r30, r6
	mr	r6, r2
	mr	r2, r8
	ld	r29, r30, 0
	ba	r29
beq_else.31668:
	cmpwi	cr0, r10, 2
	bne	beq_else.31669
	fld	fr1, r2, 0
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.31670
	beq	le.31670
	li	r5, 1
	b	gt_cont.31671
le.31670:
	li	r5, 0
gt_cont.31671:
	cmpwi	cr0, r5, 0
	bne	beq_else.31672
	li	r2, 0
	blr
beq_else.31672:
	fld	fr1, r2, 0
	fld	fr2, r9, 12
	fmul	fr1, fr1, fr2
	fst	fr1, r7, 0
	li	r2, 1
	blr
beq_else.31669:
	fld	fr4, r2, 0
	fld	fr5, r0, 44
	fcmp	cr0, fr4, fr5
	bne	beq_else.31673
	li	r5, 1
	b	beq_cont.31674
beq_else.31673:
	li	r5, 0
beq_cont.31674:
	cmpwi	cr0, r5, 0
	bne	beq_else.31675
	fld	fr5, r2, 4
	fmul	fr1, fr5, fr1
	fld	fr5, r2, 8
	fmul	fr2, fr5, fr2
	fadd	fr1, fr1, fr2
	fld	fr2, r2, 12
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r9, 12
	st	r7, r3, 0
	st	r2, r3, 4
	fst	fr1, r3, 8
	st	r8, r3, 12
	fst	fr2, r3, 16
	fst	fr4, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_fsqr
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 16
	fld	fr3, r3, 20
	fmul	fr2, fr3, fr2
	fsub	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.31676
	beq	le.31676
	li	r2, 1
	b	gt_cont.31677
le.31676:
	li	r2, 0
gt_cont.31677:
	cmpwi	cr0, r2, 0
	bne	beq_else.31678
	li	r2, 0
	blr
beq_else.31678:
	ld	r2, r3, 12
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.31679
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_sqrt
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 8
	fsub	fr1, fr2, fr1
	ld	r2, r3, 4
	fld	fr2, r2, 16
	fmul	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 0
	b	beq_cont.31680
beq_else.31679:
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_sqrt
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 8
	fadd	fr1, fr2, fr1
	ld	r2, r3, 4
	fld	fr2, r2, 16
	fmul	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 0
beq_cont.31680:
	li	r2, 1
	blr
beq_else.31675:
	li	r2, 0
	blr
setup_rect_table.2979:
	li	r6, 6
	fld	fr1, r0, 44
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
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31681
	li	r6, 1
	b	beq_cont.31682
beq_else.31681:
	li	r6, 0
beq_cont.31682:
	cmpwi	cr0, r6, 0
	bne	beq_else.31683
	ld	r6, r3, 0
	ld	r7, r6, 24
	fld	fr1, r5, 0
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.31685
	beq	le.31685
	li	r8, 1
	b	gt_cont.31686
le.31685:
	li	r8, 0
gt_cont.31686:
	cmpwi	cr0, r7, 0
	bne	beq_else.31687
	mr	r7, r8
	b	beq_cont.31688
beq_else.31687:
	cmpwi	cr0, r8, 0
	bne	beq_else.31689
	li	r7, 1
	b	beq_cont.31690
beq_else.31689:
	li	r7, 0
beq_cont.31690:
beq_cont.31688:
	ld	r8, r6, 16
	fld	fr1, r8, 0
	cmpwi	cr0, r7, 0
	bne	beq_else.31691
	fsub	fr1, fr0, fr1
	b	beq_cont.31692
beq_else.31691:
beq_cont.31692:
	fst	fr1, r2, 0
	fld	fr1, r0, 16
	fld	fr2, r5, 0
	fdiv	fr1, fr1, fr2
	fst	fr1, r2, 4
	b	beq_cont.31684
beq_else.31683:
	fld	fr1, r0, 44
	fst	fr1, r2, 4
beq_cont.31684:
	fld	fr1, r5, 4
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31693
	li	r6, 1
	b	beq_cont.31694
beq_else.31693:
	li	r6, 0
beq_cont.31694:
	cmpwi	cr0, r6, 0
	bne	beq_else.31695
	ld	r6, r3, 0
	ld	r7, r6, 24
	fld	fr1, r5, 4
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.31697
	beq	le.31697
	li	r8, 1
	b	gt_cont.31698
le.31697:
	li	r8, 0
gt_cont.31698:
	cmpwi	cr0, r7, 0
	bne	beq_else.31699
	mr	r7, r8
	b	beq_cont.31700
beq_else.31699:
	cmpwi	cr0, r8, 0
	bne	beq_else.31701
	li	r7, 1
	b	beq_cont.31702
beq_else.31701:
	li	r7, 0
beq_cont.31702:
beq_cont.31700:
	ld	r8, r6, 16
	fld	fr1, r8, 4
	cmpwi	cr0, r7, 0
	bne	beq_else.31703
	fsub	fr1, fr0, fr1
	b	beq_cont.31704
beq_else.31703:
beq_cont.31704:
	fst	fr1, r2, 8
	fld	fr1, r0, 16
	fld	fr2, r5, 4
	fdiv	fr1, fr1, fr2
	fst	fr1, r2, 12
	b	beq_cont.31696
beq_else.31695:
	fld	fr1, r0, 44
	fst	fr1, r2, 12
beq_cont.31696:
	fld	fr1, r5, 8
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.31705
	li	r6, 1
	b	beq_cont.31706
beq_else.31705:
	li	r6, 0
beq_cont.31706:
	cmpwi	cr0, r6, 0
	bne	beq_else.31707
	ld	r6, r3, 0
	ld	r7, r6, 24
	fld	fr1, r5, 8
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.31709
	beq	le.31709
	li	r8, 1
	b	gt_cont.31710
le.31709:
	li	r8, 0
gt_cont.31710:
	cmpwi	cr0, r7, 0
	bne	beq_else.31711
	mr	r7, r8
	b	beq_cont.31712
beq_else.31711:
	cmpwi	cr0, r8, 0
	bne	beq_else.31713
	li	r7, 1
	b	beq_cont.31714
beq_else.31713:
	li	r7, 0
beq_cont.31714:
beq_cont.31712:
	ld	r6, r6, 16
	fld	fr1, r6, 8
	cmpwi	cr0, r7, 0
	bne	beq_else.31715
	fsub	fr1, fr0, fr1
	b	beq_cont.31716
beq_else.31715:
beq_cont.31716:
	fst	fr1, r2, 16
	fld	fr1, r0, 16
	fld	fr2, r5, 8
	fdiv	fr1, fr1, fr2
	fst	fr1, r2, 20
	b	beq_cont.31708
beq_else.31707:
	fld	fr1, r0, 44
	fst	fr1, r2, 20
beq_cont.31708:
	blr
setup_surface_table.2982:
	li	r6, 4
	fld	fr1, r0, 44
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
	ld	r7, r6, 16
	fld	fr2, r7, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r5, 4
	ld	r7, r6, 16
	fld	fr3, r7, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r5, 8
	ld	r5, r6, 16
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.31717
	beq	le.31717
	li	r5, 1
	b	gt_cont.31718
le.31717:
	li	r5, 0
gt_cont.31718:
	cmpwi	cr0, r5, 0
	bne	beq_else.31719
	fld	fr1, r0, 44
	fst	fr1, r2, 0
	b	beq_cont.31720
beq_else.31719:
	fld	fr2, r0, 96
	fdiv	fr2, fr2, fr1
	fst	fr2, r2, 0
	ld	r5, r6, 16
	fld	fr2, r5, 0
	fdiv	fr2, fr2, fr1
	fsub	fr2, fr0, fr2
	fst	fr2, r2, 4
	ld	r5, r6, 16
	fld	fr2, r5, 4
	fdiv	fr2, fr2, fr1
	fsub	fr2, fr0, fr2
	fst	fr2, r2, 8
	ld	r5, r6, 16
	fld	fr2, r5, 8
	fdiv	fr1, fr2, fr1
	fsub	fr1, fr0, fr1
	fst	fr1, r2, 12
beq_cont.31720:
	blr
setup_second_table.2985:
	li	r6, 5
	fld	fr1, r0, 44
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
	st	r2, r3, 8
	fst	fr1, r3, 12
	fst	fr3, r3, 16
	fst	fr2, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_fsqr
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 0
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 20
	fst	fr1, r3, 24
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_fsqr
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 0
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 24
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 16
	fst	fr1, r3, 28
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fsqr
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 0
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 28
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.31721
	b	beq_cont.31722
beq_else.31721:
	fld	fr2, r3, 16
	fld	fr3, r3, 20
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 12
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.31722:
	ld	r5, r3, 4
	fld	fr2, r5, 0
	ld	r6, r2, 16
	fld	fr3, r6, 0
	fmul	fr2, fr2, fr3
	fsub	fr2, fr0, fr2
	fld	fr3, r5, 4
	ld	r6, r2, 16
	fld	fr4, r6, 4
	fmul	fr3, fr3, fr4
	fsub	fr3, fr0, fr3
	fld	fr4, r5, 8
	ld	r6, r2, 16
	fld	fr5, r6, 8
	fmul	fr4, fr4, fr5
	fsub	fr4, fr0, fr4
	ld	r6, r3, 8
	fst	fr1, r6, 0
	ld	r7, r2, 12
	fst	fr1, r3, 32
	cmpwi	cr0, r7, 0
	bne	beq_else.31723
	fst	fr2, r6, 4
	fst	fr3, r6, 8
	fst	fr4, r6, 12
	b	beq_cont.31724
beq_else.31723:
	fld	fr5, r5, 8
	ld	r7, r2, 36
	fld	fr6, r7, 4
	fmul	fr5, fr5, fr6
	fld	fr6, r5, 4
	ld	r7, r2, 36
	fld	fr7, r7, 8
	fmul	fr6, fr6, fr7
	fadd	fr5, fr5, fr6
	fst	fr4, r3, 36
	fst	fr3, r3, 40
	fst	fr2, r3, 44
	mflr	r31
	fmr	fr1, fr5
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fhalf
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 44
	fsub	fr1, fr2, fr1
	ld	r2, r3, 8
	fst	fr1, r2, 4
	ld	r5, r3, 4
	fld	fr1, r5, 8
	ld	r6, r3, 0
	ld	r7, r6, 36
	fld	fr2, r7, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r5, 0
	ld	r7, r6, 36
	fld	fr3, r7, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fhalf
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 40
	fsub	fr1, fr2, fr1
	ld	r2, r3, 8
	fst	fr1, r2, 8
	ld	r5, r3, 4
	fld	fr1, r5, 4
	ld	r6, r3, 0
	ld	r7, r6, 36
	fld	fr2, r7, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r5, 0
	ld	r5, r6, 36
	fld	fr3, r5, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fhalf
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 36
	fsub	fr1, fr2, fr1
	ld	r2, r3, 8
	fst	fr1, r2, 12
beq_cont.31724:
	fld	fr1, r0, 44
	fld	fr2, r3, 32
	fcmp	cr0, fr2, fr1
	bne	beq_else.31725
	li	r2, 1
	b	beq_cont.31726
beq_else.31725:
	li	r2, 0
beq_cont.31726:
	cmpwi	cr0, r2, 0
	bne	beq_else.31727
	fld	fr1, r0, 16
	fdiv	fr1, fr1, fr2
	ld	r2, r3, 8
	fst	fr1, r2, 16
	b	beq_cont.31728
beq_else.31727:
beq_cont.31728:
	ld	r2, r3, 8
	blr
iter_setup_dirvec_constants.2988:
	ld	r6, r30, 4
	cmpwi	cr0, r5, 0
	blt	bge_else.31729
	slwi	r7, r5, 2
	add	r31, r6, r7
	ld	r7, r31, 0
	ld	r8, r2, 4
	ld	r9, r2, 0
	ld	r10, r7, 4
	st	r30, r3, 0
	st	r2, r3, 4
	st	r6, r3, 8
	cmpwi	cr0, r10, 1
	bne	beq_else.31730
	st	r8, r3, 12
	st	r5, r3, 16
	mflr	r31
	mr	r5, r7
	mr	r2, r9
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	setup_rect_table.2979
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 16
	slwi	r6, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.31731
beq_else.31730:
	cmpwi	cr0, r10, 2
	bne	beq_else.31732
	li	r10, 4
	fld	fr1, r0, 44
	st	r8, r3, 12
	st	r5, r3, 16
	st	r7, r3, 20
	st	r9, r3, 24
	mflr	r31
	mr	r2, r10
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 24
	fld	fr1, r5, 0
	ld	r6, r3, 20
	ld	r7, r6, 16
	fld	fr2, r7, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r5, 4
	ld	r7, r6, 16
	fld	fr3, r7, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r5, 8
	ld	r5, r6, 16
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.31734
	beq	le.31734
	li	r5, 1
	b	gt_cont.31735
le.31734:
	li	r5, 0
gt_cont.31735:
	cmpwi	cr0, r5, 0
	bne	beq_else.31736
	fld	fr1, r0, 44
	fst	fr1, r2, 0
	b	beq_cont.31737
beq_else.31736:
	fld	fr2, r0, 96
	fdiv	fr2, fr2, fr1
	fst	fr2, r2, 0
	ld	r5, r6, 16
	fld	fr2, r5, 0
	fdiv	fr2, fr2, fr1
	fsub	fr2, fr0, fr2
	fst	fr2, r2, 4
	ld	r5, r6, 16
	fld	fr2, r5, 4
	fdiv	fr2, fr2, fr1
	fsub	fr2, fr0, fr2
	fst	fr2, r2, 8
	ld	r5, r6, 16
	fld	fr2, r5, 8
	fdiv	fr1, fr2, fr1
	fsub	fr1, fr0, fr1
	fst	fr1, r2, 12
beq_cont.31737:
	ld	r5, r3, 16
	slwi	r6, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.31733
beq_else.31732:
	st	r8, r3, 12
	st	r5, r3, 16
	mflr	r31
	mr	r5, r7
	mr	r2, r9
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	setup_second_table.2985
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 16
	slwi	r6, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r6
	st	r2, r31, 0
beq_cont.31733:
beq_cont.31731:
	addi	r2, r5, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.31738
	slwi	r5, r2, 2
	ld	r6, r3, 8
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r6, r3, 4
	ld	r7, r6, 4
	ld	r8, r6, 0
	ld	r9, r5, 4
	cmpwi	cr0, r9, 1
	bne	beq_else.31739
	st	r7, r3, 28
	st	r2, r3, 32
	mflr	r31
	mr	r2, r8
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	setup_rect_table.2979
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 32
	slwi	r6, r5, 2
	ld	r7, r3, 28
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.31740
beq_else.31739:
	cmpwi	cr0, r9, 2
	bne	beq_else.31741
	st	r7, r3, 28
	st	r2, r3, 32
	mflr	r31
	mr	r2, r8
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	setup_surface_table.2982
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 32
	slwi	r6, r5, 2
	ld	r7, r3, 28
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.31742
beq_else.31741:
	st	r7, r3, 28
	st	r2, r3, 32
	mflr	r31
	mr	r2, r8
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	setup_second_table.2985
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 32
	slwi	r6, r5, 2
	ld	r7, r3, 28
	add	r31, r7, r6
	st	r2, r31, 0
beq_cont.31742:
beq_cont.31740:
	addi	r5, r5, -1
	ld	r2, r3, 4
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
bge_else.31738:
	blr
bge_else.31729:
	blr
setup_startp_constants.2993:
	ld	r6, r30, 4
	cmpwi	cr0, r5, 0
	blt	bge_else.31745
	slwi	r7, r5, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	ld	r7, r6, 40
	ld	r8, r6, 4
	fld	fr1, r2, 0
	ld	r9, r6, 20
	fld	fr2, r9, 0
	fsub	fr1, fr1, fr2
	fst	fr1, r7, 0
	fld	fr1, r2, 4
	ld	r9, r6, 20
	fld	fr2, r9, 4
	fsub	fr1, fr1, fr2
	fst	fr1, r7, 4
	fld	fr1, r2, 8
	ld	r9, r6, 20
	fld	fr2, r9, 8
	fsub	fr1, fr1, fr2
	fst	fr1, r7, 8
	st	r2, r3, 0
	st	r30, r3, 4
	st	r5, r3, 8
	cmpwi	cr0, r8, 2
	bne	beq_else.31746
	ld	r6, r6, 16
	fld	fr1, r7, 0
	fld	fr2, r7, 4
	fld	fr3, r7, 8
	fld	fr4, r6, 0
	fmul	fr1, fr4, fr1
	fld	fr4, r6, 4
	fmul	fr2, fr4, fr2
	fadd	fr1, fr1, fr2
	fld	fr2, r6, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r7, 12
	b	beq_cont.31747
beq_else.31746:
	cmpwi	cr0, r8, 2
	blt	le.31748
	beq	le.31748
	fld	fr1, r7, 0
	fld	fr2, r7, 4
	fld	fr3, r7, 8
	st	r7, r3, 12
	st	r8, r3, 16
	fst	fr1, r3, 20
	fst	fr3, r3, 24
	fst	fr2, r3, 28
	st	r6, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fsqr
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 32
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
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
	ld	r2, r3, 32
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 36
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 24
	fst	fr1, r3, 40
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_fsqr
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 32
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 40
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.31750
	b	beq_cont.31751
beq_else.31750:
	fld	fr2, r3, 24
	fld	fr3, r3, 28
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 20
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r2, r2, 36
	fld	fr3, r2, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.31751:
	ld	r2, r3, 16
	cmpwi	cr0, r2, 3
	bne	beq_else.31752
	fld	fr2, r0, 16
	fsub	fr1, fr1, fr2
	b	beq_cont.31753
beq_else.31752:
beq_cont.31753:
	ld	r2, r3, 12
	fst	fr1, r2, 12
	b	gt_cont.31749
le.31748:
gt_cont.31749:
beq_cont.31747:
	ld	r2, r3, 8
	addi	r5, r2, -1
	ld	r2, r3, 0
	ld	r30, r3, 4
	ld	r29, r30, 0
	ba	r29
bge_else.31745:
	blr
is_outside.3013:
	ld	r5, r2, 20
	fld	fr4, r5, 0
	fsub	fr1, fr1, fr4
	ld	r5, r2, 20
	fld	fr4, r5, 4
	fsub	fr2, fr2, fr4
	ld	r5, r2, 20
	fld	fr4, r5, 8
	fsub	fr3, fr3, fr4
	ld	r5, r2, 4
	cmpwi	cr0, r5, 1
	bne	beq_else.31755
	fst	fr3, r3, 0
	fst	fr2, r3, 4
	fst	fr1, r3, 8
	st	r2, r3, 12
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_fabs
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 12
	ld	r5, r2, 16
	fld	fr1, r5, 0
	fld	fr2, r3, 8
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
	blt	le.31756
	beq	le.31756
	li	r2, 1
	b	gt_cont.31757
le.31756:
	li	r2, 0
gt_cont.31757:
	cmpwi	cr0, r2, 0
	bne	beq_else.31758
	li	r2, 0
	b	beq_cont.31759
beq_else.31758:
	fld	fr1, r3, 4
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_fabs
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 12
	ld	r5, r2, 16
	fld	fr1, r5, 4
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
	blt	le.31760
	beq	le.31760
	li	r2, 1
	b	gt_cont.31761
le.31760:
	li	r2, 0
gt_cont.31761:
	cmpwi	cr0, r2, 0
	bne	beq_else.31762
	li	r2, 0
	b	beq_cont.31763
beq_else.31762:
	fld	fr1, r3, 0
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_fabs
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 12
	ld	r5, r2, 16
	fld	fr1, r5, 8
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
	blt	le.31764
	beq	le.31764
	li	r2, 1
	b	gt_cont.31765
le.31764:
	li	r2, 0
gt_cont.31765:
beq_cont.31763:
beq_cont.31759:
	cmpwi	cr0, r2, 0
	bne	beq_else.31766
	ld	r2, r3, 12
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.31767
	li	r2, 1
	blr
beq_else.31767:
	li	r2, 0
	blr
beq_else.31766:
	ld	r2, r3, 12
	ld	r2, r2, 24
	blr
beq_else.31755:
	cmpwi	cr0, r5, 2
	bne	beq_else.31768
	ld	r5, r2, 16
	fld	fr4, r5, 0
	fmul	fr1, fr4, fr1
	fld	fr4, r5, 4
	fmul	fr2, fr4, fr2
	fadd	fr1, fr1, fr2
	fld	fr2, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	ld	r2, r2, 24
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.31769
	beq	le.31769
	li	r5, 1
	b	gt_cont.31770
le.31769:
	li	r5, 0
gt_cont.31770:
	cmpwi	cr0, r2, 0
	bne	beq_else.31771
	mr	r2, r5
	b	beq_cont.31772
beq_else.31771:
	cmpwi	cr0, r5, 0
	bne	beq_else.31773
	li	r2, 1
	b	beq_cont.31774
beq_else.31773:
	li	r2, 0
beq_cont.31774:
beq_cont.31772:
	cmpwi	cr0, r2, 0
	bne	beq_else.31775
	li	r2, 1
	blr
beq_else.31775:
	li	r2, 0
	blr
beq_else.31768:
	fst	fr1, r3, 8
	fst	fr3, r3, 0
	fst	fr2, r3, 4
	st	r2, r3, 12
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_fsqr
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 12
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
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
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 28
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 0
	fst	fr1, r3, 32
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fsqr
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 12
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 32
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.31776
	b	beq_cont.31777
beq_else.31776:
	fld	fr2, r3, 0
	fld	fr3, r3, 4
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 8
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.31777:
	ld	r5, r2, 4
	cmpwi	cr0, r5, 3
	bne	beq_else.31778
	fld	fr2, r0, 16
	fsub	fr1, fr1, fr2
	b	beq_cont.31779
beq_else.31778:
beq_cont.31779:
	ld	r2, r2, 24
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.31780
	beq	le.31780
	li	r5, 1
	b	gt_cont.31781
le.31780:
	li	r5, 0
gt_cont.31781:
	cmpwi	cr0, r2, 0
	bne	beq_else.31782
	mr	r2, r5
	b	beq_cont.31783
beq_else.31782:
	cmpwi	cr0, r5, 0
	bne	beq_else.31784
	li	r2, 1
	b	beq_cont.31785
beq_else.31784:
	li	r2, 0
beq_cont.31785:
beq_cont.31783:
	cmpwi	cr0, r2, 0
	bne	beq_else.31786
	li	r2, 1
	blr
beq_else.31786:
	li	r2, 0
	blr
check_all_inside.3018:
	ld	r6, r30, 4
	slwi	r7, r2, 2
	add	r31, r5, r7
	ld	r7, r31, 0
	cmpwi	cr0, r7, -1
	bne	beq_else.31787
	li	r2, 1
	blr
beq_else.31787:
	slwi	r7, r7, 2
	add	r31, r6, r7
	ld	r7, r31, 0
	ld	r8, r7, 20
	fld	fr4, r8, 0
	fsub	fr4, fr1, fr4
	ld	r8, r7, 20
	fld	fr5, r8, 4
	fsub	fr5, fr2, fr5
	ld	r8, r7, 20
	fld	fr6, r8, 8
	fsub	fr6, fr3, fr6
	ld	r8, r7, 4
	st	r30, r3, 0
	fst	fr3, r3, 4
	fst	fr2, r3, 8
	fst	fr1, r3, 12
	st	r6, r3, 16
	st	r5, r3, 20
	st	r2, r3, 24
	cmpwi	cr0, r8, 1
	bne	beq_else.31788
	fst	fr6, r3, 28
	fst	fr5, r3, 32
	fst	fr4, r3, 36
	st	r7, r3, 40
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_fabs
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 16
	fld	fr1, r5, 0
	fld	fr2, r3, 36
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
	blt	le.31790
	beq	le.31790
	li	r2, 1
	b	gt_cont.31791
le.31790:
	li	r2, 0
gt_cont.31791:
	cmpwi	cr0, r2, 0
	bne	beq_else.31792
	li	r2, 0
	b	beq_cont.31793
beq_else.31792:
	fld	fr1, r3, 32
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fabs
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 16
	fld	fr1, r5, 4
	fld	fr2, r3, 32
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
	blt	le.31794
	beq	le.31794
	li	r2, 1
	b	gt_cont.31795
le.31794:
	li	r2, 0
gt_cont.31795:
	cmpwi	cr0, r2, 0
	bne	beq_else.31796
	li	r2, 0
	b	beq_cont.31797
beq_else.31796:
	fld	fr1, r3, 28
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_fabs
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 16
	fld	fr1, r5, 8
	fld	fr2, r3, 28
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
	blt	le.31798
	beq	le.31798
	li	r2, 1
	b	gt_cont.31799
le.31798:
	li	r2, 0
gt_cont.31799:
beq_cont.31797:
beq_cont.31793:
	cmpwi	cr0, r2, 0
	bne	beq_else.31800
	ld	r2, r3, 40
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.31802
	li	r2, 1
	b	beq_cont.31803
beq_else.31802:
	li	r2, 0
beq_cont.31803:
	b	beq_cont.31801
beq_else.31800:
	ld	r2, r3, 40
	ld	r2, r2, 24
beq_cont.31801:
	b	beq_cont.31789
beq_else.31788:
	cmpwi	cr0, r8, 2
	bne	beq_else.31804
	ld	r8, r7, 16
	fld	fr7, r8, 0
	fmul	fr4, fr7, fr4
	fld	fr7, r8, 4
	fmul	fr5, fr7, fr5
	fadd	fr4, fr4, fr5
	fld	fr5, r8, 8
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	ld	r7, r7, 24
	fld	fr5, r0, 44
	fcmp	cr0, fr5, fr4
	blt	le.31806
	beq	le.31806
	li	r8, 1
	b	gt_cont.31807
le.31806:
	li	r8, 0
gt_cont.31807:
	cmpwi	cr0, r7, 0
	bne	beq_else.31808
	mr	r7, r8
	b	beq_cont.31809
beq_else.31808:
	cmpwi	cr0, r8, 0
	bne	beq_else.31810
	li	r7, 1
	b	beq_cont.31811
beq_else.31810:
	li	r7, 0
beq_cont.31811:
beq_cont.31809:
	cmpwi	cr0, r7, 0
	bne	beq_else.31812
	li	r2, 1
	b	beq_cont.31813
beq_else.31812:
	li	r2, 0
beq_cont.31813:
	b	beq_cont.31805
beq_else.31804:
	fst	fr4, r3, 36
	fst	fr6, r3, 28
	fst	fr5, r3, 32
	st	r7, r3, 40
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fsqr
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 32
	fst	fr1, r3, 56
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fsqr
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 56
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 28
	fst	fr1, r3, 60
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_fsqr
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 60
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.31814
	b	beq_cont.31815
beq_else.31814:
	fld	fr2, r3, 28
	fld	fr3, r3, 32
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 36
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.31815:
	ld	r5, r2, 4
	cmpwi	cr0, r5, 3
	bne	beq_else.31816
	fld	fr2, r0, 16
	fsub	fr1, fr1, fr2
	b	beq_cont.31817
beq_else.31816:
beq_cont.31817:
	ld	r2, r2, 24
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.31818
	beq	le.31818
	li	r5, 1
	b	gt_cont.31819
le.31818:
	li	r5, 0
gt_cont.31819:
	cmpwi	cr0, r2, 0
	bne	beq_else.31820
	mr	r2, r5
	b	beq_cont.31821
beq_else.31820:
	cmpwi	cr0, r5, 0
	bne	beq_else.31822
	li	r2, 1
	b	beq_cont.31823
beq_else.31822:
	li	r2, 0
beq_cont.31823:
beq_cont.31821:
	cmpwi	cr0, r2, 0
	bne	beq_else.31824
	li	r2, 1
	b	beq_cont.31825
beq_else.31824:
	li	r2, 0
beq_cont.31825:
beq_cont.31805:
beq_cont.31789:
	cmpwi	cr0, r2, 0
	bne	beq_else.31826
	ld	r2, r3, 24
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 20
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.31827
	li	r2, 1
	blr
beq_else.31827:
	slwi	r5, r5, 2
	ld	r7, r3, 16
	add	r31, r7, r5
	ld	r5, r31, 0
	fld	fr1, r3, 12
	fld	fr2, r3, 8
	fld	fr3, r3, 4
	st	r2, r3, 64
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	is_outside.3013
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31828
	ld	r2, r3, 64
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 20
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.31829
	li	r2, 1
	blr
beq_else.31829:
	slwi	r5, r5, 2
	ld	r7, r3, 16
	add	r31, r7, r5
	ld	r5, r31, 0
	ld	r8, r5, 20
	fld	fr1, r8, 0
	fld	fr2, r3, 12
	fsub	fr1, fr2, fr1
	ld	r8, r5, 20
	fld	fr3, r8, 4
	fld	fr4, r3, 8
	fsub	fr3, fr4, fr3
	ld	r8, r5, 20
	fld	fr5, r8, 8
	fld	fr6, r3, 4
	fsub	fr5, fr6, fr5
	ld	r8, r5, 4
	st	r2, r3, 68
	cmpwi	cr0, r8, 1
	bne	beq_else.31830
	fst	fr5, r3, 72
	fst	fr3, r3, 76
	fst	fr1, r3, 80
	st	r5, r3, 84
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fabs
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r2, r3, 84
	ld	r5, r2, 16
	fld	fr1, r5, 0
	fld	fr2, r3, 80
	fst	fr1, r3, 88
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fabs
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	fld	fr2, r3, 88
	fcmp	cr0, fr2, fr1
	blt	le.31832
	beq	le.31832
	li	r2, 1
	b	gt_cont.31833
le.31832:
	li	r2, 0
gt_cont.31833:
	cmpwi	cr0, r2, 0
	bne	beq_else.31834
	li	r2, 0
	b	beq_cont.31835
beq_else.31834:
	fld	fr1, r3, 76
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fabs
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r2, r3, 84
	ld	r5, r2, 16
	fld	fr1, r5, 4
	fld	fr2, r3, 76
	fst	fr1, r3, 92
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fabs
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	fld	fr2, r3, 92
	fcmp	cr0, fr2, fr1
	blt	le.31836
	beq	le.31836
	li	r2, 1
	b	gt_cont.31837
le.31836:
	li	r2, 0
gt_cont.31837:
	cmpwi	cr0, r2, 0
	bne	beq_else.31838
	li	r2, 0
	b	beq_cont.31839
beq_else.31838:
	fld	fr1, r3, 72
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fabs
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r2, r3, 84
	ld	r5, r2, 16
	fld	fr1, r5, 8
	fld	fr2, r3, 72
	fst	fr1, r3, 96
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fabs
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	fld	fr2, r3, 96
	fcmp	cr0, fr2, fr1
	blt	le.31840
	beq	le.31840
	li	r2, 1
	b	gt_cont.31841
le.31840:
	li	r2, 0
gt_cont.31841:
beq_cont.31839:
beq_cont.31835:
	cmpwi	cr0, r2, 0
	bne	beq_else.31842
	ld	r2, r3, 84
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.31844
	li	r2, 1
	b	beq_cont.31845
beq_else.31844:
	li	r2, 0
beq_cont.31845:
	b	beq_cont.31843
beq_else.31842:
	ld	r2, r3, 84
	ld	r2, r2, 24
beq_cont.31843:
	b	beq_cont.31831
beq_else.31830:
	cmpwi	cr0, r8, 2
	bne	beq_else.31846
	ld	r8, r5, 16
	fld	fr7, r8, 0
	fmul	fr1, fr7, fr1
	fld	fr7, r8, 4
	fmul	fr3, fr7, fr3
	fadd	fr1, fr1, fr3
	fld	fr3, r8, 8
	fmul	fr3, fr3, fr5
	fadd	fr1, fr1, fr3
	ld	r5, r5, 24
	fld	fr3, r0, 44
	fcmp	cr0, fr3, fr1
	blt	le.31848
	beq	le.31848
	li	r8, 1
	b	gt_cont.31849
le.31848:
	li	r8, 0
gt_cont.31849:
	cmpwi	cr0, r5, 0
	bne	beq_else.31850
	mr	r5, r8
	b	beq_cont.31851
beq_else.31850:
	cmpwi	cr0, r8, 0
	bne	beq_else.31852
	li	r5, 1
	b	beq_cont.31853
beq_else.31852:
	li	r5, 0
beq_cont.31853:
beq_cont.31851:
	cmpwi	cr0, r5, 0
	bne	beq_else.31854
	li	r2, 1
	b	beq_cont.31855
beq_else.31854:
	li	r2, 0
beq_cont.31855:
	b	beq_cont.31847
beq_else.31846:
	fst	fr1, r3, 80
	fst	fr5, r3, 72
	fst	fr3, r3, 76
	st	r5, r3, 84
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fsqr
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r2, r3, 84
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 76
	fst	fr1, r3, 100
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_fsqr
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	ld	r2, r3, 84
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 100
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 72
	fst	fr1, r3, 104
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_fsqr
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	ld	r2, r3, 84
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 104
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.31856
	b	beq_cont.31857
beq_else.31856:
	fld	fr2, r3, 72
	fld	fr3, r3, 76
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 80
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.31857:
	ld	r5, r2, 4
	cmpwi	cr0, r5, 3
	bne	beq_else.31858
	fld	fr2, r0, 16
	fsub	fr1, fr1, fr2
	b	beq_cont.31859
beq_else.31858:
beq_cont.31859:
	ld	r2, r2, 24
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.31860
	beq	le.31860
	li	r5, 1
	b	gt_cont.31861
le.31860:
	li	r5, 0
gt_cont.31861:
	cmpwi	cr0, r2, 0
	bne	beq_else.31862
	mr	r2, r5
	b	beq_cont.31863
beq_else.31862:
	cmpwi	cr0, r5, 0
	bne	beq_else.31864
	li	r2, 1
	b	beq_cont.31865
beq_else.31864:
	li	r2, 0
beq_cont.31865:
beq_cont.31863:
	cmpwi	cr0, r2, 0
	bne	beq_else.31866
	li	r2, 1
	b	beq_cont.31867
beq_else.31866:
	li	r2, 0
beq_cont.31867:
beq_cont.31847:
beq_cont.31831:
	cmpwi	cr0, r2, 0
	bne	beq_else.31868
	ld	r2, r3, 68
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 20
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.31869
	li	r2, 1
	blr
beq_else.31869:
	slwi	r5, r5, 2
	ld	r7, r3, 16
	add	r31, r7, r5
	ld	r5, r31, 0
	fld	fr1, r3, 12
	fld	fr2, r3, 8
	fld	fr3, r3, 4
	st	r2, r3, 108
	mflr	r31
	mr	r2, r5
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	is_outside.3013
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31870
	ld	r2, r3, 108
	addi	r2, r2, 1
	fld	fr1, r3, 12
	fld	fr2, r3, 8
	fld	fr3, r3, 4
	ld	r5, r3, 20
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
beq_else.31870:
	li	r2, 0
	blr
beq_else.31868:
	li	r2, 0
	blr
beq_else.31828:
	li	r2, 0
	blr
beq_else.31826:
	li	r2, 0
	blr
shadow_check_and_group.3024:
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
	slwi	r17, r2, 2
	add	r31, r5, r17
	ld	r17, r31, 0
	cmpwi	cr0, r17, -1
	bne	beq_else.31871
	li	r2, 0
	blr
beq_else.31871:
	slwi	r17, r2, 2
	add	r31, r5, r17
	ld	r17, r31, 0
	slwi	r18, r17, 2
	add	r31, r11, r18
	ld	r18, r31, 0
	fld	fr1, r14, 0
	ld	r19, r18, 20
	fld	fr2, r19, 0
	fsub	fr1, fr1, fr2
	fld	fr2, r14, 4
	ld	r19, r18, 20
	fld	fr3, r19, 4
	fsub	fr2, fr2, fr3
	fld	fr3, r14, 8
	ld	r19, r18, 20
	fld	fr4, r19, 8
	fsub	fr3, fr3, fr4
	slwi	r19, r17, 2
	add	r31, r15, r19
	ld	r15, r31, 0
	ld	r19, r18, 4
	st	r16, r3, 0
	st	r13, r3, 4
	st	r30, r3, 8
	st	r14, r3, 12
	st	r12, r3, 16
	st	r9, r3, 20
	st	r5, r3, 24
	st	r2, r3, 28
	st	r11, r3, 32
	st	r17, r3, 36
	st	r10, r3, 40
	cmpwi	cr0, r19, 1
	bne	beq_else.31872
	mflr	r31
	mr	r5, r6
	mr	r2, r18
	mr	r30, r8
	mr	r6, r15
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	b	beq_cont.31873
beq_else.31872:
	cmpwi	cr0, r19, 2
	bne	beq_else.31874
	fld	fr4, r15, 0
	fld	fr5, r0, 44
	fcmp	cr0, fr5, fr4
	blt	le.31876
	beq	le.31876
	li	r6, 1
	b	gt_cont.31877
le.31876:
	li	r6, 0
gt_cont.31877:
	cmpwi	cr0, r6, 0
	bne	beq_else.31878
	li	r2, 0
	b	beq_cont.31879
beq_else.31878:
	fld	fr4, r15, 4
	fmul	fr1, fr4, fr1
	fld	fr4, r15, 8
	fmul	fr2, fr4, fr2
	fadd	fr1, fr1, fr2
	fld	fr2, r15, 12
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r10, 0
	li	r2, 1
beq_cont.31879:
	b	beq_cont.31875
beq_else.31874:
	mflr	r31
	mr	r5, r15
	mr	r2, r18
	mr	r30, r7
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
beq_cont.31875:
beq_cont.31873:
	ld	r5, r3, 40
	fld	fr1, r5, 0
	cmpwi	cr0, r2, 0
	bne	beq_else.31880
	li	r2, 0
	b	beq_cont.31881
beq_else.31880:
	fld	fr2, r0, 100
	fcmp	cr0, fr2, fr1
	blt	le.31882
	beq	le.31882
	li	r2, 1
	b	gt_cont.31883
le.31882:
	li	r2, 0
gt_cont.31883:
beq_cont.31881:
	cmpwi	cr0, r2, 0
	bne	beq_else.31884
	ld	r2, r3, 36
	slwi	r2, r2, 2
	ld	r6, r3, 32
	add	r31, r6, r2
	ld	r2, r31, 0
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.31885
	li	r2, 0
	blr
beq_else.31885:
	ld	r2, r3, 28
	addi	r2, r2, 1
	slwi	r7, r2, 2
	ld	r8, r3, 24
	add	r31, r8, r7
	ld	r7, r31, 0
	cmpwi	cr0, r7, -1
	bne	beq_else.31886
	li	r2, 0
	blr
beq_else.31886:
	slwi	r7, r2, 2
	add	r31, r8, r7
	ld	r7, r31, 0
	ld	r9, r3, 16
	ld	r10, r3, 12
	ld	r30, r3, 20
	st	r2, r3, 44
	st	r7, r3, 48
	mflr	r31
	mr	r6, r10
	mr	r5, r9
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r5, r3, 40
	fld	fr1, r5, 0
	cmpwi	cr0, r2, 0
	bne	beq_else.31887
	li	r2, 0
	b	beq_cont.31888
beq_else.31887:
	fld	fr2, r0, 100
	fcmp	cr0, fr2, fr1
	blt	le.31889
	beq	le.31889
	li	r2, 1
	b	gt_cont.31890
le.31889:
	li	r2, 0
gt_cont.31890:
beq_cont.31888:
	cmpwi	cr0, r2, 0
	bne	beq_else.31891
	ld	r2, r3, 48
	slwi	r2, r2, 2
	ld	r5, r3, 32
	add	r31, r5, r2
	ld	r2, r31, 0
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.31892
	li	r2, 0
	blr
beq_else.31892:
	ld	r2, r3, 44
	addi	r2, r2, 1
	ld	r5, r3, 24
	ld	r30, r3, 8
	ld	r29, r30, 0
	ba	r29
beq_else.31891:
	fld	fr2, r0, 104
	fadd	fr1, fr1, fr2
	ld	r2, r3, 4
	fld	fr2, r2, 0
	fmul	fr2, fr2, fr1
	ld	r5, r3, 12
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
	ld	r5, r3, 24
	ld	r2, r5, 0
	cmpwi	cr0, r2, -1
	bne	beq_else.31893
	li	r2, 1
	b	beq_cont.31894
beq_else.31893:
	slwi	r2, r2, 2
	ld	r6, r3, 32
	add	r31, r6, r2
	ld	r2, r31, 0
	ld	r7, r2, 20
	fld	fr4, r7, 0
	fsub	fr4, fr2, fr4
	ld	r7, r2, 20
	fld	fr5, r7, 4
	fsub	fr5, fr3, fr5
	ld	r7, r2, 20
	fld	fr6, r7, 8
	fsub	fr6, fr1, fr6
	ld	r7, r2, 4
	fst	fr1, r3, 52
	fst	fr3, r3, 56
	fst	fr2, r3, 60
	cmpwi	cr0, r7, 1
	bne	beq_else.31895
	fst	fr6, r3, 64
	fst	fr5, r3, 68
	fst	fr4, r3, 72
	st	r2, r3, 76
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_fabs
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r2, r3, 76
	ld	r5, r2, 16
	fld	fr1, r5, 0
	fld	fr2, r3, 72
	fst	fr1, r3, 80
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_fabs
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	fld	fr2, r3, 80
	fcmp	cr0, fr2, fr1
	blt	le.31897
	beq	le.31897
	li	r2, 1
	b	gt_cont.31898
le.31897:
	li	r2, 0
gt_cont.31898:
	cmpwi	cr0, r2, 0
	bne	beq_else.31899
	li	r2, 0
	b	beq_cont.31900
beq_else.31899:
	fld	fr1, r3, 68
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_fabs
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r2, r3, 76
	ld	r5, r2, 16
	fld	fr1, r5, 4
	fld	fr2, r3, 68
	fst	fr1, r3, 84
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fabs
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	fld	fr2, r3, 84
	fcmp	cr0, fr2, fr1
	blt	le.31901
	beq	le.31901
	li	r2, 1
	b	gt_cont.31902
le.31901:
	li	r2, 0
gt_cont.31902:
	cmpwi	cr0, r2, 0
	bne	beq_else.31903
	li	r2, 0
	b	beq_cont.31904
beq_else.31903:
	fld	fr1, r3, 64
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fabs
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r2, r3, 76
	ld	r5, r2, 16
	fld	fr1, r5, 8
	fld	fr2, r3, 64
	fst	fr1, r3, 88
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fabs
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	fld	fr2, r3, 88
	fcmp	cr0, fr2, fr1
	blt	le.31905
	beq	le.31905
	li	r2, 1
	b	gt_cont.31906
le.31905:
	li	r2, 0
gt_cont.31906:
beq_cont.31904:
beq_cont.31900:
	cmpwi	cr0, r2, 0
	bne	beq_else.31907
	ld	r2, r3, 76
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.31909
	li	r2, 1
	b	beq_cont.31910
beq_else.31909:
	li	r2, 0
beq_cont.31910:
	b	beq_cont.31908
beq_else.31907:
	ld	r2, r3, 76
	ld	r2, r2, 24
beq_cont.31908:
	b	beq_cont.31896
beq_else.31895:
	cmpwi	cr0, r7, 2
	bne	beq_else.31911
	ld	r7, r2, 16
	fld	fr7, r7, 0
	fmul	fr4, fr7, fr4
	fld	fr7, r7, 4
	fmul	fr5, fr7, fr5
	fadd	fr4, fr4, fr5
	fld	fr5, r7, 8
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	ld	r2, r2, 24
	fld	fr5, r0, 44
	fcmp	cr0, fr5, fr4
	blt	le.31913
	beq	le.31913
	li	r7, 1
	b	gt_cont.31914
le.31913:
	li	r7, 0
gt_cont.31914:
	cmpwi	cr0, r2, 0
	bne	beq_else.31915
	mr	r2, r7
	b	beq_cont.31916
beq_else.31915:
	cmpwi	cr0, r7, 0
	bne	beq_else.31917
	li	r2, 1
	b	beq_cont.31918
beq_else.31917:
	li	r2, 0
beq_cont.31918:
beq_cont.31916:
	cmpwi	cr0, r2, 0
	bne	beq_else.31919
	li	r2, 1
	b	beq_cont.31920
beq_else.31919:
	li	r2, 0
beq_cont.31920:
	b	beq_cont.31912
beq_else.31911:
	fst	fr4, r3, 72
	fst	fr6, r3, 64
	fst	fr5, r3, 68
	st	r2, r3, 76
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fsqr
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r2, r3, 76
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 68
	fst	fr1, r3, 92
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fsqr
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r2, r3, 76
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 92
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 64
	fst	fr1, r3, 96
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fsqr
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r2, r3, 76
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 96
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.31921
	b	beq_cont.31922
beq_else.31921:
	fld	fr2, r3, 64
	fld	fr3, r3, 68
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 72
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.31922:
	ld	r5, r2, 4
	cmpwi	cr0, r5, 3
	bne	beq_else.31923
	fld	fr2, r0, 16
	fsub	fr1, fr1, fr2
	b	beq_cont.31924
beq_else.31923:
beq_cont.31924:
	ld	r2, r2, 24
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.31925
	beq	le.31925
	li	r5, 1
	b	gt_cont.31926
le.31925:
	li	r5, 0
gt_cont.31926:
	cmpwi	cr0, r2, 0
	bne	beq_else.31927
	mr	r2, r5
	b	beq_cont.31928
beq_else.31927:
	cmpwi	cr0, r5, 0
	bne	beq_else.31929
	li	r2, 1
	b	beq_cont.31930
beq_else.31929:
	li	r2, 0
beq_cont.31930:
beq_cont.31928:
	cmpwi	cr0, r2, 0
	bne	beq_else.31931
	li	r2, 1
	b	beq_cont.31932
beq_else.31931:
	li	r2, 0
beq_cont.31932:
beq_cont.31912:
beq_cont.31896:
	cmpwi	cr0, r2, 0
	bne	beq_else.31933
	ld	r5, r3, 24
	ld	r2, r5, 4
	cmpwi	cr0, r2, -1
	bne	beq_else.31935
	li	r2, 1
	b	beq_cont.31936
beq_else.31935:
	slwi	r2, r2, 2
	ld	r6, r3, 32
	add	r31, r6, r2
	ld	r2, r31, 0
	fld	fr1, r3, 60
	fld	fr2, r3, 56
	fld	fr3, r3, 52
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	is_outside.3013
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31937
	li	r2, 2
	fld	fr1, r3, 60
	fld	fr2, r3, 56
	fld	fr3, r3, 52
	ld	r5, r3, 24
	ld	r30, r3, 0
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	b	beq_cont.31938
beq_else.31937:
	li	r2, 0
beq_cont.31938:
beq_cont.31936:
	b	beq_cont.31934
beq_else.31933:
	li	r2, 0
beq_cont.31934:
beq_cont.31894:
	cmpwi	cr0, r2, 0
	bne	beq_else.31939
	ld	r2, r3, 44
	addi	r2, r2, 1
	ld	r5, r3, 24
	ld	r30, r3, 8
	ld	r29, r30, 0
	ba	r29
beq_else.31939:
	li	r2, 1
	blr
beq_else.31884:
	fld	fr2, r0, 104
	fadd	fr1, fr1, fr2
	ld	r2, r3, 4
	fld	fr2, r2, 0
	fmul	fr2, fr2, fr1
	ld	r6, r3, 12
	fld	fr3, r6, 0
	fadd	fr2, fr2, fr3
	fld	fr3, r2, 4
	fmul	fr3, fr3, fr1
	fld	fr4, r6, 4
	fadd	fr3, fr3, fr4
	fld	fr4, r2, 8
	fmul	fr1, fr4, fr1
	fld	fr4, r6, 8
	fadd	fr1, fr1, fr4
	ld	r7, r3, 24
	ld	r8, r7, 0
	cmpwi	cr0, r8, -1
	bne	beq_else.31940
	li	r2, 1
	b	beq_cont.31941
beq_else.31940:
	slwi	r8, r8, 2
	ld	r9, r3, 32
	add	r31, r9, r8
	ld	r8, r31, 0
	fst	fr1, r3, 100
	fst	fr3, r3, 104
	fst	fr2, r3, 108
	mflr	r31
	mr	r2, r8
	fmr	fr31, fr3
	fmr	fr3, fr1
	fmr	fr1, fr2
	fmr	fr2, fr31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	is_outside.3013
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31942
	ld	r2, r3, 24
	ld	r5, r2, 4
	cmpwi	cr0, r5, -1
	bne	beq_else.31944
	li	r2, 1
	b	beq_cont.31945
beq_else.31944:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r7, r5, 20
	fld	fr1, r7, 0
	fld	fr2, r3, 108
	fsub	fr1, fr2, fr1
	ld	r7, r5, 20
	fld	fr3, r7, 4
	fld	fr4, r3, 104
	fsub	fr3, fr4, fr3
	ld	r7, r5, 20
	fld	fr5, r7, 8
	fld	fr6, r3, 100
	fsub	fr5, fr6, fr5
	ld	r7, r5, 4
	cmpwi	cr0, r7, 1
	bne	beq_else.31946
	fst	fr5, r3, 112
	fst	fr3, r3, 116
	fst	fr1, r3, 120
	st	r5, r3, 124
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_fabs
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r2, r3, 124
	ld	r5, r2, 16
	fld	fr1, r5, 0
	fld	fr2, r3, 120
	fst	fr1, r3, 128
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_fabs
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	fld	fr2, r3, 128
	fcmp	cr0, fr2, fr1
	blt	le.31948
	beq	le.31948
	li	r2, 1
	b	gt_cont.31949
le.31948:
	li	r2, 0
gt_cont.31949:
	cmpwi	cr0, r2, 0
	bne	beq_else.31950
	li	r2, 0
	b	beq_cont.31951
beq_else.31950:
	fld	fr1, r3, 116
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_fabs
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r2, r3, 124
	ld	r5, r2, 16
	fld	fr1, r5, 4
	fld	fr2, r3, 116
	fst	fr1, r3, 132
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_fabs
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	fld	fr2, r3, 132
	fcmp	cr0, fr2, fr1
	blt	le.31952
	beq	le.31952
	li	r2, 1
	b	gt_cont.31953
le.31952:
	li	r2, 0
gt_cont.31953:
	cmpwi	cr0, r2, 0
	bne	beq_else.31954
	li	r2, 0
	b	beq_cont.31955
beq_else.31954:
	fld	fr1, r3, 112
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_fabs
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	ld	r2, r3, 124
	ld	r5, r2, 16
	fld	fr1, r5, 8
	fld	fr2, r3, 112
	fst	fr1, r3, 136
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_fabs
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	fld	fr2, r3, 136
	fcmp	cr0, fr2, fr1
	blt	le.31956
	beq	le.31956
	li	r2, 1
	b	gt_cont.31957
le.31956:
	li	r2, 0
gt_cont.31957:
beq_cont.31955:
beq_cont.31951:
	cmpwi	cr0, r2, 0
	bne	beq_else.31958
	ld	r2, r3, 124
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.31960
	li	r2, 1
	b	beq_cont.31961
beq_else.31960:
	li	r2, 0
beq_cont.31961:
	b	beq_cont.31959
beq_else.31958:
	ld	r2, r3, 124
	ld	r2, r2, 24
beq_cont.31959:
	b	beq_cont.31947
beq_else.31946:
	cmpwi	cr0, r7, 2
	bne	beq_else.31962
	ld	r7, r5, 16
	fld	fr7, r7, 0
	fmul	fr1, fr7, fr1
	fld	fr7, r7, 4
	fmul	fr3, fr7, fr3
	fadd	fr1, fr1, fr3
	fld	fr3, r7, 8
	fmul	fr3, fr3, fr5
	fadd	fr1, fr1, fr3
	ld	r5, r5, 24
	fld	fr3, r0, 44
	fcmp	cr0, fr3, fr1
	blt	le.31964
	beq	le.31964
	li	r7, 1
	b	gt_cont.31965
le.31964:
	li	r7, 0
gt_cont.31965:
	cmpwi	cr0, r5, 0
	bne	beq_else.31966
	mr	r5, r7
	b	beq_cont.31967
beq_else.31966:
	cmpwi	cr0, r7, 0
	bne	beq_else.31968
	li	r5, 1
	b	beq_cont.31969
beq_else.31968:
	li	r5, 0
beq_cont.31969:
beq_cont.31967:
	cmpwi	cr0, r5, 0
	bne	beq_else.31970
	li	r2, 1
	b	beq_cont.31971
beq_else.31970:
	li	r2, 0
beq_cont.31971:
	b	beq_cont.31963
beq_else.31962:
	fst	fr1, r3, 120
	fst	fr5, r3, 112
	fst	fr3, r3, 116
	st	r5, r3, 124
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_fsqr
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	ld	r2, r3, 124
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 116
	fst	fr1, r3, 140
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 148
	addi	r3, r3, 152
	bl	min_caml_fsqr
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	ld	r2, r3, 124
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 140
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 112
	fst	fr1, r3, 144
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 148
	addi	r3, r3, 152
	bl	min_caml_fsqr
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	ld	r2, r3, 124
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 144
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.31972
	b	beq_cont.31973
beq_else.31972:
	fld	fr2, r3, 112
	fld	fr3, r3, 116
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 120
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.31973:
	ld	r5, r2, 4
	cmpwi	cr0, r5, 3
	bne	beq_else.31974
	fld	fr2, r0, 16
	fsub	fr1, fr1, fr2
	b	beq_cont.31975
beq_else.31974:
beq_cont.31975:
	ld	r2, r2, 24
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.31976
	beq	le.31976
	li	r5, 1
	b	gt_cont.31977
le.31976:
	li	r5, 0
gt_cont.31977:
	cmpwi	cr0, r2, 0
	bne	beq_else.31978
	mr	r2, r5
	b	beq_cont.31979
beq_else.31978:
	cmpwi	cr0, r5, 0
	bne	beq_else.31980
	li	r2, 1
	b	beq_cont.31981
beq_else.31980:
	li	r2, 0
beq_cont.31981:
beq_cont.31979:
	cmpwi	cr0, r2, 0
	bne	beq_else.31982
	li	r2, 1
	b	beq_cont.31983
beq_else.31982:
	li	r2, 0
beq_cont.31983:
beq_cont.31963:
beq_cont.31947:
	cmpwi	cr0, r2, 0
	bne	beq_else.31984
	ld	r2, r3, 24
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.31986
	li	r2, 1
	b	beq_cont.31987
beq_else.31986:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	fld	fr1, r3, 108
	fld	fr2, r3, 104
	fld	fr3, r3, 100
	mflr	r31
	mr	r2, r5
	st	r31, r3, 148
	addi	r3, r3, 152
	bl	is_outside.3013
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.31988
	li	r2, 3
	fld	fr1, r3, 108
	fld	fr2, r3, 104
	fld	fr3, r3, 100
	ld	r5, r3, 24
	ld	r30, r3, 0
	mflr	r31
	st	r31, r3, 148
	addi	r3, r3, 152
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	b	beq_cont.31989
beq_else.31988:
	li	r2, 0
beq_cont.31989:
beq_cont.31987:
	b	beq_cont.31985
beq_else.31984:
	li	r2, 0
beq_cont.31985:
beq_cont.31945:
	b	beq_cont.31943
beq_else.31942:
	li	r2, 0
beq_cont.31943:
beq_cont.31941:
	cmpwi	cr0, r2, 0
	bne	beq_else.31990
	ld	r2, r3, 28
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 24
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.31991
	li	r2, 0
	blr
beq_else.31991:
	slwi	r5, r2, 2
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r7, r3, 16
	ld	r8, r3, 12
	ld	r30, r3, 20
	st	r2, r3, 148
	st	r5, r3, 152
	mflr	r31
	mr	r6, r8
	mr	r2, r5
	mr	r5, r7
	st	r31, r3, 156
	addi	r3, r3, 160
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -160
	ld	r31, r3, 156
	mtlr	r31
	ld	r5, r3, 40
	fld	fr1, r5, 0
	cmpwi	cr0, r2, 0
	bne	beq_else.31992
	li	r2, 0
	b	beq_cont.31993
beq_else.31992:
	fld	fr2, r0, 100
	fcmp	cr0, fr2, fr1
	blt	le.31994
	beq	le.31994
	li	r2, 1
	b	gt_cont.31995
le.31994:
	li	r2, 0
gt_cont.31995:
beq_cont.31993:
	cmpwi	cr0, r2, 0
	bne	beq_else.31996
	ld	r2, r3, 152
	slwi	r2, r2, 2
	ld	r5, r3, 32
	add	r31, r5, r2
	ld	r2, r31, 0
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.31997
	li	r2, 0
	blr
beq_else.31997:
	ld	r2, r3, 148
	addi	r2, r2, 1
	ld	r5, r3, 24
	ld	r30, r3, 8
	ld	r29, r30, 0
	ba	r29
beq_else.31996:
	fld	fr2, r0, 104
	fadd	fr1, fr1, fr2
	ld	r2, r3, 4
	fld	fr2, r2, 0
	fmul	fr2, fr2, fr1
	ld	r5, r3, 12
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
	ld	r5, r3, 24
	ld	r2, r5, 0
	cmpwi	cr0, r2, -1
	bne	beq_else.31998
	li	r2, 1
	b	beq_cont.31999
beq_else.31998:
	slwi	r2, r2, 2
	ld	r6, r3, 32
	add	r31, r6, r2
	ld	r2, r31, 0
	ld	r7, r2, 20
	fld	fr4, r7, 0
	fsub	fr4, fr2, fr4
	ld	r7, r2, 20
	fld	fr5, r7, 4
	fsub	fr5, fr3, fr5
	ld	r7, r2, 20
	fld	fr6, r7, 8
	fsub	fr6, fr1, fr6
	ld	r7, r2, 4
	fst	fr1, r3, 156
	fst	fr3, r3, 160
	fst	fr2, r3, 164
	cmpwi	cr0, r7, 1
	bne	beq_else.32000
	fst	fr6, r3, 168
	fst	fr5, r3, 172
	fst	fr4, r3, 176
	st	r2, r3, 180
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 188
	addi	r3, r3, 192
	bl	min_caml_fabs
	addi	r3, r3, -192
	ld	r31, r3, 188
	mtlr	r31
	ld	r2, r3, 180
	ld	r5, r2, 16
	fld	fr1, r5, 0
	fld	fr2, r3, 176
	fst	fr1, r3, 184
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 188
	addi	r3, r3, 192
	bl	min_caml_fabs
	addi	r3, r3, -192
	ld	r31, r3, 188
	mtlr	r31
	fld	fr2, r3, 184
	fcmp	cr0, fr2, fr1
	blt	le.32002
	beq	le.32002
	li	r2, 1
	b	gt_cont.32003
le.32002:
	li	r2, 0
gt_cont.32003:
	cmpwi	cr0, r2, 0
	bne	beq_else.32004
	li	r2, 0
	b	beq_cont.32005
beq_else.32004:
	fld	fr1, r3, 172
	mflr	r31
	st	r31, r3, 188
	addi	r3, r3, 192
	bl	min_caml_fabs
	addi	r3, r3, -192
	ld	r31, r3, 188
	mtlr	r31
	ld	r2, r3, 180
	ld	r5, r2, 16
	fld	fr1, r5, 4
	fld	fr2, r3, 172
	fst	fr1, r3, 188
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 196
	addi	r3, r3, 200
	bl	min_caml_fabs
	addi	r3, r3, -200
	ld	r31, r3, 196
	mtlr	r31
	fld	fr2, r3, 188
	fcmp	cr0, fr2, fr1
	blt	le.32006
	beq	le.32006
	li	r2, 1
	b	gt_cont.32007
le.32006:
	li	r2, 0
gt_cont.32007:
	cmpwi	cr0, r2, 0
	bne	beq_else.32008
	li	r2, 0
	b	beq_cont.32009
beq_else.32008:
	fld	fr1, r3, 168
	mflr	r31
	st	r31, r3, 196
	addi	r3, r3, 200
	bl	min_caml_fabs
	addi	r3, r3, -200
	ld	r31, r3, 196
	mtlr	r31
	ld	r2, r3, 180
	ld	r5, r2, 16
	fld	fr1, r5, 8
	fld	fr2, r3, 168
	fst	fr1, r3, 192
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 196
	addi	r3, r3, 200
	bl	min_caml_fabs
	addi	r3, r3, -200
	ld	r31, r3, 196
	mtlr	r31
	fld	fr2, r3, 192
	fcmp	cr0, fr2, fr1
	blt	le.32010
	beq	le.32010
	li	r2, 1
	b	gt_cont.32011
le.32010:
	li	r2, 0
gt_cont.32011:
beq_cont.32009:
beq_cont.32005:
	cmpwi	cr0, r2, 0
	bne	beq_else.32012
	ld	r2, r3, 180
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.32014
	li	r2, 1
	b	beq_cont.32015
beq_else.32014:
	li	r2, 0
beq_cont.32015:
	b	beq_cont.32013
beq_else.32012:
	ld	r2, r3, 180
	ld	r2, r2, 24
beq_cont.32013:
	b	beq_cont.32001
beq_else.32000:
	cmpwi	cr0, r7, 2
	bne	beq_else.32016
	ld	r7, r2, 16
	fld	fr7, r7, 0
	fmul	fr4, fr7, fr4
	fld	fr7, r7, 4
	fmul	fr5, fr7, fr5
	fadd	fr4, fr4, fr5
	fld	fr5, r7, 8
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	ld	r2, r2, 24
	fld	fr5, r0, 44
	fcmp	cr0, fr5, fr4
	blt	le.32018
	beq	le.32018
	li	r7, 1
	b	gt_cont.32019
le.32018:
	li	r7, 0
gt_cont.32019:
	cmpwi	cr0, r2, 0
	bne	beq_else.32020
	mr	r2, r7
	b	beq_cont.32021
beq_else.32020:
	cmpwi	cr0, r7, 0
	bne	beq_else.32022
	li	r2, 1
	b	beq_cont.32023
beq_else.32022:
	li	r2, 0
beq_cont.32023:
beq_cont.32021:
	cmpwi	cr0, r2, 0
	bne	beq_else.32024
	li	r2, 1
	b	beq_cont.32025
beq_else.32024:
	li	r2, 0
beq_cont.32025:
	b	beq_cont.32017
beq_else.32016:
	fst	fr4, r3, 176
	fst	fr6, r3, 168
	fst	fr5, r3, 172
	st	r2, r3, 180
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 196
	addi	r3, r3, 200
	bl	min_caml_fsqr
	addi	r3, r3, -200
	ld	r31, r3, 196
	mtlr	r31
	ld	r2, r3, 180
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 172
	fst	fr1, r3, 196
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 204
	addi	r3, r3, 208
	bl	min_caml_fsqr
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	ld	r2, r3, 180
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 196
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 168
	fst	fr1, r3, 200
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 204
	addi	r3, r3, 208
	bl	min_caml_fsqr
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	ld	r2, r3, 180
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 200
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.32026
	b	beq_cont.32027
beq_else.32026:
	fld	fr2, r3, 168
	fld	fr3, r3, 172
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 176
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.32027:
	ld	r5, r2, 4
	cmpwi	cr0, r5, 3
	bne	beq_else.32028
	fld	fr2, r0, 16
	fsub	fr1, fr1, fr2
	b	beq_cont.32029
beq_else.32028:
beq_cont.32029:
	ld	r2, r2, 24
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32030
	beq	le.32030
	li	r5, 1
	b	gt_cont.32031
le.32030:
	li	r5, 0
gt_cont.32031:
	cmpwi	cr0, r2, 0
	bne	beq_else.32032
	mr	r2, r5
	b	beq_cont.32033
beq_else.32032:
	cmpwi	cr0, r5, 0
	bne	beq_else.32034
	li	r2, 1
	b	beq_cont.32035
beq_else.32034:
	li	r2, 0
beq_cont.32035:
beq_cont.32033:
	cmpwi	cr0, r2, 0
	bne	beq_else.32036
	li	r2, 1
	b	beq_cont.32037
beq_else.32036:
	li	r2, 0
beq_cont.32037:
beq_cont.32017:
beq_cont.32001:
	cmpwi	cr0, r2, 0
	bne	beq_else.32038
	ld	r5, r3, 24
	ld	r2, r5, 4
	cmpwi	cr0, r2, -1
	bne	beq_else.32040
	li	r2, 1
	b	beq_cont.32041
beq_else.32040:
	slwi	r2, r2, 2
	ld	r6, r3, 32
	add	r31, r6, r2
	ld	r2, r31, 0
	fld	fr1, r3, 164
	fld	fr2, r3, 160
	fld	fr3, r3, 156
	mflr	r31
	st	r31, r3, 204
	addi	r3, r3, 208
	bl	is_outside.3013
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32042
	li	r2, 2
	fld	fr1, r3, 164
	fld	fr2, r3, 160
	fld	fr3, r3, 156
	ld	r5, r3, 24
	ld	r30, r3, 0
	mflr	r31
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	b	beq_cont.32043
beq_else.32042:
	li	r2, 0
beq_cont.32043:
beq_cont.32041:
	b	beq_cont.32039
beq_else.32038:
	li	r2, 0
beq_cont.32039:
beq_cont.31999:
	cmpwi	cr0, r2, 0
	bne	beq_else.32044
	ld	r2, r3, 148
	addi	r2, r2, 1
	ld	r5, r3, 24
	ld	r30, r3, 8
	ld	r29, r30, 0
	ba	r29
beq_else.32044:
	li	r2, 1
	blr
beq_else.31990:
	li	r2, 1
	blr
shadow_check_one_or_group.3027:
	ld	r6, r30, 36
	ld	r7, r30, 32
	ld	r8, r30, 28
	ld	r9, r30, 24
	ld	r10, r30, 20
	ld	r11, r30, 16
	ld	r12, r30, 12
	ld	r13, r30, 8
	ld	r14, r30, 4
	slwi	r15, r2, 2
	add	r31, r5, r15
	ld	r15, r31, 0
	cmpwi	cr0, r15, -1
	bne	beq_else.32045
	li	r2, 0
	blr
beq_else.32045:
	slwi	r15, r15, 2
	add	r31, r14, r15
	ld	r15, r31, 0
	ld	r16, r15, 0
	st	r30, r3, 0
	st	r8, r3, 4
	st	r14, r3, 8
	st	r5, r3, 12
	st	r2, r3, 16
	cmpwi	cr0, r16, -1
	bne	beq_else.32046
	li	r2, 0
	b	beq_cont.32047
beq_else.32046:
	ld	r16, r15, 0
	st	r13, r3, 20
	st	r12, r3, 24
	st	r11, r3, 28
	st	r15, r3, 32
	st	r9, r3, 36
	st	r16, r3, 40
	st	r7, r3, 44
	mflr	r31
	mr	r5, r10
	mr	r2, r16
	mr	r30, r6
	mr	r6, r12
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r5, r3, 44
	fld	fr1, r5, 0
	cmpwi	cr0, r2, 0
	bne	beq_else.32048
	li	r2, 0
	b	beq_cont.32049
beq_else.32048:
	fld	fr2, r0, 100
	fcmp	cr0, fr2, fr1
	blt	le.32050
	beq	le.32050
	li	r2, 1
	b	gt_cont.32051
le.32050:
	li	r2, 0
gt_cont.32051:
beq_cont.32049:
	cmpwi	cr0, r2, 0
	bne	beq_else.32052
	ld	r2, r3, 40
	slwi	r2, r2, 2
	ld	r5, r3, 36
	add	r31, r5, r2
	ld	r2, r31, 0
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.32054
	li	r2, 0
	b	beq_cont.32055
beq_else.32054:
	li	r2, 1
	ld	r5, r3, 32
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
beq_cont.32055:
	b	beq_cont.32053
beq_else.32052:
	fld	fr2, r0, 104
	fadd	fr1, fr1, fr2
	ld	r2, r3, 28
	fld	fr2, r2, 0
	fmul	fr2, fr2, fr1
	ld	r5, r3, 24
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
	ld	r5, r3, 32
	ld	r2, r5, 0
	cmpwi	cr0, r2, -1
	bne	beq_else.32056
	li	r2, 1
	b	beq_cont.32057
beq_else.32056:
	slwi	r2, r2, 2
	ld	r6, r3, 36
	add	r31, r6, r2
	ld	r2, r31, 0
	ld	r7, r2, 20
	fld	fr4, r7, 0
	fsub	fr4, fr2, fr4
	ld	r7, r2, 20
	fld	fr5, r7, 4
	fsub	fr5, fr3, fr5
	ld	r7, r2, 20
	fld	fr6, r7, 8
	fsub	fr6, fr1, fr6
	ld	r7, r2, 4
	fst	fr1, r3, 48
	fst	fr3, r3, 52
	fst	fr2, r3, 56
	cmpwi	cr0, r7, 1
	bne	beq_else.32058
	fst	fr6, r3, 60
	fst	fr5, r3, 64
	fst	fr4, r3, 68
	st	r2, r3, 72
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_fabs
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 72
	ld	r5, r2, 16
	fld	fr1, r5, 0
	fld	fr2, r3, 68
	fst	fr1, r3, 76
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_fabs
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	fld	fr2, r3, 76
	fcmp	cr0, fr2, fr1
	blt	le.32060
	beq	le.32060
	li	r2, 1
	b	gt_cont.32061
le.32060:
	li	r2, 0
gt_cont.32061:
	cmpwi	cr0, r2, 0
	bne	beq_else.32062
	li	r2, 0
	b	beq_cont.32063
beq_else.32062:
	fld	fr1, r3, 64
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_fabs
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r2, r3, 72
	ld	r5, r2, 16
	fld	fr1, r5, 4
	fld	fr2, r3, 64
	fst	fr1, r3, 80
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_fabs
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	fld	fr2, r3, 80
	fcmp	cr0, fr2, fr1
	blt	le.32064
	beq	le.32064
	li	r2, 1
	b	gt_cont.32065
le.32064:
	li	r2, 0
gt_cont.32065:
	cmpwi	cr0, r2, 0
	bne	beq_else.32066
	li	r2, 0
	b	beq_cont.32067
beq_else.32066:
	fld	fr1, r3, 60
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_fabs
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r2, r3, 72
	ld	r5, r2, 16
	fld	fr1, r5, 8
	fld	fr2, r3, 60
	fst	fr1, r3, 84
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fabs
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	fld	fr2, r3, 84
	fcmp	cr0, fr2, fr1
	blt	le.32068
	beq	le.32068
	li	r2, 1
	b	gt_cont.32069
le.32068:
	li	r2, 0
gt_cont.32069:
beq_cont.32067:
beq_cont.32063:
	cmpwi	cr0, r2, 0
	bne	beq_else.32070
	ld	r2, r3, 72
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.32072
	li	r2, 1
	b	beq_cont.32073
beq_else.32072:
	li	r2, 0
beq_cont.32073:
	b	beq_cont.32071
beq_else.32070:
	ld	r2, r3, 72
	ld	r2, r2, 24
beq_cont.32071:
	b	beq_cont.32059
beq_else.32058:
	cmpwi	cr0, r7, 2
	bne	beq_else.32074
	ld	r7, r2, 16
	fld	fr7, r7, 0
	fmul	fr4, fr7, fr4
	fld	fr7, r7, 4
	fmul	fr5, fr7, fr5
	fadd	fr4, fr4, fr5
	fld	fr5, r7, 8
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	ld	r2, r2, 24
	fld	fr5, r0, 44
	fcmp	cr0, fr5, fr4
	blt	le.32076
	beq	le.32076
	li	r7, 1
	b	gt_cont.32077
le.32076:
	li	r7, 0
gt_cont.32077:
	cmpwi	cr0, r2, 0
	bne	beq_else.32078
	mr	r2, r7
	b	beq_cont.32079
beq_else.32078:
	cmpwi	cr0, r7, 0
	bne	beq_else.32080
	li	r2, 1
	b	beq_cont.32081
beq_else.32080:
	li	r2, 0
beq_cont.32081:
beq_cont.32079:
	cmpwi	cr0, r2, 0
	bne	beq_else.32082
	li	r2, 1
	b	beq_cont.32083
beq_else.32082:
	li	r2, 0
beq_cont.32083:
	b	beq_cont.32075
beq_else.32074:
	fst	fr4, r3, 68
	fst	fr6, r3, 60
	fst	fr5, r3, 64
	st	r2, r3, 72
	mflr	r31
	fmr	fr1, fr4
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fsqr
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r2, r3, 72
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 64
	fst	fr1, r3, 88
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fsqr
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r2, r3, 72
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 88
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 60
	fst	fr1, r3, 92
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fsqr
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r2, r3, 72
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 92
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.32084
	b	beq_cont.32085
beq_else.32084:
	fld	fr2, r3, 60
	fld	fr3, r3, 64
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 68
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.32085:
	ld	r5, r2, 4
	cmpwi	cr0, r5, 3
	bne	beq_else.32086
	fld	fr2, r0, 16
	fsub	fr1, fr1, fr2
	b	beq_cont.32087
beq_else.32086:
beq_cont.32087:
	ld	r2, r2, 24
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32088
	beq	le.32088
	li	r5, 1
	b	gt_cont.32089
le.32088:
	li	r5, 0
gt_cont.32089:
	cmpwi	cr0, r2, 0
	bne	beq_else.32090
	mr	r2, r5
	b	beq_cont.32091
beq_else.32090:
	cmpwi	cr0, r5, 0
	bne	beq_else.32092
	li	r2, 1
	b	beq_cont.32093
beq_else.32092:
	li	r2, 0
beq_cont.32093:
beq_cont.32091:
	cmpwi	cr0, r2, 0
	bne	beq_else.32094
	li	r2, 1
	b	beq_cont.32095
beq_else.32094:
	li	r2, 0
beq_cont.32095:
beq_cont.32075:
beq_cont.32059:
	cmpwi	cr0, r2, 0
	bne	beq_else.32096
	ld	r5, r3, 32
	ld	r2, r5, 4
	cmpwi	cr0, r2, -1
	bne	beq_else.32098
	li	r2, 1
	b	beq_cont.32099
beq_else.32098:
	slwi	r2, r2, 2
	ld	r6, r3, 36
	add	r31, r6, r2
	ld	r2, r31, 0
	fld	fr1, r3, 56
	fld	fr2, r3, 52
	fld	fr3, r3, 48
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	is_outside.3013
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32100
	li	r2, 2
	fld	fr1, r3, 56
	fld	fr2, r3, 52
	fld	fr3, r3, 48
	ld	r5, r3, 32
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	b	beq_cont.32101
beq_else.32100:
	li	r2, 0
beq_cont.32101:
beq_cont.32099:
	b	beq_cont.32097
beq_else.32096:
	li	r2, 0
beq_cont.32097:
beq_cont.32057:
	cmpwi	cr0, r2, 0
	bne	beq_else.32102
	li	r2, 1
	ld	r5, r3, 32
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	b	beq_cont.32103
beq_else.32102:
	li	r2, 1
beq_cont.32103:
beq_cont.32053:
beq_cont.32047:
	cmpwi	cr0, r2, 0
	bne	beq_else.32104
	ld	r2, r3, 16
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 12
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.32105
	li	r2, 0
	blr
beq_else.32105:
	slwi	r5, r5, 2
	ld	r7, r3, 8
	add	r31, r7, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r30, r3, 4
	st	r2, r3, 96
	mflr	r31
	mr	r2, r7
	st	r31, r3, 100
	addi	r3, r3, 104
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32106
	ld	r2, r3, 96
	addi	r2, r2, 1
	ld	r5, r3, 12
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
beq_else.32106:
	li	r2, 1
	blr
beq_else.32104:
	li	r2, 1
	blr
shadow_check_one_or_matrix.3030:
	ld	r6, r30, 48
	ld	r7, r30, 44
	ld	r8, r30, 40
	ld	r9, r30, 36
	ld	r10, r30, 32
	ld	r11, r30, 28
	ld	r12, r30, 24
	ld	r13, r30, 20
	ld	r14, r30, 16
	ld	r15, r30, 12
	ld	r16, r30, 8
	ld	r17, r30, 4
	slwi	r18, r2, 2
	add	r31, r5, r18
	ld	r18, r31, 0
	ld	r19, r18, 0
	cmpwi	cr0, r19, -1
	bne	beq_else.32107
	li	r2, 0
	blr
beq_else.32107:
	st	r12, r3, 0
	st	r17, r3, 4
	st	r18, r3, 8
	st	r30, r3, 12
	st	r11, r3, 16
	st	r10, r3, 20
	st	r15, r3, 24
	st	r14, r3, 28
	st	r9, r3, 32
	st	r5, r3, 36
	st	r2, r3, 40
	cmpwi	cr0, r19, 99
	bne	beq_else.32108
	li	r2, 1
	b	beq_cont.32109
beq_else.32108:
	slwi	r20, r19, 2
	add	r31, r13, r20
	ld	r13, r31, 0
	fld	fr1, r15, 0
	ld	r20, r13, 20
	fld	fr2, r20, 0
	fsub	fr1, fr1, fr2
	fld	fr2, r15, 4
	ld	r20, r13, 20
	fld	fr3, r20, 4
	fsub	fr2, fr2, fr3
	fld	fr3, r15, 8
	ld	r20, r13, 20
	fld	fr4, r20, 8
	fsub	fr3, fr3, fr4
	slwi	r19, r19, 2
	add	r31, r16, r19
	ld	r16, r31, 0
	ld	r19, r13, 4
	cmpwi	cr0, r19, 1
	bne	beq_else.32110
	mflr	r31
	mr	r5, r6
	mr	r2, r13
	mr	r30, r8
	mr	r6, r16
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	b	beq_cont.32111
beq_else.32110:
	cmpwi	cr0, r19, 2
	bne	beq_else.32112
	fld	fr4, r16, 0
	fld	fr5, r0, 44
	fcmp	cr0, fr5, fr4
	blt	le.32114
	beq	le.32114
	li	r6, 1
	b	gt_cont.32115
le.32114:
	li	r6, 0
gt_cont.32115:
	cmpwi	cr0, r6, 0
	bne	beq_else.32116
	li	r2, 0
	b	beq_cont.32117
beq_else.32116:
	fld	fr4, r16, 4
	fmul	fr1, fr4, fr1
	fld	fr4, r16, 8
	fmul	fr2, fr4, fr2
	fadd	fr1, fr1, fr2
	fld	fr2, r16, 12
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r10, 0
	li	r2, 1
beq_cont.32117:
	b	beq_cont.32113
beq_else.32112:
	mflr	r31
	mr	r5, r16
	mr	r2, r13
	mr	r30, r7
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
beq_cont.32113:
beq_cont.32111:
	cmpwi	cr0, r2, 0
	bne	beq_else.32118
	li	r2, 0
	b	beq_cont.32119
beq_else.32118:
	fld	fr1, r0, 108
	ld	r2, r3, 20
	fld	fr2, r2, 0
	fcmp	cr0, fr1, fr2
	blt	le.32120
	beq	le.32120
	li	r5, 1
	b	gt_cont.32121
le.32120:
	li	r5, 0
gt_cont.32121:
	cmpwi	cr0, r5, 0
	bne	beq_else.32122
	li	r2, 0
	b	beq_cont.32123
beq_else.32122:
	ld	r5, r3, 8
	ld	r6, r5, 4
	cmpwi	cr0, r6, -1
	bne	beq_else.32124
	li	r2, 0
	b	beq_cont.32125
beq_else.32124:
	slwi	r6, r6, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	ld	r6, r31, 0
	li	r8, 0
	ld	r30, r3, 0
	mflr	r31
	mr	r5, r6
	mr	r2, r8
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32126
	li	r2, 2
	ld	r5, r3, 8
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	b	beq_cont.32127
beq_else.32126:
	li	r2, 1
beq_cont.32127:
beq_cont.32125:
	cmpwi	cr0, r2, 0
	bne	beq_else.32128
	li	r2, 0
	b	beq_cont.32129
beq_else.32128:
	li	r2, 1
beq_cont.32129:
beq_cont.32123:
beq_cont.32119:
beq_cont.32109:
	cmpwi	cr0, r2, 0
	bne	beq_else.32130
	ld	r2, r3, 40
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 36
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r7, r5, 0
	cmpwi	cr0, r7, -1
	bne	beq_else.32131
	li	r2, 0
	blr
beq_else.32131:
	st	r5, r3, 44
	st	r2, r3, 48
	cmpwi	cr0, r7, 99
	bne	beq_else.32132
	li	r2, 1
	b	beq_cont.32133
beq_else.32132:
	ld	r8, r3, 28
	ld	r9, r3, 24
	ld	r30, r3, 32
	mflr	r31
	mr	r6, r9
	mr	r5, r8
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32134
	li	r2, 0
	b	beq_cont.32135
beq_else.32134:
	fld	fr1, r0, 108
	ld	r2, r3, 20
	fld	fr2, r2, 0
	fcmp	cr0, fr1, fr2
	blt	le.32136
	beq	le.32136
	li	r2, 1
	b	gt_cont.32137
le.32136:
	li	r2, 0
gt_cont.32137:
	cmpwi	cr0, r2, 0
	bne	beq_else.32138
	li	r2, 0
	b	beq_cont.32139
beq_else.32138:
	li	r2, 1
	ld	r5, r3, 44
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32140
	li	r2, 0
	b	beq_cont.32141
beq_else.32140:
	li	r2, 1
beq_cont.32141:
beq_cont.32139:
beq_cont.32135:
beq_cont.32133:
	cmpwi	cr0, r2, 0
	bne	beq_else.32142
	ld	r2, r3, 48
	addi	r2, r2, 1
	ld	r5, r3, 36
	ld	r30, r3, 12
	ld	r29, r30, 0
	ba	r29
beq_else.32142:
	li	r2, 1
	ld	r5, r3, 44
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32143
	ld	r2, r3, 48
	addi	r2, r2, 1
	ld	r5, r3, 36
	ld	r30, r3, 12
	ld	r29, r30, 0
	ba	r29
beq_else.32143:
	li	r2, 1
	blr
beq_else.32130:
	ld	r2, r3, 8
	ld	r5, r2, 4
	cmpwi	cr0, r5, -1
	bne	beq_else.32144
	li	r2, 0
	b	beq_cont.32145
beq_else.32144:
	slwi	r5, r5, 2
	ld	r6, r3, 4
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r6, 0
	ld	r30, r3, 0
	mflr	r31
	mr	r2, r6
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32146
	li	r2, 2
	ld	r5, r3, 8
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	b	beq_cont.32147
beq_else.32146:
	li	r2, 1
beq_cont.32147:
beq_cont.32145:
	cmpwi	cr0, r2, 0
	bne	beq_else.32148
	ld	r2, r3, 40
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 36
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r7, r5, 0
	cmpwi	cr0, r7, -1
	bne	beq_else.32149
	li	r2, 0
	blr
beq_else.32149:
	st	r5, r3, 52
	st	r2, r3, 56
	cmpwi	cr0, r7, 99
	bne	beq_else.32150
	li	r2, 1
	b	beq_cont.32151
beq_else.32150:
	ld	r8, r3, 28
	ld	r9, r3, 24
	ld	r30, r3, 32
	mflr	r31
	mr	r6, r9
	mr	r5, r8
	mr	r2, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32152
	li	r2, 0
	b	beq_cont.32153
beq_else.32152:
	fld	fr1, r0, 108
	ld	r2, r3, 20
	fld	fr2, r2, 0
	fcmp	cr0, fr1, fr2
	blt	le.32154
	beq	le.32154
	li	r2, 1
	b	gt_cont.32155
le.32154:
	li	r2, 0
gt_cont.32155:
	cmpwi	cr0, r2, 0
	bne	beq_else.32156
	li	r2, 0
	b	beq_cont.32157
beq_else.32156:
	li	r2, 1
	ld	r5, r3, 52
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32158
	li	r2, 0
	b	beq_cont.32159
beq_else.32158:
	li	r2, 1
beq_cont.32159:
beq_cont.32157:
beq_cont.32153:
beq_cont.32151:
	cmpwi	cr0, r2, 0
	bne	beq_else.32160
	ld	r2, r3, 56
	addi	r2, r2, 1
	ld	r5, r3, 36
	ld	r30, r3, 12
	ld	r29, r30, 0
	ba	r29
beq_else.32160:
	li	r2, 1
	ld	r5, r3, 52
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32161
	ld	r2, r3, 56
	addi	r2, r2, 1
	ld	r5, r3, 36
	ld	r30, r3, 12
	ld	r29, r30, 0
	ba	r29
beq_else.32161:
	li	r2, 1
	blr
beq_else.32148:
	li	r2, 1
	blr
solve_each_element.3033:
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
	slwi	r17, r2, 2
	add	r31, r5, r17
	ld	r17, r31, 0
	cmpwi	cr0, r17, -1
	bne	beq_else.32162
	blr
beq_else.32162:
	slwi	r18, r17, 2
	add	r31, r12, r18
	ld	r18, r31, 0
	fld	fr1, r8, 0
	ld	r19, r18, 20
	fld	fr2, r19, 0
	fsub	fr1, fr1, fr2
	fld	fr2, r8, 4
	ld	r19, r18, 20
	fld	fr3, r19, 4
	fsub	fr2, fr2, fr3
	fld	fr3, r8, 8
	ld	r19, r18, 20
	fld	fr4, r19, 8
	fsub	fr3, fr3, fr4
	ld	r19, r18, 4
	st	r13, r3, 0
	st	r15, r3, 4
	st	r14, r3, 8
	st	r16, r3, 12
	st	r8, r3, 16
	st	r7, r3, 20
	st	r11, r3, 24
	st	r6, r3, 28
	st	r5, r3, 32
	st	r30, r3, 36
	st	r2, r3, 40
	st	r12, r3, 44
	st	r17, r3, 48
	cmpwi	cr0, r19, 1
	bne	beq_else.32164
	mflr	r31
	mr	r5, r6
	mr	r2, r18
	mr	r30, r10
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	b	beq_cont.32165
beq_else.32164:
	cmpwi	cr0, r19, 2
	bne	beq_else.32166
	ld	r9, r18, 16
	fld	fr4, r6, 0
	fld	fr5, r9, 0
	fmul	fr4, fr4, fr5
	fld	fr5, r6, 4
	fld	fr6, r9, 4
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	fld	fr5, r6, 8
	fld	fr6, r9, 8
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	fld	fr5, r0, 44
	fcmp	cr0, fr4, fr5
	blt	le.32168
	beq	le.32168
	li	r10, 1
	b	gt_cont.32169
le.32168:
	li	r10, 0
gt_cont.32169:
	cmpwi	cr0, r10, 0
	bne	beq_else.32170
	li	r2, 0
	b	beq_cont.32171
beq_else.32170:
	fld	fr5, r9, 0
	fmul	fr1, fr5, fr1
	fld	fr5, r9, 4
	fmul	fr2, fr5, fr2
	fadd	fr1, fr1, fr2
	fld	fr2, r9, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fsub	fr1, fr0, fr1
	fdiv	fr1, fr1, fr4
	fst	fr1, r11, 0
	li	r2, 1
beq_cont.32171:
	b	beq_cont.32167
beq_else.32166:
	mflr	r31
	mr	r5, r6
	mr	r2, r18
	mr	r30, r9
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
beq_cont.32167:
beq_cont.32165:
	cmpwi	cr0, r2, 0
	bne	beq_else.32172
	ld	r2, r3, 48
	slwi	r2, r2, 2
	ld	r5, r3, 44
	add	r31, r5, r2
	ld	r2, r31, 0
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.32173
	blr
beq_else.32173:
	ld	r2, r3, 40
	addi	r2, r2, 1
	ld	r5, r3, 32
	ld	r6, r3, 28
	ld	r30, r3, 36
	ld	r29, r30, 0
	ba	r29
beq_else.32172:
	ld	r5, r3, 24
	fld	fr1, r5, 0
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.32175
	beq	le.32175
	li	r5, 1
	b	gt_cont.32176
le.32175:
	li	r5, 0
gt_cont.32176:
	cmpwi	cr0, r5, 0
	bne	beq_else.32177
	b	beq_cont.32178
beq_else.32177:
	ld	r5, r3, 20
	fld	fr2, r5, 0
	fcmp	cr0, fr2, fr1
	blt	le.32179
	beq	le.32179
	li	r6, 1
	b	gt_cont.32180
le.32179:
	li	r6, 0
gt_cont.32180:
	cmpwi	cr0, r6, 0
	bne	beq_else.32181
	b	beq_cont.32182
beq_else.32181:
	fld	fr2, r0, 104
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
	ld	r7, r3, 32
	ld	r8, r7, 0
	st	r2, r3, 52
	fst	fr4, r3, 56
	fst	fr3, r3, 60
	fst	fr2, r3, 64
	fst	fr1, r3, 68
	cmpwi	cr0, r8, -1
	bne	beq_else.32183
	li	r2, 1
	b	beq_cont.32184
beq_else.32183:
	slwi	r8, r8, 2
	ld	r9, r3, 44
	add	r31, r9, r8
	ld	r8, r31, 0
	mflr	r31
	mr	r2, r8
	fmr	fr1, fr2
	fmr	fr2, fr3
	fmr	fr3, fr4
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	is_outside.3013
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32185
	ld	r5, r3, 32
	ld	r2, r5, 4
	cmpwi	cr0, r2, -1
	bne	beq_else.32187
	li	r2, 1
	b	beq_cont.32188
beq_else.32187:
	slwi	r2, r2, 2
	ld	r6, r3, 44
	add	r31, r6, r2
	ld	r2, r31, 0
	ld	r7, r2, 20
	fld	fr1, r7, 0
	fld	fr2, r3, 64
	fsub	fr1, fr2, fr1
	ld	r7, r2, 20
	fld	fr3, r7, 4
	fld	fr4, r3, 60
	fsub	fr3, fr4, fr3
	ld	r7, r2, 20
	fld	fr5, r7, 8
	fld	fr6, r3, 56
	fsub	fr5, fr6, fr5
	ld	r7, r2, 4
	cmpwi	cr0, r7, 1
	bne	beq_else.32189
	fst	fr5, r3, 72
	fst	fr3, r3, 76
	fst	fr1, r3, 80
	st	r2, r3, 84
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fabs
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r2, r3, 84
	ld	r5, r2, 16
	fld	fr1, r5, 0
	fld	fr2, r3, 80
	fst	fr1, r3, 88
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fabs
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	fld	fr2, r3, 88
	fcmp	cr0, fr2, fr1
	blt	le.32191
	beq	le.32191
	li	r2, 1
	b	gt_cont.32192
le.32191:
	li	r2, 0
gt_cont.32192:
	cmpwi	cr0, r2, 0
	bne	beq_else.32193
	li	r2, 0
	b	beq_cont.32194
beq_else.32193:
	fld	fr1, r3, 76
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fabs
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r2, r3, 84
	ld	r5, r2, 16
	fld	fr1, r5, 4
	fld	fr2, r3, 76
	fst	fr1, r3, 92
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fabs
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	fld	fr2, r3, 92
	fcmp	cr0, fr2, fr1
	blt	le.32195
	beq	le.32195
	li	r2, 1
	b	gt_cont.32196
le.32195:
	li	r2, 0
gt_cont.32196:
	cmpwi	cr0, r2, 0
	bne	beq_else.32197
	li	r2, 0
	b	beq_cont.32198
beq_else.32197:
	fld	fr1, r3, 72
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fabs
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r2, r3, 84
	ld	r5, r2, 16
	fld	fr1, r5, 8
	fld	fr2, r3, 72
	fst	fr1, r3, 96
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fabs
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	fld	fr2, r3, 96
	fcmp	cr0, fr2, fr1
	blt	le.32199
	beq	le.32199
	li	r2, 1
	b	gt_cont.32200
le.32199:
	li	r2, 0
gt_cont.32200:
beq_cont.32198:
beq_cont.32194:
	cmpwi	cr0, r2, 0
	bne	beq_else.32201
	ld	r2, r3, 84
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.32203
	li	r2, 1
	b	beq_cont.32204
beq_else.32203:
	li	r2, 0
beq_cont.32204:
	b	beq_cont.32202
beq_else.32201:
	ld	r2, r3, 84
	ld	r2, r2, 24
beq_cont.32202:
	b	beq_cont.32190
beq_else.32189:
	cmpwi	cr0, r7, 2
	bne	beq_else.32205
	ld	r7, r2, 16
	fld	fr7, r7, 0
	fmul	fr1, fr7, fr1
	fld	fr7, r7, 4
	fmul	fr3, fr7, fr3
	fadd	fr1, fr1, fr3
	fld	fr3, r7, 8
	fmul	fr3, fr3, fr5
	fadd	fr1, fr1, fr3
	ld	r2, r2, 24
	fld	fr3, r0, 44
	fcmp	cr0, fr3, fr1
	blt	le.32207
	beq	le.32207
	li	r7, 1
	b	gt_cont.32208
le.32207:
	li	r7, 0
gt_cont.32208:
	cmpwi	cr0, r2, 0
	bne	beq_else.32209
	mr	r2, r7
	b	beq_cont.32210
beq_else.32209:
	cmpwi	cr0, r7, 0
	bne	beq_else.32211
	li	r2, 1
	b	beq_cont.32212
beq_else.32211:
	li	r2, 0
beq_cont.32212:
beq_cont.32210:
	cmpwi	cr0, r2, 0
	bne	beq_else.32213
	li	r2, 1
	b	beq_cont.32214
beq_else.32213:
	li	r2, 0
beq_cont.32214:
	b	beq_cont.32206
beq_else.32205:
	fst	fr1, r3, 80
	fst	fr5, r3, 72
	fst	fr3, r3, 76
	st	r2, r3, 84
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fsqr
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r2, r3, 84
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 76
	fst	fr1, r3, 100
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_fsqr
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	ld	r2, r3, 84
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 100
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 72
	fst	fr1, r3, 104
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_fsqr
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	ld	r2, r3, 84
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 104
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.32215
	b	beq_cont.32216
beq_else.32215:
	fld	fr2, r3, 72
	fld	fr3, r3, 76
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 80
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.32216:
	ld	r5, r2, 4
	cmpwi	cr0, r5, 3
	bne	beq_else.32217
	fld	fr2, r0, 16
	fsub	fr1, fr1, fr2
	b	beq_cont.32218
beq_else.32217:
beq_cont.32218:
	ld	r2, r2, 24
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32219
	beq	le.32219
	li	r5, 1
	b	gt_cont.32220
le.32219:
	li	r5, 0
gt_cont.32220:
	cmpwi	cr0, r2, 0
	bne	beq_else.32221
	mr	r2, r5
	b	beq_cont.32222
beq_else.32221:
	cmpwi	cr0, r5, 0
	bne	beq_else.32223
	li	r2, 1
	b	beq_cont.32224
beq_else.32223:
	li	r2, 0
beq_cont.32224:
beq_cont.32222:
	cmpwi	cr0, r2, 0
	bne	beq_else.32225
	li	r2, 1
	b	beq_cont.32226
beq_else.32225:
	li	r2, 0
beq_cont.32226:
beq_cont.32206:
beq_cont.32190:
	cmpwi	cr0, r2, 0
	bne	beq_else.32227
	ld	r5, r3, 32
	ld	r2, r5, 8
	cmpwi	cr0, r2, -1
	bne	beq_else.32229
	li	r2, 1
	b	beq_cont.32230
beq_else.32229:
	slwi	r2, r2, 2
	ld	r6, r3, 44
	add	r31, r6, r2
	ld	r2, r31, 0
	fld	fr1, r3, 64
	fld	fr2, r3, 60
	fld	fr3, r3, 56
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	is_outside.3013
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32231
	li	r2, 3
	fld	fr1, r3, 64
	fld	fr2, r3, 60
	fld	fr3, r3, 56
	ld	r5, r3, 32
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	b	beq_cont.32232
beq_else.32231:
	li	r2, 0
beq_cont.32232:
beq_cont.32230:
	b	beq_cont.32228
beq_else.32227:
	li	r2, 0
beq_cont.32228:
beq_cont.32188:
	b	beq_cont.32186
beq_else.32185:
	li	r2, 0
beq_cont.32186:
beq_cont.32184:
	cmpwi	cr0, r2, 0
	bne	beq_else.32233
	b	beq_cont.32234
beq_else.32233:
	ld	r2, r3, 20
	fld	fr1, r3, 68
	fst	fr1, r2, 0
	ld	r2, r3, 8
	fld	fr1, r3, 64
	fst	fr1, r2, 0
	fld	fr1, r3, 60
	fst	fr1, r2, 4
	fld	fr1, r3, 56
	fst	fr1, r2, 8
	ld	r2, r3, 4
	ld	r5, r3, 48
	st	r5, r2, 0
	ld	r2, r3, 0
	ld	r5, r3, 52
	st	r5, r2, 0
beq_cont.32234:
beq_cont.32182:
beq_cont.32178:
	ld	r2, r3, 40
	addi	r2, r2, 1
	ld	r5, r3, 32
	ld	r6, r3, 28
	ld	r30, r3, 36
	ld	r29, r30, 0
	ba	r29
solve_one_or_network.3037:
	ld	r7, r30, 8
	ld	r8, r30, 4
	slwi	r9, r2, 2
	add	r31, r5, r9
	ld	r9, r31, 0
	cmpwi	cr0, r9, -1
	bne	beq_else.32235
	blr
beq_else.32235:
	slwi	r9, r9, 2
	add	r31, r8, r9
	ld	r9, r31, 0
	li	r10, 0
	st	r30, r3, 0
	st	r6, r3, 4
	st	r7, r3, 8
	st	r8, r3, 12
	st	r5, r3, 16
	st	r2, r3, 20
	mflr	r31
	mr	r5, r9
	mr	r2, r10
	mr	r30, r7
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 20
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.32237
	blr
beq_else.32237:
	slwi	r5, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r5
	ld	r5, r31, 0
	li	r8, 0
	ld	r9, r3, 4
	ld	r30, r3, 8
	st	r2, r3, 24
	mflr	r31
	mr	r6, r9
	mr	r2, r8
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 24
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.32239
	blr
beq_else.32239:
	slwi	r5, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r5
	ld	r5, r31, 0
	li	r8, 0
	ld	r9, r3, 4
	ld	r30, r3, 8
	st	r2, r3, 28
	mflr	r31
	mr	r6, r9
	mr	r2, r8
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.32241
	blr
beq_else.32241:
	slwi	r5, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r5
	ld	r5, r31, 0
	li	r8, 0
	ld	r9, r3, 4
	ld	r30, r3, 8
	st	r2, r3, 32
	mflr	r31
	mr	r6, r9
	mr	r2, r8
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 32
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.32243
	blr
beq_else.32243:
	slwi	r5, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r5
	ld	r5, r31, 0
	li	r8, 0
	ld	r9, r3, 4
	ld	r30, r3, 8
	st	r2, r3, 36
	mflr	r31
	mr	r6, r9
	mr	r2, r8
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 36
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.32245
	blr
beq_else.32245:
	slwi	r5, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r5
	ld	r5, r31, 0
	li	r8, 0
	ld	r9, r3, 4
	ld	r30, r3, 8
	st	r2, r3, 40
	mflr	r31
	mr	r6, r9
	mr	r2, r8
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 40
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.32247
	blr
beq_else.32247:
	slwi	r5, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r5
	ld	r5, r31, 0
	li	r8, 0
	ld	r9, r3, 4
	ld	r30, r3, 8
	st	r2, r3, 44
	mflr	r31
	mr	r6, r9
	mr	r2, r8
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.32249
	blr
beq_else.32249:
	slwi	r5, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 4
	ld	r30, r3, 8
	st	r2, r3, 48
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 48
	addi	r2, r2, 1
	ld	r5, r3, 16
	ld	r6, r3, 4
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
trace_or_matrix.3041:
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
	slwi	r17, r2, 2
	add	r31, r5, r17
	ld	r17, r31, 0
	ld	r18, r17, 0
	cmpwi	cr0, r18, -1
	bne	beq_else.32251
	blr
beq_else.32251:
	st	r30, r3, 0
	st	r7, r3, 4
	st	r11, r3, 8
	st	r8, r3, 12
	st	r12, r3, 16
	st	r13, r3, 20
	st	r6, r3, 24
	st	r14, r3, 28
	st	r16, r3, 32
	st	r5, r3, 36
	st	r2, r3, 40
	cmpwi	cr0, r18, 99
	bne	beq_else.32253
	ld	r9, r17, 4
	cmpwi	cr0, r9, -1
	bne	beq_else.32255
	b	beq_cont.32256
beq_else.32255:
	slwi	r9, r9, 2
	add	r31, r16, r9
	ld	r9, r31, 0
	li	r10, 0
	st	r17, r3, 44
	mflr	r31
	mr	r5, r9
	mr	r2, r10
	mr	r30, r14
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32257
	b	beq_cont.32258
beq_else.32257:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32259
	b	beq_cont.32260
beq_else.32259:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32261
	b	beq_cont.32262
beq_else.32261:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	ld	r5, r2, 20
	cmpwi	cr0, r5, -1
	bne	beq_else.32263
	b	beq_cont.32264
beq_else.32263:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	ld	r5, r2, 24
	cmpwi	cr0, r5, -1
	bne	beq_else.32265
	b	beq_cont.32266
beq_else.32265:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	ld	r5, r2, 28
	cmpwi	cr0, r5, -1
	bne	beq_else.32267
	b	beq_cont.32268
beq_else.32267:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	li	r2, 8
	ld	r5, r3, 44
	ld	r6, r3, 24
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
beq_cont.32268:
beq_cont.32266:
beq_cont.32264:
beq_cont.32262:
beq_cont.32260:
beq_cont.32258:
beq_cont.32256:
	b	beq_cont.32254
beq_else.32253:
	slwi	r18, r18, 2
	add	r31, r15, r18
	ld	r15, r31, 0
	fld	fr1, r8, 0
	ld	r18, r15, 20
	fld	fr2, r18, 0
	fsub	fr1, fr1, fr2
	fld	fr2, r8, 4
	ld	r18, r15, 20
	fld	fr3, r18, 4
	fsub	fr2, fr2, fr3
	fld	fr3, r8, 8
	ld	r18, r15, 20
	fld	fr4, r18, 8
	fsub	fr3, fr3, fr4
	ld	r18, r15, 4
	st	r17, r3, 44
	cmpwi	cr0, r18, 1
	bne	beq_else.32269
	mflr	r31
	mr	r5, r6
	mr	r2, r15
	mr	r30, r10
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	b	beq_cont.32270
beq_else.32269:
	cmpwi	cr0, r18, 2
	bne	beq_else.32271
	ld	r9, r15, 16
	fld	fr4, r6, 0
	fld	fr5, r9, 0
	fmul	fr4, fr4, fr5
	fld	fr5, r6, 4
	fld	fr6, r9, 4
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	fld	fr5, r6, 8
	fld	fr6, r9, 8
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	fld	fr5, r0, 44
	fcmp	cr0, fr4, fr5
	blt	le.32273
	beq	le.32273
	li	r10, 1
	b	gt_cont.32274
le.32273:
	li	r10, 0
gt_cont.32274:
	cmpwi	cr0, r10, 0
	bne	beq_else.32275
	li	r2, 0
	b	beq_cont.32276
beq_else.32275:
	fld	fr5, r9, 0
	fmul	fr1, fr5, fr1
	fld	fr5, r9, 4
	fmul	fr2, fr5, fr2
	fadd	fr1, fr1, fr2
	fld	fr2, r9, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fsub	fr1, fr0, fr1
	fdiv	fr1, fr1, fr4
	fst	fr1, r11, 0
	li	r2, 1
beq_cont.32276:
	b	beq_cont.32272
beq_else.32271:
	mflr	r31
	mr	r5, r6
	mr	r2, r15
	mr	r30, r9
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
beq_cont.32272:
beq_cont.32270:
	cmpwi	cr0, r2, 0
	bne	beq_else.32277
	b	beq_cont.32278
beq_else.32277:
	ld	r2, r3, 8
	fld	fr1, r2, 0
	ld	r5, r3, 4
	fld	fr2, r5, 0
	fcmp	cr0, fr2, fr1
	blt	le.32279
	beq	le.32279
	li	r6, 1
	b	gt_cont.32280
le.32279:
	li	r6, 0
gt_cont.32280:
	cmpwi	cr0, r6, 0
	bne	beq_else.32281
	b	beq_cont.32282
beq_else.32281:
	ld	r6, r3, 44
	ld	r7, r6, 4
	cmpwi	cr0, r7, -1
	bne	beq_else.32283
	b	beq_cont.32284
beq_else.32283:
	slwi	r7, r7, 2
	ld	r8, r3, 32
	add	r31, r8, r7
	ld	r7, r31, 0
	li	r9, 0
	ld	r10, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r10
	mr	r5, r7
	mr	r2, r9
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32285
	b	beq_cont.32286
beq_else.32285:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32287
	b	beq_cont.32288
beq_else.32287:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32289
	b	beq_cont.32290
beq_else.32289:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	ld	r5, r2, 20
	cmpwi	cr0, r5, -1
	bne	beq_else.32291
	b	beq_cont.32292
beq_else.32291:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	ld	r5, r2, 24
	cmpwi	cr0, r5, -1
	bne	beq_else.32293
	b	beq_cont.32294
beq_else.32293:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	ld	r5, r2, 28
	cmpwi	cr0, r5, -1
	bne	beq_else.32295
	b	beq_cont.32296
beq_else.32295:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	li	r2, 8
	ld	r5, r3, 44
	ld	r6, r3, 24
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
beq_cont.32296:
beq_cont.32294:
beq_cont.32292:
beq_cont.32290:
beq_cont.32288:
beq_cont.32286:
beq_cont.32284:
beq_cont.32282:
beq_cont.32278:
beq_cont.32254:
	ld	r2, r3, 40
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 36
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r7, r5, 0
	cmpwi	cr0, r7, -1
	bne	beq_else.32297
	blr
beq_else.32297:
	st	r2, r3, 48
	cmpwi	cr0, r7, 99
	bne	beq_else.32299
	ld	r7, r5, 4
	cmpwi	cr0, r7, -1
	bne	beq_else.32301
	b	beq_cont.32302
beq_else.32301:
	slwi	r7, r7, 2
	ld	r8, r3, 32
	add	r31, r8, r7
	ld	r7, r31, 0
	li	r9, 0
	ld	r10, r3, 24
	ld	r30, r3, 28
	st	r5, r3, 52
	mflr	r31
	mr	r6, r10
	mr	r5, r7
	mr	r2, r9
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 52
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32303
	b	beq_cont.32304
beq_else.32303:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 52
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32305
	b	beq_cont.32306
beq_else.32305:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 52
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32307
	b	beq_cont.32308
beq_else.32307:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 52
	ld	r5, r2, 20
	cmpwi	cr0, r5, -1
	bne	beq_else.32309
	b	beq_cont.32310
beq_else.32309:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 52
	ld	r5, r2, 24
	cmpwi	cr0, r5, -1
	bne	beq_else.32311
	b	beq_cont.32312
beq_else.32311:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r6, 0
	ld	r7, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r2, r6
	mr	r6, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	li	r2, 7
	ld	r5, r3, 52
	ld	r6, r3, 24
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
beq_cont.32312:
beq_cont.32310:
beq_cont.32308:
beq_cont.32306:
beq_cont.32304:
beq_cont.32302:
	b	beq_cont.32300
beq_else.32299:
	ld	r8, r3, 24
	ld	r9, r3, 12
	ld	r30, r3, 16
	st	r5, r3, 52
	mflr	r31
	mr	r6, r9
	mr	r5, r8
	mr	r2, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32313
	b	beq_cont.32314
beq_else.32313:
	ld	r2, r3, 8
	fld	fr1, r2, 0
	ld	r2, r3, 4
	fld	fr2, r2, 0
	fcmp	cr0, fr2, fr1
	blt	le.32315
	beq	le.32315
	li	r2, 1
	b	gt_cont.32316
le.32315:
	li	r2, 0
gt_cont.32316:
	cmpwi	cr0, r2, 0
	bne	beq_else.32317
	b	beq_cont.32318
beq_else.32317:
	ld	r2, r3, 52
	ld	r5, r2, 4
	cmpwi	cr0, r5, -1
	bne	beq_else.32319
	b	beq_cont.32320
beq_else.32319:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 52
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32321
	b	beq_cont.32322
beq_else.32321:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 52
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32323
	b	beq_cont.32324
beq_else.32323:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 52
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32325
	b	beq_cont.32326
beq_else.32325:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 52
	ld	r5, r2, 20
	cmpwi	cr0, r5, -1
	bne	beq_else.32327
	b	beq_cont.32328
beq_else.32327:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 52
	ld	r5, r2, 24
	cmpwi	cr0, r5, -1
	bne	beq_else.32329
	b	beq_cont.32330
beq_else.32329:
	slwi	r5, r5, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r6, 0
	ld	r7, r3, 24
	ld	r30, r3, 28
	mflr	r31
	mr	r2, r6
	mr	r6, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	li	r2, 7
	ld	r5, r3, 52
	ld	r6, r3, 24
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
beq_cont.32330:
beq_cont.32328:
beq_cont.32326:
beq_cont.32324:
beq_cont.32322:
beq_cont.32320:
beq_cont.32318:
beq_cont.32314:
beq_cont.32300:
	ld	r2, r3, 48
	addi	r2, r2, 1
	ld	r5, r3, 36
	ld	r6, r3, 24
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
solve_each_element_fast.3047:
	ld	r7, r30, 36
	ld	r8, r30, 32
	ld	r9, r30, 28
	ld	r10, r30, 24
	ld	r11, r30, 20
	ld	r12, r30, 16
	ld	r13, r30, 12
	ld	r14, r30, 8
	ld	r15, r30, 4
	ld	r16, r6, 0
	slwi	r17, r2, 2
	add	r31, r5, r17
	ld	r17, r31, 0
	cmpwi	cr0, r17, -1
	bne	beq_else.32331
	blr
beq_else.32331:
	slwi	r18, r17, 2
	add	r31, r11, r18
	ld	r18, r31, 0
	ld	r19, r18, 40
	fld	fr1, r19, 0
	fld	fr2, r19, 4
	fld	fr3, r19, 8
	ld	r20, r6, 4
	slwi	r21, r17, 2
	add	r31, r20, r21
	ld	r20, r31, 0
	ld	r21, r18, 4
	st	r12, r3, 0
	st	r14, r3, 4
	st	r13, r3, 8
	st	r15, r3, 12
	st	r8, r3, 16
	st	r16, r3, 20
	st	r7, r3, 24
	st	r10, r3, 28
	st	r6, r3, 32
	st	r5, r3, 36
	st	r30, r3, 40
	st	r2, r3, 44
	st	r11, r3, 48
	st	r17, r3, 52
	cmpwi	cr0, r21, 1
	bne	beq_else.32333
	ld	r19, r6, 0
	mflr	r31
	mr	r6, r20
	mr	r5, r19
	mr	r2, r18
	mr	r30, r9
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	b	beq_cont.32334
beq_else.32333:
	cmpwi	cr0, r21, 2
	bne	beq_else.32335
	fld	fr1, r20, 0
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32337
	beq	le.32337
	li	r9, 1
	b	gt_cont.32338
le.32337:
	li	r9, 0
gt_cont.32338:
	cmpwi	cr0, r9, 0
	bne	beq_else.32339
	li	r2, 0
	b	beq_cont.32340
beq_else.32339:
	fld	fr1, r20, 0
	fld	fr2, r19, 12
	fmul	fr1, fr1, fr2
	fst	fr1, r10, 0
	li	r2, 1
beq_cont.32340:
	b	beq_cont.32336
beq_else.32335:
	fld	fr4, r20, 0
	fld	fr5, r0, 44
	fcmp	cr0, fr4, fr5
	bne	beq_else.32341
	li	r9, 1
	b	beq_cont.32342
beq_else.32341:
	li	r9, 0
beq_cont.32342:
	cmpwi	cr0, r9, 0
	bne	beq_else.32343
	fld	fr5, r20, 4
	fmul	fr1, fr5, fr1
	fld	fr5, r20, 8
	fmul	fr2, fr5, fr2
	fadd	fr1, fr1, fr2
	fld	fr2, r20, 12
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r19, 12
	st	r20, r3, 56
	fst	fr1, r3, 60
	st	r18, r3, 64
	fst	fr2, r3, 68
	fst	fr4, r3, 72
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_fsqr
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 68
	fld	fr3, r3, 72
	fmul	fr2, fr3, fr2
	fsub	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.32345
	beq	le.32345
	li	r2, 1
	b	gt_cont.32346
le.32345:
	li	r2, 0
gt_cont.32346:
	cmpwi	cr0, r2, 0
	bne	beq_else.32347
	li	r2, 0
	b	beq_cont.32348
beq_else.32347:
	ld	r2, r3, 64
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.32349
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_sqrt
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 60
	fsub	fr1, fr2, fr1
	ld	r2, r3, 56
	fld	fr2, r2, 16
	fmul	fr1, fr1, fr2
	ld	r2, r3, 28
	fst	fr1, r2, 0
	b	beq_cont.32350
beq_else.32349:
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_sqrt
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 60
	fadd	fr1, fr2, fr1
	ld	r2, r3, 56
	fld	fr2, r2, 16
	fmul	fr1, fr1, fr2
	ld	r2, r3, 28
	fst	fr1, r2, 0
beq_cont.32350:
	li	r2, 1
beq_cont.32348:
	b	beq_cont.32344
beq_else.32343:
	li	r2, 0
beq_cont.32344:
beq_cont.32336:
beq_cont.32334:
	cmpwi	cr0, r2, 0
	bne	beq_else.32351
	ld	r2, r3, 52
	slwi	r2, r2, 2
	ld	r5, r3, 48
	add	r31, r5, r2
	ld	r2, r31, 0
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.32352
	blr
beq_else.32352:
	ld	r2, r3, 44
	addi	r2, r2, 1
	ld	r5, r3, 36
	ld	r6, r3, 32
	ld	r30, r3, 40
	ld	r29, r30, 0
	ba	r29
beq_else.32351:
	ld	r5, r3, 28
	fld	fr1, r5, 0
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.32354
	beq	le.32354
	li	r5, 1
	b	gt_cont.32355
le.32354:
	li	r5, 0
gt_cont.32355:
	cmpwi	cr0, r5, 0
	bne	beq_else.32356
	b	beq_cont.32357
beq_else.32356:
	ld	r5, r3, 24
	fld	fr2, r5, 0
	fcmp	cr0, fr2, fr1
	blt	le.32358
	beq	le.32358
	li	r6, 1
	b	gt_cont.32359
le.32358:
	li	r6, 0
gt_cont.32359:
	cmpwi	cr0, r6, 0
	bne	beq_else.32360
	b	beq_cont.32361
beq_else.32360:
	fld	fr2, r0, 104
	fadd	fr1, fr1, fr2
	ld	r6, r3, 20
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
	ld	r6, r3, 36
	ld	r7, r6, 0
	st	r2, r3, 76
	fst	fr4, r3, 80
	fst	fr3, r3, 84
	fst	fr2, r3, 88
	fst	fr1, r3, 92
	cmpwi	cr0, r7, -1
	bne	beq_else.32362
	li	r2, 1
	b	beq_cont.32363
beq_else.32362:
	slwi	r7, r7, 2
	ld	r8, r3, 48
	add	r31, r8, r7
	ld	r7, r31, 0
	mflr	r31
	mr	r2, r7
	fmr	fr1, fr2
	fmr	fr2, fr3
	fmr	fr3, fr4
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	is_outside.3013
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32364
	ld	r5, r3, 36
	ld	r2, r5, 4
	cmpwi	cr0, r2, -1
	bne	beq_else.32366
	li	r2, 1
	b	beq_cont.32367
beq_else.32366:
	slwi	r2, r2, 2
	ld	r6, r3, 48
	add	r31, r6, r2
	ld	r2, r31, 0
	ld	r7, r2, 20
	fld	fr1, r7, 0
	fld	fr2, r3, 88
	fsub	fr1, fr2, fr1
	ld	r7, r2, 20
	fld	fr3, r7, 4
	fld	fr4, r3, 84
	fsub	fr3, fr4, fr3
	ld	r7, r2, 20
	fld	fr5, r7, 8
	fld	fr6, r3, 80
	fsub	fr5, fr6, fr5
	ld	r7, r2, 4
	cmpwi	cr0, r7, 1
	bne	beq_else.32368
	fst	fr5, r3, 96
	fst	fr3, r3, 100
	fst	fr1, r3, 104
	st	r2, r3, 108
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_fabs
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	ld	r2, r3, 108
	ld	r5, r2, 16
	fld	fr1, r5, 0
	fld	fr2, r3, 104
	fst	fr1, r3, 112
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_fabs
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	fld	fr2, r3, 112
	fcmp	cr0, fr2, fr1
	blt	le.32370
	beq	le.32370
	li	r2, 1
	b	gt_cont.32371
le.32370:
	li	r2, 0
gt_cont.32371:
	cmpwi	cr0, r2, 0
	bne	beq_else.32372
	li	r2, 0
	b	beq_cont.32373
beq_else.32372:
	fld	fr1, r3, 100
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_fabs
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	ld	r2, r3, 108
	ld	r5, r2, 16
	fld	fr1, r5, 4
	fld	fr2, r3, 100
	fst	fr1, r3, 116
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_fabs
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	fld	fr2, r3, 116
	fcmp	cr0, fr2, fr1
	blt	le.32374
	beq	le.32374
	li	r2, 1
	b	gt_cont.32375
le.32374:
	li	r2, 0
gt_cont.32375:
	cmpwi	cr0, r2, 0
	bne	beq_else.32376
	li	r2, 0
	b	beq_cont.32377
beq_else.32376:
	fld	fr1, r3, 96
	mflr	r31
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_fabs
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	ld	r2, r3, 108
	ld	r5, r2, 16
	fld	fr1, r5, 8
	fld	fr2, r3, 96
	fst	fr1, r3, 120
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_fabs
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	fld	fr2, r3, 120
	fcmp	cr0, fr2, fr1
	blt	le.32378
	beq	le.32378
	li	r2, 1
	b	gt_cont.32379
le.32378:
	li	r2, 0
gt_cont.32379:
beq_cont.32377:
beq_cont.32373:
	cmpwi	cr0, r2, 0
	bne	beq_else.32380
	ld	r2, r3, 108
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.32382
	li	r2, 1
	b	beq_cont.32383
beq_else.32382:
	li	r2, 0
beq_cont.32383:
	b	beq_cont.32381
beq_else.32380:
	ld	r2, r3, 108
	ld	r2, r2, 24
beq_cont.32381:
	b	beq_cont.32369
beq_else.32368:
	cmpwi	cr0, r7, 2
	bne	beq_else.32384
	ld	r7, r2, 16
	fld	fr7, r7, 0
	fmul	fr1, fr7, fr1
	fld	fr7, r7, 4
	fmul	fr3, fr7, fr3
	fadd	fr1, fr1, fr3
	fld	fr3, r7, 8
	fmul	fr3, fr3, fr5
	fadd	fr1, fr1, fr3
	ld	r2, r2, 24
	fld	fr3, r0, 44
	fcmp	cr0, fr3, fr1
	blt	le.32386
	beq	le.32386
	li	r7, 1
	b	gt_cont.32387
le.32386:
	li	r7, 0
gt_cont.32387:
	cmpwi	cr0, r2, 0
	bne	beq_else.32388
	mr	r2, r7
	b	beq_cont.32389
beq_else.32388:
	cmpwi	cr0, r7, 0
	bne	beq_else.32390
	li	r2, 1
	b	beq_cont.32391
beq_else.32390:
	li	r2, 0
beq_cont.32391:
beq_cont.32389:
	cmpwi	cr0, r2, 0
	bne	beq_else.32392
	li	r2, 1
	b	beq_cont.32393
beq_else.32392:
	li	r2, 0
beq_cont.32393:
	b	beq_cont.32385
beq_else.32384:
	fst	fr1, r3, 104
	fst	fr5, r3, 96
	fst	fr3, r3, 100
	st	r2, r3, 108
	mflr	r31
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_fsqr
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	ld	r2, r3, 108
	ld	r5, r2, 16
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 100
	fst	fr1, r3, 124
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_fsqr
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r2, r3, 108
	ld	r5, r2, 16
	fld	fr2, r5, 4
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 124
	fadd	fr1, fr2, fr1
	fld	fr2, r3, 96
	fst	fr1, r3, 128
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_fsqr
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r2, r3, 108
	ld	r5, r2, 16
	fld	fr2, r5, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 128
	fadd	fr1, fr2, fr1
	ld	r5, r2, 12
	cmpwi	cr0, r5, 0
	bne	beq_else.32394
	b	beq_cont.32395
beq_else.32394:
	fld	fr2, r3, 96
	fld	fr3, r3, 100
	fmul	fr4, fr3, fr2
	ld	r5, r2, 36
	fld	fr5, r5, 0
	fmul	fr4, fr4, fr5
	fadd	fr1, fr1, fr4
	fld	fr4, r3, 104
	fmul	fr2, fr2, fr4
	ld	r5, r2, 36
	fld	fr5, r5, 4
	fmul	fr2, fr2, fr5
	fadd	fr1, fr1, fr2
	fmul	fr2, fr4, fr3
	ld	r5, r2, 36
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
beq_cont.32395:
	ld	r5, r2, 4
	cmpwi	cr0, r5, 3
	bne	beq_else.32396
	fld	fr2, r0, 16
	fsub	fr1, fr1, fr2
	b	beq_cont.32397
beq_else.32396:
beq_cont.32397:
	ld	r2, r2, 24
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32398
	beq	le.32398
	li	r5, 1
	b	gt_cont.32399
le.32398:
	li	r5, 0
gt_cont.32399:
	cmpwi	cr0, r2, 0
	bne	beq_else.32400
	mr	r2, r5
	b	beq_cont.32401
beq_else.32400:
	cmpwi	cr0, r5, 0
	bne	beq_else.32402
	li	r2, 1
	b	beq_cont.32403
beq_else.32402:
	li	r2, 0
beq_cont.32403:
beq_cont.32401:
	cmpwi	cr0, r2, 0
	bne	beq_else.32404
	li	r2, 1
	b	beq_cont.32405
beq_else.32404:
	li	r2, 0
beq_cont.32405:
beq_cont.32385:
beq_cont.32369:
	cmpwi	cr0, r2, 0
	bne	beq_else.32406
	ld	r5, r3, 36
	ld	r2, r5, 8
	cmpwi	cr0, r2, -1
	bne	beq_else.32408
	li	r2, 1
	b	beq_cont.32409
beq_else.32408:
	slwi	r2, r2, 2
	ld	r6, r3, 48
	add	r31, r6, r2
	ld	r2, r31, 0
	fld	fr1, r3, 88
	fld	fr2, r3, 84
	fld	fr3, r3, 80
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	is_outside.3013
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32410
	li	r2, 3
	fld	fr1, r3, 88
	fld	fr2, r3, 84
	fld	fr3, r3, 80
	ld	r5, r3, 36
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	b	beq_cont.32411
beq_else.32410:
	li	r2, 0
beq_cont.32411:
beq_cont.32409:
	b	beq_cont.32407
beq_else.32406:
	li	r2, 0
beq_cont.32407:
beq_cont.32367:
	b	beq_cont.32365
beq_else.32364:
	li	r2, 0
beq_cont.32365:
beq_cont.32363:
	cmpwi	cr0, r2, 0
	bne	beq_else.32412
	b	beq_cont.32413
beq_else.32412:
	ld	r2, r3, 24
	fld	fr1, r3, 92
	fst	fr1, r2, 0
	ld	r2, r3, 8
	fld	fr1, r3, 88
	fst	fr1, r2, 0
	fld	fr1, r3, 84
	fst	fr1, r2, 4
	fld	fr1, r3, 80
	fst	fr1, r2, 8
	ld	r2, r3, 4
	ld	r5, r3, 52
	st	r5, r2, 0
	ld	r2, r3, 0
	ld	r5, r3, 76
	st	r5, r2, 0
beq_cont.32413:
beq_cont.32361:
beq_cont.32357:
	ld	r2, r3, 44
	addi	r2, r2, 1
	ld	r5, r3, 36
	ld	r6, r3, 32
	ld	r30, r3, 40
	ld	r29, r30, 0
	ba	r29
solve_one_or_network_fast.3051:
	ld	r7, r30, 8
	ld	r8, r30, 4
	slwi	r9, r2, 2
	add	r31, r5, r9
	ld	r9, r31, 0
	cmpwi	cr0, r9, -1
	bne	beq_else.32414
	blr
beq_else.32414:
	slwi	r9, r9, 2
	add	r31, r8, r9
	ld	r9, r31, 0
	li	r10, 0
	st	r30, r3, 0
	st	r6, r3, 4
	st	r7, r3, 8
	st	r8, r3, 12
	st	r5, r3, 16
	st	r2, r3, 20
	mflr	r31
	mr	r5, r9
	mr	r2, r10
	mr	r30, r7
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 20
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.32416
	blr
beq_else.32416:
	slwi	r5, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r5
	ld	r5, r31, 0
	li	r8, 0
	ld	r9, r3, 4
	ld	r30, r3, 8
	st	r2, r3, 24
	mflr	r31
	mr	r6, r9
	mr	r2, r8
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 24
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.32418
	blr
beq_else.32418:
	slwi	r5, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r5
	ld	r5, r31, 0
	li	r8, 0
	ld	r9, r3, 4
	ld	r30, r3, 8
	st	r2, r3, 28
	mflr	r31
	mr	r6, r9
	mr	r2, r8
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 28
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.32420
	blr
beq_else.32420:
	slwi	r5, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r5
	ld	r5, r31, 0
	li	r8, 0
	ld	r9, r3, 4
	ld	r30, r3, 8
	st	r2, r3, 32
	mflr	r31
	mr	r6, r9
	mr	r2, r8
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 32
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.32422
	blr
beq_else.32422:
	slwi	r5, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r5
	ld	r5, r31, 0
	li	r8, 0
	ld	r9, r3, 4
	ld	r30, r3, 8
	st	r2, r3, 36
	mflr	r31
	mr	r6, r9
	mr	r2, r8
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 36
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.32424
	blr
beq_else.32424:
	slwi	r5, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r5
	ld	r5, r31, 0
	li	r8, 0
	ld	r9, r3, 4
	ld	r30, r3, 8
	st	r2, r3, 40
	mflr	r31
	mr	r6, r9
	mr	r2, r8
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 40
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.32426
	blr
beq_else.32426:
	slwi	r5, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r5
	ld	r5, r31, 0
	li	r8, 0
	ld	r9, r3, 4
	ld	r30, r3, 8
	st	r2, r3, 44
	mflr	r31
	mr	r6, r9
	mr	r2, r8
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	cmpwi	cr0, r5, -1
	bne	beq_else.32428
	blr
beq_else.32428:
	slwi	r5, r5, 2
	ld	r7, r3, 12
	add	r31, r7, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 4
	ld	r30, r3, 8
	st	r2, r3, 48
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 48
	addi	r2, r2, 1
	ld	r5, r3, 16
	ld	r6, r3, 4
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
trace_or_matrix_fast.3055:
	ld	r7, r30, 32
	ld	r8, r30, 28
	ld	r9, r30, 24
	ld	r10, r30, 20
	ld	r11, r30, 16
	ld	r12, r30, 12
	ld	r13, r30, 8
	ld	r14, r30, 4
	slwi	r15, r2, 2
	add	r31, r5, r15
	ld	r15, r31, 0
	ld	r16, r15, 0
	cmpwi	cr0, r16, -1
	bne	beq_else.32430
	blr
beq_else.32430:
	st	r30, r3, 0
	st	r7, r3, 4
	st	r10, r3, 8
	st	r9, r3, 12
	st	r11, r3, 16
	st	r6, r3, 20
	st	r12, r3, 24
	st	r14, r3, 28
	st	r5, r3, 32
	st	r2, r3, 36
	cmpwi	cr0, r16, 99
	bne	beq_else.32432
	ld	r8, r15, 4
	cmpwi	cr0, r8, -1
	bne	beq_else.32434
	b	beq_cont.32435
beq_else.32434:
	slwi	r8, r8, 2
	add	r31, r14, r8
	ld	r8, r31, 0
	li	r13, 0
	st	r15, r3, 40
	mflr	r31
	mr	r5, r8
	mr	r2, r13
	mr	r30, r12
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32436
	b	beq_cont.32437
beq_else.32436:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32438
	b	beq_cont.32439
beq_else.32438:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32440
	b	beq_cont.32441
beq_else.32440:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 20
	cmpwi	cr0, r5, -1
	bne	beq_else.32442
	b	beq_cont.32443
beq_else.32442:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 24
	cmpwi	cr0, r5, -1
	bne	beq_else.32444
	b	beq_cont.32445
beq_else.32444:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 28
	cmpwi	cr0, r5, -1
	bne	beq_else.32446
	b	beq_cont.32447
beq_else.32446:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	li	r2, 8
	ld	r5, r3, 40
	ld	r6, r3, 20
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
beq_cont.32447:
beq_cont.32445:
beq_cont.32443:
beq_cont.32441:
beq_cont.32439:
beq_cont.32437:
beq_cont.32435:
	b	beq_cont.32433
beq_else.32432:
	slwi	r17, r16, 2
	add	r31, r13, r17
	ld	r13, r31, 0
	ld	r17, r13, 40
	fld	fr1, r17, 0
	fld	fr2, r17, 4
	fld	fr3, r17, 8
	ld	r18, r6, 4
	slwi	r16, r16, 2
	add	r31, r18, r16
	ld	r16, r31, 0
	ld	r18, r13, 4
	st	r15, r3, 40
	cmpwi	cr0, r18, 1
	bne	beq_else.32448
	ld	r17, r6, 0
	mflr	r31
	mr	r6, r16
	mr	r5, r17
	mr	r2, r13
	mr	r30, r8
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	b	beq_cont.32449
beq_else.32448:
	cmpwi	cr0, r18, 2
	bne	beq_else.32450
	fld	fr1, r16, 0
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32452
	beq	le.32452
	li	r8, 1
	b	gt_cont.32453
le.32452:
	li	r8, 0
gt_cont.32453:
	cmpwi	cr0, r8, 0
	bne	beq_else.32454
	li	r2, 0
	b	beq_cont.32455
beq_else.32454:
	fld	fr1, r16, 0
	fld	fr2, r17, 12
	fmul	fr1, fr1, fr2
	fst	fr1, r10, 0
	li	r2, 1
beq_cont.32455:
	b	beq_cont.32451
beq_else.32450:
	fld	fr4, r16, 0
	fld	fr5, r0, 44
	fcmp	cr0, fr4, fr5
	bne	beq_else.32456
	li	r8, 1
	b	beq_cont.32457
beq_else.32456:
	li	r8, 0
beq_cont.32457:
	cmpwi	cr0, r8, 0
	bne	beq_else.32458
	fld	fr5, r16, 4
	fmul	fr1, fr5, fr1
	fld	fr5, r16, 8
	fmul	fr2, fr5, fr2
	fadd	fr1, fr1, fr2
	fld	fr2, r16, 12
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r17, 12
	st	r16, r3, 44
	fst	fr1, r3, 48
	st	r13, r3, 52
	fst	fr2, r3, 56
	fst	fr4, r3, 60
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_fsqr
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 56
	fld	fr3, r3, 60
	fmul	fr2, fr3, fr2
	fsub	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.32460
	beq	le.32460
	li	r2, 1
	b	gt_cont.32461
le.32460:
	li	r2, 0
gt_cont.32461:
	cmpwi	cr0, r2, 0
	bne	beq_else.32462
	li	r2, 0
	b	beq_cont.32463
beq_else.32462:
	ld	r2, r3, 52
	ld	r2, r2, 24
	cmpwi	cr0, r2, 0
	bne	beq_else.32464
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_sqrt
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 48
	fsub	fr1, fr2, fr1
	ld	r2, r3, 44
	fld	fr2, r2, 16
	fmul	fr1, fr1, fr2
	ld	r2, r3, 8
	fst	fr1, r2, 0
	b	beq_cont.32465
beq_else.32464:
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_sqrt
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 48
	fadd	fr1, fr2, fr1
	ld	r2, r3, 44
	fld	fr2, r2, 16
	fmul	fr1, fr1, fr2
	ld	r2, r3, 8
	fst	fr1, r2, 0
beq_cont.32465:
	li	r2, 1
beq_cont.32463:
	b	beq_cont.32459
beq_else.32458:
	li	r2, 0
beq_cont.32459:
beq_cont.32451:
beq_cont.32449:
	cmpwi	cr0, r2, 0
	bne	beq_else.32466
	b	beq_cont.32467
beq_else.32466:
	ld	r2, r3, 8
	fld	fr1, r2, 0
	ld	r5, r3, 4
	fld	fr2, r5, 0
	fcmp	cr0, fr2, fr1
	blt	le.32468
	beq	le.32468
	li	r6, 1
	b	gt_cont.32469
le.32468:
	li	r6, 0
gt_cont.32469:
	cmpwi	cr0, r6, 0
	bne	beq_else.32470
	b	beq_cont.32471
beq_else.32470:
	ld	r6, r3, 40
	ld	r7, r6, 4
	cmpwi	cr0, r7, -1
	bne	beq_else.32472
	b	beq_cont.32473
beq_else.32472:
	slwi	r7, r7, 2
	ld	r8, r3, 28
	add	r31, r8, r7
	ld	r7, r31, 0
	li	r9, 0
	ld	r10, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r10
	mr	r5, r7
	mr	r2, r9
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32474
	b	beq_cont.32475
beq_else.32474:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32476
	b	beq_cont.32477
beq_else.32476:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32478
	b	beq_cont.32479
beq_else.32478:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 20
	cmpwi	cr0, r5, -1
	bne	beq_else.32480
	b	beq_cont.32481
beq_else.32480:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 24
	cmpwi	cr0, r5, -1
	bne	beq_else.32482
	b	beq_cont.32483
beq_else.32482:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 40
	ld	r5, r2, 28
	cmpwi	cr0, r5, -1
	bne	beq_else.32484
	b	beq_cont.32485
beq_else.32484:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	li	r2, 8
	ld	r5, r3, 40
	ld	r6, r3, 20
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
beq_cont.32485:
beq_cont.32483:
beq_cont.32481:
beq_cont.32479:
beq_cont.32477:
beq_cont.32475:
beq_cont.32473:
beq_cont.32471:
beq_cont.32467:
beq_cont.32433:
	ld	r2, r3, 36
	addi	r2, r2, 1
	slwi	r5, r2, 2
	ld	r6, r3, 32
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r7, r5, 0
	cmpwi	cr0, r7, -1
	bne	beq_else.32486
	blr
beq_else.32486:
	st	r2, r3, 64
	cmpwi	cr0, r7, 99
	bne	beq_else.32488
	ld	r7, r5, 4
	cmpwi	cr0, r7, -1
	bne	beq_else.32490
	b	beq_cont.32491
beq_else.32490:
	slwi	r7, r7, 2
	ld	r8, r3, 28
	add	r31, r8, r7
	ld	r7, r31, 0
	li	r9, 0
	ld	r10, r3, 20
	ld	r30, r3, 24
	st	r5, r3, 68
	mflr	r31
	mr	r6, r10
	mr	r5, r7
	mr	r2, r9
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 68
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32492
	b	beq_cont.32493
beq_else.32492:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 68
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32494
	b	beq_cont.32495
beq_else.32494:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 68
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32496
	b	beq_cont.32497
beq_else.32496:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 68
	ld	r5, r2, 20
	cmpwi	cr0, r5, -1
	bne	beq_else.32498
	b	beq_cont.32499
beq_else.32498:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 68
	ld	r5, r2, 24
	cmpwi	cr0, r5, -1
	bne	beq_else.32500
	b	beq_cont.32501
beq_else.32500:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r6, 0
	ld	r7, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r2, r6
	mr	r6, r7
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	li	r2, 7
	ld	r5, r3, 68
	ld	r6, r3, 20
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
beq_cont.32501:
beq_cont.32499:
beq_cont.32497:
beq_cont.32495:
beq_cont.32493:
beq_cont.32491:
	b	beq_cont.32489
beq_else.32488:
	ld	r8, r3, 20
	ld	r30, r3, 12
	st	r5, r3, 68
	mflr	r31
	mr	r5, r8
	mr	r2, r7
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32502
	b	beq_cont.32503
beq_else.32502:
	ld	r2, r3, 8
	fld	fr1, r2, 0
	ld	r2, r3, 4
	fld	fr2, r2, 0
	fcmp	cr0, fr2, fr1
	blt	le.32504
	beq	le.32504
	li	r2, 1
	b	gt_cont.32505
le.32504:
	li	r2, 0
gt_cont.32505:
	cmpwi	cr0, r2, 0
	bne	beq_else.32506
	b	beq_cont.32507
beq_else.32506:
	ld	r2, r3, 68
	ld	r5, r2, 4
	cmpwi	cr0, r5, -1
	bne	beq_else.32508
	b	beq_cont.32509
beq_else.32508:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 68
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32510
	b	beq_cont.32511
beq_else.32510:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 68
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32512
	b	beq_cont.32513
beq_else.32512:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 68
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32514
	b	beq_cont.32515
beq_else.32514:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 68
	ld	r5, r2, 20
	cmpwi	cr0, r5, -1
	bne	beq_else.32516
	b	beq_cont.32517
beq_else.32516:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 68
	ld	r5, r2, 24
	cmpwi	cr0, r5, -1
	bne	beq_else.32518
	b	beq_cont.32519
beq_else.32518:
	slwi	r5, r5, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r6, 0
	ld	r7, r3, 20
	ld	r30, r3, 24
	mflr	r31
	mr	r2, r6
	mr	r6, r7
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	li	r2, 7
	ld	r5, r3, 68
	ld	r6, r3, 20
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
beq_cont.32519:
beq_cont.32517:
beq_cont.32515:
beq_cont.32513:
beq_cont.32511:
beq_cont.32509:
beq_cont.32507:
beq_cont.32503:
beq_cont.32489:
	ld	r2, r3, 64
	addi	r2, r2, 1
	ld	r5, r3, 32
	ld	r6, r3, 20
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
get_nvector_second.3065:
	ld	r5, r30, 8
	ld	r6, r30, 4
	fld	fr1, r6, 0
	ld	r7, r2, 20
	fld	fr2, r7, 0
	fsub	fr1, fr1, fr2
	fld	fr2, r6, 4
	ld	r7, r2, 20
	fld	fr3, r7, 4
	fsub	fr2, fr2, fr3
	fld	fr3, r6, 8
	ld	r6, r2, 20
	fld	fr4, r6, 8
	fsub	fr3, fr3, fr4
	ld	r6, r2, 16
	fld	fr4, r6, 0
	fmul	fr4, fr1, fr4
	ld	r6, r2, 16
	fld	fr5, r6, 4
	fmul	fr5, fr2, fr5
	ld	r6, r2, 16
	fld	fr6, r6, 8
	fmul	fr6, fr3, fr6
	ld	r6, r2, 12
	st	r5, r3, 0
	st	r2, r3, 4
	cmpwi	cr0, r6, 0
	bne	beq_else.32520
	fst	fr4, r5, 0
	fst	fr5, r5, 4
	fst	fr6, r5, 8
	b	beq_cont.32521
beq_else.32520:
	ld	r6, r2, 36
	fld	fr7, r6, 8
	fmul	fr7, fr2, fr7
	ld	r6, r2, 36
	fld	fr8, r6, 4
	fmul	fr8, fr3, fr8
	fadd	fr7, fr7, fr8
	fst	fr6, r3, 8
	fst	fr2, r3, 12
	fst	fr5, r3, 16
	fst	fr3, r3, 20
	fst	fr1, r3, 24
	fst	fr4, r3, 28
	mflr	r31
	fmr	fr1, fr7
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fhalf
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 28
	fadd	fr1, fr2, fr1
	ld	r2, r3, 0
	fst	fr1, r2, 0
	ld	r5, r3, 4
	ld	r6, r5, 36
	fld	fr1, r6, 8
	fld	fr2, r3, 24
	fmul	fr1, fr2, fr1
	ld	r6, r5, 36
	fld	fr3, r6, 0
	fld	fr4, r3, 20
	fmul	fr3, fr4, fr3
	fadd	fr1, fr1, fr3
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fhalf
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 16
	fadd	fr1, fr2, fr1
	ld	r2, r3, 0
	fst	fr1, r2, 4
	ld	r5, r3, 4
	ld	r6, r5, 36
	fld	fr1, r6, 4
	fld	fr2, r3, 24
	fmul	fr1, fr2, fr1
	ld	r6, r5, 36
	fld	fr2, r6, 0
	fld	fr3, r3, 12
	fmul	fr2, fr3, fr2
	fadd	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fhalf
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 8
	fadd	fr1, fr2, fr1
	ld	r2, r3, 0
	fst	fr1, r2, 8
beq_cont.32521:
	ld	r2, r3, 4
	ld	r2, r2, 24
	ld	r5, r3, 0
	fld	fr1, r5, 0
	st	r2, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fsqr
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 0
	fld	fr2, r2, 4
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
	fadd	fr1, fr2, fr1
	ld	r2, r3, 0
	fld	fr2, r2, 8
	fst	fr1, r3, 40
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_fsqr
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 40
	fadd	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_sqrt
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.32522
	li	r2, 1
	b	beq_cont.32523
beq_else.32522:
	li	r2, 0
beq_cont.32523:
	cmpwi	cr0, r2, 0
	bne	beq_else.32524
	ld	r2, r3, 32
	cmpwi	cr0, r2, 0
	bne	beq_else.32526
	fld	fr2, r0, 16
	fdiv	fr1, fr2, fr1
	b	beq_cont.32527
beq_else.32526:
	fld	fr2, r0, 96
	fdiv	fr1, fr2, fr1
beq_cont.32527:
	b	beq_cont.32525
beq_else.32524:
	fld	fr1, r0, 16
beq_cont.32525:
	ld	r2, r3, 0
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
utexture.3070:
	ld	r6, r30, 4
	ld	r7, r2, 0
	ld	r8, r2, 32
	fld	fr1, r8, 0
	fst	fr1, r6, 0
	ld	r8, r2, 32
	fld	fr1, r8, 4
	fst	fr1, r6, 4
	ld	r8, r2, 32
	fld	fr1, r8, 8
	fst	fr1, r6, 8
	cmpwi	cr0, r7, 1
	bne	beq_else.32529
	fld	fr1, r5, 0
	ld	r7, r2, 20
	fld	fr2, r7, 0
	fsub	fr1, fr1, fr2
	fld	fr2, r0, 148
	fmul	fr2, fr1, fr2
	st	r6, r3, 0
	st	r2, r3, 4
	st	r5, r3, 8
	fst	fr1, r3, 12
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_floor
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r0, 152
	fmul	fr1, fr1, fr2
	fld	fr2, r0, 140
	fld	fr3, r3, 12
	fsub	fr1, fr3, fr1
	fcmp	cr0, fr2, fr1
	blt	le.32530
	beq	le.32530
	li	r2, 1
	b	gt_cont.32531
le.32530:
	li	r2, 0
gt_cont.32531:
	ld	r5, r3, 8
	fld	fr1, r5, 8
	ld	r5, r3, 4
	ld	r5, r5, 20
	fld	fr2, r5, 8
	fsub	fr1, fr1, fr2
	fld	fr2, r0, 148
	fmul	fr2, fr1, fr2
	st	r2, r3, 16
	fst	fr1, r3, 20
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_floor
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r0, 152
	fmul	fr1, fr1, fr2
	fld	fr2, r0, 140
	fld	fr3, r3, 20
	fsub	fr1, fr3, fr1
	fcmp	cr0, fr2, fr1
	blt	le.32532
	beq	le.32532
	li	r2, 1
	b	gt_cont.32533
le.32532:
	li	r2, 0
gt_cont.32533:
	ld	r5, r3, 16
	cmpwi	cr0, r5, 0
	bne	beq_else.32534
	cmpwi	cr0, r2, 0
	bne	beq_else.32536
	fld	fr1, r0, 132
	b	beq_cont.32537
beq_else.32536:
	fld	fr1, r0, 44
beq_cont.32537:
	b	beq_cont.32535
beq_else.32534:
	cmpwi	cr0, r2, 0
	bne	beq_else.32538
	fld	fr1, r0, 44
	b	beq_cont.32539
beq_else.32538:
	fld	fr1, r0, 132
beq_cont.32539:
beq_cont.32535:
	ld	r2, r3, 0
	fst	fr1, r2, 4
	blr
beq_else.32529:
	cmpwi	cr0, r7, 2
	bne	beq_else.32541
	fld	fr1, r5, 4
	fld	fr2, r0, 144
	fmul	fr1, fr1, fr2
	st	r6, r3, 0
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_sin
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_fsqr
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r0, 132
	fmul	fr2, fr2, fr1
	ld	r2, r3, 0
	fst	fr2, r2, 0
	fld	fr2, r0, 132
	fld	fr3, r0, 16
	fsub	fr1, fr3, fr1
	fmul	fr1, fr2, fr1
	fst	fr1, r2, 4
	blr
beq_else.32541:
	cmpwi	cr0, r7, 3
	bne	beq_else.32543
	fld	fr1, r5, 0
	ld	r7, r2, 20
	fld	fr2, r7, 0
	fsub	fr1, fr1, fr2
	fld	fr2, r5, 8
	ld	r2, r2, 20
	fld	fr3, r2, 8
	fsub	fr2, fr2, fr3
	st	r6, r3, 0
	fst	fr2, r3, 24
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_fsqr
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r3, 24
	fst	fr1, r3, 28
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_fsqr
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 28
	fadd	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_sqrt
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r0, 140
	fdiv	fr1, fr1, fr2
	fst	fr1, r3, 32
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_floor
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r3, 32
	fsub	fr1, fr2, fr1
	fld	fr2, r0, 124
	fmul	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_cos
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
	fld	fr2, r0, 132
	fmul	fr2, fr1, fr2
	ld	r2, r3, 0
	fst	fr2, r2, 4
	fld	fr2, r0, 16
	fsub	fr1, fr2, fr1
	fld	fr2, r0, 132
	fmul	fr1, fr1, fr2
	fst	fr1, r2, 8
	blr
beq_else.32543:
	cmpwi	cr0, r7, 4
	bne	beq_else.32545
	fld	fr1, r5, 0
	ld	r7, r2, 20
	fld	fr2, r7, 0
	fsub	fr1, fr1, fr2
	ld	r7, r2, 16
	fld	fr2, r7, 0
	st	r6, r3, 0
	st	r2, r3, 4
	st	r5, r3, 8
	fst	fr1, r3, 36
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_sqrt
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 36
	fmul	fr1, fr2, fr1
	ld	r2, r3, 8
	fld	fr2, r2, 8
	ld	r5, r3, 4
	ld	r6, r5, 20
	fld	fr3, r6, 8
	fsub	fr2, fr2, fr3
	ld	r6, r5, 16
	fld	fr3, r6, 8
	fst	fr1, r3, 40
	fst	fr2, r3, 44
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_sqrt
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 44
	fmul	fr1, fr2, fr1
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
	fld	fr2, r3, 40
	fst	fr1, r3, 56
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_fabs
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr1, r0, 112
	fld	fr2, r3, 40
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
	blt	le.32546
	beq	le.32546
	li	r2, 1
	b	gt_cont.32547
le.32546:
	li	r2, 0
gt_cont.32547:
	cmpwi	cr0, r2, 0
	bne	beq_else.32548
	fld	fr1, r3, 40
	fld	fr2, r3, 48
	fdiv	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_fabs
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_atan
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r0, 120
	fmul	fr1, fr1, fr2
	fld	fr2, r0, 124
	fdiv	fr1, fr1, fr2
	b	beq_cont.32549
beq_else.32548:
	fld	fr1, r0, 116
beq_cont.32549:
	fst	fr1, r3, 64
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_floor
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 64
	fsub	fr1, fr2, fr1
	ld	r2, r3, 8
	fld	fr2, r2, 4
	ld	r2, r3, 4
	ld	r5, r2, 20
	fld	fr3, r5, 4
	fsub	fr2, fr2, fr3
	ld	r2, r2, 16
	fld	fr3, r2, 4
	fst	fr1, r3, 68
	fst	fr2, r3, 72
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_sqrt
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 72
	fmul	fr1, fr2, fr1
	fld	fr2, r3, 56
	fst	fr1, r3, 76
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_fabs
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	fld	fr1, r0, 112
	fld	fr2, r3, 56
	fst	fr1, r3, 80
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_fabs
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	fld	fr2, r3, 80
	fcmp	cr0, fr2, fr1
	blt	le.32550
	beq	le.32550
	li	r2, 1
	b	gt_cont.32551
le.32550:
	li	r2, 0
gt_cont.32551:
	cmpwi	cr0, r2, 0
	bne	beq_else.32552
	fld	fr1, r3, 56
	fld	fr2, r3, 76
	fdiv	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_fabs
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_atan
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	fld	fr2, r0, 120
	fmul	fr1, fr1, fr2
	fld	fr2, r0, 124
	fdiv	fr1, fr1, fr2
	b	beq_cont.32553
beq_else.32552:
	fld	fr1, r0, 116
beq_cont.32553:
	fst	fr1, r3, 84
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_floor
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	fld	fr2, r3, 84
	fsub	fr1, fr2, fr1
	fld	fr2, r0, 128
	fld	fr3, r0, 0
	fld	fr4, r3, 68
	fsub	fr3, fr3, fr4
	fst	fr1, r3, 88
	fst	fr2, r3, 92
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fsqr
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	fld	fr2, r3, 92
	fsub	fr1, fr2, fr1
	fld	fr2, r0, 0
	fld	fr3, r3, 88
	fsub	fr2, fr2, fr3
	fst	fr1, r3, 96
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fsqr
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	fld	fr2, r3, 96
	fsub	fr1, fr2, fr1
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32554
	beq	le.32554
	li	r2, 1
	b	gt_cont.32555
le.32554:
	li	r2, 0
gt_cont.32555:
	cmpwi	cr0, r2, 0
	bne	beq_else.32556
	b	beq_cont.32557
beq_else.32556:
	fld	fr1, r0, 44
beq_cont.32557:
	fld	fr2, r0, 132
	fmul	fr1, fr2, fr1
	fld	fr2, r0, 136
	fdiv	fr1, fr1, fr2
	ld	r2, r3, 0
	fst	fr1, r2, 8
	blr
beq_else.32545:
	blr
add_light.3073:
	ld	r2, r30, 8
	ld	r5, r30, 4
	fld	fr4, r0, 44
	fcmp	cr0, fr1, fr4
	blt	le.32560
	beq	le.32560
	li	r6, 1
	b	gt_cont.32561
le.32560:
	li	r6, 0
gt_cont.32561:
	cmpwi	cr0, r6, 0
	bne	beq_else.32562
	b	beq_cont.32563
beq_else.32562:
	fld	fr4, r5, 0
	fld	fr5, r2, 0
	fmul	fr5, fr1, fr5
	fadd	fr4, fr4, fr5
	fst	fr4, r5, 0
	fld	fr4, r5, 4
	fld	fr5, r2, 4
	fmul	fr5, fr1, fr5
	fadd	fr4, fr4, fr5
	fst	fr4, r5, 4
	fld	fr4, r5, 8
	fld	fr5, r2, 8
	fmul	fr1, fr1, fr5
	fadd	fr1, fr4, fr1
	fst	fr1, r5, 8
beq_cont.32563:
	fld	fr1, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32564
	beq	le.32564
	li	r2, 1
	b	gt_cont.32565
le.32564:
	li	r2, 0
gt_cont.32565:
	cmpwi	cr0, r2, 0
	bne	beq_else.32566
	blr
beq_else.32566:
	st	r5, r3, 0
	fst	fr3, r3, 4
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_fsqr
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_fsqr
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	fld	fr2, r3, 4
	fmul	fr1, fr1, fr2
	ld	r2, r3, 0
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
trace_reflections.3077:
	ld	r6, r30, 80
	ld	r7, r30, 76
	ld	r8, r30, 72
	ld	r9, r30, 68
	ld	r10, r30, 64
	ld	r11, r30, 60
	ld	r12, r30, 56
	ld	r13, r30, 52
	ld	r14, r30, 48
	ld	r15, r30, 44
	ld	r16, r30, 40
	ld	r17, r30, 36
	ld	r18, r30, 32
	ld	r19, r30, 28
	ld	r20, r30, 24
	ld	r21, r30, 20
	ld	r22, r30, 16
	ld	r23, r30, 12
	ld	r24, r30, 8
	ld	r25, r30, 4
	cmpwi	cr0, r2, 0
	blt	bge_else.32569
	slwi	r26, r2, 2
	add	r31, r17, r26
	ld	r26, r31, 0
	ld	r27, r26, 4
	fld	fr3, r0, 156
	fst	fr3, r7, 0
	li	r28, 0
	ld	r29, r18, 0
	st	r30, r3, 0
	st	r25, r3, 4
	st	r6, r3, 8
	st	r9, r3, 12
	st	r12, r3, 16
	st	r13, r3, 20
	st	r24, r3, 24
	st	r17, r3, 28
	st	r2, r3, 32
	fst	fr2, r3, 36
	st	r8, r3, 40
	st	r16, r3, 44
	st	r5, r3, 48
	fst	fr1, r3, 52
	st	r19, r3, 56
	st	r27, r3, 60
	st	r14, r3, 64
	st	r15, r3, 68
	st	r11, r3, 72
	st	r22, r3, 76
	st	r20, r3, 80
	st	r10, r3, 84
	st	r18, r3, 88
	st	r26, r3, 92
	st	r21, r3, 96
	st	r23, r3, 100
	st	r7, r3, 104
	mflr	r31
	mr	r5, r29
	mr	r2, r28
	mr	r30, r6
	mr	r6, r27
	st	r31, r3, 108
	addi	r3, r3, 112
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	ld	r2, r3, 104
	fld	fr1, r2, 0
	fld	fr2, r0, 108
	fcmp	cr0, fr1, fr2
	blt	le.32570
	beq	le.32570
	li	r5, 1
	b	gt_cont.32571
le.32570:
	li	r5, 0
gt_cont.32571:
	cmpwi	cr0, r5, 0
	bne	beq_else.32572
	li	r5, 0
	b	beq_cont.32573
beq_else.32572:
	fld	fr2, r0, 160
	fcmp	cr0, fr2, fr1
	blt	le.32574
	beq	le.32574
	li	r5, 1
	b	gt_cont.32575
le.32574:
	li	r5, 0
gt_cont.32575:
beq_cont.32573:
	cmpwi	cr0, r5, 0
	bne	beq_else.32576
	b	beq_cont.32577
beq_else.32576:
	ld	r5, r3, 100
	ld	r6, r5, 0
	slwi	r6, r6, 2
	ld	r7, r3, 96
	ld	r8, r7, 0
	add	r6, r6, r8
	ld	r8, r3, 92
	ld	r9, r8, 0
	cmpw	cr0, r6, r9
	bne	beq_else.32578
	ld	r6, r3, 88
	ld	r9, r6, 0
	ld	r10, r9, 0
	ld	r11, r10, 0
	cmpwi	cr0, r11, -1
	bne	beq_else.32580
	li	r2, 0
	b	beq_cont.32581
beq_else.32580:
	st	r10, r3, 108
	st	r9, r3, 112
	cmpwi	cr0, r11, 99
	bne	beq_else.32582
	li	r2, 1
	b	beq_cont.32583
beq_else.32582:
	ld	r12, r3, 80
	ld	r13, r3, 76
	ld	r30, r3, 84
	mflr	r31
	mr	r6, r13
	mr	r5, r12
	mr	r2, r11
	st	r31, r3, 116
	addi	r3, r3, 120
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32584
	li	r2, 0
	b	beq_cont.32585
beq_else.32584:
	fld	fr1, r0, 108
	ld	r2, r3, 72
	fld	fr2, r2, 0
	fcmp	cr0, fr1, fr2
	blt	le.32586
	beq	le.32586
	li	r5, 1
	b	gt_cont.32587
le.32586:
	li	r5, 0
gt_cont.32587:
	cmpwi	cr0, r5, 0
	bne	beq_else.32588
	li	r2, 0
	b	beq_cont.32589
beq_else.32588:
	li	r5, 1
	ld	r6, r3, 108
	ld	r30, r3, 68
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 116
	addi	r3, r3, 120
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32590
	li	r2, 0
	b	beq_cont.32591
beq_else.32590:
	li	r2, 1
beq_cont.32591:
beq_cont.32589:
beq_cont.32585:
beq_cont.32583:
	cmpwi	cr0, r2, 0
	bne	beq_else.32592
	li	r2, 1
	ld	r5, r3, 112
	ld	r30, r3, 64
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	b	beq_cont.32593
beq_else.32592:
	li	r2, 1
	ld	r5, r3, 108
	ld	r30, r3, 68
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32594
	li	r2, 1
	ld	r5, r3, 112
	ld	r30, r3, 64
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	b	beq_cont.32595
beq_else.32594:
	li	r2, 1
beq_cont.32595:
beq_cont.32593:
beq_cont.32581:
	cmpwi	cr0, r2, 0
	bne	beq_else.32596
	ld	r2, r3, 60
	ld	r5, r2, 0
	ld	r6, r3, 56
	fld	fr1, r6, 0
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r6, 4
	fld	fr3, r5, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r6, 8
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	ld	r5, r3, 92
	fld	fr2, r5, 8
	fld	fr3, r3, 52
	fmul	fr4, fr2, fr3
	fmul	fr1, fr4, fr1
	ld	r2, r2, 0
	ld	r5, r3, 48
	fld	fr4, r5, 0
	fld	fr5, r2, 0
	fmul	fr4, fr4, fr5
	fld	fr5, r5, 4
	fld	fr6, r2, 4
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	fld	fr5, r5, 8
	fld	fr6, r2, 8
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	fmul	fr2, fr2, fr4
	fld	fr4, r0, 44
	fcmp	cr0, fr1, fr4
	blt	le.32598
	beq	le.32598
	li	r2, 1
	b	gt_cont.32599
le.32598:
	li	r2, 0
gt_cont.32599:
	cmpwi	cr0, r2, 0
	bne	beq_else.32600
	b	beq_cont.32601
beq_else.32600:
	ld	r2, r3, 44
	fld	fr4, r2, 0
	ld	r7, r3, 40
	fld	fr5, r7, 0
	fmul	fr5, fr1, fr5
	fadd	fr4, fr4, fr5
	fst	fr4, r2, 0
	fld	fr4, r2, 4
	fld	fr5, r7, 4
	fmul	fr5, fr1, fr5
	fadd	fr4, fr4, fr5
	fst	fr4, r2, 4
	fld	fr4, r2, 8
	fld	fr5, r7, 8
	fmul	fr1, fr1, fr5
	fadd	fr1, fr4, fr1
	fst	fr1, r2, 8
beq_cont.32601:
	fld	fr1, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32602
	beq	le.32602
	li	r2, 1
	b	gt_cont.32603
le.32602:
	li	r2, 0
gt_cont.32603:
	cmpwi	cr0, r2, 0
	bne	beq_else.32604
	b	beq_cont.32605
beq_else.32604:
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_fsqr
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_fsqr
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	fld	fr2, r3, 36
	fmul	fr1, fr1, fr2
	ld	r2, r3, 44
	fld	fr3, r2, 0
	fadd	fr3, fr3, fr1
	fst	fr3, r2, 0
	fld	fr3, r2, 4
	fadd	fr3, fr3, fr1
	fst	fr3, r2, 4
	fld	fr3, r2, 8
	fadd	fr1, fr3, fr1
	fst	fr1, r2, 8
beq_cont.32605:
	b	beq_cont.32597
beq_else.32596:
beq_cont.32597:
	b	beq_cont.32579
beq_else.32578:
beq_cont.32579:
beq_cont.32577:
	ld	r2, r3, 32
	addi	r2, r2, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.32606
	slwi	r5, r2, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r6, r5, 4
	fld	fr1, r0, 156
	ld	r7, r3, 104
	fst	fr1, r7, 0
	ld	r8, r3, 88
	ld	r9, r8, 0
	ld	r10, r9, 0
	ld	r11, r10, 0
	st	r2, r3, 116
	st	r6, r3, 120
	st	r5, r3, 124
	cmpwi	cr0, r11, -1
	bne	beq_else.32607
	b	beq_cont.32608
beq_else.32607:
	st	r9, r3, 128
	cmpwi	cr0, r11, 99
	bne	beq_else.32609
	ld	r11, r10, 4
	cmpwi	cr0, r11, -1
	bne	beq_else.32611
	b	beq_cont.32612
beq_else.32611:
	slwi	r11, r11, 2
	ld	r12, r3, 24
	add	r31, r12, r11
	ld	r11, r31, 0
	li	r13, 0
	ld	r30, r3, 20
	st	r10, r3, 132
	mflr	r31
	mr	r5, r11
	mr	r2, r13
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	ld	r2, r3, 132
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32613
	b	beq_cont.32614
beq_else.32613:
	slwi	r5, r5, 2
	ld	r6, r3, 24
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 120
	ld	r30, r3, 20
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	ld	r2, r3, 132
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32615
	b	beq_cont.32616
beq_else.32615:
	slwi	r5, r5, 2
	ld	r6, r3, 24
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 120
	ld	r30, r3, 20
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	ld	r2, r3, 132
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32617
	b	beq_cont.32618
beq_else.32617:
	slwi	r5, r5, 2
	ld	r6, r3, 24
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r6, 0
	ld	r7, r3, 120
	ld	r30, r3, 20
	mflr	r31
	mr	r2, r6
	mr	r6, r7
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	li	r2, 5
	ld	r5, r3, 132
	ld	r6, r3, 120
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
beq_cont.32618:
beq_cont.32616:
beq_cont.32614:
beq_cont.32612:
	b	beq_cont.32610
beq_else.32609:
	ld	r30, r3, 12
	st	r10, r3, 132
	mflr	r31
	mr	r5, r6
	mr	r2, r11
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32619
	b	beq_cont.32620
beq_else.32619:
	ld	r2, r3, 72
	fld	fr1, r2, 0
	ld	r2, r3, 104
	fld	fr2, r2, 0
	fcmp	cr0, fr2, fr1
	blt	le.32621
	beq	le.32621
	li	r5, 1
	b	gt_cont.32622
le.32621:
	li	r5, 0
gt_cont.32622:
	cmpwi	cr0, r5, 0
	bne	beq_else.32623
	b	beq_cont.32624
beq_else.32623:
	ld	r5, r3, 132
	ld	r6, r5, 4
	cmpwi	cr0, r6, -1
	bne	beq_else.32625
	b	beq_cont.32626
beq_else.32625:
	slwi	r6, r6, 2
	ld	r7, r3, 24
	add	r31, r7, r6
	ld	r6, r31, 0
	li	r8, 0
	ld	r9, r3, 120
	ld	r30, r3, 20
	mflr	r31
	mr	r5, r6
	mr	r2, r8
	mr	r6, r9
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	ld	r2, r3, 132
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32627
	b	beq_cont.32628
beq_else.32627:
	slwi	r5, r5, 2
	ld	r6, r3, 24
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 120
	ld	r30, r3, 20
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	ld	r2, r3, 132
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32629
	b	beq_cont.32630
beq_else.32629:
	slwi	r5, r5, 2
	ld	r6, r3, 24
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 120
	ld	r30, r3, 20
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	ld	r2, r3, 132
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32631
	b	beq_cont.32632
beq_else.32631:
	slwi	r5, r5, 2
	ld	r6, r3, 24
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r6, 0
	ld	r7, r3, 120
	ld	r30, r3, 20
	mflr	r31
	mr	r2, r6
	mr	r6, r7
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	li	r2, 5
	ld	r5, r3, 132
	ld	r6, r3, 120
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
beq_cont.32632:
beq_cont.32630:
beq_cont.32628:
beq_cont.32626:
beq_cont.32624:
beq_cont.32620:
beq_cont.32610:
	li	r2, 1
	ld	r5, r3, 128
	ld	r6, r3, 120
	ld	r30, r3, 8
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
beq_cont.32608:
	ld	r2, r3, 104
	fld	fr1, r2, 0
	fld	fr2, r0, 108
	fcmp	cr0, fr1, fr2
	blt	le.32633
	beq	le.32633
	li	r2, 1
	b	gt_cont.32634
le.32633:
	li	r2, 0
gt_cont.32634:
	cmpwi	cr0, r2, 0
	bne	beq_else.32635
	li	r2, 0
	b	beq_cont.32636
beq_else.32635:
	fld	fr2, r0, 160
	fcmp	cr0, fr2, fr1
	blt	le.32637
	beq	le.32637
	li	r2, 1
	b	gt_cont.32638
le.32637:
	li	r2, 0
gt_cont.32638:
beq_cont.32636:
	cmpwi	cr0, r2, 0
	bne	beq_else.32639
	b	beq_cont.32640
beq_else.32639:
	ld	r2, r3, 100
	ld	r2, r2, 0
	slwi	r2, r2, 2
	ld	r5, r3, 96
	ld	r5, r5, 0
	add	r2, r2, r5
	ld	r5, r3, 124
	ld	r6, r5, 0
	cmpw	cr0, r2, r6
	bne	beq_else.32641
	li	r2, 0
	ld	r6, r3, 88
	ld	r6, r6, 0
	ld	r30, r3, 64
	mflr	r31
	mr	r5, r6
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32643
	ld	r2, r3, 120
	ld	r5, r2, 0
	ld	r6, r3, 56
	fld	fr1, r6, 0
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r6, 4
	fld	fr3, r5, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r6, 8
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	ld	r5, r3, 124
	fld	fr2, r5, 8
	fld	fr3, r3, 52
	fmul	fr4, fr2, fr3
	fmul	fr1, fr4, fr1
	ld	r2, r2, 0
	ld	r5, r3, 48
	fld	fr4, r5, 0
	fld	fr5, r2, 0
	fmul	fr4, fr4, fr5
	fld	fr5, r5, 4
	fld	fr6, r2, 4
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	fld	fr5, r5, 8
	fld	fr6, r2, 8
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	fmul	fr2, fr2, fr4
	fld	fr4, r3, 36
	ld	r30, r3, 4
	mflr	r31
	fmr	fr3, fr4
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	b	beq_cont.32644
beq_else.32643:
beq_cont.32644:
	b	beq_cont.32642
beq_else.32641:
beq_cont.32642:
beq_cont.32640:
	ld	r2, r3, 116
	addi	r2, r2, -1
	fld	fr1, r3, 52
	fld	fr2, r3, 36
	ld	r5, r3, 48
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
bge_else.32606:
	blr
bge_else.32569:
	blr
trace_ray.3082:
	ld	r7, r30, 128
	ld	r8, r30, 124
	ld	r9, r30, 120
	ld	r10, r30, 116
	ld	r11, r30, 112
	ld	r12, r30, 108
	ld	r13, r30, 104
	ld	r14, r30, 100
	ld	r15, r30, 96
	ld	r16, r30, 92
	ld	r17, r30, 88
	ld	r18, r30, 84
	ld	r19, r30, 80
	ld	r20, r30, 76
	ld	r21, r30, 72
	ld	r22, r30, 68
	ld	r23, r30, 64
	ld	r24, r30, 60
	ld	r25, r30, 56
	ld	r26, r30, 52
	ld	r27, r30, 48
	ld	r28, r30, 44
	ld	r29, r30, 40
	st	r8, r3, 0
	ld	r8, r30, 36
	st	r9, r3, 4
	ld	r9, r30, 32
	st	r15, r3, 8
	ld	r15, r30, 28
	st	r18, r3, 12
	ld	r18, r30, 24
	st	r19, r3, 16
	ld	r19, r30, 20
	st	r24, r3, 20
	ld	r24, r30, 16
	st	r28, r3, 24
	ld	r28, r30, 12
	st	r22, r3, 28
	ld	r22, r30, 8
	st	r30, r3, 32
	ld	r30, r30, 4
	cmpwi	cr0, r2, 4
	blt	le.32647
	beq	le.32647
	blr
le.32647:
	st	r30, r3, 36
	ld	r30, r6, 8
	fld	fr3, r0, 156
	fst	fr3, r11, 0
	st	r22, r3, 40
	li	r22, 0
	st	r29, r3, 44
	ld	r29, r25, 0
	fst	fr2, r3, 48
	st	r13, r3, 52
	st	r20, r3, 56
	st	r21, r3, 60
	st	r17, r3, 64
	st	r8, r3, 68
	st	r16, r3, 72
	st	r25, r3, 76
	st	r12, r3, 80
	st	r6, r3, 84
	st	r7, r3, 88
	st	r14, r3, 92
	st	r18, r3, 96
	st	r24, r3, 100
	st	r27, r3, 104
	st	r15, r3, 108
	st	r26, r3, 112
	st	r19, r3, 116
	st	r23, r3, 120
	st	r28, r3, 124
	fst	fr1, r3, 128
	st	r9, r3, 132
	st	r5, r3, 136
	st	r30, r3, 140
	st	r2, r3, 144
	st	r11, r3, 148
	mflr	r31
	mr	r6, r5
	mr	r2, r22
	mr	r30, r10
	mr	r5, r29
	st	r31, r3, 156
	addi	r3, r3, 160
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -160
	ld	r31, r3, 156
	mtlr	r31
	ld	r2, r3, 148
	fld	fr1, r2, 0
	fld	fr2, r0, 108
	fcmp	cr0, fr1, fr2
	blt	le.32649
	beq	le.32649
	li	r5, 1
	b	gt_cont.32650
le.32649:
	li	r5, 0
gt_cont.32650:
	cmpwi	cr0, r5, 0
	bne	beq_else.32651
	li	r5, 0
	b	beq_cont.32652
beq_else.32651:
	fld	fr2, r0, 160
	fcmp	cr0, fr2, fr1
	blt	le.32653
	beq	le.32653
	li	r5, 1
	b	gt_cont.32654
le.32653:
	li	r5, 0
gt_cont.32654:
beq_cont.32652:
	cmpwi	cr0, r5, 0
	bne	beq_else.32655
	li	r2, -1
	ld	r5, r3, 144
	slwi	r6, r5, 2
	ld	r7, r3, 140
	add	r31, r7, r6
	st	r2, r31, 0
	cmpwi	cr0, r5, 0
	bne	beq_else.32656
	blr
beq_else.32656:
	ld	r2, r3, 136
	fld	fr1, r2, 0
	ld	r5, r3, 132
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
	fsub	fr1, fr0, fr1
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.32658
	beq	le.32658
	li	r2, 1
	b	gt_cont.32659
le.32658:
	li	r2, 0
gt_cont.32659:
	cmpwi	cr0, r2, 0
	bne	beq_else.32660
	blr
beq_else.32660:
	fst	fr1, r3, 152
	mflr	r31
	st	r31, r3, 156
	addi	r3, r3, 160
	bl	min_caml_fsqr
	addi	r3, r3, -160
	ld	r31, r3, 156
	mtlr	r31
	fld	fr2, r3, 152
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 128
	fmul	fr1, fr1, fr2
	ld	r2, r3, 124
	fld	fr2, r2, 0
	fmul	fr1, fr1, fr2
	ld	r2, r3, 120
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
beq_else.32655:
	ld	r5, r3, 116
	ld	r6, r5, 0
	slwi	r7, r6, 2
	ld	r8, r3, 112
	add	r31, r8, r7
	ld	r7, r31, 0
	ld	r8, r7, 8
	ld	r9, r7, 28
	fld	fr1, r9, 0
	fld	fr2, r3, 128
	fmul	fr1, fr1, fr2
	ld	r9, r7, 4
	st	r8, r3, 156
	fst	fr1, r3, 160
	st	r6, r3, 164
	st	r7, r3, 168
	cmpwi	cr0, r9, 1
	bne	beq_else.32663
	ld	r9, r3, 108
	ld	r10, r9, 0
	fld	fr3, r0, 44
	ld	r11, r3, 104
	fst	fr3, r11, 0
	fst	fr3, r11, 4
	fst	fr3, r11, 8
	addi	r12, r10, -1
	addi	r10, r10, -1
	slwi	r10, r10, 2
	ld	r13, r3, 136
	add	r31, r13, r10
	fld	fr3, r31, 0
	fld	fr4, r0, 44
	fcmp	cr0, fr3, fr4
	bne	beq_else.32665
	li	r10, 1
	b	beq_cont.32666
beq_else.32665:
	li	r10, 0
beq_cont.32666:
	cmpwi	cr0, r10, 0
	bne	beq_else.32667
	fld	fr4, r0, 44
	fcmp	cr0, fr3, fr4
	blt	le.32669
	beq	le.32669
	li	r10, 1
	b	gt_cont.32670
le.32669:
	li	r10, 0
gt_cont.32670:
	cmpwi	cr0, r10, 0
	bne	beq_else.32671
	fld	fr3, r0, 96
	b	beq_cont.32672
beq_else.32671:
	fld	fr3, r0, 16
beq_cont.32672:
	b	beq_cont.32668
beq_else.32667:
	fld	fr3, r0, 44
beq_cont.32668:
	fsub	fr3, fr0, fr3
	slwi	r10, r12, 2
	add	r31, r11, r10
	fst	fr3, r31, 0
	b	beq_cont.32664
beq_else.32663:
	cmpwi	cr0, r9, 2
	bne	beq_else.32673
	ld	r9, r7, 16
	fld	fr3, r9, 0
	fsub	fr3, fr0, fr3
	ld	r9, r3, 104
	fst	fr3, r9, 0
	ld	r10, r7, 16
	fld	fr3, r10, 4
	fsub	fr3, fr0, fr3
	fst	fr3, r9, 4
	ld	r10, r7, 16
	fld	fr3, r10, 8
	fsub	fr3, fr0, fr3
	fst	fr3, r9, 8
	b	beq_cont.32674
beq_else.32673:
	ld	r30, r3, 100
	mflr	r31
	mr	r2, r7
	st	r31, r3, 172
	addi	r3, r3, 176
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -176
	ld	r31, r3, 172
	mtlr	r31
beq_cont.32674:
beq_cont.32664:
	ld	r5, r3, 96
	fld	fr1, r5, 0
	ld	r2, r3, 92
	fst	fr1, r2, 0
	fld	fr1, r5, 4
	fst	fr1, r2, 4
	fld	fr1, r5, 8
	fst	fr1, r2, 8
	ld	r2, r3, 168
	ld	r30, r3, 88
	mflr	r31
	st	r31, r3, 172
	addi	r3, r3, 176
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -176
	ld	r31, r3, 172
	mtlr	r31
	ld	r2, r3, 164
	slwi	r2, r2, 2
	ld	r5, r3, 108
	ld	r6, r5, 0
	add	r2, r2, r6
	ld	r6, r3, 144
	slwi	r7, r6, 2
	ld	r8, r3, 140
	add	r31, r8, r7
	st	r2, r31, 0
	ld	r2, r3, 84
	ld	r7, r2, 4
	slwi	r9, r6, 2
	add	r31, r7, r9
	ld	r7, r31, 0
	ld	r9, r3, 96
	fld	fr1, r9, 0
	fst	fr1, r7, 0
	fld	fr1, r9, 4
	fst	fr1, r7, 4
	fld	fr1, r9, 8
	fst	fr1, r7, 8
	ld	r7, r2, 12
	fld	fr1, r0, 0
	ld	r10, r3, 168
	ld	r11, r10, 28
	fld	fr2, r11, 0
	fcmp	cr0, fr1, fr2
	blt	le.32675
	beq	le.32675
	li	r11, 1
	b	gt_cont.32676
le.32675:
	li	r11, 0
gt_cont.32676:
	cmpwi	cr0, r11, 0
	bne	beq_else.32677
	li	r11, 1
	slwi	r12, r6, 2
	add	r31, r7, r12
	st	r11, r31, 0
	ld	r7, r2, 16
	slwi	r11, r6, 2
	add	r31, r7, r11
	ld	r11, r31, 0
	ld	r12, r3, 80
	fld	fr1, r12, 0
	fst	fr1, r11, 0
	fld	fr1, r12, 4
	fst	fr1, r11, 4
	fld	fr1, r12, 8
	fst	fr1, r11, 8
	slwi	r11, r6, 2
	add	r31, r7, r11
	ld	r7, r31, 0
	fld	fr1, r0, 164
	fld	fr2, r3, 160
	fmul	fr1, fr1, fr2
	fld	fr3, r7, 0
	fmul	fr3, fr3, fr1
	fst	fr3, r7, 0
	fld	fr3, r7, 4
	fmul	fr3, fr3, fr1
	fst	fr3, r7, 4
	fld	fr3, r7, 8
	fmul	fr1, fr3, fr1
	fst	fr1, r7, 8
	ld	r7, r2, 28
	slwi	r11, r6, 2
	add	r31, r7, r11
	ld	r7, r31, 0
	ld	r11, r3, 104
	fld	fr1, r11, 0
	fst	fr1, r7, 0
	fld	fr1, r11, 4
	fst	fr1, r7, 4
	fld	fr1, r11, 8
	fst	fr1, r7, 8
	b	beq_cont.32678
beq_else.32677:
	li	r11, 0
	slwi	r12, r6, 2
	add	r31, r7, r12
	st	r11, r31, 0
beq_cont.32678:
	fld	fr1, r0, 168
	ld	r7, r3, 136
	fld	fr2, r7, 0
	ld	r11, r3, 104
	fld	fr3, r11, 0
	fmul	fr2, fr2, fr3
	fld	fr3, r7, 4
	fld	fr4, r11, 4
	fmul	fr3, fr3, fr4
	fadd	fr2, fr2, fr3
	fld	fr3, r7, 8
	fld	fr4, r11, 8
	fmul	fr3, fr3, fr4
	fadd	fr2, fr2, fr3
	fmul	fr1, fr1, fr2
	fld	fr2, r7, 0
	fld	fr3, r11, 0
	fmul	fr3, fr1, fr3
	fadd	fr2, fr2, fr3
	fst	fr2, r7, 0
	fld	fr2, r7, 4
	fld	fr3, r11, 4
	fmul	fr3, fr1, fr3
	fadd	fr2, fr2, fr3
	fst	fr2, r7, 4
	fld	fr2, r7, 8
	fld	fr3, r11, 8
	fmul	fr1, fr1, fr3
	fadd	fr1, fr2, fr1
	fst	fr1, r7, 8
	ld	r12, r10, 28
	fld	fr1, r12, 4
	fld	fr2, r3, 128
	fmul	fr1, fr2, fr1
	ld	r12, r3, 76
	ld	r13, r12, 0
	ld	r14, r13, 0
	ld	r15, r14, 0
	fst	fr1, r3, 172
	cmpwi	cr0, r15, -1
	bne	beq_else.32679
	li	r2, 0
	b	beq_cont.32680
beq_else.32679:
	st	r14, r3, 176
	st	r13, r3, 180
	cmpwi	cr0, r15, 99
	bne	beq_else.32681
	li	r2, 1
	b	beq_cont.32682
beq_else.32681:
	ld	r16, r3, 68
	ld	r30, r3, 72
	mflr	r31
	mr	r6, r9
	mr	r5, r16
	mr	r2, r15
	st	r31, r3, 188
	addi	r3, r3, 192
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -192
	ld	r31, r3, 188
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32683
	li	r2, 0
	b	beq_cont.32684
beq_else.32683:
	fld	fr1, r0, 108
	ld	r2, r3, 64
	fld	fr2, r2, 0
	fcmp	cr0, fr1, fr2
	blt	le.32685
	beq	le.32685
	li	r5, 1
	b	gt_cont.32686
le.32685:
	li	r5, 0
gt_cont.32686:
	cmpwi	cr0, r5, 0
	bne	beq_else.32687
	li	r2, 0
	b	beq_cont.32688
beq_else.32687:
	li	r5, 1
	ld	r6, r3, 176
	ld	r30, r3, 60
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 188
	addi	r3, r3, 192
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -192
	ld	r31, r3, 188
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32689
	li	r2, 0
	b	beq_cont.32690
beq_else.32689:
	li	r2, 1
beq_cont.32690:
beq_cont.32688:
beq_cont.32684:
beq_cont.32682:
	cmpwi	cr0, r2, 0
	bne	beq_else.32691
	li	r2, 1
	ld	r5, r3, 180
	ld	r30, r3, 56
	mflr	r31
	st	r31, r3, 188
	addi	r3, r3, 192
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -192
	ld	r31, r3, 188
	mtlr	r31
	b	beq_cont.32692
beq_else.32691:
	li	r2, 1
	ld	r5, r3, 176
	ld	r30, r3, 60
	mflr	r31
	st	r31, r3, 188
	addi	r3, r3, 192
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -192
	ld	r31, r3, 188
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32693
	li	r2, 1
	ld	r5, r3, 180
	ld	r30, r3, 56
	mflr	r31
	st	r31, r3, 188
	addi	r3, r3, 192
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -192
	ld	r31, r3, 188
	mtlr	r31
	b	beq_cont.32694
beq_else.32693:
	li	r2, 1
beq_cont.32694:
beq_cont.32692:
beq_cont.32680:
	cmpwi	cr0, r2, 0
	bne	beq_else.32695
	ld	r2, r3, 104
	fld	fr1, r2, 0
	ld	r5, r3, 132
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
	fsub	fr1, fr0, fr1
	fld	fr2, r3, 160
	fmul	fr1, fr1, fr2
	ld	r6, r3, 136
	fld	fr3, r6, 0
	fld	fr4, r5, 0
	fmul	fr3, fr3, fr4
	fld	fr4, r6, 4
	fld	fr5, r5, 4
	fmul	fr4, fr4, fr5
	fadd	fr3, fr3, fr4
	fld	fr4, r6, 8
	fld	fr5, r5, 8
	fmul	fr4, fr4, fr5
	fadd	fr3, fr3, fr4
	fsub	fr3, fr0, fr3
	fld	fr4, r0, 44
	fcmp	cr0, fr1, fr4
	blt	le.32697
	beq	le.32697
	li	r5, 1
	b	gt_cont.32698
le.32697:
	li	r5, 0
gt_cont.32698:
	cmpwi	cr0, r5, 0
	bne	beq_else.32699
	b	beq_cont.32700
beq_else.32699:
	ld	r5, r3, 120
	fld	fr4, r5, 0
	ld	r7, r3, 80
	fld	fr5, r7, 0
	fmul	fr5, fr1, fr5
	fadd	fr4, fr4, fr5
	fst	fr4, r5, 0
	fld	fr4, r5, 4
	fld	fr5, r7, 4
	fmul	fr5, fr1, fr5
	fadd	fr4, fr4, fr5
	fst	fr4, r5, 4
	fld	fr4, r5, 8
	fld	fr5, r7, 8
	fmul	fr1, fr1, fr5
	fadd	fr1, fr4, fr1
	fst	fr1, r5, 8
beq_cont.32700:
	fld	fr1, r0, 44
	fcmp	cr0, fr3, fr1
	blt	le.32701
	beq	le.32701
	li	r5, 1
	b	gt_cont.32702
le.32701:
	li	r5, 0
gt_cont.32702:
	cmpwi	cr0, r5, 0
	bne	beq_else.32703
	b	beq_cont.32704
beq_else.32703:
	mflr	r31
	fmr	fr1, fr3
	st	r31, r3, 188
	addi	r3, r3, 192
	bl	min_caml_fsqr
	addi	r3, r3, -192
	ld	r31, r3, 188
	mtlr	r31
	mflr	r31
	st	r31, r3, 188
	addi	r3, r3, 192
	bl	min_caml_fsqr
	addi	r3, r3, -192
	ld	r31, r3, 188
	mtlr	r31
	fld	fr2, r3, 172
	fmul	fr1, fr1, fr2
	ld	r2, r3, 120
	fld	fr3, r2, 0
	fadd	fr3, fr3, fr1
	fst	fr3, r2, 0
	fld	fr3, r2, 4
	fadd	fr3, fr3, fr1
	fst	fr3, r2, 4
	fld	fr3, r2, 8
	fadd	fr1, fr3, fr1
	fst	fr1, r2, 8
beq_cont.32704:
	b	beq_cont.32696
beq_else.32695:
beq_cont.32696:
	ld	r2, r3, 96
	fld	fr1, r2, 0
	ld	r5, r3, 52
	fst	fr1, r5, 0
	fld	fr1, r2, 4
	fst	fr1, r5, 4
	fld	fr1, r2, 8
	fst	fr1, r5, 8
	ld	r5, r3, 44
	ld	r5, r5, 0
	addi	r5, r5, -1
	ld	r30, r3, 28
	mflr	r31
	st	r31, r3, 188
	addi	r3, r3, 192
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -192
	ld	r31, r3, 188
	mtlr	r31
	ld	r2, r3, 24
	ld	r2, r2, 0
	addi	r2, r2, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.32705
	slwi	r5, r2, 2
	ld	r6, r3, 20
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r6, r5, 4
	fld	fr1, r0, 156
	ld	r7, r3, 148
	fst	fr1, r7, 0
	ld	r8, r3, 76
	ld	r9, r8, 0
	ld	r10, r9, 0
	ld	r11, r10, 0
	st	r2, r3, 184
	st	r6, r3, 188
	st	r5, r3, 192
	cmpwi	cr0, r11, -1
	bne	beq_else.32707
	b	beq_cont.32708
beq_else.32707:
	st	r9, r3, 196
	cmpwi	cr0, r11, 99
	bne	beq_else.32709
	ld	r11, r10, 4
	cmpwi	cr0, r11, -1
	bne	beq_else.32711
	b	beq_cont.32712
beq_else.32711:
	slwi	r11, r11, 2
	ld	r12, r3, 40
	add	r31, r12, r11
	ld	r11, r31, 0
	li	r13, 0
	ld	r30, r3, 16
	st	r10, r3, 200
	mflr	r31
	mr	r5, r11
	mr	r2, r13
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	ld	r2, r3, 200
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32713
	b	beq_cont.32714
beq_else.32713:
	slwi	r5, r5, 2
	ld	r6, r3, 40
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 188
	ld	r30, r3, 16
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	ld	r2, r3, 200
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32715
	b	beq_cont.32716
beq_else.32715:
	slwi	r5, r5, 2
	ld	r6, r3, 40
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 188
	ld	r30, r3, 16
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	ld	r2, r3, 200
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32717
	b	beq_cont.32718
beq_else.32717:
	slwi	r5, r5, 2
	ld	r6, r3, 40
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r6, 0
	ld	r7, r3, 188
	ld	r30, r3, 16
	mflr	r31
	mr	r2, r6
	mr	r6, r7
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	li	r2, 5
	ld	r5, r3, 200
	ld	r6, r3, 188
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
beq_cont.32718:
beq_cont.32716:
beq_cont.32714:
beq_cont.32712:
	b	beq_cont.32710
beq_else.32709:
	ld	r30, r3, 8
	st	r10, r3, 200
	mflr	r31
	mr	r5, r6
	mr	r2, r11
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32719
	b	beq_cont.32720
beq_else.32719:
	ld	r2, r3, 64
	fld	fr1, r2, 0
	ld	r2, r3, 148
	fld	fr2, r2, 0
	fcmp	cr0, fr2, fr1
	blt	le.32721
	beq	le.32721
	li	r5, 1
	b	gt_cont.32722
le.32721:
	li	r5, 0
gt_cont.32722:
	cmpwi	cr0, r5, 0
	bne	beq_else.32723
	b	beq_cont.32724
beq_else.32723:
	ld	r5, r3, 200
	ld	r6, r5, 4
	cmpwi	cr0, r6, -1
	bne	beq_else.32725
	b	beq_cont.32726
beq_else.32725:
	slwi	r6, r6, 2
	ld	r7, r3, 40
	add	r31, r7, r6
	ld	r6, r31, 0
	li	r8, 0
	ld	r9, r3, 188
	ld	r30, r3, 16
	mflr	r31
	mr	r5, r6
	mr	r2, r8
	mr	r6, r9
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	ld	r2, r3, 200
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32727
	b	beq_cont.32728
beq_else.32727:
	slwi	r5, r5, 2
	ld	r6, r3, 40
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 188
	ld	r30, r3, 16
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	ld	r2, r3, 200
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32729
	b	beq_cont.32730
beq_else.32729:
	slwi	r5, r5, 2
	ld	r6, r3, 40
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 188
	ld	r30, r3, 16
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	ld	r2, r3, 200
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32731
	b	beq_cont.32732
beq_else.32731:
	slwi	r5, r5, 2
	ld	r6, r3, 40
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r6, 0
	ld	r7, r3, 188
	ld	r30, r3, 16
	mflr	r31
	mr	r2, r6
	mr	r6, r7
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	li	r2, 5
	ld	r5, r3, 200
	ld	r6, r3, 188
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
beq_cont.32732:
beq_cont.32730:
beq_cont.32728:
beq_cont.32726:
beq_cont.32724:
beq_cont.32720:
beq_cont.32710:
	li	r2, 1
	ld	r5, r3, 196
	ld	r6, r3, 188
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
beq_cont.32708:
	ld	r2, r3, 148
	fld	fr1, r2, 0
	fld	fr2, r0, 108
	fcmp	cr0, fr1, fr2
	blt	le.32733
	beq	le.32733
	li	r5, 1
	b	gt_cont.32734
le.32733:
	li	r5, 0
gt_cont.32734:
	cmpwi	cr0, r5, 0
	bne	beq_else.32735
	li	r5, 0
	b	beq_cont.32736
beq_else.32735:
	fld	fr2, r0, 160
	fcmp	cr0, fr2, fr1
	blt	le.32737
	beq	le.32737
	li	r5, 1
	b	gt_cont.32738
le.32737:
	li	r5, 0
gt_cont.32738:
beq_cont.32736:
	cmpwi	cr0, r5, 0
	bne	beq_else.32739
	b	beq_cont.32740
beq_else.32739:
	ld	r5, r3, 116
	ld	r5, r5, 0
	slwi	r5, r5, 2
	ld	r6, r3, 108
	ld	r6, r6, 0
	add	r5, r5, r6
	ld	r6, r3, 192
	ld	r7, r6, 0
	cmpw	cr0, r5, r7
	bne	beq_else.32741
	li	r5, 0
	ld	r7, r3, 76
	ld	r7, r7, 0
	ld	r30, r3, 56
	mflr	r31
	mr	r2, r5
	mr	r5, r7
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32743
	ld	r2, r3, 188
	ld	r5, r2, 0
	ld	r6, r3, 104
	fld	fr1, r6, 0
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r6, 4
	fld	fr3, r5, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r6, 8
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	ld	r5, r3, 192
	fld	fr2, r5, 8
	fld	fr3, r3, 160
	fmul	fr4, fr2, fr3
	fmul	fr1, fr4, fr1
	ld	r2, r2, 0
	ld	r5, r3, 136
	fld	fr4, r5, 0
	fld	fr5, r2, 0
	fmul	fr4, fr4, fr5
	fld	fr5, r5, 4
	fld	fr6, r2, 4
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	fld	fr5, r5, 8
	fld	fr6, r2, 8
	fmul	fr5, fr5, fr6
	fadd	fr4, fr4, fr5
	fmul	fr2, fr2, fr4
	fld	fr4, r3, 172
	ld	r30, r3, 36
	mflr	r31
	fmr	fr3, fr4
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	b	beq_cont.32744
beq_else.32743:
beq_cont.32744:
	b	beq_cont.32742
beq_else.32741:
beq_cont.32742:
beq_cont.32740:
	ld	r2, r3, 184
	addi	r2, r2, -1
	fld	fr1, r3, 160
	fld	fr2, r3, 172
	ld	r5, r3, 136
	ld	r30, r3, 0
	mflr	r31
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	b	bge_cont.32706
bge_else.32705:
bge_cont.32706:
	fld	fr1, r0, 172
	fld	fr2, r3, 128
	fcmp	cr0, fr2, fr1
	blt	le.32745
	beq	le.32745
	li	r2, 1
	b	gt_cont.32746
le.32745:
	li	r2, 0
gt_cont.32746:
	cmpwi	cr0, r2, 0
	bne	beq_else.32747
	blr
beq_else.32747:
	ld	r2, r3, 144
	cmpwi	cr0, r2, 4
	blt	bge_else.32749
	b	bge_cont.32750
bge_else.32749:
	addi	r5, r2, 1
	li	r6, -1
	slwi	r5, r5, 2
	ld	r7, r3, 140
	add	r31, r7, r5
	st	r6, r31, 0
bge_cont.32750:
	ld	r5, r3, 156
	cmpwi	cr0, r5, 2
	bne	beq_else.32751
	fld	fr1, r0, 16
	ld	r5, r3, 168
	ld	r5, r5, 28
	fld	fr3, r5, 0
	fsub	fr1, fr1, fr3
	fmul	fr1, fr2, fr1
	addi	r2, r2, 1
	ld	r5, r3, 148
	fld	fr2, r5, 0
	fld	fr3, r3, 48
	fadd	fr2, fr3, fr2
	ld	r5, r3, 136
	ld	r6, r3, 84
	ld	r30, r3, 32
	mflr	r31
	st	r31, r3, 204
	addi	r3, r3, 208
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -208
	ld	r31, r3, 204
	mtlr	r31
	b	beq_cont.32752
beq_else.32751:
beq_cont.32752:
	blr
trace_diffuse_ray.3088:
	ld	r5, r30, 72
	ld	r6, r30, 68
	ld	r7, r30, 64
	ld	r8, r30, 60
	ld	r9, r30, 56
	ld	r10, r30, 52
	ld	r11, r30, 48
	ld	r12, r30, 44
	ld	r13, r30, 40
	ld	r14, r30, 36
	ld	r15, r30, 32
	ld	r16, r30, 28
	ld	r17, r30, 24
	ld	r18, r30, 20
	ld	r19, r30, 16
	ld	r20, r30, 12
	ld	r21, r30, 8
	ld	r22, r30, 4
	fld	fr2, r0, 156
	fst	fr2, r7, 0
	li	r23, 0
	ld	r24, r13, 0
	st	r8, r3, 0
	st	r22, r3, 4
	fst	fr1, r3, 8
	st	r17, r3, 12
	st	r11, r3, 16
	st	r12, r3, 20
	st	r10, r3, 24
	st	r16, r3, 28
	st	r9, r3, 32
	st	r13, r3, 36
	st	r19, r3, 40
	st	r5, r3, 44
	st	r21, r3, 48
	st	r15, r3, 52
	st	r18, r3, 56
	st	r2, r3, 60
	st	r14, r3, 64
	st	r20, r3, 68
	st	r7, r3, 72
	mflr	r31
	mr	r5, r24
	mr	r30, r6
	mr	r6, r2
	mr	r2, r23
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 72
	fld	fr1, r2, 0
	fld	fr2, r0, 108
	fcmp	cr0, fr1, fr2
	blt	le.32754
	beq	le.32754
	li	r2, 1
	b	gt_cont.32755
le.32754:
	li	r2, 0
gt_cont.32755:
	cmpwi	cr0, r2, 0
	bne	beq_else.32756
	li	r2, 0
	b	beq_cont.32757
beq_else.32756:
	fld	fr2, r0, 160
	fcmp	cr0, fr2, fr1
	blt	le.32758
	beq	le.32758
	li	r2, 1
	b	gt_cont.32759
le.32758:
	li	r2, 0
gt_cont.32759:
beq_cont.32757:
	cmpwi	cr0, r2, 0
	bne	beq_else.32760
	blr
beq_else.32760:
	ld	r2, r3, 68
	ld	r2, r2, 0
	slwi	r2, r2, 2
	ld	r5, r3, 64
	add	r31, r5, r2
	ld	r2, r31, 0
	ld	r5, r3, 60
	ld	r5, r5, 0
	ld	r6, r2, 4
	st	r2, r3, 76
	cmpwi	cr0, r6, 1
	bne	beq_else.32762
	ld	r6, r3, 56
	ld	r6, r6, 0
	fld	fr1, r0, 44
	ld	r7, r3, 52
	fst	fr1, r7, 0
	fst	fr1, r7, 4
	fst	fr1, r7, 8
	addi	r8, r6, -1
	addi	r6, r6, -1
	slwi	r6, r6, 2
	add	r31, r5, r6
	fld	fr1, r31, 0
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.32764
	li	r5, 1
	b	beq_cont.32765
beq_else.32764:
	li	r5, 0
beq_cont.32765:
	cmpwi	cr0, r5, 0
	bne	beq_else.32766
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.32768
	beq	le.32768
	li	r5, 1
	b	gt_cont.32769
le.32768:
	li	r5, 0
gt_cont.32769:
	cmpwi	cr0, r5, 0
	bne	beq_else.32770
	fld	fr1, r0, 96
	b	beq_cont.32771
beq_else.32770:
	fld	fr1, r0, 16
beq_cont.32771:
	b	beq_cont.32767
beq_else.32766:
	fld	fr1, r0, 44
beq_cont.32767:
	fsub	fr1, fr0, fr1
	slwi	r5, r8, 2
	add	r31, r7, r5
	fst	fr1, r31, 0
	b	beq_cont.32763
beq_else.32762:
	cmpwi	cr0, r6, 2
	bne	beq_else.32772
	ld	r5, r2, 16
	fld	fr1, r5, 0
	fsub	fr1, fr0, fr1
	ld	r5, r3, 52
	fst	fr1, r5, 0
	ld	r6, r2, 16
	fld	fr1, r6, 4
	fsub	fr1, fr0, fr1
	fst	fr1, r5, 4
	ld	r6, r2, 16
	fld	fr1, r6, 8
	fsub	fr1, fr0, fr1
	fst	fr1, r5, 8
	b	beq_cont.32773
beq_else.32772:
	ld	r30, r3, 48
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
beq_cont.32773:
beq_cont.32763:
	ld	r2, r3, 76
	ld	r5, r3, 40
	ld	r30, r3, 44
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r2, r3, 36
	ld	r5, r2, 0
	ld	r2, r5, 0
	ld	r6, r2, 0
	cmpwi	cr0, r6, -1
	bne	beq_else.32774
	li	r2, 0
	b	beq_cont.32775
beq_else.32774:
	st	r2, r3, 80
	st	r5, r3, 84
	cmpwi	cr0, r6, 99
	bne	beq_else.32776
	li	r2, 1
	b	beq_cont.32777
beq_else.32776:
	ld	r7, r3, 28
	ld	r8, r3, 40
	ld	r30, r3, 32
	mflr	r31
	mr	r5, r7
	mr	r2, r6
	mr	r6, r8
	st	r31, r3, 92
	addi	r3, r3, 96
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32778
	li	r2, 0
	b	beq_cont.32779
beq_else.32778:
	fld	fr1, r0, 108
	ld	r2, r3, 24
	fld	fr2, r2, 0
	fcmp	cr0, fr1, fr2
	blt	le.32780
	beq	le.32780
	li	r2, 1
	b	gt_cont.32781
le.32780:
	li	r2, 0
gt_cont.32781:
	cmpwi	cr0, r2, 0
	bne	beq_else.32782
	li	r2, 0
	b	beq_cont.32783
beq_else.32782:
	li	r2, 1
	ld	r5, r3, 80
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32784
	li	r2, 0
	b	beq_cont.32785
beq_else.32784:
	li	r2, 1
beq_cont.32785:
beq_cont.32783:
beq_cont.32779:
beq_cont.32777:
	cmpwi	cr0, r2, 0
	bne	beq_else.32786
	li	r2, 1
	ld	r5, r3, 84
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	b	beq_cont.32787
beq_else.32786:
	li	r2, 1
	ld	r5, r3, 80
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32788
	li	r2, 1
	ld	r5, r3, 84
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	b	beq_cont.32789
beq_else.32788:
	li	r2, 1
beq_cont.32789:
beq_cont.32787:
beq_cont.32775:
	cmpwi	cr0, r2, 0
	bne	beq_else.32790
	ld	r2, r3, 52
	fld	fr1, r2, 0
	ld	r5, r3, 12
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
	fsub	fr1, fr0, fr1
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.32791
	beq	le.32791
	li	r2, 1
	b	gt_cont.32792
le.32791:
	li	r2, 0
gt_cont.32792:
	cmpwi	cr0, r2, 0
	bne	beq_else.32793
	fld	fr1, r0, 44
	b	beq_cont.32794
beq_else.32793:
beq_cont.32794:
	fld	fr2, r3, 8
	fmul	fr1, fr2, fr1
	ld	r2, r3, 76
	ld	r2, r2, 28
	fld	fr2, r2, 0
	fmul	fr1, fr1, fr2
	ld	r2, r3, 4
	fld	fr2, r2, 0
	ld	r5, r3, 0
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
beq_else.32790:
	blr
iter_trace_diffuse_rays.3091:
	ld	r8, r30, 80
	ld	r9, r30, 76
	ld	r10, r30, 72
	ld	r11, r30, 68
	ld	r12, r30, 64
	ld	r13, r30, 60
	ld	r14, r30, 56
	ld	r15, r30, 52
	ld	r16, r30, 48
	ld	r17, r30, 44
	ld	r18, r30, 40
	ld	r19, r30, 36
	ld	r20, r30, 32
	ld	r21, r30, 28
	ld	r22, r30, 24
	ld	r23, r30, 20
	ld	r24, r30, 16
	ld	r25, r30, 12
	ld	r26, r30, 8
	ld	r27, r30, 4
	cmpwi	cr0, r7, 0
	blt	bge_else.32797
	slwi	r28, r7, 2
	add	r31, r2, r28
	ld	r28, r31, 0
	ld	r28, r28, 0
	fld	fr1, r28, 0
	fld	fr2, r5, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r28, 4
	fld	fr3, r5, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r28, 8
	fld	fr3, r5, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32798
	beq	le.32798
	li	r28, 1
	b	gt_cont.32799
le.32798:
	li	r28, 0
gt_cont.32799:
	st	r6, r3, 0
	st	r30, r3, 4
	st	r10, r3, 8
	st	r5, r3, 12
	st	r2, r3, 16
	st	r7, r3, 20
	cmpwi	cr0, r28, 0
	bne	beq_else.32800
	slwi	r28, r7, 2
	add	r31, r2, r28
	ld	r28, r31, 0
	fld	fr2, r0, 180
	fdiv	fr1, fr1, fr2
	fld	fr2, r0, 156
	fst	fr2, r11, 0
	ld	r29, r18, 0
	ld	r6, r29, 0
	ld	r30, r6, 0
	st	r12, r3, 24
	st	r26, r3, 28
	fst	fr1, r3, 32
	st	r21, r3, 36
	st	r17, r3, 40
	st	r18, r3, 44
	st	r23, r3, 48
	st	r8, r3, 52
	st	r25, r3, 56
	st	r20, r3, 60
	st	r22, r3, 64
	st	r28, r3, 68
	st	r19, r3, 72
	st	r24, r3, 76
	st	r11, r3, 80
	cmpwi	cr0, r30, -1
	bne	beq_else.32802
	b	beq_cont.32803
beq_else.32802:
	st	r29, r3, 84
	st	r9, r3, 88
	cmpwi	cr0, r30, 99
	bne	beq_else.32804
	ld	r13, r6, 4
	cmpwi	cr0, r13, -1
	bne	beq_else.32806
	b	beq_cont.32807
beq_else.32806:
	slwi	r13, r13, 2
	add	r31, r27, r13
	ld	r13, r31, 0
	li	r14, 0
	st	r15, r3, 92
	st	r16, r3, 96
	st	r27, r3, 100
	st	r6, r3, 104
	mflr	r31
	mr	r6, r28
	mr	r5, r13
	mr	r2, r14
	mr	r30, r16
	st	r31, r3, 108
	addi	r3, r3, 112
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	ld	r2, r3, 104
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32808
	b	beq_cont.32809
beq_else.32808:
	slwi	r5, r5, 2
	ld	r6, r3, 100
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 68
	ld	r30, r3, 96
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 108
	addi	r3, r3, 112
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	ld	r2, r3, 104
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32810
	b	beq_cont.32811
beq_else.32810:
	slwi	r5, r5, 2
	ld	r6, r3, 100
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 68
	ld	r30, r3, 96
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 108
	addi	r3, r3, 112
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	ld	r2, r3, 104
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32812
	b	beq_cont.32813
beq_else.32812:
	slwi	r5, r5, 2
	ld	r6, r3, 100
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r6, 0
	ld	r7, r3, 68
	ld	r30, r3, 96
	mflr	r31
	mr	r2, r6
	mr	r6, r7
	st	r31, r3, 108
	addi	r3, r3, 112
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	li	r2, 5
	ld	r5, r3, 104
	ld	r6, r3, 68
	ld	r30, r3, 92
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
beq_cont.32813:
beq_cont.32811:
beq_cont.32809:
beq_cont.32807:
	b	beq_cont.32805
beq_else.32804:
	st	r15, r3, 92
	st	r16, r3, 96
	st	r27, r3, 100
	st	r6, r3, 104
	st	r14, r3, 108
	mflr	r31
	mr	r5, r28
	mr	r2, r30
	mr	r30, r13
	st	r31, r3, 116
	addi	r3, r3, 120
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32814
	b	beq_cont.32815
beq_else.32814:
	ld	r2, r3, 108
	fld	fr1, r2, 0
	ld	r2, r3, 80
	fld	fr2, r2, 0
	fcmp	cr0, fr2, fr1
	blt	le.32816
	beq	le.32816
	li	r5, 1
	b	gt_cont.32817
le.32816:
	li	r5, 0
gt_cont.32817:
	cmpwi	cr0, r5, 0
	bne	beq_else.32818
	b	beq_cont.32819
beq_else.32818:
	ld	r5, r3, 104
	ld	r6, r5, 4
	cmpwi	cr0, r6, -1
	bne	beq_else.32820
	b	beq_cont.32821
beq_else.32820:
	slwi	r6, r6, 2
	ld	r7, r3, 100
	add	r31, r7, r6
	ld	r6, r31, 0
	li	r8, 0
	ld	r9, r3, 68
	ld	r30, r3, 96
	mflr	r31
	mr	r5, r6
	mr	r2, r8
	mr	r6, r9
	st	r31, r3, 116
	addi	r3, r3, 120
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	ld	r2, r3, 104
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32822
	b	beq_cont.32823
beq_else.32822:
	slwi	r5, r5, 2
	ld	r6, r3, 100
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 68
	ld	r30, r3, 96
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 116
	addi	r3, r3, 120
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	ld	r2, r3, 104
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32824
	b	beq_cont.32825
beq_else.32824:
	slwi	r5, r5, 2
	ld	r6, r3, 100
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 68
	ld	r30, r3, 96
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 116
	addi	r3, r3, 120
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	ld	r2, r3, 104
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32826
	b	beq_cont.32827
beq_else.32826:
	slwi	r5, r5, 2
	ld	r6, r3, 100
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r6, 0
	ld	r7, r3, 68
	ld	r30, r3, 96
	mflr	r31
	mr	r2, r6
	mr	r6, r7
	st	r31, r3, 116
	addi	r3, r3, 120
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	li	r2, 5
	ld	r5, r3, 104
	ld	r6, r3, 68
	ld	r30, r3, 92
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
beq_cont.32827:
beq_cont.32825:
beq_cont.32823:
beq_cont.32821:
beq_cont.32819:
beq_cont.32815:
beq_cont.32805:
	li	r2, 1
	ld	r5, r3, 84
	ld	r6, r3, 68
	ld	r30, r3, 88
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
beq_cont.32803:
	ld	r2, r3, 80
	fld	fr1, r2, 0
	fld	fr2, r0, 108
	fcmp	cr0, fr1, fr2
	blt	le.32828
	beq	le.32828
	li	r2, 1
	b	gt_cont.32829
le.32828:
	li	r2, 0
gt_cont.32829:
	cmpwi	cr0, r2, 0
	bne	beq_else.32830
	li	r2, 0
	b	beq_cont.32831
beq_else.32830:
	fld	fr2, r0, 160
	fcmp	cr0, fr2, fr1
	blt	le.32832
	beq	le.32832
	li	r2, 1
	b	gt_cont.32833
le.32832:
	li	r2, 0
gt_cont.32833:
beq_cont.32831:
	cmpwi	cr0, r2, 0
	bne	beq_else.32834
	b	beq_cont.32835
beq_else.32834:
	ld	r2, r3, 76
	ld	r2, r2, 0
	slwi	r2, r2, 2
	ld	r5, r3, 72
	add	r31, r5, r2
	ld	r2, r31, 0
	ld	r5, r3, 68
	ld	r5, r5, 0
	ld	r6, r2, 4
	st	r2, r3, 112
	cmpwi	cr0, r6, 1
	bne	beq_else.32836
	ld	r6, r3, 64
	ld	r6, r6, 0
	fld	fr1, r0, 44
	ld	r7, r3, 60
	fst	fr1, r7, 0
	fst	fr1, r7, 4
	fst	fr1, r7, 8
	addi	r8, r6, -1
	addi	r6, r6, -1
	slwi	r6, r6, 2
	add	r31, r5, r6
	fld	fr1, r31, 0
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.32838
	li	r5, 1
	b	beq_cont.32839
beq_else.32838:
	li	r5, 0
beq_cont.32839:
	cmpwi	cr0, r5, 0
	bne	beq_else.32840
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.32842
	beq	le.32842
	li	r5, 1
	b	gt_cont.32843
le.32842:
	li	r5, 0
gt_cont.32843:
	cmpwi	cr0, r5, 0
	bne	beq_else.32844
	fld	fr1, r0, 96
	b	beq_cont.32845
beq_else.32844:
	fld	fr1, r0, 16
beq_cont.32845:
	b	beq_cont.32841
beq_else.32840:
	fld	fr1, r0, 44
beq_cont.32841:
	fsub	fr1, fr0, fr1
	slwi	r5, r8, 2
	add	r31, r7, r5
	fst	fr1, r31, 0
	b	beq_cont.32837
beq_else.32836:
	cmpwi	cr0, r6, 2
	bne	beq_else.32846
	ld	r5, r2, 16
	fld	fr1, r5, 0
	fsub	fr1, fr0, fr1
	ld	r5, r3, 60
	fst	fr1, r5, 0
	ld	r6, r2, 16
	fld	fr1, r6, 4
	fsub	fr1, fr0, fr1
	fst	fr1, r5, 4
	ld	r6, r2, 16
	fld	fr1, r6, 8
	fsub	fr1, fr0, fr1
	fst	fr1, r5, 8
	b	beq_cont.32847
beq_else.32846:
	ld	r30, r3, 56
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
beq_cont.32847:
beq_cont.32837:
	ld	r2, r3, 112
	ld	r5, r3, 48
	ld	r30, r3, 52
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	li	r2, 0
	ld	r5, r3, 44
	ld	r5, r5, 0
	ld	r30, r3, 40
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32848
	ld	r2, r3, 60
	fld	fr1, r2, 0
	ld	r5, r3, 36
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
	fsub	fr1, fr0, fr1
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.32850
	beq	le.32850
	li	r2, 1
	b	gt_cont.32851
le.32850:
	li	r2, 0
gt_cont.32851:
	cmpwi	cr0, r2, 0
	bne	beq_else.32852
	fld	fr1, r0, 44
	b	beq_cont.32853
beq_else.32852:
beq_cont.32853:
	fld	fr2, r3, 32
	fmul	fr1, fr2, fr1
	ld	r2, r3, 112
	ld	r2, r2, 28
	fld	fr2, r2, 0
	fmul	fr1, fr1, fr2
	ld	r2, r3, 28
	fld	fr2, r2, 0
	ld	r5, r3, 24
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
	b	beq_cont.32849
beq_else.32848:
beq_cont.32849:
beq_cont.32835:
	b	beq_cont.32801
beq_else.32800:
	addi	r28, r7, 1
	slwi	r28, r28, 2
	add	r31, r2, r28
	ld	r28, r31, 0
	fld	fr2, r0, 176
	fdiv	fr1, fr1, fr2
	fld	fr2, r0, 156
	fst	fr2, r11, 0
	ld	r29, r18, 0
	ld	r6, r29, 0
	ld	r30, r6, 0
	st	r12, r3, 24
	st	r26, r3, 28
	fst	fr1, r3, 116
	st	r21, r3, 36
	st	r17, r3, 40
	st	r18, r3, 44
	st	r23, r3, 48
	st	r8, r3, 52
	st	r25, r3, 56
	st	r20, r3, 60
	st	r22, r3, 64
	st	r28, r3, 120
	st	r19, r3, 72
	st	r24, r3, 76
	st	r11, r3, 80
	cmpwi	cr0, r30, -1
	bne	beq_else.32854
	b	beq_cont.32855
beq_else.32854:
	st	r29, r3, 124
	st	r9, r3, 88
	cmpwi	cr0, r30, 99
	bne	beq_else.32856
	ld	r13, r6, 4
	cmpwi	cr0, r13, -1
	bne	beq_else.32858
	b	beq_cont.32859
beq_else.32858:
	slwi	r13, r13, 2
	add	r31, r27, r13
	ld	r13, r31, 0
	li	r14, 0
	st	r15, r3, 92
	st	r16, r3, 96
	st	r27, r3, 100
	st	r6, r3, 128
	mflr	r31
	mr	r6, r28
	mr	r5, r13
	mr	r2, r14
	mr	r30, r16
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r2, r3, 128
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32860
	b	beq_cont.32861
beq_else.32860:
	slwi	r5, r5, 2
	ld	r6, r3, 100
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 120
	ld	r30, r3, 96
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r2, r3, 128
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32862
	b	beq_cont.32863
beq_else.32862:
	slwi	r5, r5, 2
	ld	r6, r3, 100
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 120
	ld	r30, r3, 96
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r2, r3, 128
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32864
	b	beq_cont.32865
beq_else.32864:
	slwi	r5, r5, 2
	ld	r6, r3, 100
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r6, 0
	ld	r7, r3, 120
	ld	r30, r3, 96
	mflr	r31
	mr	r2, r6
	mr	r6, r7
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	li	r2, 5
	ld	r5, r3, 128
	ld	r6, r3, 120
	ld	r30, r3, 92
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
beq_cont.32865:
beq_cont.32863:
beq_cont.32861:
beq_cont.32859:
	b	beq_cont.32857
beq_else.32856:
	st	r15, r3, 92
	st	r16, r3, 96
	st	r27, r3, 100
	st	r6, r3, 128
	st	r14, r3, 108
	mflr	r31
	mr	r5, r28
	mr	r2, r30
	mr	r30, r13
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32866
	b	beq_cont.32867
beq_else.32866:
	ld	r2, r3, 108
	fld	fr1, r2, 0
	ld	r2, r3, 80
	fld	fr2, r2, 0
	fcmp	cr0, fr2, fr1
	blt	le.32868
	beq	le.32868
	li	r5, 1
	b	gt_cont.32869
le.32868:
	li	r5, 0
gt_cont.32869:
	cmpwi	cr0, r5, 0
	bne	beq_else.32870
	b	beq_cont.32871
beq_else.32870:
	ld	r5, r3, 128
	ld	r6, r5, 4
	cmpwi	cr0, r6, -1
	bne	beq_else.32872
	b	beq_cont.32873
beq_else.32872:
	slwi	r6, r6, 2
	ld	r7, r3, 100
	add	r31, r7, r6
	ld	r6, r31, 0
	li	r8, 0
	ld	r9, r3, 120
	ld	r30, r3, 96
	mflr	r31
	mr	r5, r6
	mr	r2, r8
	mr	r6, r9
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r2, r3, 128
	ld	r5, r2, 8
	cmpwi	cr0, r5, -1
	bne	beq_else.32874
	b	beq_cont.32875
beq_else.32874:
	slwi	r5, r5, 2
	ld	r6, r3, 100
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 120
	ld	r30, r3, 96
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r2, r3, 128
	ld	r5, r2, 12
	cmpwi	cr0, r5, -1
	bne	beq_else.32876
	b	beq_cont.32877
beq_else.32876:
	slwi	r5, r5, 2
	ld	r6, r3, 100
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r7, 0
	ld	r8, r3, 120
	ld	r30, r3, 96
	mflr	r31
	mr	r6, r8
	mr	r2, r7
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r2, r3, 128
	ld	r5, r2, 16
	cmpwi	cr0, r5, -1
	bne	beq_else.32878
	b	beq_cont.32879
beq_else.32878:
	slwi	r5, r5, 2
	ld	r6, r3, 100
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r6, 0
	ld	r7, r3, 120
	ld	r30, r3, 96
	mflr	r31
	mr	r2, r6
	mr	r6, r7
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	li	r2, 5
	ld	r5, r3, 128
	ld	r6, r3, 120
	ld	r30, r3, 92
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
beq_cont.32879:
beq_cont.32877:
beq_cont.32875:
beq_cont.32873:
beq_cont.32871:
beq_cont.32867:
beq_cont.32857:
	li	r2, 1
	ld	r5, r3, 124
	ld	r6, r3, 120
	ld	r30, r3, 88
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
beq_cont.32855:
	ld	r2, r3, 80
	fld	fr1, r2, 0
	fld	fr2, r0, 108
	fcmp	cr0, fr1, fr2
	blt	le.32880
	beq	le.32880
	li	r2, 1
	b	gt_cont.32881
le.32880:
	li	r2, 0
gt_cont.32881:
	cmpwi	cr0, r2, 0
	bne	beq_else.32882
	li	r2, 0
	b	beq_cont.32883
beq_else.32882:
	fld	fr2, r0, 160
	fcmp	cr0, fr2, fr1
	blt	le.32884
	beq	le.32884
	li	r2, 1
	b	gt_cont.32885
le.32884:
	li	r2, 0
gt_cont.32885:
beq_cont.32883:
	cmpwi	cr0, r2, 0
	bne	beq_else.32886
	b	beq_cont.32887
beq_else.32886:
	ld	r2, r3, 76
	ld	r2, r2, 0
	slwi	r2, r2, 2
	ld	r5, r3, 72
	add	r31, r5, r2
	ld	r2, r31, 0
	ld	r5, r3, 120
	ld	r5, r5, 0
	ld	r6, r2, 4
	st	r2, r3, 132
	cmpwi	cr0, r6, 1
	bne	beq_else.32888
	ld	r6, r3, 64
	ld	r6, r6, 0
	fld	fr1, r0, 44
	ld	r7, r3, 60
	fst	fr1, r7, 0
	fst	fr1, r7, 4
	fst	fr1, r7, 8
	addi	r8, r6, -1
	addi	r6, r6, -1
	slwi	r6, r6, 2
	add	r31, r5, r6
	fld	fr1, r31, 0
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.32890
	li	r5, 1
	b	beq_cont.32891
beq_else.32890:
	li	r5, 0
beq_cont.32891:
	cmpwi	cr0, r5, 0
	bne	beq_else.32892
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.32894
	beq	le.32894
	li	r5, 1
	b	gt_cont.32895
le.32894:
	li	r5, 0
gt_cont.32895:
	cmpwi	cr0, r5, 0
	bne	beq_else.32896
	fld	fr1, r0, 96
	b	beq_cont.32897
beq_else.32896:
	fld	fr1, r0, 16
beq_cont.32897:
	b	beq_cont.32893
beq_else.32892:
	fld	fr1, r0, 44
beq_cont.32893:
	fsub	fr1, fr0, fr1
	slwi	r5, r8, 2
	add	r31, r7, r5
	fst	fr1, r31, 0
	b	beq_cont.32889
beq_else.32888:
	cmpwi	cr0, r6, 2
	bne	beq_else.32898
	ld	r5, r2, 16
	fld	fr1, r5, 0
	fsub	fr1, fr0, fr1
	ld	r5, r3, 60
	fst	fr1, r5, 0
	ld	r6, r2, 16
	fld	fr1, r6, 4
	fsub	fr1, fr0, fr1
	fst	fr1, r5, 4
	ld	r6, r2, 16
	fld	fr1, r6, 8
	fsub	fr1, fr0, fr1
	fst	fr1, r5, 8
	b	beq_cont.32899
beq_else.32898:
	ld	r30, r3, 56
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
beq_cont.32899:
beq_cont.32889:
	ld	r2, r3, 132
	ld	r5, r3, 48
	ld	r30, r3, 52
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	li	r2, 0
	ld	r5, r3, 44
	ld	r5, r5, 0
	ld	r30, r3, 40
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	beq_else.32900
	ld	r2, r3, 60
	fld	fr1, r2, 0
	ld	r5, r3, 36
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
	fsub	fr1, fr0, fr1
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	blt	le.32902
	beq	le.32902
	li	r2, 1
	b	gt_cont.32903
le.32902:
	li	r2, 0
gt_cont.32903:
	cmpwi	cr0, r2, 0
	bne	beq_else.32904
	fld	fr1, r0, 44
	b	beq_cont.32905
beq_else.32904:
beq_cont.32905:
	fld	fr2, r3, 116
	fmul	fr1, fr2, fr1
	ld	r2, r3, 132
	ld	r2, r2, 28
	fld	fr2, r2, 0
	fmul	fr1, fr1, fr2
	ld	r2, r3, 28
	fld	fr2, r2, 0
	ld	r5, r3, 24
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
	b	beq_cont.32901
beq_else.32900:
beq_cont.32901:
beq_cont.32887:
beq_cont.32801:
	ld	r2, r3, 20
	addi	r2, r2, -2
	cmpwi	cr0, r2, 0
	blt	bge_else.32906
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r5, r5, 0
	fld	fr1, r5, 0
	ld	r7, r3, 12
	fld	fr2, r7, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r5, 4
	fld	fr3, r7, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r5, 8
	fld	fr3, r7, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32907
	beq	le.32907
	li	r5, 1
	b	gt_cont.32908
le.32907:
	li	r5, 0
gt_cont.32908:
	st	r2, r3, 136
	cmpwi	cr0, r5, 0
	bne	beq_else.32909
	slwi	r5, r2, 2
	add	r31, r6, r5
	ld	r5, r31, 0
	fld	fr2, r0, 180
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 8
	mflr	r31
	mr	r2, r5
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	b	beq_cont.32910
beq_else.32909:
	addi	r5, r2, 1
	slwi	r5, r5, 2
	add	r31, r6, r5
	ld	r5, r31, 0
	fld	fr2, r0, 176
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 8
	mflr	r31
	mr	r2, r5
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
beq_cont.32910:
	ld	r2, r3, 136
	addi	r7, r2, -2
	ld	r2, r3, 16
	ld	r5, r3, 12
	ld	r6, r3, 0
	ld	r30, r3, 4
	ld	r29, r30, 0
	ba	r29
bge_else.32906:
	blr
bge_else.32797:
	blr
trace_diffuse_ray_80percent.3100:
	ld	r7, r30, 20
	ld	r8, r30, 16
	ld	r9, r30, 12
	ld	r10, r30, 8
	ld	r11, r30, 4
	st	r5, r3, 0
	st	r10, r3, 4
	st	r8, r3, 8
	st	r9, r3, 12
	st	r7, r3, 16
	st	r6, r3, 20
	st	r11, r3, 24
	st	r2, r3, 28
	cmpwi	cr0, r2, 0
	bne	beq_else.32913
	b	beq_cont.32914
beq_else.32913:
	ld	r12, r11, 0
	fld	fr1, r6, 0
	fst	fr1, r7, 0
	fld	fr1, r6, 4
	fst	fr1, r7, 4
	fld	fr1, r6, 8
	fst	fr1, r7, 8
	ld	r13, r9, 0
	addi	r13, r13, -1
	st	r12, r3, 32
	mflr	r31
	mr	r5, r13
	mr	r2, r6
	mr	r30, r8
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	li	r7, 118
	ld	r2, r3, 32
	ld	r5, r3, 0
	ld	r6, r3, 20
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
beq_cont.32914:
	ld	r2, r3, 28
	cmpwi	cr0, r2, 1
	bne	beq_else.32915
	b	beq_cont.32916
beq_else.32915:
	ld	r5, r3, 24
	ld	r6, r5, 4
	ld	r7, r3, 20
	fld	fr1, r7, 0
	ld	r8, r3, 16
	fst	fr1, r8, 0
	fld	fr1, r7, 4
	fst	fr1, r8, 4
	fld	fr1, r7, 8
	fst	fr1, r8, 8
	ld	r9, r3, 12
	ld	r10, r9, 0
	addi	r10, r10, -1
	ld	r30, r3, 8
	st	r6, r3, 36
	mflr	r31
	mr	r5, r10
	mr	r2, r7
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	li	r7, 118
	ld	r2, r3, 36
	ld	r5, r3, 0
	ld	r6, r3, 20
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
beq_cont.32916:
	ld	r2, r3, 28
	cmpwi	cr0, r2, 2
	bne	beq_else.32917
	b	beq_cont.32918
beq_else.32917:
	ld	r5, r3, 24
	ld	r6, r5, 8
	ld	r7, r3, 20
	fld	fr1, r7, 0
	ld	r8, r3, 16
	fst	fr1, r8, 0
	fld	fr1, r7, 4
	fst	fr1, r8, 4
	fld	fr1, r7, 8
	fst	fr1, r8, 8
	ld	r9, r3, 12
	ld	r10, r9, 0
	addi	r10, r10, -1
	ld	r30, r3, 8
	st	r6, r3, 40
	mflr	r31
	mr	r5, r10
	mr	r2, r7
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	li	r7, 118
	ld	r2, r3, 40
	ld	r5, r3, 0
	ld	r6, r3, 20
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
beq_cont.32918:
	ld	r2, r3, 28
	cmpwi	cr0, r2, 3
	bne	beq_else.32919
	b	beq_cont.32920
beq_else.32919:
	ld	r5, r3, 24
	ld	r6, r5, 12
	ld	r7, r3, 20
	fld	fr1, r7, 0
	ld	r8, r3, 16
	fst	fr1, r8, 0
	fld	fr1, r7, 4
	fst	fr1, r8, 4
	fld	fr1, r7, 8
	fst	fr1, r8, 8
	ld	r9, r3, 12
	ld	r10, r9, 0
	addi	r10, r10, -1
	ld	r30, r3, 8
	st	r6, r3, 44
	mflr	r31
	mr	r5, r10
	mr	r2, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	li	r7, 118
	ld	r2, r3, 44
	ld	r5, r3, 0
	ld	r6, r3, 20
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
beq_cont.32920:
	ld	r2, r3, 28
	cmpwi	cr0, r2, 4
	bne	beq_else.32921
	blr
beq_else.32921:
	ld	r2, r3, 24
	ld	r2, r2, 16
	ld	r5, r3, 20
	fld	fr1, r5, 0
	ld	r6, r3, 16
	fst	fr1, r6, 0
	fld	fr1, r5, 4
	fst	fr1, r6, 4
	fld	fr1, r5, 8
	fst	fr1, r6, 8
	ld	r6, r3, 12
	ld	r6, r6, 0
	addi	r6, r6, -1
	ld	r30, r3, 8
	st	r2, r3, 48
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	li	r7, 118
	ld	r2, r3, 48
	ld	r5, r3, 0
	ld	r6, r3, 20
	ld	r30, r3, 4
	ld	r29, r30, 0
	ba	r29
calc_diffuse_using_1point.3104:
	ld	r6, r30, 32
	ld	r7, r30, 28
	ld	r8, r30, 24
	ld	r9, r30, 20
	ld	r10, r30, 16
	ld	r11, r30, 12
	ld	r12, r30, 8
	ld	r13, r30, 4
	ld	r14, r2, 20
	ld	r15, r2, 28
	ld	r16, r2, 4
	ld	r17, r2, 16
	slwi	r18, r5, 2
	add	r31, r14, r18
	ld	r14, r31, 0
	fld	fr1, r14, 0
	fst	fr1, r13, 0
	fld	fr1, r14, 4
	fst	fr1, r13, 4
	fld	fr1, r14, 8
	fst	fr1, r13, 8
	ld	r2, r2, 24
	ld	r2, r2, 0
	slwi	r14, r5, 2
	add	r31, r15, r14
	ld	r14, r31, 0
	slwi	r15, r5, 2
	add	r31, r16, r15
	ld	r15, r31, 0
	st	r13, r3, 0
	st	r9, r3, 4
	st	r17, r3, 8
	st	r5, r3, 12
	st	r11, r3, 16
	st	r6, r3, 20
	st	r14, r3, 24
	st	r8, r3, 28
	st	r10, r3, 32
	st	r7, r3, 36
	st	r15, r3, 40
	st	r12, r3, 44
	st	r2, r3, 48
	cmpwi	cr0, r2, 0
	bne	beq_else.32923
	b	beq_cont.32924
beq_else.32923:
	ld	r16, r12, 0
	fld	fr1, r15, 0
	fst	fr1, r7, 0
	fld	fr1, r15, 4
	fst	fr1, r7, 4
	fld	fr1, r15, 8
	fst	fr1, r7, 8
	ld	r18, r10, 0
	addi	r18, r18, -1
	st	r16, r3, 52
	mflr	r31
	mr	r5, r18
	mr	r2, r15
	mr	r30, r8
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 52
	ld	r5, r2, 472
	ld	r5, r5, 0
	fld	fr1, r5, 0
	ld	r6, r3, 24
	fld	fr2, r6, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r5, 4
	fld	fr3, r6, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r5, 8
	fld	fr3, r6, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32925
	beq	le.32925
	li	r5, 1
	b	gt_cont.32926
le.32925:
	li	r5, 0
gt_cont.32926:
	cmpwi	cr0, r5, 0
	bne	beq_else.32927
	ld	r5, r2, 472
	fld	fr2, r0, 180
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	b	beq_cont.32928
beq_else.32927:
	ld	r5, r2, 476
	fld	fr2, r0, 176
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
beq_cont.32928:
	li	r7, 116
	ld	r2, r3, 52
	ld	r5, r3, 24
	ld	r6, r3, 40
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
beq_cont.32924:
	ld	r2, r3, 48
	cmpwi	cr0, r2, 1
	bne	beq_else.32929
	b	beq_cont.32930
beq_else.32929:
	ld	r5, r3, 44
	ld	r6, r5, 4
	ld	r7, r3, 40
	fld	fr1, r7, 0
	ld	r8, r3, 36
	fst	fr1, r8, 0
	fld	fr1, r7, 4
	fst	fr1, r8, 4
	fld	fr1, r7, 8
	fst	fr1, r8, 8
	ld	r9, r3, 32
	ld	r10, r9, 0
	addi	r10, r10, -1
	ld	r30, r3, 28
	st	r6, r3, 56
	mflr	r31
	mr	r5, r10
	mr	r2, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 56
	ld	r5, r2, 472
	ld	r5, r5, 0
	fld	fr1, r5, 0
	ld	r6, r3, 24
	fld	fr2, r6, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r5, 4
	fld	fr3, r6, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r5, 8
	fld	fr3, r6, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32931
	beq	le.32931
	li	r5, 1
	b	gt_cont.32932
le.32931:
	li	r5, 0
gt_cont.32932:
	cmpwi	cr0, r5, 0
	bne	beq_else.32933
	ld	r5, r2, 472
	fld	fr2, r0, 180
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	b	beq_cont.32934
beq_else.32933:
	ld	r5, r2, 476
	fld	fr2, r0, 176
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
beq_cont.32934:
	li	r7, 116
	ld	r2, r3, 56
	ld	r5, r3, 24
	ld	r6, r3, 40
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
beq_cont.32930:
	ld	r2, r3, 48
	cmpwi	cr0, r2, 2
	bne	beq_else.32935
	b	beq_cont.32936
beq_else.32935:
	ld	r5, r3, 44
	ld	r6, r5, 8
	ld	r7, r3, 40
	fld	fr1, r7, 0
	ld	r8, r3, 36
	fst	fr1, r8, 0
	fld	fr1, r7, 4
	fst	fr1, r8, 4
	fld	fr1, r7, 8
	fst	fr1, r8, 8
	ld	r9, r3, 32
	ld	r10, r9, 0
	addi	r10, r10, -1
	ld	r30, r3, 28
	st	r6, r3, 60
	mflr	r31
	mr	r5, r10
	mr	r2, r7
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 60
	ld	r5, r2, 472
	ld	r5, r5, 0
	fld	fr1, r5, 0
	ld	r6, r3, 24
	fld	fr2, r6, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r5, 4
	fld	fr3, r6, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r5, 8
	fld	fr3, r6, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32937
	beq	le.32937
	li	r5, 1
	b	gt_cont.32938
le.32937:
	li	r5, 0
gt_cont.32938:
	cmpwi	cr0, r5, 0
	bne	beq_else.32939
	ld	r5, r2, 472
	fld	fr2, r0, 180
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	b	beq_cont.32940
beq_else.32939:
	ld	r5, r2, 476
	fld	fr2, r0, 176
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
beq_cont.32940:
	li	r7, 116
	ld	r2, r3, 60
	ld	r5, r3, 24
	ld	r6, r3, 40
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
beq_cont.32936:
	ld	r2, r3, 48
	cmpwi	cr0, r2, 3
	bne	beq_else.32941
	b	beq_cont.32942
beq_else.32941:
	ld	r5, r3, 44
	ld	r6, r5, 12
	ld	r7, r3, 40
	fld	fr1, r7, 0
	ld	r8, r3, 36
	fst	fr1, r8, 0
	fld	fr1, r7, 4
	fst	fr1, r8, 4
	fld	fr1, r7, 8
	fst	fr1, r8, 8
	ld	r9, r3, 32
	ld	r10, r9, 0
	addi	r10, r10, -1
	ld	r30, r3, 28
	st	r6, r3, 64
	mflr	r31
	mr	r5, r10
	mr	r2, r7
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 64
	ld	r5, r2, 472
	ld	r5, r5, 0
	fld	fr1, r5, 0
	ld	r6, r3, 24
	fld	fr2, r6, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r5, 4
	fld	fr3, r6, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r5, 8
	fld	fr3, r6, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32943
	beq	le.32943
	li	r5, 1
	b	gt_cont.32944
le.32943:
	li	r5, 0
gt_cont.32944:
	cmpwi	cr0, r5, 0
	bne	beq_else.32945
	ld	r5, r2, 472
	fld	fr2, r0, 180
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	b	beq_cont.32946
beq_else.32945:
	ld	r5, r2, 476
	fld	fr2, r0, 176
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
beq_cont.32946:
	li	r7, 116
	ld	r2, r3, 64
	ld	r5, r3, 24
	ld	r6, r3, 40
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
beq_cont.32942:
	ld	r2, r3, 48
	cmpwi	cr0, r2, 4
	bne	beq_else.32947
	b	beq_cont.32948
beq_else.32947:
	ld	r2, r3, 44
	ld	r2, r2, 16
	ld	r5, r3, 40
	fld	fr1, r5, 0
	ld	r6, r3, 36
	fst	fr1, r6, 0
	fld	fr1, r5, 4
	fst	fr1, r6, 4
	fld	fr1, r5, 8
	fst	fr1, r6, 8
	ld	r6, r3, 32
	ld	r6, r6, 0
	addi	r6, r6, -1
	ld	r30, r3, 28
	st	r2, r3, 68
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 68
	ld	r5, r2, 472
	ld	r5, r5, 0
	fld	fr1, r5, 0
	ld	r6, r3, 24
	fld	fr2, r6, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r5, 4
	fld	fr3, r6, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r5, 8
	fld	fr3, r6, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.32949
	beq	le.32949
	li	r5, 1
	b	gt_cont.32950
le.32949:
	li	r5, 0
gt_cont.32950:
	cmpwi	cr0, r5, 0
	bne	beq_else.32951
	ld	r5, r2, 472
	fld	fr2, r0, 180
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	b	beq_cont.32952
beq_else.32951:
	ld	r5, r2, 476
	fld	fr2, r0, 176
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
beq_cont.32952:
	li	r7, 116
	ld	r2, r3, 68
	ld	r5, r3, 24
	ld	r6, r3, 40
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
beq_cont.32948:
	ld	r2, r3, 12
	slwi	r2, r2, 2
	ld	r5, r3, 8
	add	r31, r5, r2
	ld	r2, r31, 0
	ld	r5, r3, 4
	fld	fr1, r5, 0
	fld	fr2, r2, 0
	ld	r6, r3, 0
	fld	fr3, r6, 0
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 0
	fld	fr1, r5, 4
	fld	fr2, r2, 4
	fld	fr3, r6, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 4
	fld	fr1, r5, 8
	fld	fr2, r2, 8
	fld	fr3, r6, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 8
	blr
calc_diffuse_using_5points.3107:
	ld	r9, r30, 8
	ld	r10, r30, 4
	slwi	r11, r2, 2
	add	r31, r5, r11
	ld	r5, r31, 0
	ld	r5, r5, 20
	addi	r11, r2, -1
	slwi	r11, r11, 2
	add	r31, r6, r11
	ld	r11, r31, 0
	ld	r11, r11, 20
	slwi	r12, r2, 2
	add	r31, r6, r12
	ld	r12, r31, 0
	ld	r12, r12, 20
	addi	r13, r2, 1
	slwi	r13, r13, 2
	add	r31, r6, r13
	ld	r13, r31, 0
	ld	r13, r13, 20
	slwi	r14, r2, 2
	add	r31, r7, r14
	ld	r7, r31, 0
	ld	r7, r7, 20
	slwi	r14, r8, 2
	add	r31, r5, r14
	ld	r5, r31, 0
	fld	fr1, r5, 0
	fst	fr1, r10, 0
	fld	fr1, r5, 4
	fst	fr1, r10, 4
	fld	fr1, r5, 8
	fst	fr1, r10, 8
	slwi	r5, r8, 2
	add	r31, r11, r5
	ld	r5, r31, 0
	fld	fr1, r10, 0
	fld	fr2, r5, 0
	fadd	fr1, fr1, fr2
	fst	fr1, r10, 0
	fld	fr1, r10, 4
	fld	fr2, r5, 4
	fadd	fr1, fr1, fr2
	fst	fr1, r10, 4
	fld	fr1, r10, 8
	fld	fr2, r5, 8
	fadd	fr1, fr1, fr2
	fst	fr1, r10, 8
	slwi	r5, r8, 2
	add	r31, r12, r5
	ld	r5, r31, 0
	fld	fr1, r10, 0
	fld	fr2, r5, 0
	fadd	fr1, fr1, fr2
	fst	fr1, r10, 0
	fld	fr1, r10, 4
	fld	fr2, r5, 4
	fadd	fr1, fr1, fr2
	fst	fr1, r10, 4
	fld	fr1, r10, 8
	fld	fr2, r5, 8
	fadd	fr1, fr1, fr2
	fst	fr1, r10, 8
	slwi	r5, r8, 2
	add	r31, r13, r5
	ld	r5, r31, 0
	fld	fr1, r10, 0
	fld	fr2, r5, 0
	fadd	fr1, fr1, fr2
	fst	fr1, r10, 0
	fld	fr1, r10, 4
	fld	fr2, r5, 4
	fadd	fr1, fr1, fr2
	fst	fr1, r10, 4
	fld	fr1, r10, 8
	fld	fr2, r5, 8
	fadd	fr1, fr1, fr2
	fst	fr1, r10, 8
	slwi	r5, r8, 2
	add	r31, r7, r5
	ld	r5, r31, 0
	fld	fr1, r10, 0
	fld	fr2, r5, 0
	fadd	fr1, fr1, fr2
	fst	fr1, r10, 0
	fld	fr1, r10, 4
	fld	fr2, r5, 4
	fadd	fr1, fr1, fr2
	fst	fr1, r10, 4
	fld	fr1, r10, 8
	fld	fr2, r5, 8
	fadd	fr1, fr1, fr2
	fst	fr1, r10, 8
	slwi	r2, r2, 2
	add	r31, r6, r2
	ld	r2, r31, 0
	ld	r2, r2, 16
	slwi	r5, r8, 2
	add	r31, r2, r5
	ld	r2, r31, 0
	fld	fr1, r9, 0
	fld	fr2, r2, 0
	fld	fr3, r10, 0
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r9, 0
	fld	fr1, r9, 4
	fld	fr2, r2, 4
	fld	fr3, r10, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r9, 4
	fld	fr1, r9, 8
	fld	fr2, r2, 8
	fld	fr3, r10, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r9, 8
	blr
do_without_neighbors.3113:
	ld	r6, r30, 36
	ld	r7, r30, 32
	ld	r8, r30, 28
	ld	r9, r30, 24
	ld	r10, r30, 20
	ld	r11, r30, 16
	ld	r12, r30, 12
	ld	r13, r30, 8
	ld	r14, r30, 4
	cmpwi	cr0, r5, 4
	blt	le.32955
	beq	le.32955
	blr
le.32955:
	ld	r15, r2, 8
	slwi	r16, r5, 2
	add	r31, r15, r16
	ld	r15, r31, 0
	cmpwi	cr0, r15, 0
	blt	bge_else.32957
	ld	r15, r2, 12
	slwi	r16, r5, 2
	add	r31, r15, r16
	ld	r15, r31, 0
	st	r30, r3, 0
	st	r9, r3, 4
	st	r6, r3, 8
	st	r13, r3, 12
	st	r14, r3, 16
	st	r2, r3, 20
	st	r5, r3, 24
	cmpwi	cr0, r15, 0
	bne	beq_else.32958
	b	beq_cont.32959
beq_else.32958:
	ld	r15, r2, 20
	ld	r16, r2, 28
	ld	r17, r2, 4
	ld	r18, r2, 16
	slwi	r19, r5, 2
	add	r31, r15, r19
	ld	r15, r31, 0
	fld	fr1, r15, 0
	fst	fr1, r13, 0
	fld	fr1, r15, 4
	fst	fr1, r13, 4
	fld	fr1, r15, 8
	fst	fr1, r13, 8
	ld	r15, r2, 24
	ld	r15, r15, 0
	slwi	r19, r5, 2
	add	r31, r16, r19
	ld	r16, r31, 0
	slwi	r19, r5, 2
	add	r31, r17, r19
	ld	r17, r31, 0
	st	r18, r3, 28
	st	r16, r3, 32
	st	r11, r3, 36
	st	r8, r3, 40
	st	r10, r3, 44
	st	r7, r3, 48
	st	r17, r3, 52
	st	r12, r3, 56
	st	r15, r3, 60
	cmpwi	cr0, r15, 0
	bne	beq_else.32960
	b	beq_cont.32961
beq_else.32960:
	ld	r19, r12, 0
	fld	fr1, r17, 0
	fst	fr1, r7, 0
	fld	fr1, r17, 4
	fst	fr1, r7, 4
	fld	fr1, r17, 8
	fst	fr1, r7, 8
	ld	r20, r10, 0
	addi	r20, r20, -1
	st	r19, r3, 64
	mflr	r31
	mr	r5, r20
	mr	r2, r17
	mr	r30, r8
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	li	r7, 118
	ld	r2, r3, 64
	ld	r5, r3, 32
	ld	r6, r3, 52
	ld	r30, r3, 36
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
beq_cont.32961:
	ld	r2, r3, 60
	cmpwi	cr0, r2, 1
	bne	beq_else.32962
	b	beq_cont.32963
beq_else.32962:
	ld	r5, r3, 56
	ld	r6, r5, 4
	ld	r7, r3, 52
	fld	fr1, r7, 0
	ld	r8, r3, 48
	fst	fr1, r8, 0
	fld	fr1, r7, 4
	fst	fr1, r8, 4
	fld	fr1, r7, 8
	fst	fr1, r8, 8
	ld	r9, r3, 44
	ld	r10, r9, 0
	addi	r10, r10, -1
	ld	r30, r3, 40
	st	r6, r3, 68
	mflr	r31
	mr	r5, r10
	mr	r2, r7
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	li	r7, 118
	ld	r2, r3, 68
	ld	r5, r3, 32
	ld	r6, r3, 52
	ld	r30, r3, 36
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
beq_cont.32963:
	ld	r2, r3, 60
	cmpwi	cr0, r2, 2
	bne	beq_else.32964
	b	beq_cont.32965
beq_else.32964:
	ld	r5, r3, 56
	ld	r6, r5, 8
	ld	r7, r3, 52
	fld	fr1, r7, 0
	ld	r8, r3, 48
	fst	fr1, r8, 0
	fld	fr1, r7, 4
	fst	fr1, r8, 4
	fld	fr1, r7, 8
	fst	fr1, r8, 8
	ld	r9, r3, 44
	ld	r10, r9, 0
	addi	r10, r10, -1
	ld	r30, r3, 40
	st	r6, r3, 72
	mflr	r31
	mr	r5, r10
	mr	r2, r7
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	li	r7, 118
	ld	r2, r3, 72
	ld	r5, r3, 32
	ld	r6, r3, 52
	ld	r30, r3, 36
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
beq_cont.32965:
	ld	r2, r3, 60
	cmpwi	cr0, r2, 3
	bne	beq_else.32966
	b	beq_cont.32967
beq_else.32966:
	ld	r5, r3, 56
	ld	r6, r5, 12
	ld	r7, r3, 52
	fld	fr1, r7, 0
	ld	r8, r3, 48
	fst	fr1, r8, 0
	fld	fr1, r7, 4
	fst	fr1, r8, 4
	fld	fr1, r7, 8
	fst	fr1, r8, 8
	ld	r9, r3, 44
	ld	r10, r9, 0
	addi	r10, r10, -1
	ld	r30, r3, 40
	st	r6, r3, 76
	mflr	r31
	mr	r5, r10
	mr	r2, r7
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	li	r7, 118
	ld	r2, r3, 76
	ld	r5, r3, 32
	ld	r6, r3, 52
	ld	r30, r3, 36
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
beq_cont.32967:
	ld	r2, r3, 60
	cmpwi	cr0, r2, 4
	bne	beq_else.32968
	b	beq_cont.32969
beq_else.32968:
	ld	r2, r3, 56
	ld	r2, r2, 16
	ld	r5, r3, 52
	fld	fr1, r5, 0
	ld	r6, r3, 48
	fst	fr1, r6, 0
	fld	fr1, r5, 4
	fst	fr1, r6, 4
	fld	fr1, r5, 8
	fst	fr1, r6, 8
	ld	r6, r3, 44
	ld	r6, r6, 0
	addi	r6, r6, -1
	ld	r30, r3, 40
	st	r2, r3, 80
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	li	r7, 118
	ld	r2, r3, 80
	ld	r5, r3, 32
	ld	r6, r3, 52
	ld	r30, r3, 36
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
beq_cont.32969:
	ld	r2, r3, 24
	slwi	r5, r2, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r6, r3, 4
	fld	fr1, r6, 0
	fld	fr2, r5, 0
	ld	r7, r3, 12
	fld	fr3, r7, 0
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r6, 0
	fld	fr1, r6, 4
	fld	fr2, r5, 4
	fld	fr3, r7, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r6, 4
	fld	fr1, r6, 8
	fld	fr2, r5, 8
	fld	fr3, r7, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r6, 8
beq_cont.32959:
	ld	r2, r3, 24
	addi	r5, r2, 1
	cmpwi	cr0, r5, 4
	blt	le.32970
	beq	le.32970
	blr
le.32970:
	ld	r2, r3, 20
	ld	r6, r2, 8
	slwi	r7, r5, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	cmpwi	cr0, r6, 0
	blt	bge_else.32972
	ld	r6, r2, 12
	slwi	r7, r5, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	st	r5, r3, 84
	cmpwi	cr0, r6, 0
	bne	beq_else.32973
	b	beq_cont.32974
beq_else.32973:
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
beq_cont.32974:
	ld	r2, r3, 84
	addi	r2, r2, 1
	cmpwi	cr0, r2, 4
	blt	le.32975
	beq	le.32975
	blr
le.32975:
	ld	r5, r3, 20
	ld	r6, r5, 8
	slwi	r7, r2, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	cmpwi	cr0, r6, 0
	blt	bge_else.32977
	ld	r6, r5, 12
	slwi	r7, r2, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	cmpwi	cr0, r6, 0
	bne	beq_else.32978
	b	beq_cont.32979
beq_else.32978:
	ld	r6, r5, 20
	ld	r7, r5, 28
	ld	r8, r5, 4
	ld	r9, r5, 16
	slwi	r10, r2, 2
	add	r31, r6, r10
	ld	r6, r31, 0
	fld	fr1, r6, 0
	ld	r10, r3, 12
	fst	fr1, r10, 0
	fld	fr1, r6, 4
	fst	fr1, r10, 4
	fld	fr1, r6, 8
	fst	fr1, r10, 8
	ld	r6, r5, 24
	ld	r6, r6, 0
	slwi	r11, r2, 2
	add	r31, r7, r11
	ld	r7, r31, 0
	slwi	r11, r2, 2
	add	r31, r8, r11
	ld	r8, r31, 0
	ld	r30, r3, 8
	st	r9, r3, 88
	st	r2, r3, 92
	mflr	r31
	mr	r5, r7
	mr	r2, r6
	mr	r6, r8
	st	r31, r3, 100
	addi	r3, r3, 104
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r2, r3, 92
	slwi	r5, r2, 2
	ld	r6, r3, 88
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r6, r3, 4
	fld	fr1, r6, 0
	fld	fr2, r5, 0
	ld	r7, r3, 12
	fld	fr3, r7, 0
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r6, 0
	fld	fr1, r6, 4
	fld	fr2, r5, 4
	fld	fr3, r7, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r6, 4
	fld	fr1, r6, 8
	fld	fr2, r5, 8
	fld	fr3, r7, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r6, 8
beq_cont.32979:
	addi	r5, r2, 1
	cmpwi	cr0, r5, 4
	blt	le.32980
	beq	le.32980
	blr
le.32980:
	ld	r2, r3, 20
	ld	r6, r2, 8
	slwi	r7, r5, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	cmpwi	cr0, r6, 0
	blt	bge_else.32982
	ld	r6, r2, 12
	slwi	r7, r5, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	st	r5, r3, 96
	cmpwi	cr0, r6, 0
	bne	beq_else.32983
	b	beq_cont.32984
beq_else.32983:
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
beq_cont.32984:
	ld	r2, r3, 96
	addi	r5, r2, 1
	ld	r2, r3, 20
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
bge_else.32982:
	blr
bge_else.32977:
	blr
bge_else.32972:
	blr
bge_else.32957:
	blr
try_exploit_neighbors.3129:
	ld	r10, r30, 24
	ld	r11, r30, 20
	ld	r12, r30, 16
	ld	r13, r30, 12
	ld	r14, r30, 8
	ld	r15, r30, 4
	slwi	r16, r2, 2
	add	r31, r7, r16
	ld	r16, r31, 0
	cmpwi	cr0, r9, 4
	blt	le.32989
	beq	le.32989
	blr
le.32989:
	ld	r17, r16, 8
	slwi	r18, r9, 2
	add	r31, r17, r18
	ld	r17, r31, 0
	cmpwi	cr0, r17, 0
	blt	bge_else.32991
	slwi	r17, r2, 2
	add	r31, r7, r17
	ld	r17, r31, 0
	ld	r17, r17, 8
	slwi	r18, r9, 2
	add	r31, r17, r18
	ld	r17, r31, 0
	slwi	r18, r2, 2
	add	r31, r6, r18
	ld	r18, r31, 0
	ld	r18, r18, 8
	slwi	r19, r9, 2
	add	r31, r18, r19
	ld	r18, r31, 0
	cmpw	cr0, r18, r17
	bne	beq_else.32992
	slwi	r18, r2, 2
	add	r31, r8, r18
	ld	r18, r31, 0
	ld	r18, r18, 8
	slwi	r19, r9, 2
	add	r31, r18, r19
	ld	r18, r31, 0
	cmpw	cr0, r18, r17
	bne	beq_else.32994
	addi	r18, r2, -1
	slwi	r18, r18, 2
	add	r31, r7, r18
	ld	r18, r31, 0
	ld	r18, r18, 8
	slwi	r19, r9, 2
	add	r31, r18, r19
	ld	r18, r31, 0
	cmpw	cr0, r18, r17
	bne	beq_else.32996
	addi	r18, r2, 1
	slwi	r18, r18, 2
	add	r31, r7, r18
	ld	r18, r31, 0
	ld	r18, r18, 8
	slwi	r19, r9, 2
	add	r31, r18, r19
	ld	r18, r31, 0
	cmpw	cr0, r18, r17
	bne	beq_else.32998
	li	r17, 1
	b	beq_cont.32999
beq_else.32998:
	li	r17, 0
beq_cont.32999:
	b	beq_cont.32997
beq_else.32996:
	li	r17, 0
beq_cont.32997:
	b	beq_cont.32995
beq_else.32994:
	li	r17, 0
beq_cont.32995:
	b	beq_cont.32993
beq_else.32992:
	li	r17, 0
beq_cont.32993:
	cmpwi	cr0, r17, 0
	bne	beq_else.33000
	slwi	r2, r2, 2
	add	r31, r7, r2
	ld	r2, r31, 0
	cmpwi	cr0, r9, 4
	blt	le.33001
	beq	le.33001
	blr
le.33001:
	ld	r5, r2, 8
	slwi	r6, r9, 2
	add	r31, r5, r6
	ld	r5, r31, 0
	cmpwi	cr0, r5, 0
	blt	bge_else.33003
	ld	r5, r2, 12
	slwi	r6, r9, 2
	add	r31, r5, r6
	ld	r5, r31, 0
	st	r12, r3, 0
	st	r15, r3, 4
	st	r11, r3, 8
	st	r10, r3, 12
	st	r13, r3, 16
	st	r2, r3, 20
	st	r9, r3, 24
	cmpwi	cr0, r5, 0
	bne	beq_else.33004
	b	beq_cont.33005
beq_else.33004:
	mflr	r31
	mr	r5, r9
	mr	r30, r15
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
beq_cont.33005:
	ld	r2, r3, 24
	addi	r2, r2, 1
	cmpwi	cr0, r2, 4
	blt	le.33006
	beq	le.33006
	blr
le.33006:
	ld	r5, r3, 20
	ld	r6, r5, 8
	slwi	r7, r2, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	cmpwi	cr0, r6, 0
	blt	bge_else.33008
	ld	r6, r5, 12
	slwi	r7, r2, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	cmpwi	cr0, r6, 0
	bne	beq_else.33009
	b	beq_cont.33010
beq_else.33009:
	ld	r6, r5, 20
	ld	r7, r5, 28
	ld	r8, r5, 4
	ld	r9, r5, 16
	slwi	r10, r2, 2
	add	r31, r6, r10
	ld	r6, r31, 0
	fld	fr1, r6, 0
	ld	r10, r3, 16
	fst	fr1, r10, 0
	fld	fr1, r6, 4
	fst	fr1, r10, 4
	fld	fr1, r6, 8
	fst	fr1, r10, 8
	ld	r6, r5, 24
	ld	r6, r6, 0
	slwi	r11, r2, 2
	add	r31, r7, r11
	ld	r7, r31, 0
	slwi	r11, r2, 2
	add	r31, r8, r11
	ld	r8, r31, 0
	ld	r30, r3, 12
	st	r9, r3, 28
	st	r2, r3, 32
	mflr	r31
	mr	r5, r7
	mr	r2, r6
	mr	r6, r8
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 32
	slwi	r5, r2, 2
	ld	r6, r3, 28
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r6, r3, 8
	fld	fr1, r6, 0
	fld	fr2, r5, 0
	ld	r7, r3, 16
	fld	fr3, r7, 0
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r6, 0
	fld	fr1, r6, 4
	fld	fr2, r5, 4
	fld	fr3, r7, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r6, 4
	fld	fr1, r6, 8
	fld	fr2, r5, 8
	fld	fr3, r7, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r6, 8
beq_cont.33010:
	addi	r5, r2, 1
	cmpwi	cr0, r5, 4
	blt	le.33011
	beq	le.33011
	blr
le.33011:
	ld	r2, r3, 20
	ld	r6, r2, 8
	slwi	r7, r5, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	cmpwi	cr0, r6, 0
	blt	bge_else.33013
	ld	r6, r2, 12
	slwi	r7, r5, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	st	r5, r3, 36
	cmpwi	cr0, r6, 0
	bne	beq_else.33014
	b	beq_cont.33015
beq_else.33014:
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
beq_cont.33015:
	ld	r2, r3, 36
	addi	r5, r2, 1
	ld	r2, r3, 20
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
bge_else.33013:
	blr
bge_else.33008:
	blr
bge_else.33003:
	blr
beq_else.33000:
	ld	r16, r16, 12
	slwi	r17, r9, 2
	add	r31, r16, r17
	ld	r16, r31, 0
	cmpwi	cr0, r16, 0
	bne	beq_else.33019
	b	beq_cont.33020
beq_else.33019:
	slwi	r16, r2, 2
	add	r31, r6, r16
	ld	r16, r31, 0
	ld	r16, r16, 20
	addi	r17, r2, -1
	slwi	r17, r17, 2
	add	r31, r7, r17
	ld	r17, r31, 0
	ld	r17, r17, 20
	slwi	r18, r2, 2
	add	r31, r7, r18
	ld	r18, r31, 0
	ld	r18, r18, 20
	addi	r19, r2, 1
	slwi	r19, r19, 2
	add	r31, r7, r19
	ld	r19, r31, 0
	ld	r19, r19, 20
	slwi	r20, r2, 2
	add	r31, r8, r20
	ld	r20, r31, 0
	ld	r20, r20, 20
	slwi	r21, r9, 2
	add	r31, r16, r21
	ld	r16, r31, 0
	fld	fr1, r16, 0
	fst	fr1, r13, 0
	fld	fr1, r16, 4
	fst	fr1, r13, 4
	fld	fr1, r16, 8
	fst	fr1, r13, 8
	slwi	r16, r9, 2
	add	r31, r17, r16
	ld	r16, r31, 0
	fld	fr1, r13, 0
	fld	fr2, r16, 0
	fadd	fr1, fr1, fr2
	fst	fr1, r13, 0
	fld	fr1, r13, 4
	fld	fr2, r16, 4
	fadd	fr1, fr1, fr2
	fst	fr1, r13, 4
	fld	fr1, r13, 8
	fld	fr2, r16, 8
	fadd	fr1, fr1, fr2
	fst	fr1, r13, 8
	slwi	r16, r9, 2
	add	r31, r18, r16
	ld	r16, r31, 0
	fld	fr1, r13, 0
	fld	fr2, r16, 0
	fadd	fr1, fr1, fr2
	fst	fr1, r13, 0
	fld	fr1, r13, 4
	fld	fr2, r16, 4
	fadd	fr1, fr1, fr2
	fst	fr1, r13, 4
	fld	fr1, r13, 8
	fld	fr2, r16, 8
	fadd	fr1, fr1, fr2
	fst	fr1, r13, 8
	slwi	r16, r9, 2
	add	r31, r19, r16
	ld	r16, r31, 0
	fld	fr1, r13, 0
	fld	fr2, r16, 0
	fadd	fr1, fr1, fr2
	fst	fr1, r13, 0
	fld	fr1, r13, 4
	fld	fr2, r16, 4
	fadd	fr1, fr1, fr2
	fst	fr1, r13, 4
	fld	fr1, r13, 8
	fld	fr2, r16, 8
	fadd	fr1, fr1, fr2
	fst	fr1, r13, 8
	slwi	r16, r9, 2
	add	r31, r20, r16
	ld	r16, r31, 0
	fld	fr1, r13, 0
	fld	fr2, r16, 0
	fadd	fr1, fr1, fr2
	fst	fr1, r13, 0
	fld	fr1, r13, 4
	fld	fr2, r16, 4
	fadd	fr1, fr1, fr2
	fst	fr1, r13, 4
	fld	fr1, r13, 8
	fld	fr2, r16, 8
	fadd	fr1, fr1, fr2
	fst	fr1, r13, 8
	slwi	r16, r2, 2
	add	r31, r7, r16
	ld	r16, r31, 0
	ld	r16, r16, 16
	slwi	r17, r9, 2
	add	r31, r16, r17
	ld	r16, r31, 0
	fld	fr1, r11, 0
	fld	fr2, r16, 0
	fld	fr3, r13, 0
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r11, 0
	fld	fr1, r11, 4
	fld	fr2, r16, 4
	fld	fr3, r13, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r11, 4
	fld	fr1, r11, 8
	fld	fr2, r16, 8
	fld	fr3, r13, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r11, 8
beq_cont.33020:
	addi	r9, r9, 1
	slwi	r16, r2, 2
	add	r31, r7, r16
	ld	r16, r31, 0
	cmpwi	cr0, r9, 4
	blt	le.33021
	beq	le.33021
	blr
le.33021:
	ld	r17, r16, 8
	slwi	r18, r9, 2
	add	r31, r17, r18
	ld	r17, r31, 0
	cmpwi	cr0, r17, 0
	blt	bge_else.33023
	slwi	r17, r2, 2
	add	r31, r7, r17
	ld	r17, r31, 0
	ld	r17, r17, 8
	slwi	r18, r9, 2
	add	r31, r17, r18
	ld	r17, r31, 0
	slwi	r18, r2, 2
	add	r31, r6, r18
	ld	r18, r31, 0
	ld	r18, r18, 8
	slwi	r19, r9, 2
	add	r31, r18, r19
	ld	r18, r31, 0
	cmpw	cr0, r18, r17
	bne	beq_else.33024
	slwi	r18, r2, 2
	add	r31, r8, r18
	ld	r18, r31, 0
	ld	r18, r18, 8
	slwi	r19, r9, 2
	add	r31, r18, r19
	ld	r18, r31, 0
	cmpw	cr0, r18, r17
	bne	beq_else.33026
	addi	r18, r2, -1
	slwi	r18, r18, 2
	add	r31, r7, r18
	ld	r18, r31, 0
	ld	r18, r18, 8
	slwi	r19, r9, 2
	add	r31, r18, r19
	ld	r18, r31, 0
	cmpw	cr0, r18, r17
	bne	beq_else.33028
	addi	r18, r2, 1
	slwi	r18, r18, 2
	add	r31, r7, r18
	ld	r18, r31, 0
	ld	r18, r18, 8
	slwi	r19, r9, 2
	add	r31, r18, r19
	ld	r18, r31, 0
	cmpw	cr0, r18, r17
	bne	beq_else.33030
	li	r17, 1
	b	beq_cont.33031
beq_else.33030:
	li	r17, 0
beq_cont.33031:
	b	beq_cont.33029
beq_else.33028:
	li	r17, 0
beq_cont.33029:
	b	beq_cont.33027
beq_else.33026:
	li	r17, 0
beq_cont.33027:
	b	beq_cont.33025
beq_else.33024:
	li	r17, 0
beq_cont.33025:
	cmpwi	cr0, r17, 0
	bne	beq_else.33032
	slwi	r2, r2, 2
	add	r31, r7, r2
	ld	r2, r31, 0
	cmpwi	cr0, r9, 4
	blt	le.33033
	beq	le.33033
	blr
le.33033:
	ld	r5, r2, 8
	slwi	r6, r9, 2
	add	r31, r5, r6
	ld	r5, r31, 0
	cmpwi	cr0, r5, 0
	blt	bge_else.33035
	ld	r5, r2, 12
	slwi	r6, r9, 2
	add	r31, r5, r6
	ld	r5, r31, 0
	st	r12, r3, 0
	st	r15, r3, 4
	st	r2, r3, 40
	st	r9, r3, 44
	cmpwi	cr0, r5, 0
	bne	beq_else.33036
	b	beq_cont.33037
beq_else.33036:
	ld	r5, r2, 20
	ld	r6, r2, 28
	ld	r7, r2, 4
	ld	r8, r2, 16
	slwi	r14, r9, 2
	add	r31, r5, r14
	ld	r5, r31, 0
	fld	fr1, r5, 0
	fst	fr1, r13, 0
	fld	fr1, r5, 4
	fst	fr1, r13, 4
	fld	fr1, r5, 8
	fst	fr1, r13, 8
	ld	r5, r2, 24
	ld	r5, r5, 0
	slwi	r14, r9, 2
	add	r31, r6, r14
	ld	r6, r31, 0
	slwi	r14, r9, 2
	add	r31, r7, r14
	ld	r7, r31, 0
	st	r13, r3, 16
	st	r11, r3, 8
	st	r8, r3, 48
	mflr	r31
	mr	r2, r5
	mr	r30, r10
	mr	r5, r6
	mr	r6, r7
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 44
	slwi	r5, r2, 2
	ld	r6, r3, 48
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r6, r3, 8
	fld	fr1, r6, 0
	fld	fr2, r5, 0
	ld	r7, r3, 16
	fld	fr3, r7, 0
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r6, 0
	fld	fr1, r6, 4
	fld	fr2, r5, 4
	fld	fr3, r7, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r6, 4
	fld	fr1, r6, 8
	fld	fr2, r5, 8
	fld	fr3, r7, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r6, 8
beq_cont.33037:
	ld	r2, r3, 44
	addi	r5, r2, 1
	cmpwi	cr0, r5, 4
	blt	le.33038
	beq	le.33038
	blr
le.33038:
	ld	r2, r3, 40
	ld	r6, r2, 8
	slwi	r7, r5, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	cmpwi	cr0, r6, 0
	blt	bge_else.33040
	ld	r6, r2, 12
	slwi	r7, r5, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	st	r5, r3, 52
	cmpwi	cr0, r6, 0
	bne	beq_else.33041
	b	beq_cont.33042
beq_else.33041:
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
beq_cont.33042:
	ld	r2, r3, 52
	addi	r5, r2, 1
	ld	r2, r3, 40
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
bge_else.33040:
	blr
bge_else.33035:
	blr
beq_else.33032:
	ld	r10, r16, 12
	slwi	r11, r9, 2
	add	r31, r10, r11
	ld	r10, r31, 0
	st	r8, r3, 56
	st	r7, r3, 60
	st	r6, r3, 64
	st	r5, r3, 68
	st	r2, r3, 72
	st	r30, r3, 76
	st	r9, r3, 44
	cmpwi	cr0, r10, 0
	bne	beq_else.33045
	b	beq_cont.33046
beq_else.33045:
	mflr	r31
	mr	r5, r6
	mr	r30, r14
	mr	r6, r7
	mr	r7, r8
	mr	r8, r9
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
beq_cont.33046:
	ld	r2, r3, 44
	addi	r9, r2, 1
	ld	r2, r3, 72
	ld	r5, r3, 68
	ld	r6, r3, 64
	ld	r7, r3, 60
	ld	r8, r3, 56
	ld	r30, r3, 76
	ld	r29, r30, 0
	ba	r29
bge_else.33023:
	blr
bge_else.32991:
	blr
pretrace_diffuse_rays.3142:
	ld	r6, r30, 28
	ld	r7, r30, 24
	ld	r8, r30, 20
	ld	r9, r30, 16
	ld	r10, r30, 12
	ld	r11, r30, 8
	ld	r12, r30, 4
	cmpwi	cr0, r5, 4
	blt	le.33049
	beq	le.33049
	blr
le.33049:
	ld	r13, r2, 8
	slwi	r14, r5, 2
	add	r31, r13, r14
	ld	r13, r31, 0
	cmpwi	cr0, r13, 0
	blt	bge_else.33051
	ld	r13, r2, 12
	slwi	r14, r5, 2
	add	r31, r13, r14
	ld	r13, r31, 0
	st	r30, r3, 0
	st	r10, r3, 4
	st	r6, r3, 8
	st	r8, r3, 12
	st	r9, r3, 16
	st	r7, r3, 20
	st	r11, r3, 24
	st	r12, r3, 28
	st	r5, r3, 32
	cmpwi	cr0, r13, 0
	bne	beq_else.33052
	b	beq_cont.33053
beq_else.33052:
	ld	r13, r2, 24
	ld	r13, r13, 0
	fld	fr1, r0, 44
	fst	fr1, r12, 0
	fst	fr1, r12, 4
	fst	fr1, r12, 8
	ld	r14, r2, 28
	ld	r15, r2, 4
	slwi	r13, r13, 2
	add	r31, r11, r13
	ld	r13, r31, 0
	slwi	r16, r5, 2
	add	r31, r14, r16
	ld	r14, r31, 0
	slwi	r16, r5, 2
	add	r31, r15, r16
	ld	r15, r31, 0
	fld	fr1, r15, 0
	fst	fr1, r7, 0
	fld	fr1, r15, 4
	fst	fr1, r7, 4
	fld	fr1, r15, 8
	fst	fr1, r7, 8
	ld	r16, r9, 0
	addi	r16, r16, -1
	st	r2, r3, 36
	st	r15, r3, 40
	st	r14, r3, 44
	st	r13, r3, 48
	mflr	r31
	mr	r5, r16
	mr	r2, r15
	mr	r30, r8
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	li	r7, 118
	ld	r2, r3, 48
	ld	r5, r3, 44
	ld	r6, r3, 40
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r2, r3, 36
	ld	r5, r2, 20
	ld	r6, r3, 32
	slwi	r7, r6, 2
	add	r31, r5, r7
	ld	r5, r31, 0
	ld	r7, r3, 28
	fld	fr1, r7, 0
	fst	fr1, r5, 0
	fld	fr1, r7, 4
	fst	fr1, r5, 4
	fld	fr1, r7, 8
	fst	fr1, r5, 8
beq_cont.33053:
	ld	r5, r3, 32
	addi	r5, r5, 1
	cmpwi	cr0, r5, 4
	blt	le.33054
	beq	le.33054
	blr
le.33054:
	ld	r6, r2, 8
	slwi	r7, r5, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	cmpwi	cr0, r6, 0
	blt	bge_else.33056
	ld	r6, r2, 12
	slwi	r7, r5, 2
	add	r31, r6, r7
	ld	r6, r31, 0
	st	r5, r3, 52
	cmpwi	cr0, r6, 0
	bne	beq_else.33057
	b	beq_cont.33058
beq_else.33057:
	ld	r6, r2, 24
	ld	r6, r6, 0
	fld	fr1, r0, 44
	ld	r7, r3, 28
	fst	fr1, r7, 0
	fst	fr1, r7, 4
	fst	fr1, r7, 8
	ld	r8, r2, 28
	ld	r9, r2, 4
	slwi	r6, r6, 2
	ld	r10, r3, 24
	add	r31, r10, r6
	ld	r6, r31, 0
	slwi	r10, r5, 2
	add	r31, r8, r10
	ld	r8, r31, 0
	slwi	r10, r5, 2
	add	r31, r9, r10
	ld	r9, r31, 0
	fld	fr1, r9, 0
	ld	r10, r3, 20
	fst	fr1, r10, 0
	fld	fr1, r9, 4
	fst	fr1, r10, 4
	fld	fr1, r9, 8
	fst	fr1, r10, 8
	ld	r10, r3, 16
	ld	r10, r10, 0
	addi	r10, r10, -1
	ld	r30, r3, 12
	st	r2, r3, 36
	st	r9, r3, 56
	st	r8, r3, 60
	st	r6, r3, 64
	mflr	r31
	mr	r5, r10
	mr	r2, r9
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 64
	ld	r5, r2, 472
	ld	r5, r5, 0
	fld	fr1, r5, 0
	ld	r6, r3, 60
	fld	fr2, r6, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r5, 4
	fld	fr3, r6, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r5, 8
	fld	fr3, r6, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.33059
	beq	le.33059
	li	r5, 1
	b	gt_cont.33060
le.33059:
	li	r5, 0
gt_cont.33060:
	cmpwi	cr0, r5, 0
	bne	beq_else.33061
	ld	r5, r2, 472
	fld	fr2, r0, 180
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 8
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	b	beq_cont.33062
beq_else.33061:
	ld	r5, r2, 476
	fld	fr2, r0, 176
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 8
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
beq_cont.33062:
	li	r7, 116
	ld	r2, r3, 64
	ld	r5, r3, 60
	ld	r6, r3, 56
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 36
	ld	r5, r2, 20
	ld	r6, r3, 52
	slwi	r7, r6, 2
	add	r31, r5, r7
	ld	r5, r31, 0
	ld	r7, r3, 28
	fld	fr1, r7, 0
	fst	fr1, r5, 0
	fld	fr1, r7, 4
	fst	fr1, r5, 4
	fld	fr1, r7, 8
	fst	fr1, r5, 8
beq_cont.33058:
	ld	r5, r3, 52
	addi	r5, r5, 1
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
bge_else.33056:
	blr
bge_else.33051:
	blr
pretrace_pixels.3145:
	ld	r7, r30, 64
	ld	r8, r30, 60
	ld	r9, r30, 56
	ld	r10, r30, 52
	ld	r11, r30, 48
	ld	r12, r30, 44
	ld	r13, r30, 40
	ld	r14, r30, 36
	ld	r15, r30, 32
	ld	r16, r30, 28
	ld	r17, r30, 24
	ld	r18, r30, 20
	ld	r19, r30, 16
	ld	r20, r30, 12
	ld	r21, r30, 8
	ld	r22, r30, 4
	cmpwi	cr0, r5, 0
	blt	bge_else.33065
	fld	fr4, r14, 0
	ld	r23, r20, 0
	sub	r23, r5, r23
	st	r30, r3, 0
	st	r20, r3, 4
	st	r14, r3, 8
	st	r17, r3, 12
	st	r19, r3, 16
	st	r9, r3, 20
	st	r12, r3, 24
	st	r18, r3, 28
	st	r10, r3, 32
	st	r21, r3, 36
	st	r22, r3, 40
	st	r6, r3, 44
	st	r8, r3, 48
	st	r2, r3, 52
	st	r5, r3, 56
	st	r11, r3, 60
	st	r7, r3, 64
	st	r15, r3, 68
	fst	fr3, r3, 72
	fst	fr2, r3, 76
	st	r16, r3, 80
	fst	fr1, r3, 84
	st	r13, r3, 88
	fst	fr4, r3, 92
	mflr	r31
	mr	r2, r23
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_float_of_int
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	fld	fr2, r3, 92
	fmul	fr1, fr2, fr1
	ld	r2, r3, 88
	fld	fr2, r2, 0
	fmul	fr2, fr1, fr2
	fld	fr3, r3, 84
	fadd	fr2, fr2, fr3
	ld	r5, r3, 80
	fst	fr2, r5, 0
	fld	fr2, r2, 4
	fmul	fr2, fr1, fr2
	fld	fr4, r3, 76
	fadd	fr2, fr2, fr4
	fst	fr2, r5, 4
	fld	fr2, r2, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 72
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 8
	fld	fr1, r5, 0
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fsqr
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r2, r3, 80
	fld	fr2, r2, 4
	fst	fr1, r3, 96
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_fsqr
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	fld	fr2, r3, 96
	fadd	fr1, fr2, fr1
	ld	r2, r3, 80
	fld	fr2, r2, 8
	fst	fr1, r3, 100
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_fsqr
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	fld	fr2, r3, 100
	fadd	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_sqrt
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.33066
	li	r2, 1
	b	beq_cont.33067
beq_else.33066:
	li	r2, 0
beq_cont.33067:
	cmpwi	cr0, r2, 0
	bne	beq_else.33068
	fld	fr2, r0, 16
	fdiv	fr1, fr2, fr1
	b	beq_cont.33069
beq_else.33068:
	fld	fr1, r0, 16
beq_cont.33069:
	ld	r5, r3, 80
	fld	fr2, r5, 0
	fmul	fr2, fr2, fr1
	fst	fr2, r5, 0
	fld	fr2, r5, 4
	fmul	fr2, fr2, fr1
	fst	fr2, r5, 4
	fld	fr2, r5, 8
	fmul	fr1, fr2, fr1
	fst	fr1, r5, 8
	fld	fr1, r0, 44
	ld	r2, r3, 68
	fst	fr1, r2, 0
	fst	fr1, r2, 4
	fst	fr1, r2, 8
	ld	r6, r3, 64
	fld	fr1, r6, 0
	ld	r7, r3, 60
	fst	fr1, r7, 0
	fld	fr1, r6, 4
	fst	fr1, r7, 4
	fld	fr1, r6, 8
	fst	fr1, r7, 8
	li	r8, 0
	fld	fr1, r0, 16
	ld	r9, r3, 56
	slwi	r10, r9, 2
	ld	r11, r3, 52
	add	r31, r11, r10
	ld	r10, r31, 0
	fld	fr2, r0, 44
	ld	r30, r3, 48
	mflr	r31
	mr	r6, r10
	mr	r2, r8
	st	r31, r3, 108
	addi	r3, r3, 112
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	ld	r2, r3, 56
	slwi	r5, r2, 2
	ld	r6, r3, 52
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r5, r5, 0
	ld	r7, r3, 68
	fld	fr1, r7, 0
	fst	fr1, r5, 0
	fld	fr1, r7, 4
	fst	fr1, r5, 4
	fld	fr1, r7, 8
	fst	fr1, r5, 8
	slwi	r5, r2, 2
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r5, r5, 24
	ld	r8, r3, 44
	st	r8, r5, 0
	slwi	r5, r2, 2
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r9, r5, 8
	ld	r9, r9, 0
	cmpwi	cr0, r9, 0
	blt	bge_else.33070
	ld	r9, r5, 12
	ld	r9, r9, 0
	st	r5, r3, 104
	cmpwi	cr0, r9, 0
	bne	beq_else.33072
	b	beq_cont.33073
beq_else.33072:
	ld	r9, r5, 24
	ld	r9, r9, 0
	fld	fr1, r0, 44
	ld	r10, r3, 40
	fst	fr1, r10, 0
	fst	fr1, r10, 4
	fst	fr1, r10, 8
	ld	r11, r5, 28
	ld	r12, r5, 4
	slwi	r9, r9, 2
	ld	r13, r3, 36
	add	r31, r13, r9
	ld	r9, r31, 0
	ld	r11, r11, 0
	ld	r12, r12, 0
	fld	fr1, r12, 0
	ld	r13, r3, 32
	fst	fr1, r13, 0
	fld	fr1, r12, 4
	fst	fr1, r13, 4
	fld	fr1, r12, 8
	fst	fr1, r13, 8
	ld	r13, r3, 28
	ld	r13, r13, 0
	addi	r13, r13, -1
	ld	r30, r3, 24
	st	r12, r3, 108
	st	r11, r3, 112
	st	r9, r3, 116
	mflr	r31
	mr	r5, r13
	mr	r2, r12
	st	r31, r3, 124
	addi	r3, r3, 128
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	ld	r2, r3, 116
	ld	r5, r2, 472
	ld	r5, r5, 0
	fld	fr1, r5, 0
	ld	r6, r3, 112
	fld	fr2, r6, 0
	fmul	fr1, fr1, fr2
	fld	fr2, r5, 4
	fld	fr3, r6, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r5, 8
	fld	fr3, r6, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fld	fr2, r0, 44
	fcmp	cr0, fr2, fr1
	blt	le.33074
	beq	le.33074
	li	r5, 1
	b	gt_cont.33075
le.33074:
	li	r5, 0
gt_cont.33075:
	cmpwi	cr0, r5, 0
	bne	beq_else.33076
	ld	r5, r2, 472
	fld	fr2, r0, 180
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 124
	addi	r3, r3, 128
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	b	beq_cont.33077
beq_else.33076:
	ld	r5, r2, 476
	fld	fr2, r0, 176
	fdiv	fr1, fr1, fr2
	ld	r30, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 124
	addi	r3, r3, 128
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
beq_cont.33077:
	li	r7, 116
	ld	r2, r3, 116
	ld	r5, r3, 112
	ld	r6, r3, 108
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 124
	addi	r3, r3, 128
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	ld	r2, r3, 104
	ld	r5, r2, 20
	ld	r5, r5, 0
	ld	r6, r3, 40
	fld	fr1, r6, 0
	fst	fr1, r5, 0
	fld	fr1, r6, 4
	fst	fr1, r5, 4
	fld	fr1, r6, 8
	fst	fr1, r5, 8
beq_cont.33073:
	li	r5, 1
	ld	r2, r3, 104
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 124
	addi	r3, r3, 128
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	b	bge_cont.33071
bge_else.33070:
bge_cont.33071:
	ld	r2, r3, 56
	addi	r2, r2, -1
	ld	r5, r3, 44
	addi	r5, r5, 1
	cmpwi	cr0, r5, 5
	blt	bge_else.33078
	addi	r5, r5, -5
	b	bge_cont.33079
bge_else.33078:
bge_cont.33079:
	cmpwi	cr0, r2, 0
	blt	bge_else.33080
	ld	r6, r3, 8
	fld	fr1, r6, 0
	ld	r6, r3, 4
	ld	r6, r6, 0
	sub	r6, r2, r6
	st	r5, r3, 120
	st	r2, r3, 124
	fst	fr1, r3, 128
	mflr	r31
	mr	r2, r6
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_float_of_int
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	fld	fr2, r3, 128
	fmul	fr1, fr2, fr1
	ld	r2, r3, 88
	fld	fr2, r2, 0
	fmul	fr2, fr1, fr2
	fld	fr3, r3, 84
	fadd	fr2, fr2, fr3
	ld	r5, r3, 80
	fst	fr2, r5, 0
	fld	fr2, r2, 4
	fmul	fr2, fr1, fr2
	fld	fr4, r3, 76
	fadd	fr2, fr2, fr4
	fst	fr2, r5, 4
	fld	fr2, r2, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 72
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 8
	fld	fr1, r5, 0
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_fsqr
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	ld	r2, r3, 80
	fld	fr2, r2, 4
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
	fadd	fr1, fr2, fr1
	ld	r2, r3, 80
	fld	fr2, r2, 8
	fst	fr1, r3, 136
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_fsqr
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	fld	fr2, r3, 136
	fadd	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_sqrt
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.33081
	li	r2, 1
	b	beq_cont.33082
beq_else.33081:
	li	r2, 0
beq_cont.33082:
	cmpwi	cr0, r2, 0
	bne	beq_else.33083
	fld	fr2, r0, 16
	fdiv	fr1, fr2, fr1
	b	beq_cont.33084
beq_else.33083:
	fld	fr1, r0, 16
beq_cont.33084:
	ld	r5, r3, 80
	fld	fr2, r5, 0
	fmul	fr2, fr2, fr1
	fst	fr2, r5, 0
	fld	fr2, r5, 4
	fmul	fr2, fr2, fr1
	fst	fr2, r5, 4
	fld	fr2, r5, 8
	fmul	fr1, fr2, fr1
	fst	fr1, r5, 8
	fld	fr1, r0, 44
	ld	r2, r3, 68
	fst	fr1, r2, 0
	fst	fr1, r2, 4
	fst	fr1, r2, 8
	ld	r6, r3, 64
	fld	fr1, r6, 0
	ld	r7, r3, 60
	fst	fr1, r7, 0
	fld	fr1, r6, 4
	fst	fr1, r7, 4
	fld	fr1, r6, 8
	fst	fr1, r7, 8
	li	r6, 0
	fld	fr1, r0, 16
	ld	r7, r3, 124
	slwi	r8, r7, 2
	ld	r9, r3, 52
	add	r31, r9, r8
	ld	r8, r31, 0
	fld	fr2, r0, 44
	ld	r30, r3, 48
	mflr	r31
	mr	r2, r6
	mr	r6, r8
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	ld	r2, r3, 124
	slwi	r5, r2, 2
	ld	r6, r3, 52
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r5, r5, 0
	ld	r7, r3, 68
	fld	fr1, r7, 0
	fst	fr1, r5, 0
	fld	fr1, r7, 4
	fst	fr1, r5, 4
	fld	fr1, r7, 8
	fst	fr1, r5, 8
	slwi	r5, r2, 2
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r5, r5, 24
	ld	r7, r3, 120
	st	r7, r5, 0
	slwi	r5, r2, 2
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r8, 0
	ld	r30, r3, 12
	mflr	r31
	mr	r2, r5
	mr	r5, r8
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	ld	r2, r3, 124
	addi	r5, r2, -1
	ld	r2, r3, 120
	addi	r2, r2, 1
	cmpwi	cr0, r2, 5
	blt	bge_else.33085
	addi	r6, r2, -5
	b	bge_cont.33086
bge_else.33085:
	mr	r6, r2
bge_cont.33086:
	fld	fr1, r3, 84
	fld	fr2, r3, 76
	fld	fr3, r3, 72
	ld	r2, r3, 52
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
bge_else.33080:
	blr
bge_else.33065:
	blr
pretrace_line.3152:
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
	fld	fr1, r13, 0
	ld	r20, r19, 4
	sub	r5, r5, r20
	st	r16, r3, 0
	st	r17, r3, 4
	st	r6, r3, 8
	st	r8, r3, 12
	st	r2, r3, 16
	st	r9, r3, 20
	st	r7, r3, 24
	st	r14, r3, 28
	st	r15, r3, 32
	st	r12, r3, 36
	st	r19, r3, 40
	st	r13, r3, 44
	st	r18, r3, 48
	st	r10, r3, 52
	st	r11, r3, 56
	fst	fr1, r3, 60
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_float_of_int
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 60
	fmul	fr1, fr2, fr1
	ld	r2, r3, 56
	fld	fr2, r2, 0
	fmul	fr2, fr1, fr2
	ld	r5, r3, 52
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
	ld	r2, r3, 48
	ld	r2, r2, 0
	addi	r2, r2, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33089
	ld	r5, r3, 44
	fld	fr4, r5, 0
	ld	r5, r3, 40
	ld	r5, r5, 0
	sub	r5, r2, r5
	st	r2, r3, 64
	fst	fr1, r3, 68
	fst	fr3, r3, 72
	fst	fr2, r3, 76
	fst	fr4, r3, 80
	mflr	r31
	mr	r2, r5
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_float_of_int
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	fld	fr2, r3, 80
	fmul	fr1, fr2, fr1
	ld	r2, r3, 36
	fld	fr2, r2, 0
	fmul	fr2, fr1, fr2
	fld	fr3, r3, 76
	fadd	fr2, fr2, fr3
	ld	r5, r3, 32
	fst	fr2, r5, 0
	fld	fr2, r2, 4
	fmul	fr2, fr1, fr2
	fld	fr4, r3, 72
	fadd	fr2, fr2, fr4
	fst	fr2, r5, 4
	fld	fr2, r2, 8
	fmul	fr1, fr1, fr2
	fld	fr2, r3, 68
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 8
	fld	fr1, r5, 0
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_fsqr
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r2, r3, 32
	fld	fr2, r2, 4
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
	ld	r2, r3, 32
	fld	fr2, r2, 8
	fst	fr1, r3, 88
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_fsqr
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	fld	fr2, r3, 88
	fadd	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_sqrt
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	fld	fr2, r0, 44
	fcmp	cr0, fr1, fr2
	bne	beq_else.33090
	li	r2, 1
	b	beq_cont.33091
beq_else.33090:
	li	r2, 0
beq_cont.33091:
	cmpwi	cr0, r2, 0
	bne	beq_else.33092
	fld	fr2, r0, 16
	fdiv	fr1, fr2, fr1
	b	beq_cont.33093
beq_else.33092:
	fld	fr1, r0, 16
beq_cont.33093:
	ld	r5, r3, 32
	fld	fr2, r5, 0
	fmul	fr2, fr2, fr1
	fst	fr2, r5, 0
	fld	fr2, r5, 4
	fmul	fr2, fr2, fr1
	fst	fr2, r5, 4
	fld	fr2, r5, 8
	fmul	fr1, fr2, fr1
	fst	fr1, r5, 8
	fld	fr1, r0, 44
	ld	r2, r3, 28
	fst	fr1, r2, 0
	fst	fr1, r2, 4
	fst	fr1, r2, 8
	ld	r6, r3, 24
	fld	fr1, r6, 0
	ld	r7, r3, 20
	fst	fr1, r7, 0
	fld	fr1, r6, 4
	fst	fr1, r7, 4
	fld	fr1, r6, 8
	fst	fr1, r7, 8
	li	r6, 0
	fld	fr1, r0, 16
	ld	r7, r3, 64
	slwi	r8, r7, 2
	ld	r9, r3, 16
	add	r31, r9, r8
	ld	r8, r31, 0
	fld	fr2, r0, 44
	ld	r30, r3, 12
	mflr	r31
	mr	r2, r6
	mr	r6, r8
	st	r31, r3, 92
	addi	r3, r3, 96
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r2, r3, 64
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r5, r5, 0
	ld	r7, r3, 28
	fld	fr1, r7, 0
	fst	fr1, r5, 0
	fld	fr1, r7, 4
	fst	fr1, r5, 4
	fld	fr1, r7, 8
	fst	fr1, r5, 8
	slwi	r5, r2, 2
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r5, r5, 24
	ld	r7, r3, 8
	st	r7, r5, 0
	slwi	r5, r2, 2
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r8, 0
	ld	r30, r3, 4
	mflr	r31
	mr	r2, r5
	mr	r5, r8
	st	r31, r3, 92
	addi	r3, r3, 96
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r2, r3, 64
	addi	r5, r2, -1
	ld	r2, r3, 8
	addi	r2, r2, 1
	cmpwi	cr0, r2, 5
	blt	bge_else.33094
	addi	r6, r2, -5
	b	bge_cont.33095
bge_else.33094:
	mr	r6, r2
bge_cont.33095:
	fld	fr1, r3, 76
	fld	fr2, r3, 72
	fld	fr3, r3, 68
	ld	r2, r3, 16
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
bge_else.33089:
	blr
scan_pixel.3156:
	ld	r9, r30, 32
	ld	r10, r30, 28
	ld	r11, r30, 24
	ld	r12, r30, 20
	ld	r13, r30, 16
	ld	r14, r30, 12
	ld	r15, r30, 8
	ld	r16, r30, 4
	ld	r17, r12, 0
	cmpw	cr0, r17, r2
	blt	le.33097
	beq	le.33097
	slwi	r17, r2, 2
	add	r31, r7, r17
	ld	r17, r31, 0
	ld	r17, r17, 0
	fld	fr1, r17, 0
	fst	fr1, r11, 0
	fld	fr1, r17, 4
	fst	fr1, r11, 4
	fld	fr1, r17, 8
	fst	fr1, r11, 8
	ld	r17, r12, 4
	addi	r18, r5, 1
	cmpw	cr0, r17, r18
	blt	le.33098
	beq	le.33098
	cmpwi	cr0, r5, 0
	blt	le.33100
	beq	le.33100
	ld	r17, r12, 0
	addi	r18, r2, 1
	cmpw	cr0, r17, r18
	blt	le.33102
	beq	le.33102
	cmpwi	cr0, r2, 0
	blt	le.33104
	beq	le.33104
	li	r17, 1
	b	gt_cont.33105
le.33104:
	li	r17, 0
gt_cont.33105:
	b	gt_cont.33103
le.33102:
	li	r17, 0
gt_cont.33103:
	b	gt_cont.33101
le.33100:
	li	r17, 0
gt_cont.33101:
	b	gt_cont.33099
le.33098:
	li	r17, 0
gt_cont.33099:
	st	r30, r3, 0
	st	r8, r3, 4
	st	r6, r3, 8
	st	r9, r3, 12
	st	r13, r3, 16
	st	r16, r3, 20
	st	r10, r3, 24
	st	r14, r3, 28
	st	r5, r3, 32
	st	r7, r3, 36
	st	r12, r3, 40
	st	r2, r3, 44
	st	r11, r3, 48
	cmpwi	cr0, r17, 0
	bne	beq_else.33106
	slwi	r15, r2, 2
	add	r31, r7, r15
	ld	r15, r31, 0
	li	r17, 0
	ld	r18, r15, 8
	ld	r18, r18, 0
	cmpwi	cr0, r18, 0
	blt	bge_else.33108
	ld	r18, r15, 12
	ld	r18, r18, 0
	st	r15, r3, 52
	cmpwi	cr0, r18, 0
	bne	beq_else.33110
	b	beq_cont.33111
beq_else.33110:
	mflr	r31
	mr	r5, r17
	mr	r2, r15
	mr	r30, r16
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
beq_cont.33111:
	ld	r2, r3, 52
	ld	r5, r2, 8
	ld	r5, r5, 4
	cmpwi	cr0, r5, 0
	blt	bge_else.33112
	ld	r5, r2, 12
	ld	r5, r5, 4
	cmpwi	cr0, r5, 0
	bne	beq_else.33114
	b	beq_cont.33115
beq_else.33114:
	ld	r5, r2, 20
	ld	r6, r2, 28
	ld	r7, r2, 4
	ld	r8, r2, 16
	ld	r5, r5, 4
	fld	fr1, r5, 0
	ld	r9, r3, 28
	fst	fr1, r9, 0
	fld	fr1, r5, 4
	fst	fr1, r9, 4
	fld	fr1, r5, 8
	fst	fr1, r9, 8
	ld	r5, r2, 24
	ld	r5, r5, 0
	ld	r6, r6, 4
	ld	r7, r7, 4
	ld	r30, r3, 24
	st	r8, r3, 56
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	mr	r6, r7
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 56
	ld	r2, r2, 4
	ld	r5, r3, 48
	fld	fr1, r5, 0
	fld	fr2, r2, 0
	ld	r6, r3, 28
	fld	fr3, r6, 0
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 0
	fld	fr1, r5, 4
	fld	fr2, r2, 4
	fld	fr3, r6, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 4
	fld	fr1, r5, 8
	fld	fr2, r2, 8
	fld	fr3, r6, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 8
beq_cont.33115:
	li	r5, 2
	ld	r2, r3, 52
	ld	r6, r2, 8
	ld	r6, r6, 8
	cmpwi	cr0, r6, 0
	blt	bge_else.33116
	ld	r6, r2, 12
	ld	r6, r6, 8
	cmpwi	cr0, r6, 0
	bne	beq_else.33118
	b	beq_cont.33119
beq_else.33118:
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
beq_cont.33119:
	li	r5, 3
	ld	r2, r3, 52
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	b	bge_cont.33117
bge_else.33116:
bge_cont.33117:
	b	bge_cont.33113
bge_else.33112:
bge_cont.33113:
	b	bge_cont.33109
bge_else.33108:
bge_cont.33109:
	b	beq_cont.33107
beq_else.33106:
	li	r17, 0
	slwi	r18, r2, 2
	add	r31, r7, r18
	ld	r18, r31, 0
	ld	r19, r18, 8
	ld	r19, r19, 0
	cmpwi	cr0, r19, 0
	blt	bge_else.33120
	slwi	r19, r2, 2
	add	r31, r7, r19
	ld	r19, r31, 0
	ld	r19, r19, 8
	ld	r19, r19, 0
	slwi	r20, r2, 2
	add	r31, r6, r20
	ld	r20, r31, 0
	ld	r20, r20, 8
	ld	r20, r20, 0
	cmpw	cr0, r20, r19
	bne	beq_else.33122
	slwi	r20, r2, 2
	add	r31, r8, r20
	ld	r20, r31, 0
	ld	r20, r20, 8
	ld	r20, r20, 0
	cmpw	cr0, r20, r19
	bne	beq_else.33124
	addi	r20, r2, -1
	slwi	r20, r20, 2
	add	r31, r7, r20
	ld	r20, r31, 0
	ld	r20, r20, 8
	ld	r20, r20, 0
	cmpw	cr0, r20, r19
	bne	beq_else.33126
	addi	r20, r2, 1
	slwi	r20, r20, 2
	add	r31, r7, r20
	ld	r20, r31, 0
	ld	r20, r20, 8
	ld	r20, r20, 0
	cmpw	cr0, r20, r19
	bne	beq_else.33128
	li	r19, 1
	b	beq_cont.33129
beq_else.33128:
	li	r19, 0
beq_cont.33129:
	b	beq_cont.33127
beq_else.33126:
	li	r19, 0
beq_cont.33127:
	b	beq_cont.33125
beq_else.33124:
	li	r19, 0
beq_cont.33125:
	b	beq_cont.33123
beq_else.33122:
	li	r19, 0
beq_cont.33123:
	cmpwi	cr0, r19, 0
	bne	beq_else.33130
	slwi	r15, r2, 2
	add	r31, r7, r15
	ld	r15, r31, 0
	ld	r17, r15, 8
	ld	r17, r17, 0
	cmpwi	cr0, r17, 0
	blt	bge_else.33132
	ld	r17, r15, 12
	ld	r17, r17, 0
	st	r15, r3, 60
	cmpwi	cr0, r17, 0
	bne	beq_else.33134
	b	beq_cont.33135
beq_else.33134:
	ld	r17, r15, 20
	ld	r18, r15, 28
	ld	r19, r15, 4
	ld	r20, r15, 16
	ld	r17, r17, 0
	fld	fr1, r17, 0
	fst	fr1, r14, 0
	fld	fr1, r17, 4
	fst	fr1, r14, 4
	fld	fr1, r17, 8
	fst	fr1, r14, 8
	ld	r17, r15, 24
	ld	r17, r17, 0
	ld	r18, r18, 0
	ld	r19, r19, 0
	st	r20, r3, 64
	mflr	r31
	mr	r6, r19
	mr	r5, r18
	mr	r2, r17
	mr	r30, r10
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 64
	ld	r2, r2, 0
	ld	r5, r3, 48
	fld	fr1, r5, 0
	fld	fr2, r2, 0
	ld	r6, r3, 28
	fld	fr3, r6, 0
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 0
	fld	fr1, r5, 4
	fld	fr2, r2, 4
	fld	fr3, r6, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 4
	fld	fr1, r5, 8
	fld	fr2, r2, 8
	fld	fr3, r6, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 8
beq_cont.33135:
	li	r5, 1
	ld	r2, r3, 60
	ld	r6, r2, 8
	ld	r6, r6, 4
	cmpwi	cr0, r6, 0
	blt	bge_else.33136
	ld	r6, r2, 12
	ld	r6, r6, 4
	cmpwi	cr0, r6, 0
	bne	beq_else.33138
	b	beq_cont.33139
beq_else.33138:
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
beq_cont.33139:
	li	r5, 2
	ld	r2, r3, 60
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	b	bge_cont.33137
bge_else.33136:
bge_cont.33137:
	b	bge_cont.33133
bge_else.33132:
bge_cont.33133:
	b	beq_cont.33131
beq_else.33130:
	ld	r18, r18, 12
	ld	r18, r18, 0
	cmpwi	cr0, r18, 0
	bne	beq_else.33140
	b	beq_cont.33141
beq_else.33140:
	mflr	r31
	mr	r5, r6
	mr	r30, r15
	mr	r6, r7
	mr	r7, r8
	mr	r8, r17
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
beq_cont.33141:
	li	r9, 1
	ld	r2, r3, 44
	ld	r5, r3, 32
	ld	r6, r3, 8
	ld	r7, r3, 36
	ld	r8, r3, 4
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
beq_cont.33131:
	b	bge_cont.33121
bge_else.33120:
bge_cont.33121:
beq_cont.33107:
	ld	r2, r3, 48
	fld	fr1, r2, 0
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_int_of_float
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	cmpwi	cr0, r2, 255
	blt	le.33142
	beq	le.33142
	li	r2, 255
	b	gt_cont.33143
le.33142:
	cmpwi	cr0, r2, 0
	blt	bge_else.33144
	b	bge_cont.33145
bge_else.33144:
	li	r2, 0
bge_cont.33145:
gt_cont.33143:
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_print_int
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	li	r2, 32
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_print_char
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 48
	fld	fr1, r2, 4
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_int_of_float
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	cmpwi	cr0, r2, 255
	blt	le.33146
	beq	le.33146
	li	r2, 255
	b	gt_cont.33147
le.33146:
	cmpwi	cr0, r2, 0
	blt	bge_else.33148
	b	bge_cont.33149
bge_else.33148:
	li	r2, 0
bge_cont.33149:
gt_cont.33147:
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_print_int
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	li	r2, 32
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_print_char
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 48
	fld	fr1, r2, 8
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_int_of_float
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	cmpwi	cr0, r2, 255
	blt	le.33150
	beq	le.33150
	li	r2, 255
	b	gt_cont.33151
le.33150:
	cmpwi	cr0, r2, 0
	blt	bge_else.33152
	b	bge_cont.33153
bge_else.33152:
	li	r2, 0
bge_cont.33153:
gt_cont.33151:
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_print_int
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	li	r2, 10
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_print_char
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 44
	addi	r2, r2, 1
	ld	r5, r3, 40
	ld	r6, r5, 0
	cmpw	cr0, r6, r2
	blt	le.33154
	beq	le.33154
	slwi	r6, r2, 2
	ld	r7, r3, 36
	add	r31, r7, r6
	ld	r6, r31, 0
	ld	r6, r6, 0
	fld	fr1, r6, 0
	ld	r8, r3, 48
	fst	fr1, r8, 0
	fld	fr1, r6, 4
	fst	fr1, r8, 4
	fld	fr1, r6, 8
	fst	fr1, r8, 8
	ld	r6, r5, 4
	ld	r9, r3, 32
	addi	r10, r9, 1
	cmpw	cr0, r6, r10
	blt	le.33155
	beq	le.33155
	cmpwi	cr0, r9, 0
	blt	le.33157
	beq	le.33157
	ld	r5, r5, 0
	addi	r6, r2, 1
	cmpw	cr0, r5, r6
	blt	le.33159
	beq	le.33159
	cmpwi	cr0, r2, 0
	blt	le.33161
	beq	le.33161
	li	r5, 1
	b	gt_cont.33162
le.33161:
	li	r5, 0
gt_cont.33162:
	b	gt_cont.33160
le.33159:
	li	r5, 0
gt_cont.33160:
	b	gt_cont.33158
le.33157:
	li	r5, 0
gt_cont.33158:
	b	gt_cont.33156
le.33155:
	li	r5, 0
gt_cont.33156:
	st	r2, r3, 68
	cmpwi	cr0, r5, 0
	bne	beq_else.33163
	slwi	r5, r2, 2
	add	r31, r7, r5
	ld	r5, r31, 0
	ld	r6, r5, 8
	ld	r6, r6, 0
	cmpwi	cr0, r6, 0
	blt	bge_else.33165
	ld	r6, r5, 12
	ld	r6, r6, 0
	st	r5, r3, 72
	cmpwi	cr0, r6, 0
	bne	beq_else.33167
	b	beq_cont.33168
beq_else.33167:
	ld	r6, r5, 20
	ld	r10, r5, 28
	ld	r11, r5, 4
	ld	r12, r5, 16
	ld	r6, r6, 0
	fld	fr1, r6, 0
	ld	r13, r3, 28
	fst	fr1, r13, 0
	fld	fr1, r6, 4
	fst	fr1, r13, 4
	fld	fr1, r6, 8
	fst	fr1, r13, 8
	ld	r6, r5, 24
	ld	r6, r6, 0
	ld	r10, r10, 0
	ld	r11, r11, 0
	ld	r30, r3, 24
	st	r12, r3, 76
	mflr	r31
	mr	r5, r10
	mr	r2, r6
	mr	r6, r11
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r2, r3, 76
	ld	r2, r2, 0
	ld	r5, r3, 48
	fld	fr1, r5, 0
	fld	fr2, r2, 0
	ld	r6, r3, 28
	fld	fr3, r6, 0
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 0
	fld	fr1, r5, 4
	fld	fr2, r2, 4
	fld	fr3, r6, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 4
	fld	fr1, r5, 8
	fld	fr2, r2, 8
	fld	fr3, r6, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 8
beq_cont.33168:
	li	r5, 1
	ld	r2, r3, 72
	ld	r6, r2, 8
	ld	r6, r6, 4
	cmpwi	cr0, r6, 0
	blt	bge_else.33169
	ld	r6, r2, 12
	ld	r6, r6, 4
	cmpwi	cr0, r6, 0
	bne	beq_else.33171
	b	beq_cont.33172
beq_else.33171:
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
beq_cont.33172:
	li	r5, 2
	ld	r2, r3, 72
	ld	r30, r3, 16
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	b	bge_cont.33170
bge_else.33169:
bge_cont.33170:
	b	bge_cont.33166
bge_else.33165:
bge_cont.33166:
	b	beq_cont.33164
beq_else.33163:
	li	r5, 0
	ld	r6, r3, 8
	ld	r10, r3, 4
	ld	r30, r3, 12
	mflr	r31
	mr	r8, r10
	mr	r29, r9
	mr	r9, r5
	mr	r5, r29
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
beq_cont.33164:
	ld	r2, r3, 48
	fld	fr1, r2, 0
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_int_of_float
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	cmpwi	cr0, r2, 255
	blt	le.33173
	beq	le.33173
	li	r2, 255
	b	gt_cont.33174
le.33173:
	cmpwi	cr0, r2, 0
	blt	bge_else.33175
	b	bge_cont.33176
bge_else.33175:
	li	r2, 0
bge_cont.33176:
gt_cont.33174:
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_print_int
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	li	r2, 32
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_print_char
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r2, r3, 48
	fld	fr1, r2, 4
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_int_of_float
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	cmpwi	cr0, r2, 255
	blt	le.33177
	beq	le.33177
	li	r2, 255
	b	gt_cont.33178
le.33177:
	cmpwi	cr0, r2, 0
	blt	bge_else.33179
	b	bge_cont.33180
bge_else.33179:
	li	r2, 0
bge_cont.33180:
gt_cont.33178:
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_print_int
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	li	r2, 32
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_print_char
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r2, r3, 48
	fld	fr1, r2, 8
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_int_of_float
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	cmpwi	cr0, r2, 255
	blt	le.33181
	beq	le.33181
	li	r2, 255
	b	gt_cont.33182
le.33181:
	cmpwi	cr0, r2, 0
	blt	bge_else.33183
	b	bge_cont.33184
bge_else.33183:
	li	r2, 0
bge_cont.33184:
gt_cont.33182:
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_print_int
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	li	r2, 10
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_print_char
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r2, r3, 68
	addi	r2, r2, 1
	ld	r5, r3, 32
	ld	r6, r3, 8
	ld	r7, r3, 36
	ld	r8, r3, 4
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
le.33154:
	blr
le.33097:
	blr
scan_line.3162:
	ld	r9, r30, 56
	ld	r10, r30, 52
	ld	r11, r30, 48
	ld	r12, r30, 44
	ld	r13, r30, 40
	ld	r14, r30, 36
	ld	r15, r30, 32
	ld	r16, r30, 28
	ld	r17, r30, 24
	ld	r18, r30, 20
	ld	r19, r30, 16
	ld	r20, r30, 12
	ld	r21, r30, 8
	ld	r22, r30, 4
	ld	r23, r18, 4
	cmpw	cr0, r23, r2
	blt	le.33187
	beq	le.33187
	ld	r23, r18, 4
	addi	r23, r23, -1
	st	r30, r3, 0
	st	r17, r3, 4
	st	r8, r3, 8
	st	r13, r3, 12
	st	r7, r3, 16
	st	r5, r3, 20
	st	r9, r3, 24
	st	r20, r3, 28
	st	r22, r3, 32
	st	r10, r3, 36
	st	r21, r3, 40
	st	r2, r3, 44
	st	r15, r3, 48
	st	r6, r3, 52
	st	r18, r3, 56
	cmpw	cr0, r23, r2
	blt	le.33188
	beq	le.33188
	addi	r23, r2, 1
	fld	fr1, r14, 0
	ld	r14, r19, 4
	sub	r14, r23, r14
	st	r16, r3, 60
	st	r11, r3, 64
	st	r12, r3, 68
	fst	fr1, r3, 72
	mflr	r31
	mr	r2, r14
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_float_of_int
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 72
	fmul	fr1, fr2, fr1
	ld	r2, r3, 68
	fld	fr2, r2, 0
	fmul	fr2, fr1, fr2
	ld	r5, r3, 64
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
	ld	r2, r3, 56
	ld	r5, r2, 0
	addi	r5, r5, -1
	ld	r6, r3, 16
	ld	r7, r3, 8
	ld	r30, r3, 60
	mflr	r31
	mr	r2, r6
	mr	r6, r7
	fmr	fr31, fr3
	fmr	fr3, fr1
	fmr	fr1, fr2
	fmr	fr2, fr31
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	b	gt_cont.33189
le.33188:
gt_cont.33189:
	li	r2, 0
	ld	r5, r3, 56
	ld	r6, r5, 0
	cmpwi	cr0, r6, 0
	blt	le.33190
	beq	le.33190
	ld	r7, r3, 52
	ld	r6, r7, 0
	ld	r6, r6, 0
	fld	fr1, r6, 0
	ld	r8, r3, 48
	fst	fr1, r8, 0
	fld	fr1, r6, 4
	fst	fr1, r8, 4
	fld	fr1, r6, 8
	fst	fr1, r8, 8
	ld	r6, r5, 4
	ld	r9, r3, 44
	addi	r10, r9, 1
	cmpw	cr0, r6, r10
	blt	le.33192
	beq	le.33192
	cmpwi	cr0, r9, 0
	blt	le.33194
	beq	le.33194
	ld	r6, r5, 0
	cmpwi	cr0, r6, 1
	blt	le.33196
	beq	le.33196
	li	r6, 0
	b	gt_cont.33197
le.33196:
	li	r6, 0
gt_cont.33197:
	b	gt_cont.33195
le.33194:
	li	r6, 0
gt_cont.33195:
	b	gt_cont.33193
le.33192:
	li	r6, 0
gt_cont.33193:
	cmpwi	cr0, r6, 0
	bne	beq_else.33198
	ld	r2, r7, 0
	ld	r6, r2, 8
	ld	r6, r6, 0
	cmpwi	cr0, r6, 0
	blt	bge_else.33200
	ld	r6, r2, 12
	ld	r6, r6, 0
	st	r2, r3, 76
	cmpwi	cr0, r6, 0
	bne	beq_else.33202
	b	beq_cont.33203
beq_else.33202:
	ld	r6, r2, 20
	ld	r10, r2, 28
	ld	r11, r2, 4
	ld	r12, r2, 16
	ld	r6, r6, 0
	fld	fr1, r6, 0
	ld	r13, r3, 40
	fst	fr1, r13, 0
	fld	fr1, r6, 4
	fst	fr1, r13, 4
	fld	fr1, r6, 8
	fst	fr1, r13, 8
	ld	r6, r2, 24
	ld	r6, r6, 0
	ld	r10, r10, 0
	ld	r11, r11, 0
	ld	r30, r3, 36
	st	r12, r3, 80
	mflr	r31
	mr	r5, r10
	mr	r2, r6
	mr	r6, r11
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r2, r3, 80
	ld	r2, r2, 0
	ld	r5, r3, 48
	fld	fr1, r5, 0
	fld	fr2, r2, 0
	ld	r6, r3, 40
	fld	fr3, r6, 0
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 0
	fld	fr1, r5, 4
	fld	fr2, r2, 4
	fld	fr3, r6, 4
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 4
	fld	fr1, r5, 8
	fld	fr2, r2, 8
	fld	fr3, r6, 8
	fmul	fr2, fr2, fr3
	fadd	fr1, fr1, fr2
	fst	fr1, r5, 8
beq_cont.33203:
	li	r5, 1
	ld	r2, r3, 76
	ld	r6, r2, 8
	ld	r6, r6, 4
	cmpwi	cr0, r6, 0
	blt	bge_else.33204
	ld	r6, r2, 12
	ld	r6, r6, 4
	cmpwi	cr0, r6, 0
	bne	beq_else.33206
	b	beq_cont.33207
beq_else.33206:
	ld	r30, r3, 32
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
beq_cont.33207:
	li	r5, 2
	ld	r2, r3, 76
	ld	r30, r3, 28
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	b	bge_cont.33205
bge_else.33204:
bge_cont.33205:
	b	bge_cont.33201
bge_else.33200:
bge_cont.33201:
	b	beq_cont.33199
beq_else.33198:
	li	r6, 0
	ld	r10, r3, 20
	ld	r11, r3, 16
	ld	r30, r3, 24
	mflr	r31
	mr	r8, r11
	mr	r5, r9
	mr	r9, r6
	mr	r6, r10
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
beq_cont.33199:
	ld	r2, r3, 48
	fld	fr1, r2, 0
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_int_of_float
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	cmpwi	cr0, r2, 255
	blt	le.33208
	beq	le.33208
	li	r2, 255
	b	gt_cont.33209
le.33208:
	cmpwi	cr0, r2, 0
	blt	bge_else.33210
	b	bge_cont.33211
bge_else.33210:
	li	r2, 0
bge_cont.33211:
gt_cont.33209:
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_print_int
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	li	r2, 32
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_print_char
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r2, r3, 48
	fld	fr1, r2, 4
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_int_of_float
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	cmpwi	cr0, r2, 255
	blt	le.33212
	beq	le.33212
	li	r2, 255
	b	gt_cont.33213
le.33212:
	cmpwi	cr0, r2, 0
	blt	bge_else.33214
	b	bge_cont.33215
bge_else.33214:
	li	r2, 0
bge_cont.33215:
gt_cont.33213:
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_print_int
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	li	r2, 32
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_print_char
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r2, r3, 48
	fld	fr1, r2, 8
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_int_of_float
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	cmpwi	cr0, r2, 255
	blt	le.33216
	beq	le.33216
	li	r2, 255
	b	gt_cont.33217
le.33216:
	cmpwi	cr0, r2, 0
	blt	bge_else.33218
	b	bge_cont.33219
bge_else.33218:
	li	r2, 0
bge_cont.33219:
gt_cont.33217:
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_print_int
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	li	r2, 10
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_print_char
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	li	r2, 1
	ld	r5, r3, 44
	ld	r6, r3, 20
	ld	r7, r3, 52
	ld	r8, r3, 16
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	b	gt_cont.33191
le.33190:
gt_cont.33191:
	ld	r2, r3, 44
	addi	r5, r2, 1
	ld	r2, r3, 8
	addi	r2, r2, 2
	cmpwi	cr0, r2, 5
	blt	bge_else.33220
	addi	r6, r2, -5
	b	bge_cont.33221
bge_else.33220:
	mr	r6, r2
bge_cont.33221:
	ld	r2, r3, 56
	ld	r7, r2, 4
	cmpw	cr0, r7, r5
	blt	le.33222
	beq	le.33222
	ld	r2, r2, 4
	addi	r2, r2, -1
	st	r6, r3, 84
	st	r5, r3, 88
	cmpw	cr0, r2, r5
	blt	le.33224
	beq	le.33224
	addi	r2, r5, 1
	ld	r7, r3, 20
	ld	r30, r3, 4
	mflr	r31
	mr	r5, r2
	mr	r2, r7
	st	r31, r3, 92
	addi	r3, r3, 96
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	b	gt_cont.33225
le.33224:
gt_cont.33225:
	li	r2, 0
	ld	r5, r3, 88
	ld	r6, r3, 52
	ld	r7, r3, 16
	ld	r8, r3, 20
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r2, r3, 88
	addi	r2, r2, 1
	ld	r5, r3, 84
	addi	r5, r5, 2
	cmpwi	cr0, r5, 5
	blt	bge_else.33226
	addi	r8, r5, -5
	b	bge_cont.33227
bge_else.33226:
	mr	r8, r5
bge_cont.33227:
	ld	r5, r3, 16
	ld	r6, r3, 20
	ld	r7, r3, 52
	ld	r30, r3, 0
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	b	gt_cont.33223
le.33222:
gt_cont.33223:
	blr
le.33187:
	blr
create_pixel.3170:
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_create_float_array
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
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
	li	r2, 5
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_create_array
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 4
	mflr	r31
	mr	r2, r5
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 4
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 4
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 4
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 4
	st	r2, r5, 16
	li	r2, 5
	li	r6, 0
	mflr	r31
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
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 12
	mflr	r31
	mr	r2, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 16
	mflr	r31
	mr	r2, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 16
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 16
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 16
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 16
	st	r2, r5, 16
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 20
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 20
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 20
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 20
	st	r2, r5, 16
	li	r2, 1
	li	r6, 0
	mflr	r31
	mr	r5, r6
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 24
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 28
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 28
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 28
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 28
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 28
	st	r2, r5, 16
	mr	r2, r4
	addi	r4, r4, 32
	st	r5, r2, 28
	ld	r5, r3, 24
	st	r5, r2, 24
	ld	r5, r3, 20
	st	r5, r2, 20
	ld	r5, r3, 16
	st	r5, r2, 16
	ld	r5, r3, 12
	st	r5, r2, 12
	ld	r5, r3, 8
	st	r5, r2, 8
	ld	r5, r3, 4
	st	r5, r2, 4
	ld	r5, r3, 0
	st	r5, r2, 0
	blr
init_line_elements.3172:
	cmpwi	cr0, r5, 0
	blt	bge_else.33230
	li	r6, 3
	fld	fr1, r0, 44
	st	r2, r3, 0
	st	r5, r3, 4
	mflr	r31
	mr	r2, r6
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 8
	mflr	r31
	mr	r2, r5
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 12
	mflr	r31
	mr	r2, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	st	r2, r5, 16
	li	r2, 5
	li	r6, 0
	mflr	r31
	mr	r5, r6
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r5, 5
	li	r6, 0
	st	r2, r3, 16
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 24
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 24
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 24
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 24
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 24
	st	r2, r5, 16
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 28
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 28
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 28
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 28
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 28
	st	r2, r5, 16
	li	r2, 1
	li	r6, 0
	mflr	r31
	mr	r5, r6
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 32
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 36
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 36
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 36
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 36
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 36
	st	r2, r5, 16
	mr	r2, r4
	addi	r4, r4, 32
	st	r5, r2, 28
	ld	r5, r3, 32
	st	r5, r2, 24
	ld	r5, r3, 28
	st	r5, r2, 20
	ld	r5, r3, 24
	st	r5, r2, 16
	ld	r5, r3, 20
	st	r5, r2, 12
	ld	r5, r3, 16
	st	r5, r2, 8
	ld	r5, r3, 12
	st	r5, r2, 4
	ld	r5, r3, 8
	st	r5, r2, 0
	ld	r5, r3, 4
	slwi	r6, r5, 2
	ld	r7, r3, 0
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33231
	st	r2, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	create_pixel.3170
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 40
	slwi	r6, r5, 2
	ld	r7, r3, 0
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33232
	li	r5, 3
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
	st	r2, r3, 48
	mflr	r31
	mr	r2, r5
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_float_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 52
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_float_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 52
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_float_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 52
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_float_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 52
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_float_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 52
	st	r2, r5, 16
	li	r2, 5
	li	r6, 0
	mflr	r31
	mr	r5, r6
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	li	r5, 5
	li	r6, 0
	st	r2, r3, 56
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
	fld	fr1, r0, 44
	st	r2, r3, 60
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_float_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 64
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_float_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r5, r3, 64
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_float_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r5, r3, 64
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_float_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r5, r3, 64
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_float_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r5, r3, 64
	st	r2, r5, 16
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_float_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 68
	mflr	r31
	mr	r2, r5
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_float_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r5, r3, 68
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_float_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r5, r3, 68
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_float_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r5, r3, 68
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_float_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r5, r3, 68
	st	r2, r5, 16
	li	r2, 1
	li	r6, 0
	mflr	r31
	mr	r5, r6
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 72
	mflr	r31
	mr	r2, r5
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_float_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 76
	mflr	r31
	mr	r2, r5
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_float_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r5, r3, 76
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_float_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r5, r3, 76
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_float_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r5, r3, 76
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_float_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r5, r3, 76
	st	r2, r5, 16
	mr	r2, r4
	addi	r4, r4, 32
	st	r5, r2, 28
	ld	r5, r3, 72
	st	r5, r2, 24
	ld	r5, r3, 68
	st	r5, r2, 20
	ld	r5, r3, 64
	st	r5, r2, 16
	ld	r5, r3, 60
	st	r5, r2, 12
	ld	r5, r3, 56
	st	r5, r2, 8
	ld	r5, r3, 52
	st	r5, r2, 4
	ld	r5, r3, 48
	st	r5, r2, 0
	ld	r5, r3, 44
	slwi	r6, r5, 2
	ld	r7, r3, 0
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33233
	st	r2, r3, 80
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	create_pixel.3170
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	ld	r5, r3, 80
	slwi	r6, r5, 2
	ld	r7, r3, 0
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r5, r5, -1
	mr	r2, r7
	b	init_line_elements.3172
bge_else.33233:
	mr	r2, r7
	blr
bge_else.33232:
	mr	r2, r7
	blr
bge_else.33231:
	mr	r2, r7
	blr
bge_else.33230:
	blr
create_pixelline.3175:
	ld	r2, r30, 4
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_create_float_array
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r2, 3
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
	st	r2, r3, 4
	mflr	r31
	mr	r2, r5
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 4
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 4
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 4
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 4
	st	r2, r5, 16
	li	r2, 5
	li	r5, 0
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	li	r2, 5
	li	r5, 0
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 8
	mflr	r31
	mr	r2, r5
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 8
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 8
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 8
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 8
	st	r2, r5, 16
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_float_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_create_array
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 12
	mflr	r31
	mr	r2, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	st	r2, r5, 16
	li	r2, 1
	li	r5, 0
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 16
	mflr	r31
	mr	r2, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 16
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 16
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 16
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 16
	st	r2, r5, 16
	ld	r2, r3, 0
	ld	r5, r2, 0
	li	r6, 3
	fld	fr1, r0, 44
	st	r5, r3, 20
	mflr	r31
	mr	r2, r6
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 24
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 28
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 28
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 28
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 28
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r5, r3, 28
	st	r2, r5, 16
	li	r2, 5
	li	r6, 0
	mflr	r31
	mr	r5, r6
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	li	r5, 5
	li	r6, 0
	st	r2, r3, 32
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 36
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 40
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 40
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 40
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 40
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 40
	st	r2, r5, 16
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 44
	mflr	r31
	mr	r2, r5
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_float_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r5, r3, 44
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_float_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r5, r3, 44
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_float_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r5, r3, 44
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_float_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	ld	r5, r3, 44
	st	r2, r5, 16
	li	r2, 1
	li	r6, 0
	mflr	r31
	mr	r5, r6
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 48
	mflr	r31
	mr	r2, r5
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_float_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 52
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_float_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 52
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_float_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 52
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_float_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 52
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_float_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 52
	st	r2, r5, 16
	mr	r2, r4
	addi	r4, r4, 32
	st	r5, r2, 28
	ld	r5, r3, 48
	st	r5, r2, 24
	ld	r5, r3, 44
	st	r5, r2, 20
	ld	r5, r3, 40
	st	r5, r2, 16
	ld	r5, r3, 36
	st	r5, r2, 12
	ld	r5, r3, 32
	st	r5, r2, 8
	ld	r5, r3, 28
	st	r5, r2, 4
	ld	r5, r3, 24
	st	r5, r2, 0
	mr	r5, r2
	ld	r2, r3, 20
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 0
	ld	r5, r5, 0
	addi	r5, r5, -2
	cmpwi	cr0, r5, 0
	blt	bge_else.33234
	st	r2, r3, 56
	st	r5, r3, 60
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	create_pixel.3170
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r5, r3, 60
	slwi	r6, r5, 2
	ld	r7, r3, 56
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33235
	li	r5, 3
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
	st	r2, r3, 68
	mflr	r31
	mr	r2, r5
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_float_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 72
	mflr	r31
	mr	r2, r5
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_float_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r5, r3, 72
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_float_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r5, r3, 72
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_float_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r5, r3, 72
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_float_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r5, r3, 72
	st	r2, r5, 16
	li	r2, 5
	li	r6, 0
	mflr	r31
	mr	r5, r6
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	li	r5, 5
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
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 80
	mflr	r31
	mr	r2, r5
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_float_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 84
	mflr	r31
	mr	r2, r5
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_float_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r5, r3, 84
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_float_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r5, r3, 84
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_float_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r5, r3, 84
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_float_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r5, r3, 84
	st	r2, r5, 16
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_float_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 88
	mflr	r31
	mr	r2, r5
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_float_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r5, r3, 88
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_float_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r5, r3, 88
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_float_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r5, r3, 88
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_float_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	ld	r5, r3, 88
	st	r2, r5, 16
	li	r2, 1
	li	r6, 0
	mflr	r31
	mr	r5, r6
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 92
	mflr	r31
	mr	r2, r5
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_float_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mr	r5, r2
	mtlr	r31
	li	r2, 5
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 96
	mflr	r31
	mr	r2, r5
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_float_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r5, r3, 96
	st	r2, r5, 4
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_float_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r5, r3, 96
	st	r2, r5, 8
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_float_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r5, r3, 96
	st	r2, r5, 12
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_float_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r5, r3, 96
	st	r2, r5, 16
	mr	r2, r4
	addi	r4, r4, 32
	st	r5, r2, 28
	ld	r5, r3, 92
	st	r5, r2, 24
	ld	r5, r3, 88
	st	r5, r2, 20
	ld	r5, r3, 84
	st	r5, r2, 16
	ld	r5, r3, 80
	st	r5, r2, 12
	ld	r5, r3, 76
	st	r5, r2, 8
	ld	r5, r3, 72
	st	r5, r2, 4
	ld	r5, r3, 68
	st	r5, r2, 0
	ld	r5, r3, 64
	slwi	r6, r5, 2
	ld	r7, r3, 56
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33236
	st	r2, r3, 100
	mflr	r31
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	create_pixel.3170
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	ld	r5, r3, 100
	slwi	r6, r5, 2
	ld	r7, r3, 56
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r5, r5, -1
	mr	r2, r7
	b	init_line_elements.3172
bge_else.33236:
	mr	r2, r7
	blr
bge_else.33235:
	mr	r2, r7
	blr
bge_else.33234:
	blr
calc_dirvec.3182:
	ld	r7, r30, 4
	cmpwi	cr0, r2, 5
	blt	bge_else.33237
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
	fld	fr2, r0, 16
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
	fld	fr4, r0, 16
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
	ld	r6, r6, 0
	fst	fr2, r6, 0
	fst	fr3, r6, 4
	fst	fr1, r6, 8
	addi	r6, r5, 40
	slwi	r6, r6, 2
	add	r31, r2, r6
	ld	r6, r31, 0
	ld	r6, r6, 0
	fsub	fr4, fr0, fr3
	fst	fr2, r6, 0
	fst	fr1, r6, 4
	fst	fr4, r6, 8
	addi	r6, r5, 80
	slwi	r6, r6, 2
	add	r31, r2, r6
	ld	r6, r31, 0
	ld	r6, r6, 0
	fsub	fr4, fr0, fr2
	fsub	fr5, fr0, fr3
	fst	fr1, r6, 0
	fst	fr4, r6, 4
	fst	fr5, r6, 8
	addi	r6, r5, 1
	slwi	r6, r6, 2
	add	r31, r2, r6
	ld	r6, r31, 0
	ld	r6, r6, 0
	fsub	fr4, fr0, fr2
	fsub	fr5, fr0, fr3
	fsub	fr6, fr0, fr1
	fst	fr4, r6, 0
	fst	fr5, r6, 4
	fst	fr6, r6, 8
	addi	r6, r5, 41
	slwi	r6, r6, 2
	add	r31, r2, r6
	ld	r6, r31, 0
	ld	r6, r6, 0
	fsub	fr4, fr0, fr2
	fsub	fr5, fr0, fr1
	fst	fr4, r6, 0
	fst	fr5, r6, 4
	fst	fr3, r6, 8
	addi	r5, r5, 81
	slwi	r5, r5, 2
	add	r31, r2, r5
	ld	r2, r31, 0
	ld	r2, r2, 0
	fsub	fr1, fr0, fr1
	fst	fr1, r2, 0
	fst	fr2, r2, 4
	fst	fr3, r2, 8
	blr
bge_else.33237:
	fmul	fr1, fr2, fr2
	fld	fr2, r0, 172
	fadd	fr1, fr1, fr2
	st	r6, r3, 0
	st	r5, r3, 8
	st	r30, r3, 24
	fst	fr4, r3, 28
	st	r2, r3, 32
	fst	fr3, r3, 36
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_sqrt
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r0, 16
	fdiv	fr2, fr2, fr1
	fst	fr1, r3, 40
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_atan
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r3, 36
	fmul	fr1, fr1, fr2
	fst	fr1, r3, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_sin
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 44
	fst	fr1, r3, 48
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_cos
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	fld	fr2, r3, 48
	fdiv	fr1, fr2, fr1
	fld	fr2, r3, 40
	fmul	fr1, fr1, fr2
	ld	r2, r3, 32
	addi	r2, r2, 1
	fmul	fr2, fr1, fr1
	fld	fr3, r0, 172
	fadd	fr2, fr2, fr3
	fst	fr1, r3, 52
	st	r2, r3, 56
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_sqrt
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	fld	fr2, r0, 16
	fdiv	fr2, fr2, fr1
	fst	fr1, r3, 60
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_atan
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 28
	fmul	fr1, fr1, fr2
	fst	fr1, r3, 64
	mflr	r31
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_sin
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	fld	fr2, r3, 64
	fst	fr1, r3, 68
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_cos
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	fld	fr2, r3, 68
	fdiv	fr1, fr2, fr1
	fld	fr2, r3, 60
	fmul	fr2, fr1, fr2
	fld	fr1, r3, 52
	fld	fr3, r3, 36
	fld	fr4, r3, 28
	ld	r2, r3, 56
	ld	r5, r3, 8
	ld	r6, r3, 0
	ld	r30, r3, 24
	ld	r29, r30, 0
	ba	r29
calc_dirvecs.3190:
	ld	r7, r30, 4
	cmpwi	cr0, r2, 0
	blt	bge_else.33239
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
	fld	fr2, r0, 56
	fmul	fr1, fr1, fr2
	fld	fr2, r0, 184
	fsub	fr3, fr1, fr2
	li	r2, 0
	fld	fr1, r0, 44
	fld	fr2, r0, 44
	fld	fr4, r3, 8
	ld	r5, r3, 16
	ld	r6, r3, 12
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	bal	r31
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
	fld	fr2, r0, 56
	fmul	fr1, fr1, fr2
	fld	fr2, r0, 172
	fadd	fr3, fr1, fr2
	li	r2, 0
	fld	fr1, r0, 44
	fld	fr2, r0, 44
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
	bal	r31
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 4
	addi	r2, r2, -1
	ld	r5, r3, 16
	addi	r5, r5, 1
	cmpwi	cr0, r5, 5
	blt	bge_else.33240
	addi	r5, r5, -5
	b	bge_cont.33241
bge_else.33240:
bge_cont.33241:
	cmpwi	cr0, r2, 0
	blt	bge_else.33242
	st	r2, r3, 24
	st	r5, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_float_of_int
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r0, 56
	fmul	fr1, fr1, fr2
	fld	fr2, r0, 184
	fsub	fr3, fr1, fr2
	li	r2, 0
	fld	fr1, r0, 44
	fld	fr2, r0, 44
	fld	fr4, r3, 8
	ld	r5, r3, 28
	ld	r6, r3, 12
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 24
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_float_of_int
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r0, 56
	fmul	fr1, fr1, fr2
	fld	fr2, r0, 172
	fadd	fr3, fr1, fr2
	li	r2, 0
	fld	fr1, r0, 44
	fld	fr2, r0, 44
	ld	r5, r3, 12
	addi	r6, r5, 2
	fld	fr4, r3, 8
	ld	r7, r3, 28
	ld	r30, r3, 20
	mflr	r31
	mr	r5, r7
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 24
	addi	r2, r2, -1
	ld	r5, r3, 28
	addi	r5, r5, 1
	cmpwi	cr0, r5, 5
	blt	bge_else.33243
	addi	r5, r5, -5
	b	bge_cont.33244
bge_else.33243:
bge_cont.33244:
	fld	fr1, r3, 8
	ld	r6, r3, 12
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
bge_else.33242:
	blr
bge_else.33239:
	blr
calc_dirvec_rows.3195:
	ld	r7, r30, 8
	ld	r8, r30, 4
	cmpwi	cr0, r2, 0
	blt	bge_else.33247
	st	r30, r3, 0
	st	r2, r3, 4
	st	r7, r3, 8
	st	r6, r3, 12
	st	r5, r3, 16
	st	r8, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_float_of_int
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	fld	fr2, r0, 56
	fmul	fr1, fr1, fr2
	fld	fr2, r0, 184
	fsub	fr1, fr1, fr2
	li	r2, 4
	st	r2, r3, 24
	fst	fr1, r3, 28
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_float_of_int
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r0, 56
	fmul	fr1, fr1, fr2
	fld	fr2, r0, 184
	fsub	fr3, fr1, fr2
	li	r2, 0
	fld	fr1, r0, 44
	fld	fr2, r0, 44
	fld	fr4, r3, 28
	ld	r5, r3, 16
	ld	r6, r3, 12
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 24
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_float_of_int
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	fld	fr2, r0, 56
	fmul	fr1, fr1, fr2
	fld	fr2, r0, 172
	fadd	fr3, fr1, fr2
	li	r2, 0
	fld	fr1, r0, 44
	fld	fr2, r0, 44
	ld	r5, r3, 12
	addi	r6, r5, 2
	fld	fr4, r3, 28
	ld	r7, r3, 16
	ld	r30, r3, 20
	mflr	r31
	mr	r5, r7
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	li	r2, 3
	ld	r5, r3, 16
	addi	r6, r5, 1
	cmpwi	cr0, r6, 5
	blt	bge_else.33248
	addi	r6, r6, -5
	b	bge_cont.33249
bge_else.33248:
bge_cont.33249:
	fld	fr1, r3, 28
	ld	r7, r3, 12
	ld	r30, r3, 8
	mflr	r31
	mr	r5, r6
	mr	r6, r7
	st	r31, r3, 36
	addi	r3, r3, 40
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	ld	r2, r3, 4
	addi	r2, r2, -1
	ld	r5, r3, 16
	addi	r5, r5, 2
	cmpwi	cr0, r5, 5
	blt	bge_else.33250
	addi	r5, r5, -5
	b	bge_cont.33251
bge_else.33250:
bge_cont.33251:
	ld	r6, r3, 12
	addi	r6, r6, 4
	cmpwi	cr0, r2, 0
	blt	bge_else.33252
	st	r2, r3, 32
	st	r6, r3, 36
	st	r5, r3, 40
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_float_of_int
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	fld	fr2, r0, 56
	fmul	fr1, fr1, fr2
	fld	fr2, r0, 184
	fsub	fr1, fr1, fr2
	li	r2, 4
	ld	r5, r3, 40
	ld	r6, r3, 36
	ld	r30, r3, 8
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 32
	addi	r2, r2, -1
	ld	r5, r3, 40
	addi	r5, r5, 2
	cmpwi	cr0, r5, 5
	blt	bge_else.33253
	addi	r5, r5, -5
	b	bge_cont.33254
bge_else.33253:
bge_cont.33254:
	ld	r6, r3, 36
	addi	r6, r6, 4
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
bge_else.33252:
	blr
bge_else.33247:
	blr
create_dirvec_elements.3201:
	ld	r6, r30, 4
	cmpwi	cr0, r5, 0
	blt	bge_else.33257
	li	r7, 3
	fld	fr1, r0, 44
	st	r30, r3, 0
	st	r2, r3, 4
	st	r5, r3, 8
	st	r6, r3, 12
	mflr	r31
	mr	r2, r7
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 12
	ld	r6, r2, 0
	st	r5, r3, 16
	mflr	r31
	mr	r2, r6
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 16
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 8
	slwi	r6, r5, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33258
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 12
	ld	r6, r2, 0
	st	r5, r3, 24
	mflr	r31
	mr	r2, r6
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 24
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 20
	slwi	r6, r5, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33259
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 28
	mflr	r31
	mr	r2, r5
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 12
	ld	r6, r2, 0
	st	r5, r3, 32
	mflr	r31
	mr	r2, r6
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 32
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 28
	slwi	r6, r5, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33260
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 36
	mflr	r31
	mr	r2, r5
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 12
	ld	r6, r2, 0
	st	r5, r3, 40
	mflr	r31
	mr	r2, r6
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 40
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 36
	slwi	r6, r5, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33261
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 44
	mflr	r31
	mr	r2, r5
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_float_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 12
	ld	r6, r2, 0
	st	r5, r3, 48
	mflr	r31
	mr	r2, r6
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 48
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 44
	slwi	r6, r5, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33262
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 52
	mflr	r31
	mr	r2, r5
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_float_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 12
	ld	r6, r2, 0
	st	r5, r3, 56
	mflr	r31
	mr	r2, r6
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 56
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 52
	slwi	r6, r5, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33263
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 60
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_float_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 12
	ld	r6, r2, 0
	st	r5, r3, 64
	mflr	r31
	mr	r2, r6
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 64
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 60
	slwi	r6, r5, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33264
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 68
	mflr	r31
	mr	r2, r5
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_float_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 12
	ld	r2, r2, 0
	st	r5, r3, 72
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 72
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 68
	slwi	r6, r5, 2
	ld	r7, r3, 4
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r5, r5, -1
	ld	r30, r3, 0
	mr	r2, r7
	ld	r29, r30, 0
	ba	r29
bge_else.33264:
	blr
bge_else.33263:
	blr
bge_else.33262:
	blr
bge_else.33261:
	blr
bge_else.33260:
	blr
bge_else.33259:
	blr
bge_else.33258:
	blr
bge_else.33257:
	blr
create_dirvecs.3204:
	ld	r5, r30, 12
	ld	r6, r30, 8
	ld	r7, r30, 4
	cmpwi	cr0, r2, 0
	blt	bge_else.33273
	li	r8, 3
	fld	fr1, r0, 44
	st	r30, r3, 0
	st	r7, r3, 4
	st	r6, r3, 8
	st	r2, r3, 12
	st	r5, r3, 16
	mflr	r31
	mr	r2, r8
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	mflr	r31
	mr	r2, r6
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r2, 120
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 20
	mflr	r31
	mr	r2, r5
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_float_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 24
	mflr	r31
	mr	r2, r6
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 24
	st	r2, r5, 0
	ld	r2, r3, 20
	mflr	r31
	st	r31, r3, 28
	addi	r3, r3, 32
	bl	min_caml_create_array
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r5, r3, 12
	slwi	r6, r5, 2
	ld	r7, r3, 8
	add	r31, r7, r6
	st	r2, r31, 0
	slwi	r2, r5, 2
	add	r31, r7, r2
	ld	r2, r31, 0
	li	r6, 3
	fld	fr1, r0, 44
	st	r2, r3, 28
	mflr	r31
	mr	r2, r6
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 32
	mflr	r31
	mr	r2, r6
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 32
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 28
	st	r2, r5, 472
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_float_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 36
	mflr	r31
	mr	r2, r6
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 36
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 28
	st	r2, r5, 468
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 40
	mflr	r31
	mr	r2, r6
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 40
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 28
	st	r2, r5, 464
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	min_caml_create_float_array
	addi	r3, r3, -48
	ld	r31, r3, 44
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 44
	mflr	r31
	mr	r2, r6
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 44
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 28
	st	r2, r5, 460
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_float_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 48
	mflr	r31
	mr	r2, r6
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 48
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 28
	st	r2, r5, 456
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_float_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 52
	mflr	r31
	mr	r2, r6
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 52
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 28
	st	r2, r5, 452
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_float_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 56
	mflr	r31
	mr	r2, r6
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 56
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 28
	st	r2, r5, 448
	li	r2, 111
	ld	r30, r3, 4
	mflr	r31
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 12
	addi	r2, r2, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33274
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 60
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_float_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	mflr	r31
	mr	r2, r6
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	li	r2, 120
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 64
	mflr	r31
	mr	r2, r5
	st	r31, r3, 68
	addi	r3, r3, 72
	bl	min_caml_create_float_array
	addi	r3, r3, -72
	ld	r31, r3, 68
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 68
	mflr	r31
	mr	r2, r6
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 68
	st	r2, r5, 0
	ld	r2, r3, 64
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r5, r3, 60
	slwi	r6, r5, 2
	ld	r7, r3, 8
	add	r31, r7, r6
	st	r2, r31, 0
	slwi	r2, r5, 2
	add	r31, r7, r2
	ld	r2, r31, 0
	li	r6, 3
	fld	fr1, r0, 44
	st	r2, r3, 72
	mflr	r31
	mr	r2, r6
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_float_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 76
	mflr	r31
	mr	r2, r6
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 76
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 72
	st	r2, r5, 472
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_float_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 80
	mflr	r31
	mr	r2, r6
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 80
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 72
	st	r2, r5, 468
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 84
	addi	r3, r3, 88
	bl	min_caml_create_float_array
	addi	r3, r3, -88
	ld	r31, r3, 84
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 84
	mflr	r31
	mr	r2, r6
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 84
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 72
	st	r2, r5, 464
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_float_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 88
	mflr	r31
	mr	r2, r6
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 88
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 72
	st	r2, r5, 460
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_float_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 92
	mflr	r31
	mr	r2, r6
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 92
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 72
	st	r2, r5, 456
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_float_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 96
	mflr	r31
	mr	r2, r6
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 96
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 72
	st	r2, r5, 452
	li	r2, 112
	ld	r30, r3, 4
	mflr	r31
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	st	r31, r3, 100
	addi	r3, r3, 104
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r2, r3, 60
	addi	r2, r2, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33275
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 100
	mflr	r31
	mr	r2, r5
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_create_float_array
	addi	r3, r3, -112
	ld	r31, r3, 108
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	mflr	r31
	mr	r2, r6
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_create_array
	addi	r3, r3, -112
	ld	r31, r3, 108
	mtlr	r31
	li	r2, 120
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 104
	mflr	r31
	mr	r2, r5
	st	r31, r3, 108
	addi	r3, r3, 112
	bl	min_caml_create_float_array
	addi	r3, r3, -112
	ld	r31, r3, 108
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 108
	mflr	r31
	mr	r2, r6
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_create_array
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 108
	st	r2, r5, 0
	ld	r2, r3, 104
	mflr	r31
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_create_array
	addi	r3, r3, -120
	ld	r31, r3, 116
	mtlr	r31
	ld	r5, r3, 100
	slwi	r6, r5, 2
	ld	r7, r3, 8
	add	r31, r7, r6
	st	r2, r31, 0
	slwi	r2, r5, 2
	add	r31, r7, r2
	ld	r2, r31, 0
	li	r6, 3
	fld	fr1, r0, 44
	st	r2, r3, 112
	mflr	r31
	mr	r2, r6
	st	r31, r3, 116
	addi	r3, r3, 120
	bl	min_caml_create_float_array
	addi	r3, r3, -120
	ld	r31, r3, 116
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 116
	mflr	r31
	mr	r2, r6
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_create_array
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 116
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 112
	st	r2, r5, 472
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_create_float_array
	addi	r3, r3, -128
	ld	r31, r3, 124
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 120
	mflr	r31
	mr	r2, r6
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_create_array
	addi	r3, r3, -128
	ld	r31, r3, 124
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 120
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 112
	st	r2, r5, 468
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_create_float_array
	addi	r3, r3, -128
	ld	r31, r3, 124
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 124
	mflr	r31
	mr	r2, r6
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
	ld	r5, r3, 112
	st	r2, r5, 464
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_create_float_array
	addi	r3, r3, -136
	ld	r31, r3, 132
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 128
	mflr	r31
	mr	r2, r6
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_create_array
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 128
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 112
	st	r2, r5, 460
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 132
	addi	r3, r3, 136
	bl	min_caml_create_float_array
	addi	r3, r3, -136
	ld	r31, r3, 132
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 132
	mflr	r31
	mr	r2, r6
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
	ld	r5, r3, 112
	st	r2, r5, 456
	li	r2, 113
	ld	r30, r3, 4
	mflr	r31
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	st	r31, r3, 140
	addi	r3, r3, 144
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	ld	r2, r3, 100
	addi	r2, r2, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33276
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 136
	mflr	r31
	mr	r2, r5
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_create_float_array
	addi	r3, r3, -144
	ld	r31, r3, 140
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	mflr	r31
	mr	r2, r6
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_create_array
	addi	r3, r3, -144
	ld	r31, r3, 140
	mtlr	r31
	li	r2, 120
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 140
	mflr	r31
	mr	r2, r5
	st	r31, r3, 148
	addi	r3, r3, 152
	bl	min_caml_create_float_array
	addi	r3, r3, -152
	ld	r31, r3, 148
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 144
	mflr	r31
	mr	r2, r6
	st	r31, r3, 148
	addi	r3, r3, 152
	bl	min_caml_create_array
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 144
	st	r2, r5, 0
	ld	r2, r3, 140
	mflr	r31
	st	r31, r3, 148
	addi	r3, r3, 152
	bl	min_caml_create_array
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	ld	r5, r3, 136
	slwi	r6, r5, 2
	ld	r7, r3, 8
	add	r31, r7, r6
	st	r2, r31, 0
	slwi	r2, r5, 2
	add	r31, r7, r2
	ld	r2, r31, 0
	li	r6, 3
	fld	fr1, r0, 44
	st	r2, r3, 148
	mflr	r31
	mr	r2, r6
	st	r31, r3, 156
	addi	r3, r3, 160
	bl	min_caml_create_float_array
	addi	r3, r3, -160
	ld	r31, r3, 156
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 152
	mflr	r31
	mr	r2, r6
	st	r31, r3, 156
	addi	r3, r3, 160
	bl	min_caml_create_array
	addi	r3, r3, -160
	ld	r31, r3, 156
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 152
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 148
	st	r2, r5, 472
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 156
	addi	r3, r3, 160
	bl	min_caml_create_float_array
	addi	r3, r3, -160
	ld	r31, r3, 156
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 156
	mflr	r31
	mr	r2, r6
	st	r31, r3, 164
	addi	r3, r3, 168
	bl	min_caml_create_array
	addi	r3, r3, -168
	ld	r31, r3, 164
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 156
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 148
	st	r2, r5, 468
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 164
	addi	r3, r3, 168
	bl	min_caml_create_float_array
	addi	r3, r3, -168
	ld	r31, r3, 164
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r6, r2, 0
	st	r5, r3, 160
	mflr	r31
	mr	r2, r6
	st	r31, r3, 164
	addi	r3, r3, 168
	bl	min_caml_create_array
	addi	r3, r3, -168
	ld	r31, r3, 164
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 160
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 148
	st	r2, r5, 464
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 164
	addi	r3, r3, 168
	bl	min_caml_create_float_array
	addi	r3, r3, -168
	ld	r31, r3, 164
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 16
	ld	r2, r2, 0
	st	r5, r3, 164
	mflr	r31
	st	r31, r3, 172
	addi	r3, r3, 176
	bl	min_caml_create_array
	addi	r3, r3, -176
	ld	r31, r3, 172
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 164
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 148
	st	r2, r5, 460
	li	r2, 114
	ld	r30, r3, 4
	mflr	r31
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	st	r31, r3, 172
	addi	r3, r3, 176
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -176
	ld	r31, r3, 172
	mtlr	r31
	ld	r2, r3, 136
	addi	r2, r2, -1
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
bge_else.33276:
	blr
bge_else.33275:
	blr
bge_else.33274:
	blr
bge_else.33273:
	blr
init_dirvec_constants.3206:
	ld	r6, r30, 12
	ld	r7, r30, 8
	ld	r8, r30, 4
	cmpwi	cr0, r5, 0
	blt	bge_else.33281
	slwi	r9, r5, 2
	add	r31, r2, r9
	ld	r9, r31, 0
	ld	r10, r7, 0
	addi	r10, r10, -1
	st	r30, r3, 0
	st	r8, r3, 4
	st	r6, r3, 8
	st	r7, r3, 12
	st	r2, r3, 16
	st	r5, r3, 20
	mflr	r31
	mr	r5, r10
	mr	r2, r9
	mr	r30, r8
	st	r31, r3, 28
	addi	r3, r3, 32
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -32
	ld	r31, r3, 28
	mtlr	r31
	ld	r2, r3, 20
	addi	r2, r2, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33282
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r7, r3, 12
	ld	r8, r7, 0
	addi	r8, r8, -1
	st	r2, r3, 24
	cmpwi	cr0, r8, 0
	blt	bge_else.33283
	slwi	r9, r8, 2
	ld	r10, r3, 8
	add	r31, r10, r9
	ld	r9, r31, 0
	ld	r11, r5, 4
	ld	r12, r5, 0
	ld	r13, r9, 4
	st	r5, r3, 28
	cmpwi	cr0, r13, 1
	bne	beq_else.33285
	st	r11, r3, 32
	st	r8, r3, 36
	mflr	r31
	mr	r5, r9
	mr	r2, r12
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	setup_rect_table.2979
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 36
	slwi	r6, r5, 2
	ld	r7, r3, 32
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.33286
beq_else.33285:
	cmpwi	cr0, r13, 2
	bne	beq_else.33287
	st	r11, r3, 32
	st	r8, r3, 36
	mflr	r31
	mr	r5, r9
	mr	r2, r12
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	setup_surface_table.2982
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 36
	slwi	r6, r5, 2
	ld	r7, r3, 32
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.33288
beq_else.33287:
	st	r11, r3, 32
	st	r8, r3, 36
	mflr	r31
	mr	r5, r9
	mr	r2, r12
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	setup_second_table.2985
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 36
	slwi	r6, r5, 2
	ld	r7, r3, 32
	add	r31, r7, r6
	st	r2, r31, 0
beq_cont.33288:
beq_cont.33286:
	addi	r5, r5, -1
	ld	r2, r3, 28
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	b	bge_cont.33284
bge_else.33283:
bge_cont.33284:
	ld	r2, r3, 24
	addi	r2, r2, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33289
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r7, r3, 12
	ld	r8, r7, 0
	addi	r8, r8, -1
	ld	r30, r3, 4
	st	r2, r3, 40
	mflr	r31
	mr	r2, r5
	mr	r5, r8
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 40
	addi	r2, r2, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33290
	slwi	r5, r2, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r7, r3, 12
	ld	r7, r7, 0
	addi	r7, r7, -1
	st	r2, r3, 44
	cmpwi	cr0, r7, 0
	blt	bge_else.33291
	slwi	r8, r7, 2
	ld	r9, r3, 8
	add	r31, r9, r8
	ld	r8, r31, 0
	ld	r9, r5, 4
	ld	r10, r5, 0
	ld	r11, r8, 4
	st	r5, r3, 48
	cmpwi	cr0, r11, 1
	bne	beq_else.33293
	st	r9, r3, 52
	st	r7, r3, 56
	mflr	r31
	mr	r5, r8
	mr	r2, r10
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	setup_rect_table.2979
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 56
	slwi	r6, r5, 2
	ld	r7, r3, 52
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.33294
beq_else.33293:
	cmpwi	cr0, r11, 2
	bne	beq_else.33295
	st	r9, r3, 52
	st	r7, r3, 56
	mflr	r31
	mr	r5, r8
	mr	r2, r10
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	setup_surface_table.2982
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 56
	slwi	r6, r5, 2
	ld	r7, r3, 52
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.33296
beq_else.33295:
	st	r9, r3, 52
	st	r7, r3, 56
	mflr	r31
	mr	r5, r8
	mr	r2, r10
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	setup_second_table.2985
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 56
	slwi	r6, r5, 2
	ld	r7, r3, 52
	add	r31, r7, r6
	st	r2, r31, 0
beq_cont.33296:
beq_cont.33294:
	addi	r5, r5, -1
	ld	r2, r3, 48
	ld	r30, r3, 4
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	b	bge_cont.33292
bge_else.33291:
bge_cont.33292:
	ld	r2, r3, 44
	addi	r5, r2, -1
	ld	r2, r3, 16
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
bge_else.33290:
	blr
bge_else.33289:
	blr
bge_else.33282:
	blr
bge_else.33281:
	blr
init_vecset_constants.3209:
	ld	r5, r30, 20
	ld	r6, r30, 16
	ld	r7, r30, 12
	ld	r8, r30, 8
	ld	r9, r30, 4
	cmpwi	cr0, r2, 0
	blt	bge_else.33301
	slwi	r10, r2, 2
	add	r31, r9, r10
	ld	r10, r31, 0
	ld	r11, r10, 476
	ld	r12, r6, 0
	addi	r12, r12, -1
	st	r30, r3, 0
	st	r9, r3, 4
	st	r2, r3, 8
	st	r8, r3, 12
	st	r5, r3, 16
	st	r7, r3, 20
	st	r6, r3, 24
	st	r10, r3, 28
	cmpwi	cr0, r12, 0
	blt	bge_else.33302
	slwi	r13, r12, 2
	add	r31, r5, r13
	ld	r13, r31, 0
	ld	r14, r11, 4
	ld	r15, r11, 0
	ld	r16, r13, 4
	st	r11, r3, 32
	cmpwi	cr0, r16, 1
	bne	beq_else.33304
	st	r14, r3, 36
	st	r12, r3, 40
	mflr	r31
	mr	r5, r13
	mr	r2, r15
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	setup_rect_table.2979
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 40
	slwi	r6, r5, 2
	ld	r7, r3, 36
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.33305
beq_else.33304:
	cmpwi	cr0, r16, 2
	bne	beq_else.33306
	st	r14, r3, 36
	st	r12, r3, 40
	mflr	r31
	mr	r5, r13
	mr	r2, r15
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	setup_surface_table.2982
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 40
	slwi	r6, r5, 2
	ld	r7, r3, 36
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.33307
beq_else.33306:
	st	r14, r3, 36
	st	r12, r3, 40
	mflr	r31
	mr	r5, r13
	mr	r2, r15
	st	r31, r3, 44
	addi	r3, r3, 48
	bl	setup_second_table.2985
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r5, r3, 40
	slwi	r6, r5, 2
	ld	r7, r3, 36
	add	r31, r7, r6
	st	r2, r31, 0
beq_cont.33307:
beq_cont.33305:
	addi	r5, r5, -1
	ld	r2, r3, 32
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	b	bge_cont.33303
bge_else.33302:
bge_cont.33303:
	ld	r2, r3, 28
	ld	r5, r2, 472
	ld	r6, r3, 24
	ld	r7, r6, 0
	addi	r7, r7, -1
	ld	r30, r3, 20
	mflr	r31
	mr	r2, r5
	mr	r5, r7
	st	r31, r3, 44
	addi	r3, r3, 48
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -48
	ld	r31, r3, 44
	mtlr	r31
	ld	r2, r3, 28
	ld	r5, r2, 468
	ld	r6, r3, 24
	ld	r7, r6, 0
	addi	r7, r7, -1
	cmpwi	cr0, r7, 0
	blt	bge_else.33308
	slwi	r8, r7, 2
	ld	r9, r3, 16
	add	r31, r9, r8
	ld	r8, r31, 0
	ld	r10, r5, 4
	ld	r11, r5, 0
	ld	r12, r8, 4
	st	r5, r3, 44
	cmpwi	cr0, r12, 1
	bne	beq_else.33310
	st	r10, r3, 48
	st	r7, r3, 52
	mflr	r31
	mr	r5, r8
	mr	r2, r11
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	setup_rect_table.2979
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 52
	slwi	r6, r5, 2
	ld	r7, r3, 48
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.33311
beq_else.33310:
	cmpwi	cr0, r12, 2
	bne	beq_else.33312
	st	r10, r3, 48
	st	r7, r3, 52
	mflr	r31
	mr	r5, r8
	mr	r2, r11
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	setup_surface_table.2982
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 52
	slwi	r6, r5, 2
	ld	r7, r3, 48
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.33313
beq_else.33312:
	st	r10, r3, 48
	st	r7, r3, 52
	mflr	r31
	mr	r5, r8
	mr	r2, r11
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	setup_second_table.2985
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r5, r3, 52
	slwi	r6, r5, 2
	ld	r7, r3, 48
	add	r31, r7, r6
	st	r2, r31, 0
beq_cont.33313:
beq_cont.33311:
	addi	r5, r5, -1
	ld	r2, r3, 44
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	b	bge_cont.33309
bge_else.33308:
bge_cont.33309:
	li	r5, 116
	ld	r2, r3, 28
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	ld	r2, r3, 8
	addi	r2, r2, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33314
	slwi	r5, r2, 2
	ld	r6, r3, 4
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r7, r5, 476
	ld	r8, r3, 24
	ld	r9, r8, 0
	addi	r9, r9, -1
	ld	r30, r3, 20
	st	r2, r3, 56
	st	r5, r3, 60
	mflr	r31
	mr	r5, r9
	mr	r2, r7
	st	r31, r3, 68
	addi	r3, r3, 72
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -72
	ld	r31, r3, 68
	mtlr	r31
	ld	r2, r3, 60
	ld	r5, r2, 472
	ld	r6, r3, 24
	ld	r7, r6, 0
	addi	r7, r7, -1
	cmpwi	cr0, r7, 0
	blt	bge_else.33315
	slwi	r8, r7, 2
	ld	r9, r3, 16
	add	r31, r9, r8
	ld	r8, r31, 0
	ld	r10, r5, 4
	ld	r11, r5, 0
	ld	r12, r8, 4
	st	r5, r3, 64
	cmpwi	cr0, r12, 1
	bne	beq_else.33317
	st	r10, r3, 68
	st	r7, r3, 72
	mflr	r31
	mr	r5, r8
	mr	r2, r11
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	setup_rect_table.2979
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r5, r3, 72
	slwi	r6, r5, 2
	ld	r7, r3, 68
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.33318
beq_else.33317:
	cmpwi	cr0, r12, 2
	bne	beq_else.33319
	st	r10, r3, 68
	st	r7, r3, 72
	mflr	r31
	mr	r5, r8
	mr	r2, r11
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	setup_surface_table.2982
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r5, r3, 72
	slwi	r6, r5, 2
	ld	r7, r3, 68
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.33320
beq_else.33319:
	st	r10, r3, 68
	st	r7, r3, 72
	mflr	r31
	mr	r5, r8
	mr	r2, r11
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	setup_second_table.2985
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r5, r3, 72
	slwi	r6, r5, 2
	ld	r7, r3, 68
	add	r31, r7, r6
	st	r2, r31, 0
beq_cont.33320:
beq_cont.33318:
	addi	r5, r5, -1
	ld	r2, r3, 64
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	b	bge_cont.33316
bge_else.33315:
bge_cont.33316:
	li	r5, 117
	ld	r2, r3, 60
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 76
	addi	r3, r3, 80
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	ld	r2, r3, 56
	addi	r2, r2, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33321
	slwi	r5, r2, 2
	ld	r6, r3, 4
	add	r31, r6, r5
	ld	r5, r31, 0
	ld	r7, r5, 476
	ld	r8, r3, 24
	ld	r8, r8, 0
	addi	r8, r8, -1
	st	r2, r3, 76
	st	r5, r3, 80
	cmpwi	cr0, r8, 0
	blt	bge_else.33322
	slwi	r9, r8, 2
	ld	r10, r3, 16
	add	r31, r10, r9
	ld	r9, r31, 0
	ld	r10, r7, 4
	ld	r11, r7, 0
	ld	r12, r9, 4
	st	r7, r3, 84
	cmpwi	cr0, r12, 1
	bne	beq_else.33324
	st	r10, r3, 88
	st	r8, r3, 92
	mflr	r31
	mr	r5, r9
	mr	r2, r11
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	setup_rect_table.2979
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r5, r3, 92
	slwi	r6, r5, 2
	ld	r7, r3, 88
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.33325
beq_else.33324:
	cmpwi	cr0, r12, 2
	bne	beq_else.33326
	st	r10, r3, 88
	st	r8, r3, 92
	mflr	r31
	mr	r5, r9
	mr	r2, r11
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	setup_surface_table.2982
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r5, r3, 92
	slwi	r6, r5, 2
	ld	r7, r3, 88
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.33327
beq_else.33326:
	st	r10, r3, 88
	st	r8, r3, 92
	mflr	r31
	mr	r5, r9
	mr	r2, r11
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	setup_second_table.2985
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r5, r3, 92
	slwi	r6, r5, 2
	ld	r7, r3, 88
	add	r31, r7, r6
	st	r2, r31, 0
beq_cont.33327:
beq_cont.33325:
	addi	r5, r5, -1
	ld	r2, r3, 84
	ld	r30, r3, 20
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	b	bge_cont.33323
bge_else.33322:
bge_cont.33323:
	li	r5, 118
	ld	r2, r3, 80
	ld	r30, r3, 12
	mflr	r31
	st	r31, r3, 100
	addi	r3, r3, 104
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r2, r3, 76
	addi	r2, r2, -1
	cmpwi	cr0, r2, 0
	blt	bge_else.33328
	slwi	r5, r2, 2
	ld	r6, r3, 4
	add	r31, r6, r5
	ld	r5, r31, 0
	li	r6, 119
	ld	r30, r3, 12
	st	r2, r3, 96
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 100
	addi	r3, r3, 104
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	ld	r2, r3, 96
	addi	r2, r2, -1
	ld	r30, r3, 0
	ld	r29, r30, 0
	ba	r29
bge_else.33328:
	blr
bge_else.33321:
	blr
bge_else.33314:
	blr
bge_else.33301:
	blr
setup_reflections.3226:
	ld	r5, r30, 24
	ld	r6, r30, 20
	ld	r7, r30, 16
	ld	r8, r30, 12
	ld	r9, r30, 8
	ld	r10, r30, 4
	cmpwi	cr0, r2, 0
	blt	bge_else.33333
	slwi	r11, r2, 2
	add	r31, r6, r11
	ld	r6, r31, 0
	ld	r11, r6, 8
	cmpwi	cr0, r11, 2
	bne	beq_else.33334
	fld	fr1, r0, 16
	ld	r11, r6, 28
	fld	fr2, r11, 0
	fcmp	cr0, fr1, fr2
	blt	le.33335
	beq	le.33335
	li	r11, 1
	b	gt_cont.33336
le.33335:
	li	r11, 0
gt_cont.33336:
	cmpwi	cr0, r11, 0
	bne	beq_else.33337
	blr
beq_else.33337:
	ld	r11, r6, 4
	cmpwi	cr0, r11, 1
	bne	beq_else.33339
	slwi	r2, r2, 2
	ld	r11, r7, 0
	fld	fr1, r0, 16
	ld	r6, r6, 28
	fld	fr2, r6, 0
	fsub	fr1, fr1, fr2
	fld	fr2, r9, 0
	fsub	fr2, fr0, fr2
	fld	fr3, r9, 4
	fsub	fr3, fr0, fr3
	fld	fr4, r9, 8
	fsub	fr4, fr0, fr4
	addi	r6, r2, 1
	fld	fr5, r9, 0
	li	r12, 3
	fld	fr6, r0, 44
	st	r7, r3, 0
	fst	fr2, r3, 4
	st	r9, r3, 8
	st	r2, r3, 12
	st	r5, r3, 16
	st	r11, r3, 20
	st	r6, r3, 24
	fst	fr1, r3, 28
	st	r10, r3, 32
	fst	fr4, r3, 36
	fst	fr3, r3, 40
	fst	fr5, r3, 44
	st	r8, r3, 48
	mflr	r31
	mr	r2, r12
	fmr	fr1, fr6
	st	r31, r3, 52
	addi	r3, r3, 56
	bl	min_caml_create_float_array
	addi	r3, r3, -56
	ld	r31, r3, 52
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 48
	ld	r6, r2, 0
	st	r5, r3, 52
	mflr	r31
	mr	r2, r6
	st	r31, r3, 60
	addi	r3, r3, 64
	bl	min_caml_create_array
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 52
	st	r2, r5, 0
	fld	fr1, r3, 44
	fst	fr1, r2, 0
	fld	fr1, r3, 40
	fst	fr1, r2, 4
	fld	fr2, r3, 36
	fst	fr2, r2, 8
	ld	r2, r3, 48
	ld	r6, r2, 0
	addi	r6, r6, -1
	ld	r30, r3, 32
	st	r5, r3, 56
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 60
	addi	r3, r3, 64
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -64
	ld	r31, r3, 60
	mtlr	r31
	mr	r2, r4
	addi	r4, r4, 16
	fld	fr1, r3, 28
	fst	fr1, r2, 8
	ld	r5, r3, 56
	st	r5, r2, 4
	ld	r5, r3, 24
	st	r5, r2, 0
	ld	r5, r3, 20
	slwi	r6, r5, 2
	ld	r7, r3, 16
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, 1
	ld	r6, r3, 12
	addi	r8, r6, 2
	ld	r9, r3, 8
	fld	fr2, r9, 4
	li	r10, 3
	fld	fr3, r0, 44
	st	r2, r3, 60
	st	r8, r3, 64
	fst	fr2, r3, 68
	mflr	r31
	mr	r2, r10
	fmr	fr1, fr3
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_float_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 48
	ld	r6, r2, 0
	st	r5, r3, 72
	mflr	r31
	mr	r2, r6
	st	r31, r3, 76
	addi	r3, r3, 80
	bl	min_caml_create_array
	addi	r3, r3, -80
	ld	r31, r3, 76
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 72
	st	r2, r5, 0
	fld	fr1, r3, 4
	fst	fr1, r2, 0
	fld	fr2, r3, 68
	fst	fr2, r2, 4
	fld	fr2, r3, 36
	fst	fr2, r2, 8
	ld	r2, r3, 48
	ld	r6, r2, 0
	addi	r6, r6, -1
	ld	r30, r3, 32
	st	r5, r3, 76
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 84
	addi	r3, r3, 88
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -88
	ld	r31, r3, 84
	mtlr	r31
	mr	r2, r4
	addi	r4, r4, 16
	fld	fr1, r3, 28
	fst	fr1, r2, 8
	ld	r5, r3, 76
	st	r5, r2, 4
	ld	r5, r3, 64
	st	r5, r2, 0
	ld	r5, r3, 60
	slwi	r5, r5, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	st	r2, r31, 0
	ld	r2, r3, 20
	addi	r5, r2, 2
	ld	r7, r3, 12
	addi	r7, r7, 3
	ld	r8, r3, 8
	fld	fr2, r8, 8
	li	r8, 3
	fld	fr3, r0, 44
	st	r5, r3, 80
	st	r7, r3, 84
	fst	fr2, r3, 88
	mflr	r31
	mr	r2, r8
	fmr	fr1, fr3
	st	r31, r3, 92
	addi	r3, r3, 96
	bl	min_caml_create_float_array
	addi	r3, r3, -96
	ld	r31, r3, 92
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 48
	ld	r6, r2, 0
	st	r5, r3, 92
	mflr	r31
	mr	r2, r6
	st	r31, r3, 100
	addi	r3, r3, 104
	bl	min_caml_create_array
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 92
	st	r2, r5, 0
	fld	fr1, r3, 4
	fst	fr1, r2, 0
	fld	fr1, r3, 40
	fst	fr1, r2, 4
	fld	fr1, r3, 88
	fst	fr1, r2, 8
	ld	r2, r3, 48
	ld	r2, r2, 0
	addi	r2, r2, -1
	ld	r30, r3, 32
	st	r5, r3, 96
	mflr	r31
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	st	r31, r3, 100
	addi	r3, r3, 104
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -104
	ld	r31, r3, 100
	mtlr	r31
	mr	r2, r4
	addi	r4, r4, 16
	fld	fr1, r3, 28
	fst	fr1, r2, 8
	ld	r5, r3, 96
	st	r5, r2, 4
	ld	r5, r3, 84
	st	r5, r2, 0
	ld	r5, r3, 80
	slwi	r5, r5, 2
	ld	r6, r3, 16
	add	r31, r6, r5
	st	r2, r31, 0
	ld	r2, r3, 20
	addi	r2, r2, 3
	ld	r5, r3, 0
	st	r2, r5, 0
	blr
beq_else.33339:
	cmpwi	cr0, r11, 2
	bne	beq_else.33341
	slwi	r2, r2, 2
	addi	r2, r2, 1
	ld	r11, r7, 0
	fld	fr1, r0, 16
	ld	r12, r6, 28
	fld	fr2, r12, 0
	fsub	fr1, fr1, fr2
	ld	r12, r6, 16
	fld	fr2, r9, 0
	fld	fr3, r12, 0
	fmul	fr2, fr2, fr3
	fld	fr3, r9, 4
	fld	fr4, r12, 4
	fmul	fr3, fr3, fr4
	fadd	fr2, fr2, fr3
	fld	fr3, r9, 8
	fld	fr4, r12, 8
	fmul	fr3, fr3, fr4
	fadd	fr2, fr2, fr3
	fld	fr3, r0, 48
	ld	r12, r6, 16
	fld	fr4, r12, 0
	fmul	fr3, fr3, fr4
	fmul	fr3, fr3, fr2
	fld	fr4, r9, 0
	fsub	fr3, fr3, fr4
	fld	fr4, r0, 48
	ld	r12, r6, 16
	fld	fr5, r12, 4
	fmul	fr4, fr4, fr5
	fmul	fr4, fr4, fr2
	fld	fr5, r9, 4
	fsub	fr4, fr4, fr5
	fld	fr5, r0, 48
	ld	r6, r6, 16
	fld	fr6, r6, 8
	fmul	fr5, fr5, fr6
	fmul	fr2, fr5, fr2
	fld	fr5, r9, 8
	fsub	fr2, fr2, fr5
	li	r6, 3
	fld	fr5, r0, 44
	st	r7, r3, 0
	st	r5, r3, 16
	st	r11, r3, 100
	st	r2, r3, 104
	fst	fr1, r3, 108
	st	r10, r3, 32
	fst	fr2, r3, 112
	fst	fr4, r3, 116
	fst	fr3, r3, 120
	st	r8, r3, 48
	mflr	r31
	mr	r2, r6
	fmr	fr1, fr5
	st	r31, r3, 124
	addi	r3, r3, 128
	bl	min_caml_create_float_array
	addi	r3, r3, -128
	ld	r31, r3, 124
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 48
	ld	r6, r2, 0
	st	r5, r3, 124
	mflr	r31
	mr	r2, r6
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
	fld	fr1, r3, 120
	fst	fr1, r2, 0
	fld	fr1, r3, 116
	fst	fr1, r2, 4
	fld	fr1, r3, 112
	fst	fr1, r2, 8
	ld	r2, r3, 48
	ld	r2, r2, 0
	addi	r2, r2, -1
	ld	r30, r3, 32
	st	r5, r3, 128
	mflr	r31
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	st	r31, r3, 132
	addi	r3, r3, 136
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -136
	ld	r31, r3, 132
	mtlr	r31
	mr	r2, r4
	addi	r4, r4, 16
	fld	fr1, r3, 108
	fst	fr1, r2, 8
	ld	r5, r3, 128
	st	r5, r2, 4
	ld	r5, r3, 104
	st	r5, r2, 0
	ld	r5, r3, 100
	slwi	r6, r5, 2
	ld	r7, r3, 16
	add	r31, r7, r6
	st	r2, r31, 0
	addi	r2, r5, 1
	ld	r5, r3, 0
	st	r2, r5, 0
	blr
beq_else.33341:
	blr
beq_else.33334:
	blr
bge_else.33333:
	blr
_min_caml_start:
	li	r3, 7
	slwi	r3, r3, 16
	addi	r3, r3, 1248
	li	r4, 0
#	float data
	li	r31, 17152
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 188
	li	r31, 16230
	slwi	r31, r31, 16
	addi	r31, r31, 26214
	st	r31, r4, 184
	li	r31, 17174
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 180
	li	r31, 49942
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 176
	li	r31, 15821
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r4, 172
	li	r31, 49152
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 168
	li	r31, 15232
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 164
	li	r31, 19647
	slwi	r31, r31, 16
	addi	r31, r31, 48160
	st	r31, r4, 160
	li	r31, 20078
	slwi	r31, r31, 16
	addi	r31, r31, 27432
	st	r31, r4, 156
	li	r31, 16800
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 152
	li	r31, 15693
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r4, 148
	li	r31, 16000
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 144
	li	r31, 16672
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 140
	li	r31, 16026
	slwi	r31, r31, 16
	addi	r31, r31, 39322
	st	r31, r4, 136
	li	r31, 17279
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 132
	li	r31, 15898
	slwi	r31, r31, 16
	addi	r31, r31, 39322
	st	r31, r4, 128
	li	r31, 16457
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r4, 124
	li	r31, 16880
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 120
	li	r31, 16752
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 116
	li	r31, 14546
	slwi	r31, r31, 16
	addi	r31, r31, 46871
	st	r31, r4, 112
	li	r31, 48589
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r4, 108
	li	r31, 15396
	slwi	r31, r31, 16
	addi	r31, r31, 55050
	st	r31, r4, 104
	li	r31, 48717
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r4, 100
	li	r31, 49024
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 96
	li	r31, 49992
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 92
	li	r31, 17224
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 88
	li	r31, 15503
	slwi	r31, r31, 16
	addi	r31, r31, 64053
	st	r31, r4, 84
	li	r31, 16412
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 80
	li	r31, 16096
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 76
	li	r31, 15734
	slwi	r31, r31, 16
	addi	r31, r31, 59333
	st	r31, r4, 72
	li	r31, 15800
	slwi	r31, r31, 16
	addi	r31, r31, 54894
	st	r31, r4, 68
	li	r31, 15844
	slwi	r31, r31, 16
	addi	r31, r31, 36408
	st	r31, r4, 64
	li	r31, 15890
	slwi	r31, r31, 16
	addi	r31, r31, 18725
	st	r31, r4, 60
	li	r31, 15949
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r4, 56
	li	r31, 16043
	slwi	r31, r31, 16
	addi	r31, r31, 43690
	st	r31, r4, 52
	li	r31, 16384
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 48
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 44
	li	r31, 16201
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r4, 40
	li	r31, 16329
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r4, 36
	li	r31, 16585
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r4, 32
	li	r31, 16457
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r4, 28
	li	r31, 15028
	slwi	r31, r31, 16
	addi	r31, r31, 33030
	st	r31, r4, 24
	li	r31, 15659
	slwi	r31, r31, 16
	addi	r31, r31, 42889
	st	r31, r4, 20
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 16
	li	r31, 14669
	slwi	r31, r31, 16
	addi	r31, r31, 25782
	st	r31, r4, 12
	li	r31, 15369
	slwi	r31, r31, 16
	addi	r31, r31, 34406
	st	r31, r4, 8
	li	r31, 15915
	slwi	r31, r31, 16
	addi	r31, r31, 43692
	st	r31, r4, 4
	li	r31, 16128
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r4, 0
	addi	r4, r4, 192
#	end float data
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 132
	st	r2, r3, 16
	mflr	r31
	mr	r2, r5
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_create_float_array
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	li	r5, 1
	li	r6, -1
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
	li	r2, 50
	li	r5, 1
	li	r6, -1
	st	r2, r3, 24
	mflr	r31
	mr	r2, r5
	mr	r5, r6
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
	ld	r6, r2, 0
	st	r2, r3, 28
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 36
	addi	r3, r3, 40
	bl	min_caml_create_array
	addi	r3, r3, -40
	ld	r31, r3, 36
	mtlr	r31
	li	r2, 1
	li	r5, 1
	ld	r6, r3, 28
	ld	r7, r6, 0
	st	r2, r3, 32
	mflr	r31
	mr	r2, r5
	mr	r5, r7
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 156
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	fld	fr1, r0, 44
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
	ld	r6, r3, 124
	st	r6, r5, 0
	li	r7, 0
	fld	fr1, r0, 44
	st	r2, r3, 128
	st	r5, r3, 132
	mflr	r31
	mr	r2, r7
	st	r31, r3, 140
	addi	r3, r3, 144
	bl	min_caml_create_float_array
	addi	r3, r3, -144
	ld	r31, r3, 140
	mr	r5, r2
	mtlr	r31
	li	r2, 0
	st	r5, r3, 136
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
	ld	r2, r3, 136
	st	r2, r5, 0
	mr	r2, r5
	li	r5, 180
	li	r6, 0
	fld	fr1, r0, 44
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
	st	r2, r3, 140
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 148
	addi	r3, r3, 152
	bl	min_caml_create_array
	addi	r3, r3, -152
	ld	r31, r3, 148
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 24
	li	r6, lo16(read_screen_settings.2874)
	slwi	r6, r6, 16
	srwi	r6, r6, 31
	addi	r6, r6, ha16(read_screen_settings.2874)
	slwi	r6, r6, 16
	addi	r6, r6, lo16(read_screen_settings.2874)
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
	addi	r4, r4, 8
	li	r11, lo16(read_nth_object.2881)
	slwi	r11, r11, 16
	srwi	r11, r11, 31
	addi	r11, r11, ha16(read_nth_object.2881)
	slwi	r11, r11, 16
	addi	r11, r11, lo16(read_nth_object.2881)
	st	r11, r10, 0
	ld	r11, r3, 4
	st	r11, r10, 4
	mr	r12, r4
	addi	r4, r4, 16
	li	r13, lo16(read_object.2883)
	slwi	r13, r13, 16
	srwi	r13, r13, 31
	addi	r13, r13, ha16(read_object.2883)
	slwi	r13, r13, 16
	addi	r13, r13, lo16(read_object.2883)
	st	r13, r12, 0
	st	r10, r12, 8
	ld	r13, r3, 0
	st	r13, r12, 4
	mr	r14, r4
	addi	r4, r4, 8
	li	r15, lo16(read_and_network.2891)
	slwi	r15, r15, 16
	srwi	r15, r15, 31
	addi	r15, r15, ha16(read_and_network.2891)
	slwi	r15, r15, 16
	addi	r15, r15, lo16(read_and_network.2891)
	st	r15, r14, 0
	ld	r15, r3, 28
	st	r15, r14, 4
	mr	r16, r4
	addi	r4, r4, 40
	li	r17, lo16(read_parameter.2893)
	slwi	r17, r17, 16
	srwi	r17, r17, 31
	addi	r17, r17, ha16(read_parameter.2893)
	slwi	r17, r17, 16
	addi	r17, r17, lo16(read_parameter.2893)
	st	r17, r16, 0
	st	r5, r16, 36
	st	r12, r16, 32
	st	r10, r16, 28
	st	r14, r16, 24
	ld	r5, r3, 36
	st	r5, r16, 20
	st	r13, r16, 16
	ld	r10, r3, 16
	st	r10, r16, 12
	ld	r12, r3, 20
	st	r12, r16, 8
	st	r15, r16, 4
	mr	r14, r4
	addi	r4, r4, 8
	li	r17, lo16(solver_rect_surface.2895)
	slwi	r17, r17, 16
	srwi	r17, r17, 31
	addi	r17, r17, ha16(solver_rect_surface.2895)
	slwi	r17, r17, 16
	addi	r17, r17, lo16(solver_rect_surface.2895)
	st	r17, r14, 0
	ld	r17, r3, 40
	st	r17, r14, 4
	mr	r18, r4
	addi	r4, r4, 8
	li	r19, lo16(solver_rect.2904)
	slwi	r19, r19, 16
	srwi	r19, r19, 31
	addi	r19, r19, ha16(solver_rect.2904)
	slwi	r19, r19, 16
	addi	r19, r19, lo16(solver_rect.2904)
	st	r19, r18, 0
	st	r17, r18, 4
	mr	r19, r4
	addi	r4, r4, 8
	li	r20, lo16(solver_second.2929)
	slwi	r20, r20, 16
	srwi	r20, r20, 31
	addi	r20, r20, ha16(solver_second.2929)
	slwi	r20, r20, 16
	addi	r20, r20, lo16(solver_second.2929)
	st	r20, r19, 0
	st	r17, r19, 4
	mr	r20, r4
	addi	r4, r4, 16
	li	r21, lo16(solver.2935)
	slwi	r21, r21, 16
	srwi	r21, r21, 31
	addi	r21, r21, ha16(solver.2935)
	slwi	r21, r21, 16
	addi	r21, r21, lo16(solver.2935)
	st	r21, r20, 0
	st	r14, r20, 12
	st	r17, r20, 8
	st	r11, r20, 4
	mr	r14, r4
	addi	r4, r4, 8
	li	r21, lo16(solver_rect_fast.2939)
	slwi	r21, r21, 16
	srwi	r21, r21, 31
	addi	r21, r21, ha16(solver_rect_fast.2939)
	slwi	r21, r21, 16
	addi	r21, r21, lo16(solver_rect_fast.2939)
	st	r21, r14, 0
	st	r17, r14, 4
	mr	r21, r4
	addi	r4, r4, 8
	li	r22, lo16(solver_second_fast.2952)
	slwi	r22, r22, 16
	srwi	r22, r22, 31
	addi	r22, r22, ha16(solver_second_fast.2952)
	slwi	r22, r22, 16
	addi	r22, r22, lo16(solver_second_fast.2952)
	st	r22, r21, 0
	st	r17, r21, 4
	mr	r22, r4
	addi	r4, r4, 16
	li	r23, lo16(solver_fast.2958)
	slwi	r23, r23, 16
	srwi	r23, r23, 31
	addi	r23, r23, ha16(solver_fast.2958)
	slwi	r23, r23, 16
	addi	r23, r23, lo16(solver_fast.2958)
	st	r23, r22, 0
	st	r14, r22, 12
	st	r17, r22, 8
	st	r11, r22, 4
	mr	r23, r4
	addi	r4, r4, 16
	li	r24, lo16(solver_fast2.2976)
	slwi	r24, r24, 16
	srwi	r24, r24, 31
	addi	r24, r24, ha16(solver_fast2.2976)
	slwi	r24, r24, 16
	addi	r24, r24, lo16(solver_fast2.2976)
	st	r24, r23, 0
	st	r14, r23, 12
	st	r17, r23, 8
	st	r11, r23, 4
	mr	r24, r4
	addi	r4, r4, 8
	li	r25, lo16(iter_setup_dirvec_constants.2988)
	slwi	r25, r25, 16
	srwi	r25, r25, 31
	addi	r25, r25, ha16(iter_setup_dirvec_constants.2988)
	slwi	r25, r25, 16
	addi	r25, r25, lo16(iter_setup_dirvec_constants.2988)
	st	r25, r24, 0
	st	r11, r24, 4
	mr	r25, r4
	addi	r4, r4, 8
	li	r26, lo16(setup_startp_constants.2993)
	slwi	r26, r26, 16
	srwi	r26, r26, 31
	addi	r26, r26, ha16(setup_startp_constants.2993)
	slwi	r26, r26, 16
	addi	r26, r26, lo16(setup_startp_constants.2993)
	st	r26, r25, 0
	st	r11, r25, 4
	mr	r26, r4
	addi	r4, r4, 8
	li	r27, lo16(check_all_inside.3018)
	slwi	r27, r27, 16
	srwi	r27, r27, 31
	addi	r27, r27, ha16(check_all_inside.3018)
	slwi	r27, r27, 16
	addi	r27, r27, lo16(check_all_inside.3018)
	st	r27, r26, 0
	st	r11, r26, 4
	mr	r27, r4
	addi	r4, r4, 48
	li	r28, lo16(shadow_check_and_group.3024)
	slwi	r28, r28, 16
	srwi	r28, r28, 31
	addi	r28, r28, ha16(shadow_check_and_group.3024)
	slwi	r28, r28, 16
	addi	r28, r28, lo16(shadow_check_and_group.3024)
	st	r28, r27, 0
	ld	r28, r3, 124
	st	r28, r27, 44
	st	r21, r27, 40
	st	r14, r27, 36
	st	r22, r27, 32
	st	r17, r27, 28
	st	r11, r27, 24
	ld	r29, r3, 132
	st	r29, r27, 20
	st	r10, r27, 16
	ld	r30, r3, 52
	st	r30, r27, 12
	st	r16, r3, 144
	ld	r16, r3, 128
	st	r16, r27, 8
	st	r26, r27, 4
	st	r24, r3, 148
	mr	r24, r4
	addi	r4, r4, 40
	li	r8, lo16(shadow_check_one_or_group.3027)
	slwi	r8, r8, 16
	srwi	r8, r8, 31
	addi	r8, r8, ha16(shadow_check_one_or_group.3027)
	slwi	r8, r8, 16
	addi	r8, r8, lo16(shadow_check_one_or_group.3027)
	st	r8, r24, 0
	st	r22, r24, 36
	st	r17, r24, 32
	st	r27, r24, 28
	st	r11, r24, 24
	st	r29, r24, 20
	st	r10, r24, 16
	st	r30, r24, 12
	st	r26, r24, 8
	st	r15, r24, 4
	mr	r8, r4
	addi	r4, r4, 56
	li	r7, lo16(shadow_check_one_or_matrix.3030)
	slwi	r7, r7, 16
	srwi	r7, r7, 31
	addi	r7, r7, ha16(shadow_check_one_or_matrix.3030)
	slwi	r7, r7, 16
	addi	r7, r7, lo16(shadow_check_one_or_matrix.3030)
	st	r7, r8, 0
	st	r28, r8, 48
	st	r21, r8, 44
	st	r14, r8, 40
	st	r22, r8, 36
	st	r17, r8, 32
	st	r24, r8, 28
	st	r27, r8, 24
	st	r11, r8, 20
	st	r29, r8, 16
	st	r30, r8, 12
	st	r16, r8, 8
	st	r15, r8, 4
	mr	r7, r4
	addi	r4, r4, 48
	li	r21, lo16(solve_each_element.3033)
	slwi	r21, r21, 16
	srwi	r21, r21, 31
	addi	r21, r21, ha16(solve_each_element.3033)
	slwi	r21, r21, 16
	addi	r21, r21, lo16(solve_each_element.3033)
	st	r21, r7, 0
	ld	r21, r3, 48
	st	r21, r7, 40
	ld	r27, r3, 88
	st	r27, r7, 36
	st	r19, r7, 32
	st	r18, r7, 28
	st	r17, r7, 24
	st	r11, r7, 20
	ld	r16, r3, 44
	st	r16, r7, 16
	st	r30, r7, 12
	ld	r28, r3, 56
	st	r28, r7, 8
	st	r26, r7, 4
	mr	r9, r4
	addi	r4, r4, 16
	li	r6, lo16(solve_one_or_network.3037)
	slwi	r6, r6, 16
	srwi	r6, r6, 31
	addi	r6, r6, ha16(solve_one_or_network.3037)
	slwi	r6, r6, 16
	addi	r6, r6, lo16(solve_one_or_network.3037)
	st	r6, r9, 0
	st	r7, r9, 8
	st	r15, r9, 4
	mr	r6, r4
	addi	r4, r4, 48
	li	r12, lo16(trace_or_matrix.3041)
	slwi	r12, r12, 16
	srwi	r12, r12, 31
	addi	r12, r12, ha16(trace_or_matrix.3041)
	slwi	r12, r12, 16
	addi	r12, r12, lo16(trace_or_matrix.3041)
	st	r12, r6, 0
	st	r21, r6, 40
	st	r27, r6, 36
	st	r19, r6, 32
	st	r18, r6, 28
	st	r17, r6, 24
	st	r20, r6, 20
	st	r9, r6, 16
	st	r7, r6, 12
	st	r11, r6, 8
	st	r15, r6, 4
	mr	r7, r4
	addi	r4, r4, 40
	li	r9, lo16(solve_each_element_fast.3047)
	slwi	r9, r9, 16
	srwi	r9, r9, 31
	addi	r9, r9, ha16(solve_each_element_fast.3047)
	slwi	r9, r9, 16
	addi	r9, r9, lo16(solve_each_element_fast.3047)
	st	r9, r7, 0
	st	r21, r7, 36
	ld	r9, r3, 92
	st	r9, r7, 32
	st	r14, r7, 28
	st	r17, r7, 24
	st	r11, r7, 20
	st	r16, r7, 16
	st	r30, r7, 12
	st	r28, r7, 8
	st	r26, r7, 4
	mr	r12, r4
	addi	r4, r4, 16
	li	r18, lo16(solve_one_or_network_fast.3051)
	slwi	r18, r18, 16
	srwi	r18, r18, 31
	addi	r18, r18, ha16(solve_one_or_network_fast.3051)
	slwi	r18, r18, 16
	addi	r18, r18, lo16(solve_one_or_network_fast.3051)
	st	r18, r12, 0
	st	r7, r12, 8
	st	r15, r12, 4
	mr	r18, r4
	addi	r4, r4, 40
	li	r19, lo16(trace_or_matrix_fast.3055)
	slwi	r19, r19, 16
	srwi	r19, r19, 31
	addi	r19, r19, ha16(trace_or_matrix_fast.3055)
	slwi	r19, r19, 16
	addi	r19, r19, lo16(trace_or_matrix_fast.3055)
	st	r19, r18, 0
	st	r21, r18, 32
	st	r14, r18, 28
	st	r23, r18, 24
	st	r17, r18, 20
	st	r12, r18, 16
	st	r7, r18, 12
	st	r11, r18, 8
	st	r15, r18, 4
	mr	r14, r4
	addi	r4, r4, 16
	li	r19, lo16(get_nvector_second.3065)
	slwi	r19, r19, 16
	srwi	r19, r19, 31
	addi	r19, r19, ha16(get_nvector_second.3065)
	slwi	r19, r19, 16
	addi	r19, r19, lo16(get_nvector_second.3065)
	st	r19, r14, 0
	ld	r19, r3, 60
	st	r19, r14, 8
	st	r30, r14, 4
	mr	r20, r4
	addi	r4, r4, 8
	li	r26, lo16(utexture.3070)
	slwi	r26, r26, 16
	srwi	r26, r26, 31
	addi	r26, r26, ha16(utexture.3070)
	slwi	r26, r26, 16
	addi	r26, r26, lo16(utexture.3070)
	st	r26, r20, 0
	ld	r26, r3, 64
	st	r26, r20, 4
	st	r14, r3, 152
	mr	r14, r4
	addi	r4, r4, 16
	li	r10, lo16(add_light.3073)
	slwi	r10, r10, 16
	srwi	r10, r10, 31
	addi	r10, r10, ha16(add_light.3073)
	slwi	r10, r10, 16
	addi	r10, r10, lo16(add_light.3073)
	st	r10, r14, 0
	st	r26, r14, 8
	ld	r10, r3, 72
	st	r10, r14, 4
	mr	r13, r4
	addi	r4, r4, 88
	st	r2, r3, 156
	li	r2, lo16(trace_reflections.3077)
	slwi	r2, r2, 16
	srwi	r2, r2, 31
	addi	r2, r2, ha16(trace_reflections.3077)
	slwi	r2, r2, 16
	addi	r2, r2, lo16(trace_reflections.3077)
	st	r2, r13, 0
	st	r18, r13, 80
	st	r21, r13, 76
	st	r26, r13, 72
	st	r23, r13, 68
	st	r22, r13, 64
	st	r17, r13, 60
	st	r12, r13, 56
	st	r7, r13, 52
	st	r8, r13, 48
	st	r24, r13, 44
	st	r10, r13, 40
	ld	r2, r3, 140
	st	r2, r13, 36
	st	r5, r13, 32
	st	r19, r13, 28
	st	r29, r13, 24
	st	r16, r13, 20
	st	r30, r13, 16
	st	r28, r13, 12
	st	r15, r13, 8
	st	r14, r13, 4
	st	r14, r3, 160
	mr	r14, r4
	addi	r4, r4, 136
	li	r15, lo16(trace_ray.3082)
	slwi	r15, r15, 16
	srwi	r15, r15, 31
	addi	r15, r15, ha16(trace_ray.3082)
	slwi	r15, r15, 16
	addi	r15, r15, lo16(trace_ray.3082)
	st	r15, r14, 0
	st	r20, r14, 128
	st	r13, r14, 124
	st	r18, r14, 120
	st	r6, r14, 116
	st	r21, r14, 112
	st	r26, r14, 108
	st	r9, r14, 104
	st	r27, r14, 100
	st	r23, r14, 96
	st	r22, r14, 92
	st	r17, r14, 88
	st	r12, r14, 84
	st	r7, r14, 80
	st	r8, r14, 76
	st	r24, r14, 72
	st	r25, r14, 68
	st	r10, r14, 64
	st	r2, r14, 60
	st	r5, r14, 56
	st	r11, r14, 52
	st	r19, r14, 48
	ld	r6, r3, 156
	st	r6, r14, 44
	ld	r13, r3, 0
	st	r13, r14, 40
	st	r29, r14, 36
	ld	r15, r3, 16
	st	r15, r14, 32
	st	r16, r14, 28
	st	r30, r14, 24
	st	r28, r14, 20
	ld	r6, r3, 152
	st	r6, r14, 16
	ld	r2, r3, 20
	st	r2, r14, 12
	ld	r2, r3, 28
	st	r2, r14, 8
	ld	r27, r3, 160
	st	r27, r14, 4
	mr	r27, r4
	addi	r4, r4, 80
	st	r14, r3, 164
	li	r14, lo16(trace_diffuse_ray.3088)
	slwi	r14, r14, 16
	srwi	r14, r14, 31
	addi	r14, r14, ha16(trace_diffuse_ray.3088)
	slwi	r14, r14, 16
	addi	r14, r14, lo16(trace_diffuse_ray.3088)
	st	r14, r27, 0
	st	r20, r27, 72
	st	r18, r27, 68
	st	r21, r27, 64
	st	r26, r27, 60
	st	r22, r27, 56
	st	r17, r27, 52
	st	r8, r27, 48
	st	r24, r27, 44
	st	r5, r27, 40
	st	r11, r27, 36
	st	r19, r27, 32
	st	r29, r27, 28
	st	r15, r27, 24
	st	r16, r27, 20
	st	r30, r27, 16
	st	r28, r27, 12
	st	r6, r27, 8
	ld	r14, r3, 68
	st	r14, r27, 4
	mr	r22, r4
	addi	r4, r4, 88
	li	r24, lo16(iter_trace_diffuse_rays.3091)
	slwi	r24, r24, 16
	srwi	r24, r24, 31
	addi	r24, r24, ha16(iter_trace_diffuse_rays.3091)
	slwi	r24, r24, 16
	addi	r24, r24, lo16(iter_trace_diffuse_rays.3091)
	st	r24, r22, 0
	st	r20, r22, 80
	st	r18, r22, 76
	st	r27, r22, 72
	st	r21, r22, 68
	st	r26, r22, 64
	st	r23, r22, 60
	st	r17, r22, 56
	st	r12, r22, 52
	st	r7, r22, 48
	st	r8, r22, 44
	st	r5, r22, 40
	st	r11, r22, 36
	st	r19, r22, 32
	st	r15, r22, 28
	st	r16, r22, 24
	st	r30, r22, 20
	st	r28, r22, 16
	st	r6, r22, 12
	st	r14, r22, 8
	st	r2, r22, 4
	mr	r2, r4
	addi	r4, r4, 24
	li	r5, lo16(trace_diffuse_ray_80percent.3100)
	slwi	r5, r5, 16
	srwi	r5, r5, 31
	addi	r5, r5, ha16(trace_diffuse_ray_80percent.3100)
	slwi	r5, r5, 16
	addi	r5, r5, lo16(trace_diffuse_ray_80percent.3100)
	st	r5, r2, 0
	st	r9, r2, 20
	st	r25, r2, 16
	st	r13, r2, 12
	st	r22, r2, 8
	ld	r5, r3, 116
	st	r5, r2, 4
	mr	r6, r4
	addi	r4, r4, 40
	li	r7, lo16(calc_diffuse_using_1point.3104)
	slwi	r7, r7, 16
	srwi	r7, r7, 31
	addi	r7, r7, ha16(calc_diffuse_using_1point.3104)
	slwi	r7, r7, 16
	addi	r7, r7, lo16(calc_diffuse_using_1point.3104)
	st	r7, r6, 0
	st	r27, r6, 32
	st	r9, r6, 28
	st	r25, r6, 24
	st	r10, r6, 20
	st	r13, r6, 16
	st	r22, r6, 12
	st	r5, r6, 8
	st	r14, r6, 4
	mr	r7, r4
	addi	r4, r4, 16
	li	r8, lo16(calc_diffuse_using_5points.3107)
	slwi	r8, r8, 16
	srwi	r8, r8, 31
	addi	r8, r8, ha16(calc_diffuse_using_5points.3107)
	slwi	r8, r8, 16
	addi	r8, r8, lo16(calc_diffuse_using_5points.3107)
	st	r8, r7, 0
	st	r10, r7, 8
	st	r14, r7, 4
	mr	r8, r4
	addi	r4, r4, 40
	li	r12, lo16(do_without_neighbors.3113)
	slwi	r12, r12, 16
	srwi	r12, r12, 31
	addi	r12, r12, ha16(do_without_neighbors.3113)
	slwi	r12, r12, 16
	addi	r12, r12, lo16(do_without_neighbors.3113)
	st	r12, r8, 0
	st	r2, r8, 36
	st	r9, r8, 32
	st	r25, r8, 28
	st	r10, r8, 24
	st	r13, r8, 20
	st	r22, r8, 16
	st	r5, r8, 12
	st	r14, r8, 8
	st	r6, r8, 4
	mr	r12, r4
	addi	r4, r4, 32
	li	r16, lo16(try_exploit_neighbors.3129)
	slwi	r16, r16, 16
	srwi	r16, r16, 31
	addi	r16, r16, ha16(try_exploit_neighbors.3129)
	slwi	r16, r16, 16
	addi	r16, r16, lo16(try_exploit_neighbors.3129)
	st	r16, r12, 0
	st	r2, r12, 24
	st	r10, r12, 20
	st	r8, r12, 16
	st	r14, r12, 12
	st	r7, r12, 8
	st	r6, r12, 4
	mr	r16, r4
	addi	r4, r4, 32
	li	r17, lo16(pretrace_diffuse_rays.3142)
	slwi	r17, r17, 16
	srwi	r17, r17, 31
	addi	r17, r17, ha16(pretrace_diffuse_rays.3142)
	slwi	r17, r17, 16
	addi	r17, r17, lo16(pretrace_diffuse_rays.3142)
	st	r17, r16, 0
	st	r27, r16, 28
	st	r9, r16, 24
	st	r25, r16, 20
	st	r13, r16, 16
	st	r22, r16, 12
	st	r5, r16, 8
	st	r14, r16, 4
	mr	r17, r4
	addi	r4, r4, 72
	li	r18, lo16(pretrace_pixels.3145)
	slwi	r18, r18, 16
	srwi	r18, r18, 31
	addi	r18, r18, ha16(pretrace_pixels.3145)
	slwi	r18, r18, 16
	addi	r18, r18, lo16(pretrace_pixels.3145)
	st	r18, r17, 0
	ld	r18, r3, 12
	st	r18, r17, 64
	ld	r19, r3, 164
	st	r19, r17, 60
	st	r27, r17, 56
	st	r9, r17, 52
	ld	r9, r3, 88
	st	r9, r17, 48
	st	r25, r17, 44
	ld	r20, r3, 96
	st	r20, r17, 40
	ld	r21, r3, 84
	st	r21, r17, 36
	st	r10, r17, 32
	ld	r23, r3, 108
	st	r23, r17, 28
	st	r16, r17, 24
	st	r13, r17, 20
	st	r22, r17, 16
	ld	r22, r3, 80
	st	r22, r17, 12
	st	r5, r17, 8
	st	r14, r17, 4
	mr	r24, r4
	addi	r4, r4, 56
	li	r25, lo16(pretrace_line.3152)
	slwi	r25, r25, 16
	srwi	r25, r25, 31
	addi	r25, r25, ha16(pretrace_line.3152)
	slwi	r25, r25, 16
	addi	r25, r25, lo16(pretrace_line.3152)
	st	r25, r24, 0
	st	r18, r24, 52
	st	r19, r24, 48
	st	r9, r24, 44
	ld	r9, r3, 104
	st	r9, r24, 40
	ld	r18, r3, 100
	st	r18, r24, 36
	st	r20, r24, 32
	st	r21, r24, 28
	st	r10, r24, 24
	st	r23, r24, 20
	st	r17, r24, 16
	st	r16, r24, 12
	ld	r16, r3, 76
	st	r16, r24, 8
	st	r22, r24, 4
	mr	r19, r4
	addi	r4, r4, 40
	li	r20, lo16(scan_pixel.3156)
	slwi	r20, r20, 16
	srwi	r20, r20, 31
	addi	r20, r20, ha16(scan_pixel.3156)
	slwi	r20, r20, 16
	addi	r20, r20, lo16(scan_pixel.3156)
	st	r20, r19, 0
	st	r12, r19, 32
	st	r2, r19, 28
	st	r10, r19, 24
	st	r16, r19, 20
	st	r8, r19, 16
	st	r14, r19, 12
	st	r7, r19, 8
	st	r6, r19, 4
	mr	r7, r4
	addi	r4, r4, 64
	li	r20, lo16(scan_line.3162)
	slwi	r20, r20, 16
	srwi	r20, r20, 31
	addi	r20, r20, ha16(scan_line.3162)
	slwi	r20, r20, 16
	addi	r20, r20, lo16(scan_line.3162)
	st	r20, r7, 0
	st	r12, r7, 56
	st	r2, r7, 52
	st	r9, r7, 48
	st	r18, r7, 44
	st	r19, r7, 40
	st	r21, r7, 36
	st	r10, r7, 32
	st	r17, r7, 28
	st	r24, r7, 24
	st	r16, r7, 20
	st	r22, r7, 16
	st	r8, r7, 12
	st	r14, r7, 8
	st	r6, r7, 4
	mr	r2, r4
	addi	r4, r4, 8
	li	r6, lo16(create_pixelline.3175)
	slwi	r6, r6, 16
	srwi	r6, r6, 31
	addi	r6, r6, ha16(create_pixelline.3175)
	slwi	r6, r6, 16
	addi	r6, r6, lo16(create_pixelline.3175)
	st	r6, r2, 0
	st	r16, r2, 4
	mr	r6, r4
	addi	r4, r4, 8
	li	r8, lo16(calc_dirvec.3182)
	slwi	r8, r8, 16
	srwi	r8, r8, 31
	addi	r8, r8, ha16(calc_dirvec.3182)
	slwi	r8, r8, 16
	addi	r8, r8, lo16(calc_dirvec.3182)
	st	r8, r6, 0
	st	r5, r6, 4
	mr	r8, r4
	addi	r4, r4, 8
	li	r9, lo16(calc_dirvecs.3190)
	slwi	r9, r9, 16
	srwi	r9, r9, 31
	addi	r9, r9, ha16(calc_dirvecs.3190)
	slwi	r9, r9, 16
	addi	r9, r9, lo16(calc_dirvecs.3190)
	st	r9, r8, 0
	st	r6, r8, 4
	mr	r9, r4
	addi	r4, r4, 16
	li	r10, lo16(calc_dirvec_rows.3195)
	slwi	r10, r10, 16
	srwi	r10, r10, 31
	addi	r10, r10, ha16(calc_dirvec_rows.3195)
	slwi	r10, r10, 16
	addi	r10, r10, lo16(calc_dirvec_rows.3195)
	st	r10, r9, 0
	st	r8, r9, 8
	st	r6, r9, 4
	mr	r6, r4
	addi	r4, r4, 8
	li	r10, lo16(create_dirvec_elements.3201)
	slwi	r10, r10, 16
	srwi	r10, r10, 31
	addi	r10, r10, ha16(create_dirvec_elements.3201)
	slwi	r10, r10, 16
	addi	r10, r10, lo16(create_dirvec_elements.3201)
	st	r10, r6, 0
	st	r13, r6, 4
	mr	r10, r4
	addi	r4, r4, 16
	li	r12, lo16(create_dirvecs.3204)
	slwi	r12, r12, 16
	srwi	r12, r12, 31
	addi	r12, r12, ha16(create_dirvecs.3204)
	slwi	r12, r12, 16
	addi	r12, r12, lo16(create_dirvecs.3204)
	st	r12, r10, 0
	st	r13, r10, 12
	st	r5, r10, 8
	st	r6, r10, 4
	mr	r12, r4
	addi	r4, r4, 16
	li	r14, lo16(init_dirvec_constants.3206)
	slwi	r14, r14, 16
	srwi	r14, r14, 31
	addi	r14, r14, ha16(init_dirvec_constants.3206)
	slwi	r14, r14, 16
	addi	r14, r14, lo16(init_dirvec_constants.3206)
	st	r14, r12, 0
	st	r11, r12, 12
	st	r13, r12, 8
	ld	r14, r3, 148
	st	r14, r12, 4
	mr	r17, r4
	addi	r4, r4, 24
	li	r18, lo16(init_vecset_constants.3209)
	slwi	r18, r18, 16
	srwi	r18, r18, 31
	addi	r18, r18, ha16(init_vecset_constants.3209)
	slwi	r18, r18, 16
	addi	r18, r18, lo16(init_vecset_constants.3209)
	st	r18, r17, 0
	st	r11, r17, 20
	st	r13, r17, 16
	st	r14, r17, 12
	st	r12, r17, 8
	st	r5, r17, 4
	mr	r18, r4
	addi	r4, r4, 32
	li	r19, lo16(setup_reflections.3226)
	slwi	r19, r19, 16
	srwi	r19, r19, 31
	addi	r19, r19, ha16(setup_reflections.3226)
	slwi	r19, r19, 16
	addi	r19, r19, lo16(setup_reflections.3226)
	st	r19, r18, 0
	ld	r19, r3, 140
	st	r19, r18, 24
	st	r11, r18, 20
	ld	r19, r3, 156
	st	r19, r18, 16
	st	r13, r18, 12
	st	r15, r18, 8
	st	r14, r18, 4
	li	r19, 128
	li	r20, 128
	st	r19, r16, 0
	st	r20, r16, 4
	li	r20, 64
	st	r20, r22, 0
	li	r20, 64
	st	r20, r22, 4
	fld	fr1, r0, 188
	st	r7, r3, 168
	st	r24, r3, 172
	st	r18, r3, 176
	st	r17, r3, 180
	st	r12, r3, 184
	st	r9, r3, 188
	st	r8, r3, 192
	st	r10, r3, 196
	st	r6, r3, 200
	st	r2, r3, 204
	fst	fr1, r3, 208
	mflr	r31
	mr	r2, r19
	st	r31, r3, 212
	addi	r3, r3, 216
	bl	min_caml_float_of_int
	addi	r3, r3, -216
	ld	r31, r3, 212
	mtlr	r31
	fld	fr2, r3, 208
	fdiv	fr1, fr2, fr1
	ld	r2, r3, 84
	fst	fr1, r2, 0
	ld	r30, r3, 204
	mflr	r31
	st	r31, r3, 212
	addi	r3, r3, 216
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -216
	ld	r31, r3, 212
	mtlr	r31
	ld	r30, r3, 204
	st	r2, r3, 212
	mflr	r31
	st	r31, r3, 220
	addi	r3, r3, 224
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -224
	ld	r31, r3, 220
	mtlr	r31
	ld	r30, r3, 204
	st	r2, r3, 216
	mflr	r31
	st	r31, r3, 220
	addi	r3, r3, 224
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -224
	ld	r31, r3, 220
	mtlr	r31
	ld	r30, r3, 144
	st	r2, r3, 220
	mflr	r31
	st	r31, r3, 228
	addi	r3, r3, 232
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -232
	ld	r31, r3, 228
	mtlr	r31
	li	r2, 80
	mflr	r31
	st	r31, r3, 228
	addi	r3, r3, 232
	bl	min_caml_print_char
	addi	r3, r3, -232
	ld	r31, r3, 228
	mtlr	r31
	li	r2, 51
	mflr	r31
	st	r31, r3, 228
	addi	r3, r3, 232
	bl	min_caml_print_char
	addi	r3, r3, -232
	ld	r31, r3, 228
	mtlr	r31
	li	r2, 10
	mflr	r31
	st	r31, r3, 228
	addi	r3, r3, 232
	bl	min_caml_print_char
	addi	r3, r3, -232
	ld	r31, r3, 228
	mtlr	r31
	ld	r2, r3, 76
	ld	r5, r2, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 228
	addi	r3, r3, 232
	bl	min_caml_print_int
	addi	r3, r3, -232
	ld	r31, r3, 228
	mtlr	r31
	li	r2, 32
	mflr	r31
	st	r31, r3, 228
	addi	r3, r3, 232
	bl	min_caml_print_char
	addi	r3, r3, -232
	ld	r31, r3, 228
	mtlr	r31
	ld	r2, r3, 76
	ld	r2, r2, 4
	mflr	r31
	st	r31, r3, 228
	addi	r3, r3, 232
	bl	min_caml_print_int
	addi	r3, r3, -232
	ld	r31, r3, 228
	mtlr	r31
	li	r2, 32
	mflr	r31
	st	r31, r3, 228
	addi	r3, r3, 232
	bl	min_caml_print_char
	addi	r3, r3, -232
	ld	r31, r3, 228
	mtlr	r31
	li	r2, 255
	mflr	r31
	st	r31, r3, 228
	addi	r3, r3, 232
	bl	min_caml_print_int
	addi	r3, r3, -232
	ld	r31, r3, 228
	mtlr	r31
	li	r2, 10
	mflr	r31
	st	r31, r3, 228
	addi	r3, r3, 232
	bl	min_caml_print_char
	addi	r3, r3, -232
	ld	r31, r3, 228
	mtlr	r31
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 228
	addi	r3, r3, 232
	bl	min_caml_create_float_array
	addi	r3, r3, -232
	ld	r31, r3, 228
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 0
	ld	r6, r2, 0
	mflr	r31
	mr	r2, r6
	st	r31, r3, 228
	addi	r3, r3, 232
	bl	min_caml_create_array
	addi	r3, r3, -232
	ld	r31, r3, 228
	mtlr	r31
	li	r2, 120
	li	r5, 3
	fld	fr1, r0, 44
	st	r2, r3, 224
	mflr	r31
	mr	r2, r5
	st	r31, r3, 228
	addi	r3, r3, 232
	bl	min_caml_create_float_array
	addi	r3, r3, -232
	ld	r31, r3, 228
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 0
	ld	r6, r2, 0
	st	r5, r3, 228
	mflr	r31
	mr	r2, r6
	st	r31, r3, 236
	addi	r3, r3, 240
	bl	min_caml_create_array
	addi	r3, r3, -240
	ld	r31, r3, 236
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 228
	st	r2, r5, 0
	ld	r2, r3, 224
	mflr	r31
	st	r31, r3, 236
	addi	r3, r3, 240
	bl	min_caml_create_array
	addi	r3, r3, -240
	ld	r31, r3, 236
	mtlr	r31
	ld	r5, r3, 116
	st	r2, r5, 16
	ld	r2, r5, 16
	li	r6, 3
	fld	fr1, r0, 44
	st	r2, r3, 232
	mflr	r31
	mr	r2, r6
	st	r31, r3, 236
	addi	r3, r3, 240
	bl	min_caml_create_float_array
	addi	r3, r3, -240
	ld	r31, r3, 236
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 0
	ld	r6, r2, 0
	st	r5, r3, 236
	mflr	r31
	mr	r2, r6
	st	r31, r3, 244
	addi	r3, r3, 248
	bl	min_caml_create_array
	addi	r3, r3, -248
	ld	r31, r3, 244
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 236
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 232
	st	r2, r5, 472
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 244
	addi	r3, r3, 248
	bl	min_caml_create_float_array
	addi	r3, r3, -248
	ld	r31, r3, 244
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 0
	ld	r6, r2, 0
	st	r5, r3, 240
	mflr	r31
	mr	r2, r6
	st	r31, r3, 244
	addi	r3, r3, 248
	bl	min_caml_create_array
	addi	r3, r3, -248
	ld	r31, r3, 244
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 240
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 232
	st	r2, r5, 468
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 244
	addi	r3, r3, 248
	bl	min_caml_create_float_array
	addi	r3, r3, -248
	ld	r31, r3, 244
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 0
	ld	r6, r2, 0
	st	r5, r3, 244
	mflr	r31
	mr	r2, r6
	st	r31, r3, 252
	addi	r3, r3, 256
	bl	min_caml_create_array
	addi	r3, r3, -256
	ld	r31, r3, 252
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 244
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 232
	st	r2, r5, 464
	li	r2, 3
	fld	fr1, r0, 44
	mflr	r31
	st	r31, r3, 252
	addi	r3, r3, 256
	bl	min_caml_create_float_array
	addi	r3, r3, -256
	ld	r31, r3, 252
	mr	r5, r2
	mtlr	r31
	ld	r2, r3, 0
	ld	r6, r2, 0
	st	r5, r3, 248
	mflr	r31
	mr	r2, r6
	st	r31, r3, 252
	addi	r3, r3, 256
	bl	min_caml_create_array
	addi	r3, r3, -256
	ld	r31, r3, 252
	mtlr	r31
	mr	r5, r4
	addi	r4, r4, 8
	st	r2, r5, 4
	ld	r2, r3, 248
	st	r2, r5, 0
	mr	r2, r5
	ld	r5, r3, 232
	st	r2, r5, 460
	li	r2, 114
	ld	r30, r3, 200
	mflr	r31
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	st	r31, r3, 252
	addi	r3, r3, 256
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -256
	ld	r31, r3, 252
	mtlr	r31
	li	r2, 3
	ld	r30, r3, 196
	mflr	r31
	st	r31, r3, 252
	addi	r3, r3, 256
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -256
	ld	r31, r3, 252
	mtlr	r31
	li	r2, 9
	li	r5, 0
	li	r6, 0
	st	r6, r3, 252
	st	r5, r3, 256
	mflr	r31
	st	r31, r3, 260
	addi	r3, r3, 264
	bl	min_caml_float_of_int
	addi	r3, r3, -264
	ld	r31, r3, 260
	mtlr	r31
	fld	fr2, r0, 56
	fmul	fr1, fr1, fr2
	fld	fr2, r0, 184
	fsub	fr1, fr1, fr2
	li	r2, 4
	ld	r5, r3, 256
	ld	r6, r3, 252
	ld	r30, r3, 192
	mflr	r31
	st	r31, r3, 260
	addi	r3, r3, 264
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -264
	ld	r31, r3, 260
	mtlr	r31
	li	r2, 8
	li	r5, 2
	li	r6, 4
	ld	r30, r3, 188
	mflr	r31
	st	r31, r3, 260
	addi	r3, r3, 264
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -264
	ld	r31, r3, 260
	mtlr	r31
	ld	r2, r3, 116
	ld	r2, r2, 16
	li	r5, 119
	ld	r30, r3, 184
	mflr	r31
	st	r31, r3, 260
	addi	r3, r3, 264
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -264
	ld	r31, r3, 260
	mtlr	r31
	li	r2, 3
	ld	r30, r3, 180
	mflr	r31
	st	r31, r3, 260
	addi	r3, r3, 264
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -264
	ld	r31, r3, 260
	mtlr	r31
	ld	r2, r3, 16
	fld	fr1, r2, 0
	ld	r5, r3, 124
	fst	fr1, r5, 0
	fld	fr1, r2, 4
	fst	fr1, r5, 4
	fld	fr1, r2, 8
	fst	fr1, r5, 8
	ld	r2, r3, 0
	ld	r6, r2, 0
	addi	r6, r6, -1
	cmpwi	cr0, r6, 0
	blt	bge_else.33346
	slwi	r7, r6, 2
	ld	r8, r3, 4
	add	r31, r8, r7
	ld	r7, r31, 0
	ld	r8, r7, 4
	cmpwi	cr0, r8, 1
	bne	beq_else.33348
	st	r6, r3, 260
	mflr	r31
	mr	r2, r5
	mr	r5, r7
	st	r31, r3, 268
	addi	r3, r3, 272
	bl	setup_rect_table.2979
	addi	r3, r3, -272
	ld	r31, r3, 268
	mtlr	r31
	ld	r5, r3, 260
	slwi	r6, r5, 2
	ld	r7, r3, 128
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.33349
beq_else.33348:
	cmpwi	cr0, r8, 2
	bne	beq_else.33350
	st	r6, r3, 260
	mflr	r31
	mr	r2, r5
	mr	r5, r7
	st	r31, r3, 268
	addi	r3, r3, 272
	bl	setup_surface_table.2982
	addi	r3, r3, -272
	ld	r31, r3, 268
	mtlr	r31
	ld	r5, r3, 260
	slwi	r6, r5, 2
	ld	r7, r3, 128
	add	r31, r7, r6
	st	r2, r31, 0
	b	beq_cont.33351
beq_else.33350:
	st	r6, r3, 260
	mflr	r31
	mr	r2, r5
	mr	r5, r7
	st	r31, r3, 268
	addi	r3, r3, 272
	bl	setup_second_table.2985
	addi	r3, r3, -272
	ld	r31, r3, 268
	mtlr	r31
	ld	r5, r3, 260
	slwi	r6, r5, 2
	ld	r7, r3, 128
	add	r31, r7, r6
	st	r2, r31, 0
beq_cont.33351:
beq_cont.33349:
	addi	r5, r5, -1
	ld	r2, r3, 132
	ld	r30, r3, 148
	mflr	r31
	st	r31, r3, 268
	addi	r3, r3, 272
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -272
	ld	r31, r3, 268
	mtlr	r31
	b	bge_cont.33347
bge_else.33346:
bge_cont.33347:
	ld	r2, r3, 0
	ld	r2, r2, 0
	addi	r2, r2, -1
	ld	r30, r3, 176
	mflr	r31
	st	r31, r3, 268
	addi	r3, r3, 272
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -272
	ld	r31, r3, 268
	mtlr	r31
	li	r5, 0
	li	r6, 0
	ld	r2, r3, 216
	ld	r30, r3, 172
	mflr	r31
	st	r31, r3, 268
	addi	r3, r3, 272
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -272
	ld	r31, r3, 268
	mtlr	r31
	li	r2, 0
	li	r8, 2
	ld	r5, r3, 212
	ld	r6, r3, 216
	ld	r7, r3, 220
	ld	r30, r3, 168
	mflr	r31
	st	r31, r3, 268
	addi	r3, r3, 272
	ld	r31, r30, 0
	bal	r31
	addi	r3, r3, -272
	ld	r31, r3, 268
	mtlr	r31
#	main program ends
