min_caml_print_int_div_10_loop.31:
	sub	r7, r6, r5
	cmpwi	cr0, r7, 1
	blt	min_caml_print_int_le.180
	beq	min_caml_print_int_le.180
	add	r7, r5, r6
	srwi	r7, r7, 1
	slwi	r8, r7, 1
	slwi	r9, r7, 3
	add	r8, r8, r9
	cmpw	cr0, r8, r2
	blt	min_caml_print_int_le.181
	beq	min_caml_print_int_le.181
	mr	r6, r7
	b	min_caml_print_int_div_10_loop.31
min_caml_print_int_le.181:
	mr	r5, r7
	b	min_caml_print_int_div_10_loop.31
min_caml_print_int_le.180:
	mr	r2, r5
	blr
min_caml_print_int_mod_10.37:
	srwi	r5, r2, 4
	srwi	r6, r2, 3
	addi	r6, r6, 1
	st	r2, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int_div_10_loop.31
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	slwi	r5, r2, 1
	slwi	r2, r2, 3
	add	r2, r5, r2
	ld	r5, r3, 0
	sub	r2, r5, r2
	blr
min_caml_print_int_print_int_rec.39:
	cmpwi	cr0, r2, 0
	bne	min_caml_print_int_beq_else.182
	blr
min_caml_print_int_beq_else.182:
	srwi	r5, r2, 4
	srwi	r6, r2, 3
	addi	r6, r6, 1
	st	r2, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int_div_10_loop.31
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	slwi	r5, r2, 1
	slwi	r2, r2, 3
	add	r2, r5, r2
	ld	r5, r3, 0
	sub	r2, r5, r2
	srwi	r6, r5, 4
	srwi	r7, r5, 3
	addi	r7, r7, 1
	st	r2, r3, 4
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	mr	r6, r7
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_print_int_div_10_loop.31
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	cmpwi	cr0, r2, 0
	bne	min_caml_print_int_beq_else.184
	b	min_caml_print_int_beq_cont.185
min_caml_print_int_beq_else.184:
	st	r2, r3, 8
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_print_int_mod_10.37
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 8
	srwi	r6, r5, 4
	srwi	r7, r5, 3
	addi	r7, r7, 1
	st	r2, r3, 12
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	mr	r6, r7
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_print_int_div_10_loop.31
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_print_int_print_int_rec.39
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 12
	addi	r2, r2, 48
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_print_byte
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
min_caml_print_int_beq_cont.185:
	ld	r2, r3, 4
	addi	r2, r2, 48
	b	min_caml_print_byte
min_caml_print_int:
	cmpwi	cr0, r2, 0
	bne	min_caml_print_int_beq_else.186
	li	r2, 48
	b	min_caml_print_byte
min_caml_print_int_beq_else.186:
	cmpwi	cr0, r2, 0
	blt	min_caml_print_int_bge_else.187
	cmpwi	cr0, r2, 0
	bne	min_caml_print_int_beq_else.188
	blr
min_caml_print_int_beq_else.188:
	st	r2, r3, 0
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_print_int_mod_10.37
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	ld	r5, r3, 0
	srwi	r6, r5, 4
	srwi	r7, r5, 3
	addi	r7, r7, 1
	st	r2, r3, 4
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	mr	r6, r7
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_print_int_div_10_loop.31
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_print_int_print_int_rec.39
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r2, r3, 4
	addi	r2, r2, 48
	b	min_caml_print_byte
min_caml_print_int_bge_else.187:
	li	r5, 45
	st	r2, r3, 0
	mflr	r31
	mr	r2, r5
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_print_byte
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r2, r3, 0
	sub	r2, r0, r2
	cmpwi	cr0, r2, 0
	bne	min_caml_print_int_beq_else.190
	blr
min_caml_print_int_beq_else.190:
	st	r2, r3, 8
	mflr	r31
	st	r31, r3, 12
	addi	r3, r3, 16
	bl	min_caml_print_int_mod_10.37
	addi	r3, r3, -16
	ld	r31, r3, 12
	mtlr	r31
	ld	r5, r3, 8
	srwi	r6, r5, 4
	srwi	r7, r5, 3
	addi	r7, r7, 1
	st	r2, r3, 12
	mflr	r31
	mr	r2, r5
	mr	r5, r6
	mr	r6, r7
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_print_int_div_10_loop.31
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	mflr	r31
	st	r31, r3, 20
	addi	r3, r3, 24
	bl	min_caml_print_int_print_int_rec.39
	addi	r3, r3, -24
	ld	r31, r3, 20
	mtlr	r31
	ld	r2, r3, 12
	addi	r2, r2, 48
	b	min_caml_print_byte
