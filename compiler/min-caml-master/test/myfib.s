	.text
	.globl _min_caml_start
	.align 2
fib.42:
	ld	r6, r30, 4
	cmpwi	cr0, r2, 1
	bgt	cr7, ble_else.75
	blr
ble_else.75:
	li	r7, 1
	sub	r7, r2, r7
	li	r8, 0
	st	r5, r3, 0
	st	r6, r3, 4
	st	r30, r3, 8
	st	r2, r3, 12
	mflr	r31
	mr	r5, r8
	mr	r2, r7
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mtctr	r31
	bctrl
	subi	r3, r3, 24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 12
	li	r5, 2
	sub	r5, r5, r5
	li	r6, 0
	ld	r30, r3, 8
	st	r2, r3, 16
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	st	r31, r3, 20
	addi	r3, r3, 24
	ld	r31, r30, 0
	mtctr	r31
	bctrl
	subi	r3, r3, 24
	ld	r31, r3, 20
	mtlr	r31
	ld	r5, r3, 16
	add	r2, r5, r2
	ld	r5, r3, 4
	add	r2, r2, r5
	ld	r5, r3, 0
	add	r2, r2, r5
	blr
myfib.27:
	mr	r30, r4
	addi	r4, r4, 8
	lis	r5, ha16(fib.42)
	addi	r5, r5, lo16(fib.42)
	st	r5, r30, 0
	st	r2, r30, 4
	li	r2, 30
	li	r5, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	ld	r31, r30, 0
	mtctr	r31
	bctrl
	subi	r3, r3, 8
	ld	r31, r3, 4
	mtlr	r31
	addi	r2, r2, 1
	addi	r2, r2, 2
	addi	r2, r2, 3
	addi	r2, r2, 5
	blr
_min_caml_start:
 # main entry point
	mflr	r0
	stmw	r30, r1, -8
	st	r0, r1, 8
	st	r1, r1, -96
#	main program starts
	li	r2, 8
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	myfib.27
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
	addi	r2, r2, 30
	addi	r2, r2, 2
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	myfib.27
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
