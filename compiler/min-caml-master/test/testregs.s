	.data
	.literal8
	.align 3
l.18:
# 4.500000
	.long	0
	.long	1074921472
	.align 3
l.17:
# 2.000000
	.long	0
	.long	1073741824
	.text
	.globl _min_caml_start
	.align 2
f.7:
	cmpw	cr0, r2, r5
	bne	cr7, beq_else.20
	lis	r31, ha16(l.17)
	addi	r31, r31, lo16(l.17)
	fld	f1, 0(r31)
	fmul	f0, f0, f1
	blr
beq_else.20:
	lis	r31, ha16(l.17)
	addi	r31, r31, lo16(l.17)
	fld	f1, 0(r31)
	fdiv	f0, f0, f1
	blr
_min_caml_start:
 # main entry point
	mflr	r0
	stmw	r30, r1, -8
	st	r0, r1, 8
	st	r1, r1, -96
#	main program starts
	li	r2, 1
	lis	r31, ha16(l.18)
	addi	r31, r31, lo16(l.18)
	fld	f0, 0(r31)
	li	r5, 3
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	f.7
	li	r31, 8
	sub	r3, r3, r31
	ld	r31, r3, 4
	mtlr	r31
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_float
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
