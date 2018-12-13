	.text
	.globl _min_caml_start
	.align 2
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
_min_caml_start:
#	main program starts
	li	r31, 16454
	slwi	r31, r31, 16
	addi	r31, r31, 26214
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_atan
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
