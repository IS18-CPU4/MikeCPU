	.text
	.globl _min_caml_start
	.align 2
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
_min_caml_start:
#	main program starts
	li	r31, 16550
	slwi	r31, r31, 16
	addi	r31, r31, 26214
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_floor_a_floor.24
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
	li	r31, 16563
	slwi	r31, r31, 16
	addi	r31, r31, 13107
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_floor_a_floor.24
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
	li	r31, 49318
	slwi	r31, r31, 16
	addi	r31, r31, 26214
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_floor_a_floor.24
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
	li	r31, 49331
	slwi	r31, r31, 16
	addi	r31, r31, 13107
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_floor_a_floor.24
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
	li	r31, 15949
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_floor_a_floor.24
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
	li	r31, 0
	slwi	r31, r31, 16
	addi	r31, r31, 0
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_floor_a_floor.24
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
	li	r31, 48589
	slwi	r31, r31, 16
	addi	r31, r31, 52429
	st	r31, r3, 8
	fld	fr1, r3, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_floor_a_floor.24
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
