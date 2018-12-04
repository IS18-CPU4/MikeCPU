	.text
	.globl _min_caml_start
	.align 2
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
_min_caml_start:
#	main program starts
	li	r31, 16672
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	li	r31, 16544
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	fst	fr1, r3, 0
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_sin
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	fld	fr2, r3, 0
	fmul	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_int_of_float
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	li	r31, 16672
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	li	r31, 16544
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr2, r3, 8
	st	r2, r3, 4
	fst	fr1, r3, 8
	mflr	r31
	fmr	fr1, fr2
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_cos
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	fld	fr2, r3, 8
	fmul	fr1, fr2, fr1
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_int_of_float
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 4
	add	r2, r5, r2
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_print_int
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
#	main program ends
