	.text
	.globl _min_caml_start
	.align 2
_min_caml_start:
 # main entry point
	mflr	r0
	stmw	r30, r1, -8
	st	r0, r1, 8
	st	r1, r1, -96
#	main program starts
	li	r2, 123
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
	li	r2, -456
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
	li	r2, 789
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
#	main program ends
	ld	r1, r1, 0
	ld	r0, r1, 8
	mtlr	r0
	lmw	r30, r1, -8
	blr
