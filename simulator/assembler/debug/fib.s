	.text
	.globl _min_caml_start
	.align 2
fib.10:
	cmpwi	cr0, r2, 1
	bgt	cr7, ble_else.24
	blr
ble_else.24:
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
	ld	r5, r3, 0
	li	r5, 2
	sub	r5, r5, r5
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
_min_caml_start:
 # main entry point
	mflr	r0
	stmw	r30, r1, -8
	st	r0, r1, 8
	st	r1, r1, -96
#	main program starts
	li	r2, 30
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
	ld	r1, r1, 0
	ld	r0, r1, 8
	mtlr	r0
	lmw	r30, r1, -8
	blr
