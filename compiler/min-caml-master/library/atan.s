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
