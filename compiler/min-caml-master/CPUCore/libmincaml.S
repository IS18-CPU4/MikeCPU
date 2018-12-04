min_caml_print_newline:
  li r2, 10
  out r2
  blr
#min_caml_print_int:
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
min_caml_print_byte:
  out r2
  blr
#min_caml_prerr_int:
min_caml_prerr_byte:
	out r2
	blr
#min_caml_prerr_float:
min_caml_read_int:
    in  r2
    slwi    r2, r2, 8
    in  r31
    add r2, r2, r31
    slwi    r2, r2, 8
    in  r31
    add r2, r2, r31
    slwi    r2, r2, 8
    in  r31
    add r2, r2, r31
    blr
min_caml_read_float:
    in  r2
    slwi    r2, r2, 8
    in  r31
    add r2, r2, r31
    slwi    r2, r2, 8
    in  r31
    add r2, r2, r31
    slwi    r2, r2, 8
    in  r31
    add r2, r2, r31

    st  r2, r3, 8
    fld fr1, r3, 8
    blr
min_caml_create_array:
min_caml_create_float_array:
min_caml_abs_float:
    fabs fr1, fr1
    blr
min_caml_sqrt:
    fsqrt fr1, fr1
    blr
#min_caml_floor:
min_caml_floor:
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr2, fr1
	blt	min_caml_floor_le.58
	beq	min_caml_floor_le.58
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	fsub	fr1, fr1, fr2
	b	min_caml_int_of_float
min_caml_floor_le.58:
	b	min_caml_int_of_float
min_caml_int_of_float:
  ftoi r2, fr1
  blr
min_caml_truncate:
min_caml_float_of_int:
  itof fr1, r2
  blr
#min_caml_cos:
#min_caml_sin:
min_caml_sincos_ker_sin.100:
	fmul	fr2, fr1, fr1
	fmul	fr2, fr2, fr1
	li	r31, 15915
	slwi	r31, r31, 16
	addi	r31, r31, 43692
	st	r31, r3, 8
	fld	fr3, r3, 8
	fmul	fr2, fr2, fr3
	fsub	fr2, fr1, fr2
	fmul	fr3, fr1, fr1
	fmul	fr3, fr3, fr1
	fmul	fr3, fr3, fr1
	fmul	fr3, fr3, fr1
	li	r31, 15369
	slwi	r31, r31, 16
	addi	r31, r31, 34406
	st	r31, r3, 8
	fld	fr4, r3, 8
	fmul	fr3, fr3, fr4
	fadd	fr2, fr2, fr3
	fmul	fr3, fr1, fr1
	fmul	fr3, fr3, fr1
	fmul	fr3, fr3, fr1
	fmul	fr3, fr3, fr1
	fmul	fr3, fr3, fr1
	fmul	fr1, fr3, fr1
	li	r31, 14669
	slwi	r31, r31, 16
	addi	r31, r31, 25782
	st	r31, r3, 8
	fld	fr3, r3, 8
	fmul	fr1, fr1, fr3
	fsub	fr1, fr2, fr1
	blr
min_caml_sincos_ker_cos.102:
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	fmul	fr3, fr1, fr1
	li	r31, 16128
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr4, r3, 8
	fmul	fr3, fr3, fr4
	fsub	fr2, fr2, fr3
	fmul	fr3, fr1, fr1
	fmul	fr3, fr3, fr1
	fmul	fr3, fr3, fr1
	li	r31, 15659
	slwi	r31, r31, 16
	addi	r31, r31, 42889
	st	r31, r3, 8
	fld	fr4, r3, 8
	fmul	fr3, fr3, fr4
	fadd	fr2, fr2, fr3
	fmul	fr3, fr1, fr1
	fmul	fr3, fr3, fr1
	fmul	fr3, fr3, fr1
	fmul	fr3, fr3, fr1
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
	blt	min_caml_sincos_le.234
	beq	min_caml_sincos_le.234
	fsub	fr1, fr0, fr1
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_sincos_a_sin.104
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	fsub	fr1, fr0, fr1
	blr
min_caml_sincos_le.234:
	li	r31, 16585
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr3, r3, 8
	fcmp	cr0, fr3, fr1
	blt	min_caml_sincos_le.235
	beq	min_caml_sincos_le.235
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.236
	beq	min_caml_sincos_le.236
	li	r31, 16329
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.237
	beq	min_caml_sincos_le.237
	li	r31, 16201
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.238
	beq	min_caml_sincos_le.238
	b	min_caml_sincos_ker_sin.100
min_caml_sincos_le.238:
	li	r31, 16329
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fsub	fr1, fr2, fr1
	b	min_caml_sincos_ker_cos.102
min_caml_sincos_le.237:
	li	r31, 16329
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fsub	fr1, fr1, fr2
	b	min_caml_sincos_a_sin.104
min_caml_sincos_le.236:
	fsub	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_sincos_a_sin.104
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	fsub	fr1, fr0, fr1
	blr
min_caml_sincos_le.235:
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
	b	min_caml_sincos_a_sin.104
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
	blt	min_caml_sincos_le.239
	beq	min_caml_sincos_le.239
	fsub	fr1, fr0, fr1
	b	min_caml_sincos_a_cos.106
min_caml_sincos_le.239:
	li	r31, 16585
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr3, r3, 8
	fcmp	cr0, fr3, fr1
	blt	min_caml_sincos_le.240
	beq	min_caml_sincos_le.240
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.241
	beq	min_caml_sincos_le.241
	li	r31, 16329
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.242
	beq	min_caml_sincos_le.242
	li	r31, 16201
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.243
	beq	min_caml_sincos_le.243
	b	min_caml_sincos_ker_cos.102
min_caml_sincos_le.243:
	li	r31, 16329
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fsub	fr1, fr2, fr1
	b	min_caml_sincos_ker_sin.100
min_caml_sincos_le.242:
	li	r31, 16329
	slwi	r31, r31, 16
	addi	r31, r31, 4059
	st	r31, r3, 8
	fld	fr2, r3, 8
	fsub	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_sincos_a_cos.106
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	fsub	fr1, fr0, fr1
	blr
min_caml_sincos_le.241:
	fsub	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_sincos_a_cos.106
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	fsub	fr1, fr0, fr1
	blr
min_caml_sincos_le.240:
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
	b	min_caml_sincos_a_cos.106
min_caml_atan:
