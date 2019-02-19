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
