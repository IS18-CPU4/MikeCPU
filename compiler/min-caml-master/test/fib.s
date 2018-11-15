	.text
	.globl _min_caml_start
	.align 2
fib.10:
	cmpwi	cr0, r2, 1
	blt	le.24
	beq	le.24
	li	r5, 1
	sub	r5, r2, r5
	st	r2, r3, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	fib.10
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
	li	r5, 2
	ld	r6, r3, 0
	sub	r5, r6, r5
	st	r2, r3, 4
	mflr	r31
	mr	r2, r5
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	fib.10
	li	r31, 16
	sub	r3, r3, r31
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 4
	add	r2, r5, r2
	blr
le.24:
	blr
_min_caml_start:
#	main program starts
	li	r2, 10
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	fib.10
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
#	main program ends
