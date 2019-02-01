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
