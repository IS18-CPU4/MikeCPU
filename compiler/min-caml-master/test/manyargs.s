	.text
	.globl _min_caml_start
	.align 2
f.52:
	ld	r29, r30, 4
	add	r2, r29, r2
	add	r2, r2, r5
	add	r2, r2, r6
	add	r2, r2, r7
	add	r2, r2, r8
	add	r2, r2, r9
	add	r2, r2, r10
	add	r2, r2, r11
	add	r2, r2, r12
	add	r2, r2, r13
	add	r2, r2, r14
	add	r2, r2, r15
	add	r2, r2, r16
	add	r2, r2, r17
	add	r2, r2, r18
	add	r2, r2, r19
	add	r2, r2, r20
	add	r2, r2, r21
	add	r2, r2, r22
	add	r2, r2, r23
	add	r2, r2, r24
	add	r2, r2, r25
	add	r2, r2, r26
	add	r2, r2, r27
	add	r2, r2, r28
	b	min_caml_print_int
_min_caml_start:
 # main entry point
	mflr	r0
	stmw	r30, r1, -8
	st	r0, r1, 8
	st	r1, r1, -96
#	main program starts
	li	r2, 42
	mr	r30, r4
	addi	r4, r4, 8
	lis	r5, ha16(f.52)
	addi	r5, r5, lo16(f.52)
	st	r5, r30, 0
	st	r2, r30, 4
	li	r2, 1
	li	r5, 2
	li	r6, 3
	li	r7, 4
	li	r8, 5
	li	r9, 6
	li	r10, 7
	li	r11, 8
	li	r12, 9
	li	r13, 10
	li	r14, 11
	li	r15, 12
	li	r16, 13
	li	r17, 14
	li	r18, 15
	li	r19, 16
	li	r20, 17
	li	r21, 18
	li	r22, 19
	li	r23, 20
	li	r24, 21
	li	r25, 22
	li	r26, 23
	li	r27, 24
	li	r28, 25
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	ld	r31, r30, 0
	mtctr	r31
	bctrl
	subi	r3, r3, 8
	ld	r31, r3, 4
	mtlr	r31
#	main program ends
	ld	r1, r1, 0
	ld	r0, r1, 8
	mtlr	r0
	lmw	r30, r1, -8
	blr
