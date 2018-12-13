	.text
	.globl _min_caml_start
	.align 2
#Library
min_caml_print_newline:
  li r2, 20
  out r2
  blr
#min_caml_print_int:
min_caml_print_int_mul_10.33:
	slwi	r5, r2, 1
	slwi	r2, r2, 3
	add	r2, r5, r2
	blr
min_caml_print_int_div_10_loop.35:
	sub	r7, r6, r5
	cmpwi	cr0, r7, 1
	blt	min_caml_print_int_le.97
	beq	min_caml_print_int_le.97
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
	bl	min_caml_print_int_mul_10.33
	li	r31, 24
	sub	r3, r3, r31
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	cmpw	cr0, r2, r5
	blt	min_caml_print_int_le.98
	beq	min_caml_print_int_le.98
	ld	r2, r3, 0
	ld	r6, r3, 8
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	b	min_caml_print_int_div_10_loop.35
min_caml_print_int_le.98:
	ld	r2, r3, 8
	ld	r6, r3, 4
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	b	min_caml_print_int_div_10_loop.35
min_caml_print_int_le.97:
	mr	r2, r5
	blr
min_caml_print_int_div_10.39:
	srwi	r5, r2, 4
	srwi	r6, r2, 3
	b	min_caml_print_int_div_10_loop.35
min_caml_print_int_mod_10.41:
	st	r2, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int_div_10.39
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int_mul_10.33
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
	ld	r5, r3, 0
	sub	r2, r5, r2
	blr
min_caml_print_int_print_int_rec.43:
	cmpwi	cr0, r2, 0
	bne	min_caml_print_int_beq_else.99
	blr
min_caml_print_int_beq_else.99:
	st	r2, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int_mod_10.41
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
	ld	r5, r3, 0
	st	r2, r3, 4
	mflr	r31
	mr	r2, r5
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_print_int_div_10.39
	li	r31, 16
	sub	r3, r3, r31
	ld	r31, r3, 12
	mtlr	r31
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_print_int_print_int_rec.43
	li	r31, 16
	sub	r3, r3, r31
	ld	r31, r3, 12
	mtlr	r31
	ld	r2, r3, 4
	addi	r2, r2, 48
	b	min_caml_print_byte
min_caml_print_int:
	cmpwi	cr0, r2, 0
	bne	min_caml_print_int_beq_else.101
	li	r2, 48
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_byte
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
	li	r2, 10
	b	min_caml_print_byte
min_caml_print_int_beq_else.101:
	cmpwi	cr0, r2, 0
	blt	min_caml_print_int_bge_else.102
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int_print_int_rec.43
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
	li	r2, 10
	b	min_caml_print_byte
min_caml_print_int_bge_else.102:
	li	r5, 45
	st	r2, r3, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_byte
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
	ld	r2, r3, 0
	sub	r2, r0, r2
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int_print_int_rec.43
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
	li	r2, 10
	b	min_caml_print_byte
min_caml_print_byte:
  out r2
  blr
#min_caml_prerr_int:
min_caml_prerr_byte:
	out r2
	blr
#min_caml_prerr_float:
min_caml_read_int:
min_caml_read_float:
min_caml_create_array:
min_caml_create_float_array:
min_caml_abs_float:
min_caml_sqrt:
min_caml_floor:
min_caml_int_of_float:
  ftoi r2, fr1
  blr
min_caml_truncate:
min_caml_float_of_int:
  itof fr1, r2
  blr
min_caml_cos:
min_caml_sin:
min_caml_atan:
#End Library
dbl.38:
	fadd	fr1, fr1, fr1
	blr
iloop.54:
	cmpwi	cr0, r2, 0
	bne	beq_else.117
	li	r2, 1
	b	min_caml_print_int
beq_else.117:
	fsub	fr3, fr3, fr4
	fadd	fr3, fr3, fr5
	fst	fr5, r3, 0
	st	r2, r3, 4
	fst	fr3, r3, 8
	fst	fr6, r3, 12
	fst	fr2, r3, 16
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	dbl.38
	li	r31, 24
	sub	r3, r3, r31
	ld	r31, r3, 20
	mtlr	r31
	fld	fr2, r3, 16
	fmul	fr1, fr1, fr2
	fld	fr6, r3, 12
	fadd	fr2, fr1, fr6
	fld	fr1, r3, 8
	fmul	fr3, fr1, fr1
	fmul	fr4, fr2, fr2
	fadd	fr5, fr3, fr4
	li	r31, 16512
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 24
	fld	fr7, r3, 24
	fcmp	cr0, fr5, fr7
	blt	le.118
	beq	le.118
	li	r2, 0
	b	min_caml_print_int
le.118:
	li	r2, 1
	ld	r5, r3, 4
	sub	r2, r5, r2
	fld	fr5, r3, 0
	b	iloop.54
xloop.44:
	cmpwi	cr0, r2, 400
	blt	bge_else.119
	blr
bge_else.119:
	st	r2, r3, 0
	st	r5, r3, 4
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_float_of_int
	li	r31, 16
	sub	r3, r3, r31
	ld	r31, r3, 12
	mtlr	r31
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	dbl.38
	li	r31, 16
	sub	r3, r3, r31
	ld	r31, r3, 12
	mtlr	r31
	li	r31, 17352
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 16
	fld	fr2, r3, 16
	fdiv	fr1, fr1, fr2
	li	r31, 16320
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 16
	fld	fr2, r3, 16
	fsub	fr1, fr1, fr2
	ld	r2, r3, 4
	fst	fr1, r3, 8
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_float_of_int
	li	r31, 16
	sub	r3, r3, r31
	ld	r31, r3, 12
	mtlr	r31
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	dbl.38
	li	r31, 16
	sub	r3, r3, r31
	ld	r31, r3, 12
	mtlr	r31
	li	r31, 17352
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 16
	fld	fr2, r3, 16
	fdiv	fr1, fr1, fr2
	li	r31, 16256
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 16
	fld	fr2, r3, 16
	fsub	fr6, fr1, fr2
	li	r2, 1000
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 16
	fld	fr1, r3, 16
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 16
	fld	fr2, r3, 16
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 16
	fld	fr3, r3, 16
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 16
	fld	fr4, r3, 16
	fld	fr5, r3, 8
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	iloop.54
	li	r31, 16
	sub	r3, r3, r31
	ld	r31, r3, 12
	mtlr	r31
	ld	r2, r3, 0
	addi	r2, r2, 1
	ld	r5, r3, 4
	b	xloop.44
yloop.40:
	cmpwi	cr0, r2, 400
	blt	bge_else.121
	blr
bge_else.121:
	li	r5, 0
	st	r2, r3, 0
	mflr	r31
	mr	r29, r5
	mr	r5, r2
	mr	r2, r29
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	xloop.44
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
	ld	r2, r3, 0
	addi	r2, r2, 1
	b	yloop.40
_min_caml_start:
#	main program starts
	li	r2, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	yloop.40
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
#	main program ends
