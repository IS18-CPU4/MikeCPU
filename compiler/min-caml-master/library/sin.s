min_caml_sincos_ker_sin.186:
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
min_caml_sincos_ker_cos.188:
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
	blt	min_caml_sincos_le.437
	beq	min_caml_sincos_le.437
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
min_caml_sincos_le.437:
	fld	fr3, r0, 32
	fcmp	cr0, fr3, fr1
	blt	min_caml_sincos_le.438
	beq	min_caml_sincos_le.438
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.439
	beq	min_caml_sincos_le.439
	fld	fr2, r0, 36
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.440
	beq	min_caml_sincos_le.440
	fld	fr2, r0, 40
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.441
	beq	min_caml_sincos_le.441
	b	min_caml_sincos_ker_sin.186
min_caml_sincos_le.441:
	fld	fr2, r0, 36
	fsub	fr1, fr2, fr1
	b	min_caml_sincos_ker_cos.188
min_caml_sincos_le.440:
	fld	fr2, r0, 36
	fsub	fr1, fr1, fr2
	b	min_caml_sin
min_caml_sincos_le.439:
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
min_caml_sincos_le.438:
	fld	fr3, r0, 32
	fdiv	fr3, fr1, fr3
	ftoi	r2, fr3
	itof	fr3, r2
	fld	fr4, r0, 48
	fmul	fr3, fr3, fr4
	fmul	fr2, fr3, fr2
	fsub	fr1, fr1, fr2
	b	min_caml_sin
min_caml_cos:
	fld	fr2, r0, 28
	fld	fr3, r0, 44
	fcmp	cr0, fr3, fr1
	blt	min_caml_sincos_le.442
	beq	min_caml_sincos_le.442
	fsub	fr1, fr0, fr1
	b	min_caml_cos
min_caml_sincos_le.442:
	fld	fr3, r0, 32
	fcmp	cr0, fr3, fr1
	blt	min_caml_sincos_le.443
	beq	min_caml_sincos_le.443
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.444
	beq	min_caml_sincos_le.444
	fld	fr2, r0, 36
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.445
	beq	min_caml_sincos_le.445
	fld	fr2, r0, 40
	fcmp	cr0, fr2, fr1
	blt	min_caml_sincos_le.446
	beq	min_caml_sincos_le.446
	b	min_caml_sincos_ker_cos.188
min_caml_sincos_le.446:
	fld	fr2, r0, 36
	fsub	fr1, fr2, fr1
	b	min_caml_sincos_ker_sin.186
min_caml_sincos_le.445:
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
min_caml_sincos_le.444:
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
min_caml_sincos_le.443:
	fld	fr3, r0, 32
	fdiv	fr3, fr1, fr3
	ftoi	r2, fr3
	itof	fr3, r2
	fld	fr4, r0, 48
	fmul	fr3, fr3, fr4
	fmul	fr2, fr3, fr2
	fsub	fr1, fr1, fr2
	b	min_caml_cos
